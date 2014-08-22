<?php
/* +-----------------------------------------------------------------------------+
*    OpenEMR - Open Source Electronic Medical Record
*    Copyright (C) 2013 Z&H Consultancy Services Private Limited <sam@zhservices.com>
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
*    @author  Basil PT <basil@zhservices.com>
* +------------------------------------------------------------------------------+
*/
namespace Documents\Plugin;

use Zend\Mvc\Controller\Plugin\AbstractPlugin;
use Documents\Model\DocumentsTable;

class Documents extends AbstractPlugin 
{
  protected $documentsTable;
	
  /**
   * 
   * Documents Table Object 
   * @param type $sm Service Manager
   **/
  public function __construct($sm)
  { 
    $sm->get('Zend\Db\Adapter\Adapter');
    $this->documentsTable = new DocumentsTable();
  }
	
	/**
	 * encrypt - Encrypts a plain text
	 * Supports TripleDES encryption
	 * @param String $plain_text Plain Text to be encrypted
	 * @param String $key Encryption Key
	 * @return String
	 */
	public function encrypt($plaintext,$key,$cypher = 'tripledes', $mode = 'cfb' )
	{
		$td 				= mcrypt_module_open( $cypher, '', $mode, '');
		$iv 				= mcrypt_create_iv( mcrypt_enc_get_iv_size( $td ), MCRYPT_RAND );
		mcrypt_generic_init( $td, $key, $iv );
		$crypttext	= mcrypt_generic( $td, $plaintext );
		mcrypt_generic_deinit( $td );
		return $iv.$crypttext;
	}
	
	/**
	 * decrypt  - Decrypts an Encrypted String
	 * @param String $crypttext Encrypted String
	 * @param String $key Decryption Key
	 * @return String 
	 */
	public function decrypt($crypttext,$key,$cypher = 'tripledes',$mode = 'cfb')
	{
		$plaintext 	= '';
		$td 				= mcrypt_module_open( $cypher, '', $mode, '' );
		$ivsize 		= mcrypt_enc_get_iv_size( $td) ;
		$iv 				= substr( $crypttext, 0, $ivsize );
		$crypttext 	= substr( $crypttext, $ivsize );
		if( $iv )
		{
			mcrypt_generic_init( $td, $key, $iv );
			$plaintext = mdecrypt_generic( $td, $crypttext );
		}
		return $plaintext;
	}
	
	/**
	 * couchDB - Couch DB Connection
	 * 				 - Uses Doctrine  CouchDBClient
	 * @return Object $connection
	 */
	public function couchDB()
	{
		$host       = $GLOBALS['couchdb_host'];
		$port       = $GLOBALS['couchdb_port'];
		$usename    = $GLOBALS['couchdb_user'];
		$password   = $GLOBALS['couchdb_pass'];
		$database	= $GLOBALS['couchdb_dbase'];
		$enable_log = ($GLOBALS['couchdb_log'] == 1) ? true : false;
		
		$options = array(
			'host' 		  => $host,
			'port' 		  => $port,
			'user' 		  => $usename,
			'password' 	  => $password,
			'logging' 	  => $enable_log,
			'dbname'	  => $database
		);
    $connection = \Doctrine\CouchDB\CouchDBClient::create($options);
		return $connection;
	}
	
	/**
	 * saveCouchDocument - Save Document to Couch DB
	 * @param Object $connection Couch DB Connection Object
	 * @param Json Encoded Data
	 * @return Array
	 */
	public function saveCouchDocument($connection,$data)
	{
		$couch 	= $connection->postDocument($data);
		$id			= $couch[0];
		$rev		= $couch[1];
		if($id && $rev) {
			$connection->putDocument($data,$id,$rev);
			return $couch;
		} else {
			return false;
		}
	}
	
	/**
	 * getDocument Retieve Documents from Couch/HDD
	 * @param Integer $documentId Document ID
	 * @param Boolean $doEncryption Download Encrypted File
	 * @param  String $encryption_key Key for Document Encryption
	 * @return String File Content
	 */
	public function getDocument($documentId,$doEncryption =false,$encryption_key = '')
	{
		$result = \Documents\Model\DocumentsTable::getDocument($documentId);
		if($result['couch_docid']) {
			// Couch DB
			$connection = \Documents\Plugin\Documents::couchDB();
			$couchData	= $connection->findDocument($result['couch_docid']);
			$document		= base64_decode($couchData->body['data']);	
		} else {
			// Hard Disk
			$url			= $result['url'];
			$file 		= fopen($url,"r");
			$document = fread($file,filesize($url));
		}
		
		if($doEncryption) {
			$encryptedDocument = $this->encrypt($document,$encryption_key);
			$document					 = $encryptedDocument;
		}
		
		return $document;
	}
}