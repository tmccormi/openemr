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

namespace Documents\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\View\Model\JsonModel;
use Application\Listener\Listener;

class DocumentsController extends AbstractActionController
{
  protected $documentsTable;
  protected $listenerObject;
  
  public function __construct()
  {
    $this->listenerObject	= new Listener;
  }
  
  public function getDocumentsTable()
  {
    if (!$this->documentsTable) {
      $sm = $this->getServiceLocator();
      $this ->documentsTable = $sm->get('Documents\Model\DocumentsTable');
    }
    return $this->documentsTable;
  }  
  
  /*
  * Upload document
  */
  public function uploadAction() {
    $request        = $this->getRequest();
    if($request->isPost()) {
      $error          = false;
      $files          = array();
      $uploaddir      = __DIR__ .'/../../../../../sites/'.$_SESSION['site_id'].'/documents/'.$request->getPost('file_location');
      $pid            = $request->getPost('patient_id');
      $encounter      = $request->getPost('encounter_id');
      $batch_upload   = $request->getPost('batch_upload');
      $category_id    = $request->getPost('document_category');
      $encrypted_file = $request->getPost('encrypted_file');
      $encryption_key = $request->getPost('encryption_key');
      $storage_method = $GLOBALS['document_storage_method'];
      $documents = array();
      $i         = 0;
      foreach($_FILES as $file){
        $i++;
        $dateStamp      = date('Y-m-d-H-i-s');
        $file_name      = $dateStamp."_".basename($file["name"]);
        $file["name"]   = $file_name;
        
        $documents[$i]  = array(
          'name'        => $file_name,
          'type'        => $file['type'],
          'batch_upload'=> $batch_upload,
          'storage'     => $storage_method,
          'category_id' => $category_id,
          'pid'         => $pid,
        );
        
        // Decrypt Encryped Files
        if($encrypted_file == '1') {
          // Read File Contents
          $tmpfile    = fopen($file['tmp_name'], "r");
          $filetext   = fread($tmpfile,$file['size']);
          $plaintext  = \Documents\Plugin\Documents::decrypt($filetext,$encryption_key);
          fclose($tmpfile);
          unlink($file['tmp_name']);
          
          // Write new file contents
          $tmpfile = fopen($file['tmp_name'],"w+");
          fwrite($tmpfile,$plaintext);
          fclose($tmpfile);
          $file['size'] = filesize($file['tmp_name']);
        }
        
        if($storage_method == 0) {
          if((substr($uploaddir,strlen($uploaddir)-1,1) != "/")){
            $uploaddir .= "/";
          }
          
          if($request->getPost('user_specific')=='true') {
            $uploaddir .= $_SESSION['authId']."/";
          }
          
          if($request->getPost('patient_specific')=='true') {
            $uploaddir .= $pid."/";
          }
          
          if($request->getPost('encounter_specific')=='true') {
            $uploaddir .= $encounter."/";
          }
          
          if(!file_exists($uploaddir)) {
            mkdir($uploaddir,0777,true);
          }
          
          if(move_uploaded_file($file['tmp_name'], $uploaddir .basename($file['name']))){
            $documents[$i]['size']        = $file['size'];
            $documents[$i]['url']         = $uploaddir .basename($file['name']);
            $documents[$i]['hash']        = sha1_file($uploaddir .basename($file['name']));
          }
          else {
            $error = true;
          }
        } elseif ($storage_method == 1) {
          // Couch
          $tmpfile    = fopen($file['tmp_name'], "r");
          $plainText  = fread($tmpfile,$file['size']);
          $filetext   = base64_encode($plainText);   
          fclose($tmpfile);

          $data = array(
            'data'      => $filetext,
            'pid'       => $pid,
            'encounter' => $encounter,
            'mimetype'  => $file['type']
          );
          
          $couch    = \Documents\Plugin\Documents::couchDB();
          $couch_id = \Documents\Plugin\Documents::saveCouchDocument($couch,$data);
          
          $documents[$i]['size']        = $file['size'];          
          $documents[$i]['url']         = $file_name;
          $documents[$i]['hash']        = sha1($plainText);
          $documents[$i]['couch_doc_id']= $couch_id[0];
          $documents[$i]['couch_rev_id']= $couch_id[1];
        }
      }
      $doc_id = \Documents\Controller\DocumentsController::getDocumentsTable()->saveDocument($documents);
      echo $doc_id;
    }
    return $this->response;
  }
  
  /*
  * Retrieve document
  */
  public function retrieveAction() {
    
    // List of Preview Available File types
		$previewAvailableFiles = array(
			'application/pdf',
			'image/jpeg',
			'image/png',
			'image/gif',
			'text/plain',
			'text/html',
            'text/xml',
		);
    
    $request        = $this->getRequest();
    $documentId     = $this->params()->fromRoute('id');
    $doEncryption   = ($this->params()->fromRoute('doencryption') == '1') ? true : false;
    $encryptionKey  = $this->params()->fromRoute('key');
    $type           = ($this->params()->fromRoute('download') == '1') ? "attachment" : "inline";
    
    $result         = $this->getDocumentsTable()->getDocument($documentId);
    $skip_headers   = false;
    $contentType    = $result['mimetype'];
    
    $document       = \Documents\Plugin\Documents::getDocument($documentId,$doEncryption,$encryptionKey);
    $categoryIds    = $this->getDocumentsTable()->getCategoryIDs(array('CCD','CCR','CCDA'));
    if(in_array($result['category_id'],$categoryIds)) {
      $xml          = simplexml_load_string($document);
      $xsl          = new \DomDocument;
      
      switch($result['category_id']){
        case $categoryIds['CCD']:
          $style = "ccd.xsl";
          break;
        case $categoryIds['CCR']:
          $style = "ccr.xsl";
          break;
        case $categoryIds['CCDA']:
          $style = "ccda.xsl";
          break;
      };
      
      $xsl->load(__DIR__.'/../../../../../public/xsl/'.$style);
      $proc         = new \XSLTProcessor;
      $proc->importStyleSheet($xsl);
      echo $xml;
      $document     = $proc->transformToXML($xml);
      echo $document;
    }
    
    if($type=="inline" && !$doEncryption) {
      if(in_array($result['mimetype'],$previewAvailableFiles)){
        if(in_array($result['category_id'],$categoryIds)) {
          $contentType  = 'text/html';
        }
      } else {
        $skip_headers = true;
      }
    } else {
      if($doEncryption) {
        $document     = \Documents\Plugin\Documents::encrypt($document,$encryptionKey);
        $contentType  = "application/octet-stream";
      } else {
        $contentType  = $result['mimetype'];
      }  
    }
    
    if(!$skip_headers) {
      $response       = $this->getResponse();
      $response->setContent($document);
      $headers        = $response->getHeaders();
      $headers->clearHeaders()
              ->addHeaderLine('Content-Type',$contentType)
              ->addHeaderLine('Content-Disposition', $type . '; filename="' . $result['name'] . '"')
              ->addHeaderLine('Content-Length', strlen($document));
      $response->setHeaders($headers);
      return $this->response;
    }
    
    $view = new ViewModel(array(
      'listenerObject'=> $this->listenerObject,
    ));
    return $view;
  }
}