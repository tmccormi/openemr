<?php
// Copyright (C) 2010 Rod Roark <rod@sunsetsystems.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

require_once("../globals.php");
require_once("$srcdir/acl.inc");
require_once("$srcdir/formdata.inc.php");

?>
<html>

<head>

<title><?php xl('Order and Result Types','e'); ?></title>

<link rel="stylesheet" href='<?php echo $css_header ?>' type='text/css'>

<style type="text/css">
body {
 font-family:sans-serif;
 font-size:9pt;
 font-weight:normal;
 padding: 5px 3px 5px 3px;
}
#con0 table {
 margin:0;
 padding:0;
 width:100%;
}
#con0 td {
 padding:0pt;
 font-family:sans-serif;
 font-size:9pt;
}
.plusminus {
 font-family:monospace;
 font-size:10pt;
}
.haskids {
 color:#0000dd;
 cursor:pointer;
 cursor:hand;
}
tr.head {
font-size:10pt;
background-color:#cccccc;
font-weight:bold;
}
tr.evenrow {
 background-color:#ddddff;
}
tr.oddrow {
 background-color:#ffffff;
}

.col1 {width:50%}
.col2 {width:50%}

.col11 {width:90%}
.col12 {width:10%}

</style>
<link rel="stylesheet" type="text/css" href="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.css" media="screen" />
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery-1.4.3.min.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox-1.3.4/jquery.fancybox-1.3.4.js" ></script>
<script type="text/javascript">
function toggle(id){
  if(document.getElementById('tr'+id).style.display == ''){
    document.getElementById('tr'+id).style.display = 'none';
    document.getElementById('plusminus'+id).innerHTML = '&#43;';
  }else{
    document.getElementById('tr'+id).style.display = '';
    document.getElementById('plusminus'+id).innerHTML = '&#8722;';
  }
}
function add_test(lab){
  document.getElementById('list_id').value = lab;
  document.theform.action='../super/edit_list.php';
  document.theform.submit();
}
function edit_test(lab,test){
  document.getElementById('layout_id').value = "LAB||"+lab+"||"+test;
  document.theform.action='../super/edit_layout.php';
  document.theform.submit();
}
</script>
</head>

<body class="body_nav">
<center>

<h3 style='margin-top:0'><?php xl('Types of Orders and Results','e') ?></h3>

<form method='post' name='theform' id='theform' >

  <table width='100%' cellspacing='0' cellpadding='0' border='0'>
   <tr class='head'>
    <th class='col1' align='left'>&nbsp;&nbsp;<?php xl('Name','e') ?></th>
    <th class='col5' align='left'>&nbsp;</th>
   </tr>
  </table>

  <div id="con0">
    <table width='100%' cellspacing='0' cellpadding='0' border='0'>
<?php
  $lab_query = sqlStatement("SELECT id,CONCAT(lname, fname) AS lab_name FROM users WHERE abook_type = 'ord_lab'");
  while($lab_res = sqlFetchArray($lab_query)){
    $lab_test_query = sqlStatement("SELECT option_id, title FROM list_options WHERE list_id = CONCAT('ord_lab_', ?) ORDER BY title, seq",array($lab_res['id']));
    $count = sqlNumRows($lab_test_query);
    echo "<tr><td class='col1' align='left' style='font-weight:bold' ";
    if($count > 0){
      echo "onclick='toggle(\"".$lab_res['id']."\");'";
    }
    echo ">";
    if($count > 0){
      echo "<span id='plusminus".$lab_res['id']."' style='' >&#43;</span>";
    }else{
      echo "&nbsp;&nbsp;";
    }
    echo "&nbsp;&nbsp;";
    echo xl($lab_res['lab_name'],'e');
    echo "</td><td class='col2'><a href='javascript: add_test(\"ord_lab_".$lab_res['id']."\")' >Add Test</a></td></tr>";
    if($count > 0){
      echo "<td><table id='tr".$lab_res['id']."' style='display:none' width='100%' cellspacing='0' >";
      while($lab_test_res = sqlFetchArray($lab_test_query)){
        echo "<tr><td class='col11' style='padding-left:20px;' >";
        echo $lab_test_res['title'];
        echo "</td><td class='col12' ><a href='javascript: edit_test(\"ord_lab_".$lab_res['id']."\",\"".$lab_test_res['option_id']."\")' >Edit</a></td></tr>";
      }
      echo "</table></td>";
    }
  }
?>
    </table>
  </div>
  <input type="hidden" name="list_id" id="list_id" >
  <input type="hidden" name="layout_id" id="layout_id" >
  <input type="hidden" name="source" id="source" value="laborder" >
</form>

</center>

</body>
</html>