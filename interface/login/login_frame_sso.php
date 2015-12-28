<?php
// Copyright (c) 2014 US Peace Corps
//
// This program is protected by copyright laws; you may not redistribute it and/or
// modify it in part or whole for any purpose without prior express written permission 
// from the Peace Corps.
//

//  This is an alternate login frame for SSO logins. The login user name is taken from $_SERVER['REMOTE_USER'].

$fake_register_globals=false;
$sanitize_all_escapes=true;

$ignoreAuth=true;
include_once("../globals.php");
include_once("$srcdir/sql.inc");

$username = $_GET['user_name'];
$password = '';

?>
<html>
<head>
<?php html_header_show();?>
<link rel=stylesheet href="<?php echo $css_header;?>" type="text/css">
<link rel=stylesheet href="../themes/login.css" type="text/css">

<script language='JavaScript' src="../../library/js/jquery-1.4.3.min.js"></script>
<script language='JavaScript'>
function transmit_form()
{
    document.forms[0].submit();
}
function imsubmitted() {
<?php if (!empty($GLOBALS['restore_sessions'])) { ?>
 // Delete the session cookie by setting its expiration date in the past.
 // This forces the server to create a new session ID.
 var olddate = new Date();
 olddate.setFullYear(olddate.getFullYear() - 1);
 document.cookie = '<?php echo session_name() . '=' . session_id() ?>; path=/; expires=' + olddate.toGMTString();
<?php } ?>
    return false; //Currently the submit action is handled by the encrypt_form(). 
}
</script>

</head>
<body onload="javascript:document.login_form.authUser.focus();" >
<span class="text"></span>
<center>

<form method="POST"
 action="../main/main_screen.php?auth=login&site=<?php echo attr($_SESSION['site_id']); ?>"
 target="_top" name="login_form" onsubmit="return imsubmitted();">

<input type='hidden' name='new_login_session_management' value='1' />

<?php
// collect groups
$res = sqlStatement("select distinct name from groups");
for ($iter = 0;$row = sqlFetchArray($res);$iter++)
	$result[$iter] = $row;
if (count($result) == 1) {
	$resvalue = $result[0]{"name"};
	echo "<input type='hidden' name='authProvider' value='" . attr($resvalue) . "' />\n";
}
// collect default language id
$res2 = sqlStatement("select * from lang_languages where lang_description = ?",array($GLOBALS['language_default']));
for ($iter = 0;$row = sqlFetchArray($res2);$iter++)
          $result2[$iter] = $row;
if (count($result2) == 1) {
          $defaultLangID = $result2[0]{"lang_id"};
          $defaultLangName = $result2[0]{"lang_description"};
}
else {
          //default to english if any problems
          $defaultLangID = 1;
          $defaultLangName = "English";
}
// set session variable to default so login information appears in default language
$_SESSION['language_choice'] = $defaultLangID;
// collect languages if showing language menu
if ($GLOBALS['language_menu_login']) {
    
        // sorting order of language titles depends on language translation options.
        $mainLangID = empty($_SESSION['language_choice']) ? '1' : $_SESSION['language_choice'];
        if ($mainLangID == '1' && !empty($GLOBALS['skip_english_translation']))
        {
          $sql = "SELECT *,lang_description as trans_lang_description FROM lang_languages ORDER BY lang_description, lang_id";
	  $res3=SqlStatement($sql);
        }
        else {
          // Use and sort by the translated language name.
          $sql = "SELECT ll.lang_id, " .
            "IF(LENGTH(ld.definition),ld.definition,ll.lang_description) AS trans_lang_description, " .
	    "ll.lang_description " .
            "FROM lang_languages AS ll " .
            "LEFT JOIN lang_constants AS lc ON lc.constant_name = ll.lang_description " .
            "LEFT JOIN lang_definitions AS ld ON ld.cons_id = lc.cons_id AND " .
            "ld.lang_id = ? " .
            "ORDER BY IF(LENGTH(ld.definition),ld.definition,ll.lang_description), ll.lang_id";
          $res3=SqlStatement($sql, array($mainLangID));
	}
    
        for ($iter = 0;$row = sqlFetchArray($res3);$iter++)
               $result3[$iter] = $row;
        if (count($result3) == 1) {
	       //default to english if only return one language
               echo "<input type='hidden' name='languageChoice' value='1' />\n";
        }
}
else {
        echo "<input type='hidden' name='languageChoice' value='".attr($defaultLangID)."' />\n";   
}
?>

