<?php
/* +-----------------------------------------------------------------------------+
*    OpenEMR - Open Source Electronic Medical Record
*    Copyright (C) 2014 Z&H Consultancy Services Private Limited <sam@zhservices.com>
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU Affero General Public License as
*    published by the Free Software Foundation, either version 3 of the
*    License, or (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU Affero General Public License for more details.
*
*    You should have received a copy of the GNU Affero General Public License
*    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*    @author  Vinish K <vinish@zhservices.com>
* +------------------------------------------------------------------------------+
*/

namespace Carecoordination\Model;

use Zend\Db\TableGateway\AbstractTableGateway;
use Application\Model\ApplicationTable;
use Zend\Db\Adapter\Driver\Pdo\Result;
use ZipArchive;

use CouchDB;

class EncountermanagerTable extends AbstractTableGateway
{
    public function getEncounters($data,$getCount=null)
    {
		$query_data = array();
        $query  = 	"SELECT pd.fname, pd.lname, pd.mname, date(fe.date) as date, fe.pid, fe.encounter,
                        u.fname as doc_fname, u.mname as doc_mname, u.lname as doc_lname, (select count(encounter) from form_encounter where pid=fe.pid) as enc_count,
                        (SELECT DATE(date) FROM form_encounter WHERE pid=fe.pid ORDER BY date DESC LIMIT 1) as last_visit_date,
						(select count(*) from ccda where pid=fe.pid and transfer=1) as ccda_transfer_count,
						(select count(*) from ccda where pid=fe.pid and transfer=1 and status=1) as ccda_successfull_transfer_count
                        FROM form_encounter AS fe
                        JOIN patient_data AS pd ON pd.pid=fe.pid
                        LEFT JOIN users AS u ON u.id=fe.provider_id ";
				if($data['status']) {
						$query  .= " LEFT JOIN combination_form AS cf ON cf.encounter = fe.encounter ";
				}
				
				$query  .= " WHERE 1=1 ";
				
				if($data['status'] == "signed") {
						$query  .= " AND cf.encounter IS NOT NULL AND cf.encounter !=''";
				}
				
				if($data['status'] == "unsigned") {
						$query  .= " AND (cf.encounter IS  NULL OR cf.encounter ='')";
				}
				
				if($data['from_date'] && $data['to_date']) {
						$query .= " AND fe.date BETWEEN ? AND ? ";
						$query_data[] = $data['from_date'];
						$query_data[] = $data['to_date'];
				}
				
				if($data['pid']) {
						$query .= " AND (fe.pid = ? OR pd.fname like ? OR pd.mname like ? OR pd.lname like ? OR CONCAT_WS(' ',pd.fname,pd.lname) like ?) ";
						$query_data[] = $data['pid'];
						$query_data[] = "%".$data['pid']."%";
						$query_data[] = "%".$data['pid']."%";
						$query_data[] = "%".$data['pid']."%";
						$query_data[] = "%".$data['pid']."%";
				}
				
				if($data['encounter']) {
						$query .= " AND fe.encounter = ? ";
						$query_data[] = $data['encounter'];
				}
				
				$query .= " GROUP BY fe.pid ";
				
				$query .= " ORDER BY fe.pid, fe.date ";

				$appTable   = new ApplicationTable();
				
				if($getCount){
						$res        = $appTable->zQuery($query, $query_data);
						$resCount 	= $res->count();
						return $resCount;
				}
						
				$query 		 .= " LIMIT ".$data['limit_start'].",".$data['results'];
				$resDetails = $appTable->zQuery($query, $query_data);
        return $resDetails;
    }
    
    public function getStatus($data)
    {
		$pid 		= "''";
		foreach($data as $row){
			if($pid) $pid .= ',';
			$pid 	.= $row['pid'];
		}
		$query 	    = "SELECT cc.*, DATE(fe.date) AS dos, CONCAT_WS(' ',u.fname, u.mname, u.lname) AS user_name FROM ccda AS cc
				LEFT JOIN form_encounter AS fe ON fe. pid = cc.pid AND fe.encounter = cc.encounter
				LEFT JOIN users AS u ON u.id = cc.user_id
				WHERE cc.pid in ($pid) ORDER BY cc.pid, cc.time desc";
		$appTable   = new ApplicationTable();
		$result     = $appTable->zQuery($query);
		return $result;
    }
    
    public function convert_to_yyyymmdd($date)
    {
        $date = str_replace('/','-',$date);
        $arr = explode('-',$date);
        $formatted_date = $arr[2]."-".$arr[0]."-".$arr[1];
        return $formatted_date;
    }
    
    /*
    * Convert date from database format to required format
    *
    * @param	String		$date		Date from database (format: YYYY-MM-DD)
    * @param	String		$format		Required date format
    *
    * @return	String		$formatted_date	New formatted date
    */
    public function date_format($date, $format)
    {
	if(!$date) return;
	$format = $format ? $format : 'm/d/y';	
	$temp = explode(' ',$date); //split using space and consider the first portion, incase of date with time
	$date = $temp[0];
        $date = str_replace('/','-',$date);
        $arr = explode('-',$date);
	
	if($format == 'm/d/y'){
	    $formatted_date = $arr[1]."/".$arr[2]."/".$arr[0];
	}
	$formatted_date = $temp[1] ? $formatted_date." ".$temp[1] : $formatted_date; //append the time, if exists, with the new formatted date
        return $formatted_date;
    }
    
    public function getFile($id)
    {
		require_once(dirname(__FILE__) . "/../../../../../../../../library/classes/CouchDB.class.php");
		$query 	    = "select couch_docid, couch_revid, ccda_data from ccda where id=?";
		$appTable   = new ApplicationTable();
		$result     = $appTable->zQuery($query, array($id));
		foreach($result as $row){
			if($row['couch_docid'] != ''){
				$couch 	 = new CouchDB();
				$data 	 = array($GLOBALS['couchdb_dbase'], $row['couch_docid']);
				$resp 	 = $couch->retrieve_doc($data);
				$content = base64_decode($resp->data);
			}
			else if(!$row['couch_docid']){
				$fccda 	 = fopen($row['ccda_data'], "r");		
				$content = fread($fccda, filesize($row['ccda_data']));
				fclose($fccda);
			}
			else{
				$content = $row['ccda_data'];
			}
			return $content;
		}
    }
}
?>