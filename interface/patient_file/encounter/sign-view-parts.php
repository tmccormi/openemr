<?php
// Sign Code - Minimum
require_once("$srcdir/ESign.class.php");


// Create esign object
$esign = new ESign();
$esign->init($id, $formTable);

$sigId = $esign->getNewestUnsignedSignature();

// Signing dialog
?>

<script type="text/javascript" src="../../../library/js/fancybox-1.3.4/jquery.fancybox-1.3.4.pack.js"></script>

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
?>

// Form Sign HTML
// @TODO find $action and $signDisabled

<center>
    <table>
        <tr>
            <td align = "center">
                <?php if ($action == "edit") { ?>
                    <input type = "submit" name = "Submit" value = "Save Form"> & nbsp; & nbsp;
                <?php } ?>
                <input type = "button" value = "Back" onClick = "top.restoreSession();window.location='<?php echo $GLOBALS['webroot'] ?>/interface/patient_file/encounter/encounter_top.php';" /> & nbsp; & nbsp;
                <?php if ($action == "review") { ?>
                    <input type = "button" value = "Sign" id = "signoff" href = "#login_form" <?php echo $signDisabled; ?> />
                <?php } ?>
            </td>
        </tr>
        <tr> <td>
                <div id = "signature_log" name = "signature_log">
                    <?php $esign->getDefaultSignatureLog(true); ?>
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

