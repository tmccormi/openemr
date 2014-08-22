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
*    @author  Vinish K <vinish@zhservices.com>
* +------------------------------------------------------------------------------+
*/
namespace Syndromicsurveillance\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\TableGateway\AbstractTableGateway; 
use Zend\Db\Adapter\Adapter; 
use Zend\Db\ResultSet\ResultSet; 
use Zend\Db\Sql\Select;
use Zend\InputFilter\Factory as InputFactory;
use Zend\InputFilter\InputFilter;
use Zend\InputFilter\InputFilterAwareInterface;
use Zend\InputFilter\InputFilterInterface;

use \Application\Model\ApplicationTable;

class SyndromicsurveillanceTable extends AbstractTableGateway
{
	/*
	* Fetch the reportable ICD9 codes
	*
	* @return	codes		array		list of replrtable ICD9 codes
	*/
    function non_reported_codes()
    {
		$query 	    = "select id, concat('ICD9:',code) as name from codes where reportable = 1 ORDER BY name";
		$appTable   = new ApplicationTable();
		$result     = $appTable->zQuery($query);
		
		$codes 	    = array();
		foreach($result as $row){
			$codes[] = $row;
		}
		return $codes;
    }
    
	/*
	* Get list of providers in EMR
	*
	* @return	rows	Array	List of providers
	*/
    function getProviderList()
    {
		global $encounter;
		global $pid;	
		$appTable   = new ApplicationTable();	
		
		$sqlSelctProvider 		= "SELECT * FROM form_encounter WHERE encounter = ? AND pid = ?";	
		$resultSelctProvider    = $appTable->zQuery($sqlSelctProvider, array($encounter, $pid));
		foreach($resultSelctProvider as $resultSelctProvider_row){
			$provider = $resultSelctProvider_row['provider_id'];
		}
		
		$query = "SELECT id, fname, lname, specialty FROM users 
			WHERE active = 1 AND ( info IS NULL OR info NOT LIKE '%Inactive%' ) 
			AND authorized = 1 
			ORDER BY lname, fname";
		
		$result = $appTable->zQuery($query, array());
		$rows[0] = array (
			'value' => '',
			'label' => 'Unassigned',
			'selected' => TRUE,
			'disabled' => FALSE
		);
		$i = 1;
		foreach($result as $row) {
			if ($row['id'] == $provider) {
				$select =  TRUE;
			} else {
				$select = FALSE;
			}
			$rows[$i] = array (
				'value' => $row['id'],
				'label' => $row['fname']." ".$row['lname'],
				'selected' => $select,
			);
			$i++;
		}
		return $rows;
    }
    
