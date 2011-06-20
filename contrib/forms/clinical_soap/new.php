<?php
//////////////////////////////////////////////////////////////////////
// ------------------ DO NOT MODIFY VIEW.PHP !!! ---------------------
// View.php is an exact duplicate of new.php.  If you wish to make
// any changes, then change new.php and either (recommended) make
// view.php a symbolic link to new.php, or copy new.php to view.php.
//
// And if you check in a change to either module, be sure to check
// in the other (identical) module also.
//
// This nonsense will go away if we ever move to subversion.
//////////////////////////////////////////////////////////////////////

// Copyright (C) 2011 Medical Information Integration, LLC - tony@mi-squared.com
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

include_once("../../globals.php");
include_once("$srcdir/api.inc");
include_once("$srcdir/forms.inc");

$row = array();

if (! $encounter) { // comes from globals.php
 die("Internal error: we do not seem to be in an encounter!");
}

function rbvalue($rbname) {
 $tmp = $_POST[$rbname];
 if (! $tmp) $tmp = '0';
 return "'$tmp'";
}

function cbvalue($cbname) {
 return $_POST[$cbname] ? '1' : '0';
}

function rbinput($name, $value, $desc, $colname) {
 global $row;
 $ret  = "<input type='radio' name='$name' value='$value'";
 if ($row[$colname] == $value) $ret .= " checked";
 $ret .= " />$desc";
 return $ret;
}

function rbcell($name, $value, $desc, $colname) {
 return "<td width='25%' nowrap>" . rbinput($name, $value, $desc, $colname) . "</td>\n";
}

function cbinput($name, $colname) {
 global $row;
 $ret  = "<input type='checkbox' name='$name' value='1'";
 if ($row[$colname]) $ret .= " checked";
 $ret .= " />";
 return $ret;
}

function cbcell($name, $desc, $colname) {
 return "<td width='25%' nowrap>" . cbinput($name, $colname) . "$desc</td>\n";
}

$formid = $_GET['id'];

// If Save was clicked, save the info.
//
if ($_POST['bn_save']) {

 $fu_timing = $_POST['fu_timing'];

 // If updating an existing form...
 //
 if ($formid) {
  $query = "UPDATE form_clinical_soap SET "      .
   "findings = '"          . $_POST['form_history']     . "', " .
   "radiology = '"         . $_POST['form_radiology'] . "', " .
   "assessment = '"        . $_POST['form_assessment'] . "', " .
   "plan = '"              . $_POST['form_plan']        . "', " .
   "followup_required = " . rbvalue('fu_required')     . ", "  .
   "followup_timing = '$fu_timing'"                    . " "   .
   "WHERE id = '$formid'";
  sqlStatement($query);
 }

 // If adding a new form...
 //
 else {
  $query = "INSERT INTO form_clinical_soap ( " .
   "findings, radiology, assessment, plan, followup_required, followup_timing " .
// ",outcome, destination " .
   ") VALUES ( " .
   "'" . $_POST['form_findings']     . "', " .
   "'" . $_POST['form_radiology']   . "', " .
   "'" . $_POST['form_assessment']  . "', " .
   "'" . $_POST['form_plan']        . "', " .
   rbvalue('fu_required')           . ", "  .
   "'$fu_timing'"                   . " "   .
// rbvalue('outcome')               . ", "  .
// rbvalue('destination')           . " "   .
   ")";
  $newid = sqlInsert($query);
  addForm($encounter, "Clinical Soap Notes", $newid, "clinical_soap", $pid, $userauthorized);
 }

 formHeader("Redirecting....");
 formJump();
 formFooter();
 exit;
}

if ($formid) {
 $row = sqlQuery ("SELECT * FROM form_clinical_soap WHERE " .
  "id = '$formid' AND activity = '1'") ;
}
?>
<html>
<head>
<?php html_header_show();?>
<link rel=stylesheet href="<?echo $css_header;?>" type="text/css">
<script language="JavaScript">
</script>
</head>

<body <?echo $top_bg_line;?> topmargin="0" rightmargin="0" leftmargin="2"
 bottommargin="0" marginwidth="2" marginheight="0">
<form method="post" action="<?php echo $rootdir ?>/forms/clinical_soap/new.php?id=<?php echo $formid ?>"
 onsubmit="return top.restoreSession()">

<center>

<p>
<table border='1' width='95%'>

 <tr bgcolor='#dddddd'>
  <td colspan='2' align='center'><b>Clinical SOAP Notes</b></td>
 </tr>

 <tr>
  <td width='5%'  nowrap> Additional Clinical Findings </td>
  <td width='95%' nowrap>
   <textarea name='form_findings' rows='7' style='width:100%'><?php echo $row['findings'] ?></textarea>
  </td>
 </tr>

 <tr>
  <td nowrap> Radiographic Findings </td>
  <td nowrap>
   <textarea name='form_radiology' rows='7' style='width:100%'><?php echo $row['radiology'] ?></textarea>
  </td>
 </tr>

 <tr>
  <td nowrap> Examination </td>
  <td nowrap>
   <textarea name='form_assessment' rows='7' style='width:100%'><?php echo $row['assessment'] ?></textarea>
  </td>
 </tr>

 <tr>
  <td nowrap> Plan </td>
  <td nowrap>
   <textarea name='form_plan' rows='7' style='width:100%'><?php echo $row['plan'] ?></textarea>
  </td>
 </tr>

 <tr>
  <td nowrap>Follow Up</td>
  <td nowrap>
   <table width='100%'>
    <tr>
     <td width='5%' nowrap>
      <?php echo rbinput('fu_required', '1', 'Required in:', 'followup_required') ?>
     </td>
     <td nowrap>
      <input type='text' name='fu_timing' size='10' style='width:100%'
       title='When to follow up'
       value='<?php echo addslashes($row['followup_timing']) ?>' />
     </td>
    </tr>
    <tr>
     <td colspan='2' nowrap>
      <?php echo rbinput('fu_required', '2', 'Pending investigation', 'followup_required') ?>
     </td>
    </tr>
    <tr>
     <td colspan='2' nowrap>
      <?php echo rbinput('fu_required', '0', 'None required', 'followup_required') ?>
     </td>
    </tr>
   </table>
  </td>
 </tr>

</table>

<p>
<input type='submit' name='bn_save' value='Save' />
&nbsp;
<input type='button' value='Cancel' onclick="top.restoreSession();location='<?php echo $GLOBALS['form_exit_url'] ?>'" />
</p>

</center>

</form>
</body>
</html>
