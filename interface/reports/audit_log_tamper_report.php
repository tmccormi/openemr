<?php
/**
 * Audit Log Tamper Report.
 *
 * Copyright (C) 2014 Ensoftek
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
 * @author  Anil N <aniln@ensoftek.com>
 * @link    http://www.open-emr.org
 */

//SANITIZE ALL ESCAPES
$sanitize_all_escapes=true;
//

//STOP FAKE REGISTER GLOBALS
$fake_register_globals=false;
//

include_once("../globals.php");
include_once("$srcdir/log.inc");
include_once("$srcdir/formdata.inc.php");
require_once("$srcdir/formatting.inc.php");
?>
<html>
<head>
<?php html_header_show();?>
<link rel="stylesheet" href='<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.css' type='text/css'>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dialog.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.js"></script>
<?php include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php"); ?>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_setup.js"></script>

<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery-1.2.2.min.js"></script>
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
<style>
#logview {
    width: 100%;
}
#logview table {
    width:100%;
    border-collapse: collapse;
}
#logview th {
    background-color: #cccccc;
    cursor: pointer; cursor: hand;
    padding: 5px 5px;
    align: left;
    text-align: left;
}

#logview td {
    background-color: #ffffff;
    border-bottom: 1px solid #808080;
    cursor: default;
    padding: 5px 5px;
    vertical-align: top;
}
.highlight {
    background-color: #336699;
    color: #336699;
}
.tamperColor{
	color:red;
}
</style>
<script>
//function to disable the event type field if the event name is disclosure
function eventTypeChange(eventname)
{
         if (eventname == "disclosure") {
            document.theform.type_event.disabled = true;
          }
         else {
            document.theform.type_event.disabled = false;
         }              
}

// VicarePlus :: This invokes the find-patient popup.
 function sel_patient() {
  dlgopen('../main/calendar/find_patient_popup.php?pflag=0', '_blank', 500, 400);
 }

// VicarePlus :: This is for callback by the find-patient popup.
 function setpatient(pid, lname, fname, dob) {
  var f = document.theform;
  f.form_patient.value = lname + ', ' + fname;
  f.form_pid.value = pid;
 }

</script>
</head>
<body class="body_top">
<font class="title"><?php  xl('Audit Log Tamper Report','e'); ?></font>
<br>
<?php 
$err_message=0;
if ($_GET["start_date"])
$start_date = formData('start_date','G');

if ($_GET["end_date"])
$end_date = formData('end_date','G');

if ($_GET["form_patient"])
$form_patient = formData('form_patient','G');

/*
 * Start date should not be greater than end date - Date Validation
 */
if ($start_date && $end_date)
{
	if($start_date > $end_date){
		echo "<table><tr class='alert'><td colspan=7>"; xl('Start Date should not be greater than End Date',e);
		echo "</td></tr></table>"; 
		$err_message=1;	
	}
}

?>
<?php
$form_user = formData('form_user','R');
$form_pid = formData('form_pid','R');
if ($form_patient == '' ) $form_pid = '';

$get_sdate=$start_date ? $start_date : date("Y-m-d");
$get_edate=$end_date ? $end_date : date("Y-m-d");

?>
<br>
<FORM METHOD="GET" name="theform" id="theform">
<?php