	/*
	* Fetch the list of patients having the reportable ICD9
	*
	* @param	fromDate		date		encounter date
	* @param	toDate			date		encounter date
	* @param	code_selected	string		selected ICD9 codes from the filter
	* @param	provider_selected		integer		provider id from the filter
	* @param	start			integer		pagination start
	* @param	end				integer		pagination end
	* @param	get_count		integer		flag to identify whether to return the selected rows or the number of rows
	* 
	* @return	records			array		return the list of patients having the reportable ICD9 codes
	* @return	count			integer		return the count of patients having the reportable ICD9 codes
	*/
    function fetch_result($fromDate, $toDate, $code_selected, $provider_selected, $start, $end, $get_count = null)
    {
		$records = array();
		$query_string = array();
		
		$query = "SELECT   c.code_text,l.pid AS patientid,p.language,l.diagnosis,CONCAT(p.fname, ' ', p.mname, ' ', p.lname) AS patientname,l.date AS issuedate, l.id AS issueid,l.title AS issuetitle 
			FROM
			  lists l, patient_data p, codes c, form_encounter AS fe 
			WHERE c.reportable = 1 ";	
		
		if($provider_selected){
			$query .= " AND provider_id = ? ";
			$query_string[] = $provider_selected;
		}
		
		$query .= " AND l.id NOT IN 
			(SELECT 
				lists_id 
			FROM
				syndromic_surveillance) 
			AND l.date >= ? AND l.date <= ? AND l.pid = p.pid ";
		$query_string[] = $fromDate;
		$query_string[] = $toDate;
		
		if($code_selected){
			$query .= " AND c.id IN (?) ";
			$query_string[] = implode(',',$code_selected);
		}
		
		$query .= " AND l.diagnosis LIKE 'ICD9:%' 
					AND ( SUBSTRING(l.diagnosis, 6) = c.code || SUBSTRING(l.diagnosis, 6) = CONCAT_WS('', c.code, ';') ) 
					AND fe.pid = l.pid 
				UNION DISTINCT 
				SELECT c.code_text, b.pid AS patientid, p.language, b.code, CONCAT(p.fname, ' ', p.mname, ' ', p.lname) AS patientname, b.date AS issuedate,  b.id AS issueid, '' AS issuetitle 
				FROM
					billing b, patient_data p, codes c, form_encounter fe 
				WHERE c.reportable = 1 
					AND b.code_type = 'ICD9' AND b.activity = '1' AND b.pid = p.pid AND fe.encounter = b.encounter ";
		
		if($code_selected){
			$query .= " AND c.id IN (?) ";
			$query_string[] = implode(',',$code_selected);
		}
		
		$query .= " AND c.code = b.code 
			AND fe.date IN 
			(SELECT 
				MAX(fenc.date) 
			FROM
				form_encounter AS fenc 
			WHERE fenc.pid = fe.pid) ";
		
		if($provider_selected){
			$query .= " AND provider_id = ? ";
			$query_string[] = $provider_selected;
		}
		
		$query 		.= " AND fe.date >= ? AND fe.date <= ?";
		$query_string[] = $fromDate;
		$query_string[] = $toDate;
		
		if($get_count){
			$appTable   = new ApplicationTable();
			$result     = $appTable->zQuery($query, $query_string);
			foreach($result as $row){
			$records[] = $row;
			}
			return count($records);
		}
		
		$query 	    .= " LIMIT ".$start.",".$end;
		
		$appTable   = new ApplicationTable();
		$result     = $appTable->zQuery($query, $query_string);
		foreach($result as $row){
			$records[] = $row;
		}
		
		return $records;
    }
    
