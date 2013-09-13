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
// interface/patient_file/encounter/esign.php file for signing forms from "outside" of forms dir
//
// @author  Medical Information Integration <tony@mi-squared.com>
// @link    www.mi-squared.com

require_once("../../globals.php");
include_once("$srcdir/sql.inc");
require_once("$srcdir/ESign.class.php");

if (isset($_GET['formname'])) {
    $formTable = 'forms_' . $_GET['formname'];
} else if (isset($_POST['form_name'])) {
    $formTable = $_POST['form_name'];
}

if (isset($_GET['id'])) {
    $formID = $_GET['id'];
} else if (isset($_POST['form_id'])) {
    $formID = $_POST['form_id'];
}

if (isset($_GET['action'])) {
    $action = $_GET['action'];
} else if (isset($_POST['action'])) {
    $action = $_POST['action'];
}

// Create esign object
$esign = new ESign();
$esign->init($formid, $formTable);

$sigId = $esign->getNewestUnsignedSignature();



// Signing dialog
?>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.js"></script>
<script type="text/javascript" src="../../../library/js/fancybox-1.3.4/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="../../../library/js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="../../../library/js/common.js"></script>

<script>
    $(document).ready(function() {
            $("#signoff").fancybox({
            'scrolling'		: 'no',
            'titleShow'		: false,
            'onClosed'		: function() { $("#login_prompt").hide(); }
            });
            $("#login_form").bind("submit", function() {

                document.getElementById("login_pass").value = SHA1(document.getElementById("login_pass").value);
                if ($("#login_pass").val().length <1) {
                    $("#login_prompt").show();
                    $.fancybox.resize();
                    return false;
                }

                $.fancybox.showActivity();

                $.ajax({
                    'type'	: "POST",
                    'cache'	: false,
                    'url'	: "<?php echo $GLOBALS['rootdir'] . "/patient_file/encounter/sign.php"; ?>",
                    'data'	: $(this).serializeArray(),
                    'success'   : function(data) { $.fancybox(data); }
                });
            
                return false;
           });
           
        }
    
</script>

    <?php // Form: Sign HTML ?>

<center>
    <table>
        <tr>
            <td align = "center">
                <?php if ($action == "edit") { ?>
                    <input type = "submit" name = "Submit" value = "Save Form">
                <?php } ?>
                <input type = "button" value = "Back" onClick = "top.restoreSession();window.location='<?php echo $GLOBALS['webroot'] ?>/interface/patient_file/encounter/encounter_top.php';" />
                <?php if ($action == "review") { ?>
                    <input type = "button" value = "Sign" id = "signoff" href = "#login_form" <?php echo $signDisabled; ?> />
                <?php } ?>
            </td>
        </tr>
        <tr> <td>
                <div id = "signature_log" name = "signature_log">
                    <?php $esign->getDefaultSignatureLog(true); ?>
                    <?php echo $formTable . " " . $formid . " " . $action . "<br />"; //DEBUG ?>
                </div>
            </td></tr>
    </table>
</center>
</body>
<div style = "display:none">
    <form id = "login_form" method = "post" action = "">
        <p> <center> <span style = "font-size:small;">
                <p id = "login_prompt" style = "font-size:small;"> Enter your password to sign: </p>
                <input type = "hidden" name = "sig_status" value = "approved" />
                <input type = "hidden" id = "tid" name = "tid" value = "<?php echo $id; ?>" />
                <input type = "hidden" id = "table_name" name = "table_name" value = "<?php echo $formTable; ?>" />
                <input type = "hidden" id = "signature_uid" name = "signature_uid" value = "<?php echo $_SESSION['authUserID']; ?>" />
                <input type = "hidden" id = "signature_id" name = "signature_id" value = "<?php echo $sigId->getId(); ?>" />
                <input type = "hidden" id = "exam_name" name = "exam_name" value = "<?php echo $registryRow['nickname']; ?>" />
                <input type = "hidden" id = "exam_pid" name = "exam_pid" value = "<?php echo $obj['pid']; ?>" />
                <input type = "hidden" id = "exam_date" name = "exam_date" value = "<?php echo $obj['date']; ?>" />
                <label for = "login_pass"> Password: </label>
                <input type = "password" id = "login_pass" name = "login_pass" size = "10" />
            </span>
        </center></p>
        <p>
            <input type = "submit" value = "Sign" />
        </p>
    </form>
</div>

