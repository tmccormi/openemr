<?php
// Copyright (C) 2010 Rod Roark <rod@sunsetsystems.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

require_once("../../globals.php");
require_once("$srcdir/api.inc");
require_once("$srcdir/forms.inc");
require_once("$srcdir/options.inc.php");
require_once("$srcdir/formdata.inc.php");
require_once("$srcdir/formatting.inc.php");

// Defaults for new orders.
$row = array(
  'provider_id' => $_SESSION['authUserID'],
  'date_ordered' => date('Y-m-d'),
  'date_collected' => date('Y-m-d H:i'),
);

if (! $encounter) { // comes from globals.php
 die("Internal error: we do not seem to be in an encounter!");
}

function cbvalue($cbname) {
 return $_POST[$cbname] ? '1' : '0';
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

function QuotedOrNull($fld) {
  if (empty($fld)) return "NULL";
  return "'$fld'";
}

$formid = formData('id', 'G') + 0;

// If Save was clicked, save the info.
//
//if ($_POST['bn_save']) {
//
//  $sets =
//    "procedure_type_id = " . (formData('form_proc_type') + 0)           . ", " .
//    "date_ordered = " . QuotedOrNull(formData('form_date_ordered'))     . ", " .
//    "provider_id = " . (formData('form_provider_id') + 0)               . ", " .
//    "date_collected = " . QuotedOrNull(formData('form_date_collected')) . ", " .
//    "order_priority = '" . formData('form_order_priority')              . "', " .
//    "order_status = '" . formData('form_order_status')                  . "', " .
//    "patient_instructions = '" . formData('form_patient_instructions')  . "', " .
//    "patient_id = '" . $pid                                             . "', " .
//    "encounter_id = '" . $encounter                                     . "'";
//
//  // If updating an existing form...
//  //
//  if ($formid) {
//    $query = "UPDATE procedure_order SET $sets "  .
//      "WHERE procedure_order_id = '$formid'";
//    sqlStatement($query);
//  }
//
//  // If adding a new form...
//  //
//  else {
//    $query = "INSERT INTO procedure_order SET $sets";
//    $newid = sqlInsert($query);
//    addForm($encounter, "Procedure Order", $newid, "procedure_order", $pid, $userauthorized);
//  }
//
//  formHeader("Redirecting....");
//  formJump();
//  formFooter();
//  exit;
//}
//
//if ($formid) {
//  $row = sqlQuery ("SELECT * FROM procedure_order WHERE " .
//    "procedure_order_id = '$formid' AND activity = '1'") ;
//}
//
$enrow = sqlQuery("SELECT p.fname, p.mname, p.lname, fe.date FROM " .
  "form_encounter AS fe, forms AS f, patient_data AS p WHERE " .
  "p.pid = '$pid' AND f.pid = '$pid' AND f.encounter = '$encounter' AND " .
  "f.formdir = 'newpatient' AND f.deleted = 0 AND " .
  "fe.id = f.form_id LIMIT 1");

if(formData('ajax_mode') == "list_tests"){
  echo "<option value='select' >--select--</option>";
  $labquer = sqlStatement("
    SELECT 
      option_id,title
    FROM
      list_options AS lo 
    WHERE lo.list_id = ? ORDER BY lo.seq, lo.title
  ",array(formData('lab')));
  while ($labres = sqlFetchArray($labquer)) {
    echo "<option value='".$labres['option_id']."' >".$labres['title']."</option>";
  }
  exit;
}
?>
<html>
<head>
<?php html_header_show(); ?>
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css" />

<style>

td {
 font-size:10pt;
}

.inputtext {
 padding-left:2px;
 padding-right:2px;
}

</style>

<style type="text/css">@import url(<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.css);</style>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.js"></script>
<?php include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php"); ?>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_setup.js"></script>
<script type="text/javascript" src="../../../library/js/jquery-1.4.3.min.js"></script>
<script type="text/javascript" src="../../../library/dialog.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/textformat.js"></script>

<script language='JavaScript'>
function load_tests(lab){
  if(lab != 'select'){
    document.getElementById('test_name_tr').style.display = '';
    document.getElementById('formname').value = lab;
    $.ajax({
      type: "POST",
      url: "../../forms/procedure_order/new.php",
      dataType: "html",
      data: {
      ajax_mode: "list_tests",
      lab: lab
      },              
      success: function(thedata){
        //alert(thedata);
        document.getElementById('test_name').innerHTML = thedata;
      },
      error: function (request, status, error) {
        alert(request.responseText);
      }
    });
  }else{
    document.getElementById('test_name_tr').style.display = 'none';
  }
  load_template('select');
}
function load_template(test){
  if(test != 'select'){
    document.getElementById('template_div').style.display = '';
    document.getElementById('formoption').value = test;
    $.ajax({
      type: "POST",
      url: "../../forms/procedure_order/template.php",
      dataType: "html",
      data: {
      ajax_mode: "get_template",
      formname: document.getElementById('lab_name').value,
      formoption: test
      },              
      success: function(thedata){
        //alert(thedata);
        document.getElementById('template_div').innerHTML = thedata;
      },
      error: function (request, status, error) {
        alert(request.responseText);
      }
    });
  }else{
    document.getElementById('template_div').style.display = 'none';
  }
}
</script>

</head>

<body class="body_top">

<form method="post" action="<?php echo $rootdir ?>/forms/procedure_order/template.php?id=<?php echo $formid ?>" onsubmit="return top.restoreSession()">

<p class='title' style='margin-top:8px;margin-bottom:8px;text-align:center'>
<?php
  echo xl('Procedure Order for') . ' ';
  echo $enrow['fname'] . ' ' . $enrow['mname'] . ' ' . $enrow['lname'];
  echo ' ' . xl('on') . ' ' . oeFormatShortDate(substr($enrow['date'], 0, 10));
?>
</p>
<center>
<?php
  $lab_query = sqlStatement("
    SELECT 
      lo.option_id,CONCAT(lname, ' ', fname) AS lab_name
    FROM
      users AS u 
      LEFT JOIN list_options AS lo 
        ON lo.title = CONCAT(lname, ' ', fname) 
    WHERE u.abook_type = 'ord_lab'
  ");
  echo "<br/><table><tr><td>";
  echo xl('Select Lab',e);
  echo "</td><td><select name='lab_name' id='lab_name' onchange='load_tests(this.value);' >
          <option value='select' >--select--</option>";
  while($lab_result = sqlFetchArray($lab_query)){
    echo "<option value='".$lab_result['option_id']."' >".$lab_result['lab_name']."</option>";
  }
  echo "</select></td></tr>";
  echo "<tr><td>&nbsp;</td></tr><tr id='test_name_tr' style='display:none' ><td>";
  echo xl('Select Test',e);
  echo "</td><td><select name='test_name' id='test_name' onchange='load_template(this.value);' >";
  echo "</select></td></tr>";
  echo "<table><br/><div id='template_div' style='display:none' ></div>";
  echo "<input type='hidden' name='formname' id='formname' value='' >";
  echo "<input type='hidden' name='formoption' id='formoption' value='' >";
?>
</center>
</form>
</body>
</html>