$sortby = formData('sortby','G') ;
?>
<input type="hidden" name="sortby" id="sortby" value="<?php echo $sortby; ?>">
<input type=hidden name=csum value="">
<table>
<tr><td>
<span class="text"><?php  xl('Start Date','e'); ?>: </span>
</td><td>
<input type="text" size="10" name="start_date" id="start_date" value="<?php echo $start_date ? substr($start_date, 0, 10) : date('Y-m-d'); ?>" title="<?php  xl('yyyy-mm-dd Date of service','e'); ?>" onkeyup="datekeyup(this,mypcc)" onblur="dateblur(this,mypcc)" />
<img src="../pic/show_calendar.gif" align="absbottom" width="24" height="22" id="img_begin_date" border="0" alt="[?]" style="cursor: pointer; cursor: hand" title="<?php  xl('Click here to choose a date','e'); ?>">&nbsp;
</td>
<td>
<span class="text"><?php  xl('End Date','e'); ?>: </span>
</td><td>
<input type="text" size="10" name="end_date" id="end_date" value="<?php echo $end_date ? substr($end_date, 0, 10) : date('Y-m-d'); ?>" title="<?php  xl('yyyy-mm-dd Date of service','e'); ?>" onkeyup="datekeyup(this,mypcc)" onblur="dateblur(this,mypcc)" />
<img src="../pic/show_calendar.gif" align="absbottom" width="24" height="22" id="img_end_date" border="0" alt="[?]" style="cursor: pointer; cursor: hand" title="<?php  xl('Click here to choose a date','e'); ?>">&nbsp;
</td>
<!--VicarePlus :: Feature For Generating Log For The Selected Patient --!>
<td>
&nbsp;&nbsp;<span class='text'><?php echo htmlspecialchars(xl('Patient'),ENT_NOQUOTES); ?>: </span>
</td>
<td>
<input type='text' size='20' name='form_patient' style='width:100%;cursor:pointer;cursor:hand' value='<?php echo $form_patient ? $form_patient : htmlspecialchars(xl('Click To Select'),ENT_QUOTES); ?>' onclick='sel_patient()' title='<?php echo htmlspecialchars(xl('Click to select patient'),ENT_QUOTES); ?>' />
<input type='hidden' name='form_pid' value='<?php echo $form_pid; ?>' />
</td>
</tr>

<tr><td>
<span class='text'><?php xl('Include Checksum','e'); ?>: </span>
</td><td>
<?php

$check_sum = formData('check_sum','G');
?>
<input type="checkbox" name="check_sum" " <?php if ($check_sum == 'on') echo "checked";  ?>"></input>
</td>
<td>
<input type=hidden name="event" value=<?php echo $event ; ?>>
<a href="javascript:document.theform.submit();" class='link_submit'>[<?php  xl('Refresh','e'); ?>]</a>
</td>
</tr>
</table>
</FORM>


<?php if ($start_date && $end_date && $err_message!=1) { ?>
<div id="logview">
<span class="text" id="display_tamper" style="display:none;"><?php  xl('Following rows in the audit log have been tampered','e'); ?></span>
<table>
 <tr>
  <th id="sortby_date" class="text" title="<?php xl('Sort by Tamper date/time','e'); ?>"><?php xl('Tamper Date','e'); ?></th>
  <th id="sortby_user" class="text" title="<?php xl('Sort by User','e'); ?>"><?php  xl('User','e'); ?></th>
  <th id="sortby_pid" class="text" title="<?php xl('Sort by PatientID','e'); ?>"><?php  xl('PatientID','e'); ?></th>
  <th id="sortby_comments" class="text" title="<?php xl('Sort by Comments','e'); ?>"><?php  xl('Comments','e'); ?></th>
 <?php  if($check_sum) {?>
  <th id="sortby_newchecksum" class="text" title="<?php xl('Sort by New Checksum','e'); ?>"><?php  xl('Tampered Checksum','e'); ?></th>
  <th id="sortby_oldchecksum" class="text" title="<?php xl('Sort by Old Checksum','e'); ?>"><?php  xl('Original Checksum','e'); ?></th>
  <?php } ?>
 </tr>
<?php

$eventname = formData('eventname','G');
$type_event = formData('type_event','G');
?>
<input type=hidden name=event value=<?php echo $eventname."-".$type_event ?>>
<?php
$type_event = "update";
$tevent=""; 
$gev="";
if($eventname != "" && $type_event != ""){
	$getevent=$eventname."-".$type_event;
}
      
if(($eventname == "") && ($type_event != "")){	
	$tevent=$type_event;   	
}else if($type_event =="" && $eventname != ""){
	$gev=$eventname;
}else if ($eventname == ""){
	$gev = "";
}else{
	$gev = $getevent;
}

$dispArr = array();
$icnt = 1;
if ($ret = getEvents(array('sdate' => $get_sdate,'edate' => $get_edate, 'user' => $form_user, 'patient' => $form_pid, 'sortby' => $_GET['sortby'], 'levent' =>$gev, 'tevent' =>$tevent))) {
  foreach ($ret as $iter) {
    //translate comments
    $patterns = array ('/^success/','/^failure/','/ encounter/');
	$replace = array ( xl('success'), xl('failure'), xl('encounter','',' '));
	
	$dispCheck = false;
	$log_id = $iter['id'];
	$commentEncrStatus = "No";
	$logEncryptData = logCommentEncryptData($log_id);
	
	if(count($logEncryptData) > 0){
		$commentEncrStatus = $logEncryptData['encrypt'];
		$checkSumOld = $logEncryptData['checksum'];
		$concatLogColumns = $iter['date'].$iter['event'].$iter['user'].$iter['groupname'].$iter['comments'].$iter['patient_id'].$iter['success'].$iter['checksum'].$iter['crt_user'];
		$checkSumNew = sha1($concatLogColumns);
		
		if($checkSumOld != $checkSumNew){
			$dispCheck = true;
		}else{
			$dispCheck = false;
			continue;
		}
	}else{
		continue;
	}
	
	if($commentEncrStatus == "Yes"){
		$decrypt_comment =  trim(aes256Decrypt($iter["comments"]));
		$trans_comments = preg_replace($patterns, $replace, $decrypt_comment);
	}else{
		$comments = trim($iter["comments"]);
		$trans_comments = preg_replace($patterns, $replace, $comments);
	}
	
	//Alter Checksum value records only display here
	if($dispCheck){
		$dispArr[] = $icnt++;
?>
	 <TR class="oneresult">
		  <TD class="text tamperColor"><?php echo oeFormatShortDate(substr($iter["date"], 0, 10)) . substr($iter["date"], 10) ?></TD>
		  <TD class="text tamperColor"><?php echo $iter["user"]?></TD>
		  <TD class="text tamperColor"><?php echo $iter["patient_id"]?></TD>
		  <TD class="text tamperColor"><?php echo $trans_comments?></TD>
		  <?php  if($check_sum) { ?>
		  <TD class="text tamperColor"><?php echo $checkSumNew;?></TD>
		  <TD class="text tamperColor"><?php echo $checkSumOld;?></TD>
		  <?php } ?>
	 </TR>
<?php
      }
    }
  }
  
  if( count($dispArr) == 0 ){?>
	 <TR class="oneresult">
		 <?php 
			$colspan = 4;
			if($check_sum) $colspan=6;
		 ?>
		<TD class="text" colspan="<?php echo $colspan;?>" align="center"><?php xl('No audit log tampering detected in the selected date range.','e'); ?></TD>
	 </TR>
<?php
  }else{?>
	<script type="text/javascript">$('#display_tamper').css('display', 'block');</script>
  <?php
  }
  
?>
</table>
</div>
<?php } ?>
</body>
<script language="javascript">

