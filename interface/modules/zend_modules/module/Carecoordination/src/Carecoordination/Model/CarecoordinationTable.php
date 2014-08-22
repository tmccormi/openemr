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
use Zend\XmlRpc\Generator;

use DOMDocument;
use DOMXpath;

use Document;
use CouchDB;

class CarecoordinationTable extends AbstractTableGateway
{
	/*
	* Fetch the category ID using category name
	*
	* @param		$title		String		Category Name
	* @return		$records	Array		Category ID	
	*/
	public function fetch_cat_id($title)
	{
		$appTable   = new ApplicationTable();
		$query      = "select * from categories where name = ?";
		$result     = $appTable->zQuery($query, array($title));
		$records    = array();
		foreach($result as $row){
			$records[] = $row;
		}
		return $records;
	}
	
	/*
	* Fetch the list of CCDA files uploaded and pending approval
	*
	* @return		$records	Array		List of CCDA documents
	*/
	public function document_fetch($data)
	{
		$query      = "SELECT cat.name, u.fname, u.lname, d.imported, d.size, d.date, d.couch_docid, d.couch_revid, d.url AS file_url, d.id AS document_id
					FROM documents AS d
					JOIN categories AS cat ON cat.name = ?
					JOIN categories_to_documents AS cd ON cd.document_id = d.id AND cd.category_id = cat.id
					LEFT JOIN users AS u ON u.id = d.owner
					WHERE d.audit_master_approval_status = 1
					ORDER BY date DESC";
		$appTable   = new ApplicationTable();
		$result     = $appTable->zQuery($query, array($data['cat_title']));
		$records    = array();
		foreach($result as $row){
			$records[] = $row;
		}
		return $records;
	}
	
	/*
	* Fetch a document from the database
	*
	* @param	$document_id		Integer		Document ID
	* @return	$content			String		File content
	*/
	public function getDocument($document_id)
	{
		$content = \Documents\Plugin\Documents::getDocument($document_id);
		return $content;
	}
}


