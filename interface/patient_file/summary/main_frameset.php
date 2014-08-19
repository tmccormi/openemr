<?php
include_once("../../globals.php");

$feature = formData("feature",'R');
$id = formData("id",'R');

$featureData['amendment']['title'] = "Amendments";
$featureData['amendment']['addLink'] = "add_edit_amendments.php";
$featureData['amendment']['listLink'] = "list_amendments.php";
?>
<html>
<head>
<?php html_header_show();?>
<title><?php xl($featureData[$feature]['title'],'e'); ?></title>
</head>

<frameset cols="18%,*" id="main_frame">
 <frame src="left_frame.php?feature=<?php echo $feature; ?>" name="leftFrame" scrolling="auto"/>
 <?php if ( $id ) { ?>
 	<frame src="<?php echo $GLOBALS['webroot'] ?>/interface/patient_file/summary/<?php echo $featureData[$feature]['addLink']; ?>?id=<?php echo $id ?>"
		name="rightFrame" scrolling="auto"/>
 <?php } else { ?>
	<frame src="<?php echo $GLOBALS['webroot'] ?>/interface/patient_file/summary/<?php echo $featureData[$feature]['listLink']; ?>?id=<?php echo $pid ?>"
		name="rightFrame" scrolling="auto"/>
 <?php } ?>
</frameset>

</html>
