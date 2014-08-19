<?php

//SANITIZE ALL ESCAPES
$sanitize_all_escapes=true;
//

//STOP FAKE REGISTER GLOBALS
$fake_register_globals=false;
//

include_once("../../globals.php");
include_once("$srcdir/sql.inc");
include_once("$srcdir/options.inc.php");

?>

<html>
<head>
<?php html_header_show();?>

<!-- supporting javascript code -->
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/textformat.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dialog.js"></script>


<!-- page styles -->
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">

<style>
.highlight {
  color: green;
}
tr.selected {
  background-color: white;
}	
</style>
		
<!-- pop up calendar -->
<style type="text/css">@import url(<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.css);</style>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.js"></script>
<?php include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php"); ?>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_setup.js"></script>
<script type="text/javascript">
	function checkForAmendments() {
		var amendments = "";
		$("#list_amendments input:checkbox:checked").each(function() {
				amendments += $(this).val() + ",";
		});
		
		if ( amendments == '' ) {
			alert("<?php echo xl('Select amendments to print'); ?>");
			return;
		}
		
		// Call the function to print
		var url = "print_amendments.php?ids=" + amendments;
		window.open(url);
	}
	
	function checkUncheck(option) {
		$("input[name='check_list[]']").each( function () {
			var optionFlag = ( option ) ? true : false;
			$(this).attr('checked',optionFlag);
		});
	}
</script>
</head>

<body class="body_top">

<form action="list_amendments.php" name="list_amendments" id="list_amendments" method="post">

<span class="title"><?php echo htmlspecialchars( xl('List'), ENT_NOQUOTES); ?></span>&nbsp;
<?php 
	$query = "SELECT * FROM amendments WHERE pid = ? ORDER BY amendment_date DESC";
	$resultSet = sqlStatement($query,array($pid));
	if ( sqlNumRows($resultSet)) { ?>
			<table cellspacing="0" cellpadding="0" style="width:100%">
				<tr>
					<td><a href="javascript:checkForAmendments();" class="css_button"><span><?php echo xl("Print Amendments"); ?></span></a></td>
					<td align="right">
						<a href="#" class="small" onClick="checkUncheck(1);"><span><?php echo xl('Check All');?></span></a> |
						<a href="#" class="small" onClick="checkUncheck(0);"><span><?php echo xl('Clear All');?></span></a>
					</td>
				</tr>
			</table>
		<div id="patient_stats">
			<br>
		<table border=0 cellpadding=0 cellspacing=0 style="margin-bottom:1em;">

		<tr class='head'>
			<th style="width:5%"></th>
			<th style="width:15%" align="left"><?php echo htmlspecialchars( xl('Requested Date'), ENT_NOQUOTES); ?></th>
			<th style="width:40%" align="left"><?php echo htmlspecialchars( xl('Request Description'), ENT_NOQUOTES); ?></th>
			<th style="width:25%" align="left"><?php echo htmlspecialchars( xl('Requested By'), ENT_NOQUOTES); ?></th>
			<th style="width:15%" align="left"><?php echo htmlspecialchars( xl('Request Status'), ENT_NOQUOTES); ?></th>
		</tr>
	
		<?php while($row = sqlFetchArray($resultSet)) {
			$amendmentLink = "<a href=add_edit_amendments.php?id=" . $row['amendment_id'] . ">" . oeFormatShortDate($row['amendment_date']) . "</a>";
		?>
			<tr class="amendmentrow" id="<?php echo $row['amendment_id']; ?>">
				<td><input id="check_list[]" name="check_list[]" type="checkbox" value="<?php echo $row['amendment_id']; ?>"></td>
				<td class=text><?php echo $amendmentLink; ?> </td>
				<td class=text><?php echo htmlspecialchars(xl(stripslashes($row['amendment_desc'])),ENT_NOQUOTES); ?> </td>
				<td class=text><?php echo generate_display_field(array('data_type'=>'1','list_id'=>'amendment_from'), $row['amendment_by']); ?> </td>
				<td class=text><?php echo generate_display_field(array('data_type'=>'1','list_id'=>'amendment_status'), $row['amendment_status']); ?> </td>
			</tr>
		<?php } ?>
		</table>
		</div>
	<?php } else { ?>
		<span style="color:red">
			<br>
			<?php echo xl("No ammendment requests available"); ?>
		</span>
	<?php } ?>
</form>
</body>

</html>