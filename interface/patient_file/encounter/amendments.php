<?php
/**
 * interface/patient_file/encounter/amendments.php file for adding amendments to forms after the forms are signed. 
 * The codes inside 'if' condition of submit_new and submit_edit will be same. It wont affect the flow. 
 * Previously the amendment page displays only one amendment and it can be edited. Now its modified to add multiple amendments.
 *
 * Copyright (C) 2013 Medical Information Integration <info@mi-squared.com>
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
 * @author  Visolve <services@visolve.com>
 * @link    www.mi-squared.com
 */
$fake_register_globals = false;
$sanitize_all_escapes = true;

require_once("../../globals.php");
require_once("$srcdir/options.inc.php");
include_once("$srcdir/api.inc");
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

$esign = new ESign();
$esign->init($formID, $formTable);

$sigId = $esign->getNewestUnsignedSignature();
$signId = $sigId->getId();

if ($_GET['mode'] == "edit") {
    $result = sqlFetchArray(sqlStatement("select amendments from forms_" . $_GET['formname'] . " where id=" . $_GET['id']));
    $old_amendments = $result['amendments'];

    if ($result['amendments'] != '')
        $array_of_amendments = explode("#", $old_amendments);

    /*
      $len = strlen($old_amendments);
      $old_amendments = substr($old_amendments,0,$len-20);
     */
}
else if ($_POST['flag'] == "submit_new" || $_POST['flag'] == "submit_edit") {
    $result = sqlFetchArray(sqlStatement("select amendments from " . $_POST['form_name'] . " where id=" . $_POST['form_id']));
    $old_amendments = $result['amendments'];

    if ($result['amendments'] != '')
        $array_of_amendments = explode("#", $old_amendments);

    /*
      $len = strlen($old_amendments);
      $old_amendments = substr($old_amendments,0,$len-20);
     */
}


if ($_POST['flag'] == 'submit_new' && isset($_POST['flag'])) {

    if (sha1($_POST['login_pass']) == $_SESSION['authPass']) {

        $_POST['amendments'] .= " " . date("Y-m-d H:i:s");
        if ($old_amendments != '') {
            $_POST['amendments'] = mysql_real_escape_string(str_replace('#', '', $_POST['amendments']) . "#" . $old_amendments);
        } else {
            $_POST['amendments'] = mysql_real_escape_string(str_replace('#', '', $_POST['amendments']));
        }
        $res1 = sqlStatement("update " . $_POST['form_name'] . " set amendments = '" . $_POST['amendments'] . "' where id=" . $_POST['form_id']);
        $res2 = sqlStatement("update eSignatures set datetime = CURRENT_TIMESTAMP, signed=1, uid=" . $_SESSION['authUserID'] . " where id=" . $signId);
        echo "<script>parent.$.fancybox.close();</script>";
    } else {
        echo "<span style='color:red;'>Invalid Password!</span>";
        $pwd_invalid = 1;
    }
} else if ($_POST['flag'] == 'submit_edit' && isset($_POST['flag'])) {

    if (sha1($_POST['login_pass']) == $_SESSION['authPass']) {

        $_POST['amendments'] .= " " . date("Y-m-d H:i:s");
        if ($old_amendments != '') {
            $_POST['amendments'] = mysql_real_escape_string(str_replace('#', '', $_POST['amendments']) . "#" . $old_amendments);
        } else {
            $_POST['amendments'] = mysql_real_escape_string(str_replace('#', '', $_POST['amendments']));
        }
        $res1 = sqlStatement("update " . $_POST['form_name'] . " set amendments = '" . $_POST['amendments'] . "' where id=" . $_POST['form_id']);
        $res2 = sqlStatement("update eSignatures set datetime = CURRENT_TIMESTAMP, signed=1, uid=" . $_SESSION['authUserID'] . " where id=" . $signId);
        echo "<script>parent.$.fancybox.close();</script>";
    } else {
        echo "<span style='color:red;'>Invalid Password!</span>";
        $pwd_invalid = 1;
    }
}
?>