// jQuery stuff to make the page a little easier to use
$(document).ready(function(){
    // funny thing here... good learning experience
    // the TR has TD children which have their own background and text color
    // toggling the TR color doesn't change the TD color
    // so we need to change all the TR's children (the TD's) just as we did the TR
    // thus we have two calls to toggleClass:
    // 1 - for the parent (the TR)
    // 2 - for each of the children (the TDs)
    $(".oneresult").mouseover(function() { $(this).toggleClass("highlight"); $(this).children().toggleClass("highlight"); });
    $(".oneresult").mouseout(function() { $(this).toggleClass("highlight"); $(this).children().toggleClass("highlight"); });

    // click-able column headers to sort the list
    $("#sortby_date").click(function() { $("#sortby").val("date"); $("#theform").submit(); });
    $("#sortby_event").click(function() { $("#sortby").val("event"); $("#theform").submit(); });
    $("#sortby_user").click(function() { $("#sortby").val("user"); $("#theform").submit(); });
    $("#sortby_cuser").click(function() { $("#sortby").val("user"); $("#theform").submit(); });
    $("#sortby_group").click(function() { $("#sortby").val("groupname"); $("#theform").submit(); });
    $("#sortby_pid").click(function() { $("#sortby").val("patient_id"); $("#theform").submit(); });
    $("#sortby_success").click(function() { $("#sortby").val("success"); $("#theform").submit(); });
    $("#sortby_comments").click(function() { $("#sortby").val("comments"); $("#theform").submit(); });
    $("#sortby_oldchecksum").click(function() { $("#sortby").val("checksum"); $("#theform").submit(); });
	$("#sortby_newchecksum").click(function() { $("#sortby").val("checksum"); $("#theform").submit(); });
});


/* required for popup calendar */
Calendar.setup({inputField:"start_date", ifFormat:"%Y-%m-%d", button:"img_begin_date"});
Calendar.setup({inputField:"end_date", ifFormat:"%Y-%m-%d", button:"img_end_date"});

</script>

</html>

