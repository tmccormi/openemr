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
*    @author  BASIL PT <basil@zhservices.com>
* +------------------------------------------------------------------------------+
*/

namespace Application\Model;

use Zend\Db\TableGateway\AbstractTableGateway;
use Application\Model\ApplicationTable;
use Zend\Db\Adapter\Driver\Pdo\Result;

class SendtoTable extends AbstractTableGateway
{
    /*
    * getCombinationForms
    * @param Integer $encounter Patient Encounter
    * @return array
    * 
    **/
    public function getCombinationForms($encounter)
    {
        //$sql = "SELECT
        //            DISTINCT (cl.`cl_list_slno`),
        //            cl.`cl_list_item_short` 
        //        FROM
        //            form_encounter AS fe,
        //            template_users AS tu,
        //            customlists AS cl 
        //        WHERE
        //            encounter = ? 
        //            AND tu.`tu_template_id` = cl.`cl_list_slno` 
        //            AND cl.`cl_list_type` = ? 
        //            AND tu.`tu_user_id` = fe.`provider_id` 
        //            AND IF(
        //              tu.`tu_facility_id` IS NOT NULL 
        //              AND tu.`tu_facility_id` != 0,
        //              IF(
        //                tu.`tu_facility_id` = fe.`facility_id`,
        //                1,
        //                0
        //              ),
        //              1
        //            ) = 1 
        //            AND IF(
        //              tu_visit_category IS NOT NULL 
        //              AND tu_visit_category != 0 
        //              AND tu_visit_category != '',
        //              IF(
        //                CONCAT(',', tu.`tu_visit_category`, ',') LIKE CONCAT('%,', fe.`pc_catid`, ',%'),
        //                1,
        //                0
        //              ),
        //              1
        //            ) = 1 
        //            AND IF(
        //              tu.`tu_active_id` = 0,
        //              IF(
        //                fe.`date` <= tu.`tu_deleted_dt` 
        //                AND tu.`tu_deleted_dt` != '' 
        //                AND tu.`tu_deleted_dt` IS NOT NULL,
        //                1,
        //                0
        //              ),
        //              1
        //            ) = 1 ";
        //$appTable   = new ApplicationTable();
        //$result     = $appTable->zQuery($sql,array($encounter,55));
        //return $result;
    }
    
    
    /*
     * getCombinationFormComponents
     * @param integer $formId Combination Form ID
     * @return String Combination Form nuilding Block Elemets
     *
     **/ 
    public function getCombinationFormComponents($encounter,$formId)
    {
        /*$appTable   = new ApplicationTable();
        
        // Encounter Saved Forms -- SaveAll
        $sql = "SELECT * FROM combined_encountersaved_forms where encounter=? and combinationformid=?";
        $result     = $appTable->zQuery($sql,array($encounter,$formId));
        $components  = array();
        if($result->count() > 0){
            foreach($result as $row){
                $formIdArray = explode("***",$row['formid']);
                $components[$formIdArray[0]] = $row['nickname'];
            }
            
            // Saved Forms
            $sql    = "SELECT formdir,form_name FROM forms WHERE encounter = ? ";
            $result = $appTable->zQuery($sql,array($encounter));
            foreach($result as $row){
                if(!array_key_exists($row['formdir'],$form_IDs) && $row['formdir'] !="newpatient"){
                    $components[$row['formdir']] = $row['form_name'];
                }
            }
        }else {
            // Form Components
            $sql        = "SELECT `cl_list_item_long`, `cl_list_item_long_nick` FROM `customlists` WHERE `cl_list_slno` = ?";
            $result     = $appTable->zQuery($sql,array($formId));
            $form_IDs   = array();
            foreach($result as $row){
                $cl_list_item_long      = substr_replace($row['cl_list_item_long'],"",0,1);
                $cl_list_item_long      = str_replace("facility_myTable_","",$cl_list_item_long);
                $cl_list_item_long_nick = $row['cl_list_item_long_nick'];
                $titles                 = explode(",",$cl_list_item_long_nick);
                
                $iindex = -1;
                $formIdArray = explode(",",$cl_list_item_long);
                foreach($formIdArray as $component){
                    $iindex++;
                    $componentArray  = explode("***",$component);
                    $components[$componentArray[0]] = $titles[$iindex];
                    $arry_tmp  = explode("|",$componentArray[0]);
                    array_push($form_IDs,$arry_tmp[0]);
                }  
            } 
        }
        
        // Addendum
        $sql    = " SELECT * FROM addendum WHERE encounter=? ORDER BY addendum_order ";
        $i      = 0;
        $result = $appTable->zQuery($sql,array($encounter));
        foreach($result as $row){
            $i++;
            $components[$row['addendum_order']] = "Addendum ".$i;
        }
        
        return json_encode($components);*/
    }
    
    /*
    * getFacility
    * @return array facility
    * 
    **/
    public function getFacility()
    {
        $appTable   = new ApplicationTable();
        $sql        = "SELECT * FROM facility ORDER BY name";
        $result     = $appTable->zQuery($sql);
        return $result;
    }
    
    
    /*
    * getUsers
    * @param String $type
    * @return array
    * 
    **/
    public function getUsers($type)
    {
        $appTable   = new ApplicationTable();
        $sql        = "SELECT * FROM users WHERE abook_type = ?";
        $result     = $appTable->zQuery($sql,array($type));
        return $result;
    }
    
    
    /*
    * getFaxRecievers
    * @return array fax reciever types
    * 
    **/ 
    public function getFaxRecievers()
    {
        $appTable   = new ApplicationTable();
        $sql        = "SELECT option_id, title FROM list_options WHERE list_id = 'abook_type'";
        $result     = $appTable->zQuery($sql,array($formId));
        return $result;
    }
    
    /*
    * CCDA component list
    *
    * @param    None
    * @return   $components     Array of CCDA components
    **/
    public function getCCDAComponents()
    {
        $components = array();
        $query      = "select * from ccda_components";
        $appTable   = new ApplicationTable();
        $result     = $appTable->zQuery($query, array());
        
        foreach($result as $row){
            $components[$row['ccda_components_field']] = $row['ccda_components_name'];
        }
        return $components;
    }
}