<html>

    <head>
<?php html_header_show(); ?>
        <link rel="stylesheet" href="<?php echo $css_header; ?>" type="text/css">
        <link rel="stylesheet" type="text/css" href="../../../library/js/fancybox/jquery.fancybox-1.2.6.css" media="screen" />
        <style type="text/css">@import url(../../../library/dynarch_calendar.css);</style>
        <script type="text/javascript" src="../../../library/textformat.js"></script>
        <script type="text/javascript" src="../../../library/dynarch_calendar.js"></script>
        <?php include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php"); ?>
        <script type="text/javascript" src="../../../library/dynarch_calendar_setup.js"></script>
        <script type="text/javascript" src="../../../library/dialog.js"></script>
        <script type="text/javascript" src="../../../library/js/jquery-1.6.4.min.js"></script>
        <script type="text/javascript" src="../../../library/js/common.js"></script>

        <script src='../../../library/js/jquery.autosize.js'></script>
        <style>
            body{
                font-size:small;
            }
            #login_prompt{
                text-align:center;
            }
            .previous_amendments{
                width:95%;
                background-color:#F3F8FC;
                margin-bottom:5px;
                padding:5px;
                border: 1px solid #CEDCDF;
                font-size: small;
            }
        </style>
        <script>

            $(document).ready(function() {
                $('textarea').autosize();
            });

            function validate() {
                if ($('#login_pass').val() == '') {
                    $('#login_pass').css({'border': 'solid 1px red', 'background-color': '#FBEDBB'}).focus();
                    $('form').submit(function(e) {
                        e.preventDefault();
                    });
                }
                else {
<?php
if ($_GET['mode'] == "edit") {
    echo "document.getElementById('flag').value='submit_edit';\n";
} else {
    echo "document.getElementById('flag').value='submit_new';\n";
}
?>
                    document.forms[0].submit();
                }
            }

            function checkSubmit(e)
            {
                if (e && e.keyCode == 13)
                {
                    validate();
                }
            }

        </script>
    </head>
    <body>
        <form name='form_amendments' method='post' action="amendments.php" onsubmit='return top.restoreSession()'>
            <input type="hidden" name="flag" id="flag" value="no" />
            <input type="hidden" name="form_name" id="form_name" value="<?php if (isset($_GET['formname'])) {
    echo 'forms_' . $_GET['formname'];
} else {
    echo $_POST['form_name'];
} ?>" />
            <input type="hidden" name="form_id" id="form_id" value="<?php if (isset($_GET['id'])) {
    echo $_GET['id'];
} else {
    echo $_POST['form_id'];
} ?>" />
            <p><span style="font-size:small;">
                    <label for="login_pass">Password: </label>
                    <input type="password" id="login_pass" name="login_pass" size="10" onKeyPress="return checkSubmit(event)" />
                </span></p>
            <p>
                <?php xl('Amendments:', 'e') ?><br>
                <textarea name="amendments" rows="3" style="width:100%;" id="amendments">
                    <?php if ($pwd_invalid == 1) {
                        echo $_POST['amendments'];
                    } ?>
                </textarea>
                <br>
                <input type="button" onclick="return validate()" value="<?php echo xl('Sign', 'e'); ?>">
            </p>
        </form>

        <?php
        $amend_count = count($array_of_amendments);

        if ($amend_count != 0) {
            echo "<strong>Previous Amendments:</strong>";

            for ($i = 0; $i < $amend_count; $i++) {

                $len = strlen($array_of_amendments[$i]);
                $amend_text = substr($array_of_amendments[$i], 0, $len - 20);
                $amend_datetime = substr($array_of_amendments[$i], $len - 20, $len);

                $op = "<div class='previous_amendments'>" . nl2br($amend_text);
                if ($amend_text != '')
                    $op.= "<br />";
                $op .= "<strong>" . $amend_datetime . "</strong>" . "</div>";

                echo $op;
            }
        }
        ?>
    </body>
</html>

