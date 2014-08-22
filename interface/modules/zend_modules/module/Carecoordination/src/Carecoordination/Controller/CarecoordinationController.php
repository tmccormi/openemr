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
namespace Carecoordination\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\View\Model\JsonModel;
use Application\Listener\Listener;
use Documents\Controller\DocumentsController;

use C_Document;
use Document;
use CouchDB;
use xmltoarray_parser_htmlfix;

class CarecoordinationController extends AbstractActionController
{
    protected $listenerObject;
    
    public function __construct()
    {
      $this->listenerObject	= new Listener;
    }
    
    /**
    * Index Page
    * @param int   $id     menu id
    * $param array $data   menu details
    * @param string $slug  controller name
    * @return \Zend\View\Model\ViewModel
    */
    public function indexAction()
    {
        $this->redirect()->toRoute('encountermanager',array('action'=>'index'));
    }
    
    /*
    * Upload CCDA file
    */
    public function uploadAction()
    {
        $category_details = $this->getCarecoordinationTable()->fetch_cat_id('CCDA');
        
        $time_start     = date('Y-m-d H:i:s');
        $cdoc = \Documents\Controller\DocumentsController::uploadAction();
        
        $records = $this->getCarecoordinationTable()->document_fetch(array('cat_title' => 'CCDA'));
        $view = new ViewModel(array(
            'records' => $records,
            'category_id' => $category_details[0]['id'],
            'file_location' => basename($_FILES['file']['name']),
            'patient_id' => '00',
            'listenerObject' => $this->listenerObject,
        ));
        return $view;
    }
    
    /*
    * Function to import the data CCDA file to audit tables.
    *
    * @param    document_id     integer value
    * @return   none
    */
    public function importAction()
    {
        $request        = $this->getRequest();
        $document_id    = $request->getQuery('document_id') ? $request->getQuery('document_id') : $request->getPost('document_id', null);
        
        $xml_content    = $this->getCarecoordinationTable()->getDocument($document_id);
        
        $xmltoarray     = new \Zend\Config\Reader\Xml();
        $array          = $xmltoarray->fromString((string) $xml_content);
        
        $patient_role       = $array['recordTarget']['patientRole'];        
        $patient_address    = $patient_role['addr']['streetAddressLine'];
        $patient_city       = $patient_role['addr']['city'];
        $patient_state      = $patient_role['addr']['state'];
        $patient_postalcode = $patient_role['addr']['postalCode'];
        $patient_country    = $patient_role['addr']['country'];        
        $patient_phone_type = $patient_role['telecom']['use'];
        $patient_phone_no   = $patient_role['telecom']['value'];        
        $patient_fname       = $patient_role['patient']['name']['given'][0];
        $patient_lname       = $patient_role['patient']['name']['given'][1];
        $patient_family_name = $patient_role['patient']['name']['family'];        
        $patient_gender_code = $patient_role['patient']['administrativeGenderCode']['code'];
        $patient_gender_name = $patient_role['patient']['administrativeGenderCode']['displayName'];        
        $patient_dob         = $patient_role['patient']['birthTime']['value'];
        $patient_marital_status         = $patient_role['patient']['religiousAffiliationCode']['code'];
        $patient_marital_status_display = $patient_role['patient']['religiousAffiliationCode']['displayName'];        
        $patient_race           = $patient_role['patient']['raceCode']['code'];
        $patient_race_display   = $patient_role['patient']['raceCode']['displayName'];        
        $patient_ethnicity          = $patient_role['patient']['ethnicGroupCode']['code'];
        $patient_ethnicity_display  = $patient_role['patient']['ethnicGroupCode']['displayName'];        
        $patient_language = $patient_role['patient']['languageCommunication']['languageCode']['code'];
        
        $view = new ViewModel();
        $view->setTerminal(true);
        return $view;
    }
    
    /**
    * Table gateway
    * @return object
    */
    public function getCarecoordinationTable()
    {
        if (!$this->carecoordinationTable) {
            $sm = $this->getServiceLocator();
            $this->carecoordinationTable = $sm->get('Carecoordination\Model\CarecoordinationTable');
        }
        return $this->carecoordinationTable;
    } 

}