<table width="100%" height="90%">
<td align='center' valign='middle' width='34%'>
<div class="login-box">
<div class="logo-left"><?php echo $logocode;?></div>

<div class="table-right">
<table width="100%">
<?php if (count($result) != 1) { ?>
<tr>
<td><span class="text"><?php echo xlt('Group:'); ?></span></td>
<td>
<select name=authProvider>
<?php
	foreach ($result as $iter) {
		echo "<option value='".attr($iter{"name"})."'>".text($iter{"name"})."</option>\n";
	}
?>
</select>
</td></tr>
<?php } ?>

<?php if (isset($_SESSION['loginfailure']) && ($_SESSION['loginfailure'] == 1)): ?>
<tr><td colspan='2' class='text' style='color:red'>
<?php echo xlt('Invalid username or password'); ?>
</td></tr>
<?php endif; ?>

<?php if (isset($_SESSION['relogin']) && ($_SESSION['relogin'] == 1)): ?>
<tr><td colspan='2' class='text' style='color:red;background-color:#dfdfdf;border:solid 1px #bfbfbf;text-align:center'>
<b><?php echo xlt('Password security has recently been upgraded.'); ?><br>
<?php echo xlt('Please login again.'); ?></b>
<?php unset($_SESSION['relogin']); ?>
</td></tr>
<?php endif; ?>

<tr>
<td><span class="text"><?php echo xlt('Username:'); ?></span></td>
<td>
<input class="entryfield" type="text" size="10" name="authUser" value="<?php echo $username; ?>" >
</td></tr><tr>
<td><span class="text"><?php echo xlt('Password:'); ?></span></td>
<td>
<input class="entryfield" type="password" size="10" name="clearPass" value="<?php echo $password; ?>">
</td></tr>

<?php
if ($GLOBALS['language_menu_login']) {
if (count($result3) != 1) { ?>
<tr>
<td><span class="text"><?php echo xlt('Language'); ?>:</span></td>
<td>
<select class="entryfield" name=languageChoice size="1">
<?php
        echo "<option selected='selected' value='" . attr($defaultLangID) . "'>" . xlt('Default') . " - " . xlt($defaultLangName) . "</option>\n";
        foreach ($result3 as $iter) {
	        if ($GLOBALS['language_menu_showall']) {
                    if ( !$GLOBALS['allow_debug_language'] && $iter[lang_description] == 'dummy') continue; // skip the dummy language
                    echo "<option value='".attr($iter['lang_id'])."'>".text($iter['trans_lang_description'])."</option>\n";
		}
	        else {
		    if (in_array($iter[lang_description], $GLOBALS['language_menu_show'])) {
                        if ( !$GLOBALS['allow_debug_language'] && $iter['lang_description'] == 'dummy') continue; // skip the dummy language
		        echo "<option value='".attr($iter['lang_id'])."'>" . text($iter['trans_lang_description']) . "</option>\n";
		    }
		}
        }
?>
</select>
</td></tr>
<?php }} ?>

<tr><td>&nbsp;</td><td>
<input class="button large" type="submit" onClick="transmit_form()" value="<?php echo xla('Login');?>">
</td></tr>
<tr><td colspan='2' class='text' style='color:red'>
<?php
$ip=$_SERVER['REMOTE_ADDR'];
?>
</div>
</td></tr>
<div class="warning">
<tr>
<td>
<strong>***WARNING******WARNING******WARNING******WARNING******WARNING***</strong><br />
This computer system is the property of the United States Peace Corps. It may only be accessed and used for official Government business by authorized personnel. Unauthorized access or use of this computer system is strictly prohibited and may subject violators to criminal, civil, and/or administrative action. The Peace Corps may monitor any activity, information, or communication on the system. All activity, communication, and information on this system may be intercepted, recorded, read, copied, retrieved, and disclosed by and to authorized personnel for official purposes, including criminal investigations. Users have no right of privacy or any reasonable expectation of privacy in the use of this computer system and any communication or information stored within the system. Access or use of this computer system by any person whether authorized or unauthorized, constitutes consent to all of these terms. 
</td>
</tr>
<div>
</table>
</div>
<div style="clear: both;"> </div>
<div class="version">
<?php echo "v".text($openemr_version) ?> | <a  href="../../acknowledge_license_cert.html" target="main"><?php echo xlt('Acknowledgments, Licensing and Certification'); ?></a>
</div>
</div>
</td>
</tr>
</table>
</form>
</center>
<script language='JavaScript'>
$( document ).ready(function() {
    transmit_form();
});
</script>
</body>
</html>
