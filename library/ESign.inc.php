<?php
/**
 * Copyright (C) 2012 OEMR 501c3 www.oemr.org
 *
 * e-signature include for forms to facilitate standardized signatures for forms and documents.  
 *
 * LICENSE: This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://opensource.org/licenses/gpl-license.php>;.
 *
 * @package OpenEMR
 * @author  Jeremy Wallace <jeremy@mi-squared.com>
 * @author  Medical Information Integration, LLC
 * @link    http://www.mi-squared.com
 **/

include_once(dirname(__FILE__) . "sql.inc");
require_once(dirname(__FILE__) . "ESign.class.php");

$signedSuccessfully = false;
$signingRole = "";
$skipKeys = array("id","pid","date","user","groupname","authorized","activity");
$eSignResult = "";

/**
 * Receives a $_POST with:
 *  signature_uid:  the user id for the signature entry - equates to $_SESSION['authUserID']
 *  signature_id:  the id of the signature entry in the eSignatures table. 
 *  login_pass:  the sha1-encrypted password string - should match $_SESSION['authPass']
 */

foreach($_POST as $key => $value)
{
    if(empty($_POST[$key]))
        exit;
    
    $_POST[$key] = htmlspecialchars($_POST[$key]);
}



if($_POST['login_pass'] == $_SESSION['authPass'])
{
    //consider authenticated since $_SESSION is server-side. 

    $eSignResult = sqlQuery("select * from eSignatures where id = '". $_POST['signature_id']. "'");

    if($eSignResult)
    {
        sqlStatement("update eSignatures set `datetime` = now(), `signed`=1, `uid`='". $_POST['signature_uid']."', status='".$_POST['sig_status']."' where `id` = '". $_POST['signature_id']. "'");
        $signingRole = $eSignResult['role'];
    }   
    else
    {
        //sqlStatement("insert into eSignatures set `datetime` = now(), `signed`=1, `uid`='". $_POST['signature_uid']."'");
        echo "Signature not on file.  Please re-load the form and try again.";
        exit;
    }
    
    echo "Document Signed<br>";
    
    $signedSuccessfully = true;
    
    
}
else
{
    echo "Password is invalid";
}

?>