	/*
	* generate the HL7
	* 
	* @param	fromDate		date		encounter date
	* @param	toDate			date		encounter date
	* @param	code_selected	string		selected ICD9 codes from the filter
	* @param	provider_selected		integer		provider id from the filter
	* @param	start			integer		pagination start
	* @param	end				integer		pagination end
	*
	* @return	download the generated HL7
	*/
    function generate_hl7($fromDate, $toDate, $code_selected, $provider_selected, $start, $end)
    {
		$records = array();
		$query_string = array();
		
		$query = "SELECT   c.code_text,l.pid AS patientid,p.language,l.diagnosis,
			DATE_FORMAT(p.DOB,'%Y%m%d') as DOB, concat(p.street, '^',p.postal_code,'^', p.city, '^', p.state) as address, 
			p.country_code, p.phone_home, p.phone_biz, p.status, p.sex, p.ethnoracial, c.code_text, c.code, c.code_type, DATE_FORMAT(l.date,'%Y%m%d') as issuedate, 
			concat(p.fname, '^',p.mname,'^', p.lname) as patientname, l.id AS issueid,l.title AS issuetitle 
			FROM
			  lists l, patient_data p, codes c, form_encounter AS fe 
			WHERE c.reportable = 1 ";	
		
		if($provider_selected){
			$query .= " AND provider_id = ? ";
			$query_string[] = $provider_selected;
		}
		
		$query .= " AND l.id NOT IN 
			(SELECT 
			  lists_id 
			FROM
			  syndromic_surveillance) 
			AND l.date >= ? AND l.date <= ? AND l.pid = p.pid ";
		$query_string[] = $fromDate;
		$query_string[] = $toDate;
		
		if($code_selected){
			$query .= " AND c.id IN (?) ";
			$query_string[] = implode(',',$code_selected);
		}
		
		$query .= " AND l.diagnosis LIKE 'ICD9:%' 
				AND ( SUBSTRING(l.diagnosis, 6) = c.code || SUBSTRING(l.diagnosis, 6) = CONCAT_WS('', c.code, ';') ) 
				AND fe.pid = l.pid 
			  UNION DISTINCT 
			  SELECT c.code_text, b.pid AS patientid, p.language, b.code, DATE_FORMAT(p.DOB,'%Y%m%d') as DOB, 
				  concat(p.street, '^',p.postal_code,'^', p.city, '^', p.state) as address, p.country_code, p.phone_home, p.phone_biz, p.status, 
				  p.sex, p.ethnoracial, c.code_text, c.code, c.code_type, DATE_FORMAT(fe.date,'%Y%m%d') as issuedate, concat(p.fname, '^',p.mname,'^', p.lname) as patientname,
				  b.id AS issueid, '' AS issuetitle 
			  FROM
				billing b, patient_data p, codes c, form_encounter fe 
			  WHERE c.reportable = 1 
				AND b.code_type = 'ICD9' AND b.activity = '1' AND b.pid = p.pid AND fe.encounter = b.encounter ";
		
		if($code_selected){
			$query .= " AND c.id IN (?) ";
			$query_string[] = implode(',',$code_selected);
		}
		
		$query .= " AND c.code = b.code 
		  AND fe.date IN 
		  (SELECT 
			MAX(fenc.date) 
		  FROM
			form_encounter AS fenc 
		  WHERE fenc.pid = fe.pid) ";
		
		if($provider_selected){
			$query .= " AND provider_id = ? ";
			$query_string[] = $provider_selected;
		}
		
		$query 		.= " AND fe.date >= ? AND fe.date <= ?";
		$query_string[] = $fromDate;
		$query_string[] = $toDate;
		
		$content = ''; 
		//$content.="FHS|^~\&|OPENEMR||||$now||$filename||||$D";
		//$content.="BHS|^~\&|OPENEMR||||$now||SyndromicSurveillance||||$D";
		
		$appTable   = new ApplicationTable();
		$result     = $appTable->zQuery($query, $query_string);
		
		$D="\r";
		$nowdate    = date('Ymd');
		$now 	    = date('YmdGi');
		$now1 	    = date('Y-m-d G:i');
		$filename   = "syn_sur_". $now . ".hl7";
	
		foreach($result as $r) {
			$content .= "MSH|^~\&|OPENEMR||||$nowdate||".
			"ADT^A08|$nowdate|P^T|2.5.1|||||||||$D";
			$content .= "EVN|" . // [[ 3.69 ]]
			"A08|" . // 1.B Event Type Code
			"$now|" . // 2.R Recorded Date/Time
			"|" . // 3. Date/Time Planned Event
			"|" . // 4. Event Reason Cod
			"|" . // 5. Operator ID
			"|" . // 6. Event Occurred
			"" . // 7. Event Facility
			"$D" ;
			if ($r['sex']==='Male') $r['sex'] = 'M';
			if ($r['sex']==='Female') $r['sex'] = 'F';
			if ($r['status']==='married') $r['status'] = 'M';
			if ($r['status']==='single') $r['status'] = 'S';
			if ($r['status']==='divorced') $r['status'] = 'D';
			if ($r['status']==='widowed') $r['status'] = 'W';
			if ($r['status']==='separated') $r['status'] = 'A';
			if ($r['status']==='domestic partner') $r['status'] = 'P';
			$content .= "PID|" . // [[ 3.72 ]]
			"|" . // 1. Set id
			"|" . // 2. (B)Patient id
			$r['patientid']."|". // 3. (R) Patient indentifier list
			"|" . // 4. (B) Alternate PID
			$r['patientname']."|" . // 5.R. Name
			"|" . // 6. Mather Maiden Name
			$r['DOB']."|" . // 7. Date, time of birth
			$r['sex']."|" . // 8. Sex
			"|" . // 9.B Patient Alias
			//$r['ethnoracial']."|" . // 10. Race
			"|" . // 10. Race
			$r['address']."|" . // 11. Address
			$r['country_code']."|" . // 12. country code
			$r['phone_home']."|" . // 13. Phone Home
			$r['phone_biz']."|" . // 14. Phone Bussines
			"|" . // 15. Primary language
			$r['status']."|" . // 16. Marital status
			"|" . // 17. Religion
			"|" . // 18. patient Account Number
			"|" . // 19.B SSN Number
			"|" . // 20.B Driver license number
			"|" . // 21. Mathers Identifier
			"|" . // 22. Ethnic Group
			"|" . // 23. Birth Plase
			"|" . // 24. Multiple birth indicator
			"|" . // 25. Birth order
			"|" . // 26. Citizenship
			"|" . // 27. Veteran military status
			"|" . // 28.B Nationality
			"|" . // 29. Patient Death Date and Time
			"|" . // 30. Patient Death Indicator
			"|" . // 31. Identity Unknown Indicator
			"|" . // 32. Identity Reliability Code
			"|" . // 33. Last Update Date/Time
			"|" . // 34. Last Update Facility
			"|" . // 35. Species Code
			"|" . // 36. Breed Code
			"|" . // 37. Breed Code
			"|" . // 38. Production Class Code
			""  . // 39. Tribal Citizenship
			"$D" ;
			$content .= "PV1|" . // [[ 3.86 ]]
			"|" . // 1. Set ID
			"U|" . // 2.R Patient Class (U - unknown)
			"" . // 3. ... 52.
			"$D" ;
			$content .= "DG1|" . // [[ 6.24 ]]
			"1|" . // 1. Set ID
			$r['diagnosis']."|" . // 2.B.R Diagnosis Coding Method
			$r['code']."|" . // 3. Diagnosis Code - DG1
			$r['code_text']."|" . // 4.B Diagnosis Description
			$r['issuedate']."|" . // 5. Diagnosis Date/Time
			"W|" . // 6.R Diagnosis Type  // A - Admiting, W - working
			"|" . // 7.B Major Diagnostic Category
			"|" . // 8.B Diagnostic Related Group
			"|" . // 9.B DRG Approval Indicator 
			"|" . // 10.B DRG Grouper Review Code
			"|" . // 11.B Outlier Type 
			"|" . // 12.B Outlier Days
			"|" . // 13.B Outlier Cost
			"|" . // 14.B Grouper Version And Type 
			"|" . // 15. Diagnosis Priority
			"|" . // 16. Diagnosing Clinician
			"|" . // 17. Diagnosis Classification
			"|" . // 18. Confidential Indicator
			"|" . // 19. Attestation Date/Time
			"|" . // 20.C Diagnosis Identifier
			"" . // 21.C Diagnosis Action Code
			"$D" ;
			  
			//mark if issues generated/sent
			$query_insert = "insert into syndromic_surveillance(lists_id,submission_date,filename) values (?, ?, ?)"; 
			$appTable->zQuery($query_insert, array($r['issueid'], $now1, $filename));
		}
		//$content.="BTS|||$D";
		//$content.="FTS||$D";
		  
		$content = $this->tr($content);
		//send the header here
		header('Content-type: text/plain');
		header('Content-Disposition: attachment; filename=' . $filename );
		  
		// put the content in the file
		echo($content);
		exit;
    }
    
	/*
	* date format conversion
	*/
    public function convert_to_yyyymmdd($date)
    {
        $date 	= str_replace('/','-',$date);
        $arr 	= explode('-',$date);
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
		$temp 	= explode(' ',$date); //split using space and consider the first portion, incase of date with time
		$date 	= $temp[0];
		$date 	= str_replace('/','-',$date);
		$arr 	= explode('-',$date);
		
		if($format == 'm/d/y'){
			$formatted_date = $arr[1]."/".$arr[2]."/".$arr[0];
		}
		$formatted_date = $temp[1] ? $formatted_date." ".$temp[1] : $formatted_date; //append the time, if exists, with the new formatted date
        return $formatted_date;
    }
    
    /*
    * param		string		Content in HL7 format
    * return	string		Formatted HL7 string
    */
    function tr($a) {
		return (str_replace(' ','^',$a));
    }
}