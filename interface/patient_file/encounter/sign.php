<?php

// Copyright (C) 2013 Medical Information Integration <info@mi-squared.com>
//
// LICENSE: This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 3
// of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://opensource.org/licenses/gpl-license.php>;.
//
// interface/patient_file/encounter/sign.php file for signing forms
//
// @author  Medical Information Integration <tony@mi-squared.com>
// @link    www.mi-squared.com

require_once("../../globals.php");
include_once("$srcdir/sql.inc");
require_once("$srcdir/ESign.class.php");

$signedSuccessfully = false;
$signingRole = "";
// $skipKeys = array("id", "pid", "date", "user", "groupname", "authorized", "activity");
$eSignResult = "";

/**
 * Receives a $_POST with:
 *  signature_uid:  the user id for the signature entry - equates to $_SESSION['authUserID']
 *  signature_id:  the id of the signature entry in the eSignatures table. 
 *  login_pass:  the sha1-encrypted password string - should match $_SESSION['authPass']
 */
foreach ($_POST as $key => $value) {
    if (empty($_POST[$key]))
        exit;

    $_POST[$key] = htmlspecialchars($_POST[$key]);
}

if ($_POST['login_pass'] == $_SESSION['authPass']) {
    //consider authenticated since $_SESSION is server-side. 

    $eSignResult = sqlQuery("select * from eSignatures where id = '" . $_POST['signature_id'] . "'");

    if ($eSignResult) {
        // add addtional signature
        sqlStatement("update eSignatures set `datetime` = now(), `signed`=1, `uid`='" . $_POST['signature_uid'] . "', status='" . $_POST['sig_status'] . "' where `id` = '" . $_POST['signature_id'] . "'");
        $signingRole = $eSignResult['role'];
    } else {
        echo xl("Form not Signed yet."); 
        exit;
    }
    
    $signedSuccessfully = true;
    echo xl("Document Signed") . "<br>";

    
} else {
    echo xl("Password is invalid");
}
?>
