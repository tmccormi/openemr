<?php
include_once("../../globals.php");

$feature = formData("feature",'R');
$featureData['amendment']['title'] = "Amendments";
$featureData['amendment']['addLink'] = "add_edit_amendments.php";
$featureData['amendment']['listLink'] = "list_amendments.php";

?>
<html>
<head>
<?php html_header_show();?>
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
</head>
<body class="body_top">

<span class="title"><?php xl($featureData[$feature]['title'],'e'); ?></span>
<table>
<tr height="20px">
<td>

<a href="<?php echo $GLOBALS['webroot']?>/interface/patient_file/summary/<?php echo $featureData[$feature]['listLink']; ?>?id=<?php echo $pid; ?>" target='rightFrame' class="css_button" onclick="top.restoreSession()">
<span><?php xl('List', 'e');?></span></a>
<?php if ( acl_check('patients', 'trans') ) { ?>
	<a href="<?php echo $GLOBALS['webroot']?>/interface/patient_file/summary/<?php echo $featureData[$feature]['addLink']; ?>" target='rightFrame' class="css_button" onclick="top.restoreSession()">
	<span><?php xl('Add','e');?></span></a>
<?php } ?>
</td>
</tr>
</table>

</body>
</html>
