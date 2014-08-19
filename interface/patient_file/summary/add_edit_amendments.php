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

$DateFormat=DateFormatRead();
if ( isset($_POST['mode'] )) {
	$currentUser = $_SESSION['authUserID'];
	$created_time = date('Y-m-d H:i');
	if ( formData("amendment_id") == "" ) {
		// New. Insert
		$query = "INSERT INTO amendments SET 
			amendment_date = ?,
			amendment_by = ?,
			amendment_status = ?,
			pid = ?,
			amendment_desc = ?,
			created_by = ?,
			created_time = ?";
		$sqlBindArray = array(
			DateToYYYYMMDD( formData('amendment_date')),
			formData('form_amendment_by'),
			formData('form_amendment_status'),
			$pid,
			formData('desc'),
			$currentUser,
			$create_time
		);
		$amendment_id = sqlInsert($query,$sqlBindArray);
	} else {
		$amendment_id = formData('amendment_id');
		// Existing. Update
		$query = "UPDATE amendments SET 
			amendment_date = ?,
			amendment_by = ?,
			amendment_status = ?,
			amendment_desc = ?,
			modified_by = ?,
			modified_time = ?
			WHERE amendment_id = ?";
		$sqlBindArray = array(
			DateToYYYYMMDD(formData('amendment_date')),
			formData('form_amendment_by'),
			formData('form_amendment_status'),
			formData('desc'),
			$currentUser,
			$create_time,
			formData('amendment_id')
		);
		sqlStatement($query,$sqlBindArray);
	}
	
	// Insert into amendments_history
	$query = "INSERT INTO amendments_history SET 
		amendment_id = ? ,
		amendment_note = ?,
		amendment_status = ?,
		created_by = ?,
		created_time = ?";
	$sqlBindArray = array(
		$amendment_id,
		formData('note','P',true),
		formData("form_amendment_status"),
		$currentUser,
		$created_time
	);
	sqlStatement($query,$sqlBindArray);
}

$amendment_id = ( $amendment_id ) ? $amendment_id : $_REQUEST['id'];
if ( $amendment_id ) {
	$query = "SELECT * FROM amendments WHERE amendment_id = ? ";
	$resultSet = sqlQuery($query,array($amendment_id));
	$amendment_date = $resultSet['amendment_date'];
	$amendment_status = $resultSet['amendment_status'];
	$amendment_by = $resultSet['amendment_by'];
	$amendment_desc = stripslashes($resultSet['amendment_desc']);
	
	$query = "SELECT * FROM amendments_history ah INNER JOIN users u ON ah.created_by = u.id WHERE amendment_id = ? ";
	$resultSet = sqlStatement($query,array($amendment_id));
}
// Check the ACL
$haveAccess = acl_check('patients', 'trans');
$onlyRead = ( $haveAccess ) ? 0 : 1;
$onlyRead = ( $onlyRead || $amendment_status ) ? 1 : 0;
$customAttributes = ( $onlyRead ) ? array("disabled" => "true") : null;

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

function formValidation() {
	if ( $("#amendment_date").val() == "" ) {
		alert("<?php xl('Select Amendment Date','e'); ?>");
		return;
	} else if ( $("#form_amendment_by").val() == "" ) {
		alert("<?php xl('Select Requested By','e'); ?>");
		return;
	}

	var statusText = $("#form_amendment_status option:selected").text();
	$("#note").val($("#note").val() + ' ' + statusText);

	$("#add_edit_amendments").submit();
}
</script>

</head>

<body class="body_top">

<form action="add_edit_amendments.php" name="add_edit_amendments" id="add_edit_amendments" method="post">

	<table>
	<tr>
		<td>
			<span class="title"><?php echo htmlspecialchars( xl('Amendments'), ENT_NOQUOTES); ?></span>&nbsp;
		</td>
		<?php if ( ! $onlyRead ) { ?>
		<td>
			<a href=# onclick="formValidation()" class="css_button_small"><span><?php echo xl('Save');?></span></a>
		</td>
		<?php } ?>
		<td>
			<a href="list_amendments.php" class="css_button_small"><span><?php echo xl('Back');?></span></a>
		</td>			
	</tr>
	</table>

	<br>
    <table border=0 cellpadding=1 cellspacing=1>
		<tr>
			<td><span class=text ><?php echo htmlspecialchars(xl('Requested Date')); ?></span></td>
			<td ><input type='text' size='10' name="amendment_date" id="amendment_date" readonly 
						value='<?php echo $amendment_date ? htmlspecialchars( oeFormatShortDate($amendment_date), ENT_QUOTES) : oeFormatShortDate(); ?>'
    		/>
			<?php if ( ! $onlyRead ) { ?>
         	<img src='<?php echo $rootdir; ?>/pic/show_calendar.gif' width='24' height='22'
    			id='img_amendment_date' valign="middle" border='0' alt='[?]' style='cursor:pointer;cursor:hand'
    			title='<?php echo htmlspecialchars( xl('Click here to choose a date'), ENT_QUOTES); ?>'>
			<script type="text/javascript">
				Calendar.setup({inputField:"amendment_date", ifFormat:"<?php echo $DateFormat ?>", button:"img_amendment_date"});
			</script>
			<?php } ?>
			</td>
		</tr>
		
		<tr>
			<td><span class=text ><?php echo htmlspecialchars(xl('Requested By')); ?></span></td>
			<td>
				<?php echo generate_select_list("form_amendment_by", "amendment_from", $amendment_by,'Amendment Request By',' ','','','',$customAttributes); ?>
			</td>
		</tr>
		
		<tr>
			<td><span class=text ><?php echo htmlspecialchars(xl('Request Description')); ?></span></td>
			<td><textarea <?php echo ( $onlyRead ) ? "readonly" : "";  ?> id="desc" name="desc" rows="4" cols="30"><?php ($amendment_id) ? xl($amendment_desc,'e') : "" ; ?></textarea></td>
		</tr>
		
		<tr>
			<td><span class=text ><?php echo htmlspecialchars(xl('Request Status')); ?></span></td>
			<td>
				<?php echo generate_select_list("form_amendment_status", "amendment_status", $amendment_status,'Amendment Status',' ','','','',$customAttributes); ?>
			</td>
		</tr>
		
		<tr>
			<td><span class=text ><?php echo htmlspecialchars(xl('Comments')); ?></span></td>
			<td><textarea <?php echo ( $onlyRead ) ? "readonly" : "";  ?> id="note" name="note" rows="4" cols="30"><?php ($amendment_id) ? "" : xl('New amendment request','e'); ?></textarea></td>
		</tr>
	</table>
	
	<?php if ( $amendment_id ) { ?>
	<hr>
	
	<span class="title"><?php echo xl("History") ; ?></span>
    
	<table border="1" cellpadding=3 cellspacing=0>

    <!-- some columns are sortable -->
    <tr class='text bold'>
		<th align="left" style="width:15%"><?php echo htmlspecialchars( xl('Date'), ENT_NOQUOTES); ?></th>
		<th align="left" style="width:25%"><?php echo htmlspecialchars( xl('By'), ENT_NOQUOTES); ?></th>
		<th align="left" style="width:15%"><?php echo htmlspecialchars( xl('Status'), ENT_NOQUOTES); ?></th>
		<th align="left"><?php echo htmlspecialchars( xl('Comments'), ENT_NOQUOTES); ?></th>
	</tr>	

	<?php 
	 if (sqlNumRows($resultSet)) {
		while ( $row = sqlFetchArray($resultSet) ) {
			$created_date = date('Y-m-d', strtotime($row['created_time']));
			echo "<tr>";
			$userName = $row['lname'] . ", " . $row['fname'];
			echo "<td align=left class=text>" . htmlspecialchars(xl(oeFormatShortDate($created_date)),ENT_NOQUOTES) . "</td>";
			echo "<td align=left class=text>" . htmlspecialchars(xl($userName),ENT_NOQUOTES) . "</td>";
			echo "<td align=left class=text>" . ( ( $row['amendment_status'] ) ? generate_display_field(array('data_type'=>'1','list_id'=>'amendment_status'), $row['amendment_status']) : '') . "</td>";
			echo "<td align=left class=text>" . htmlspecialchars(xl($row['amendment_note']),ENT_NOQUOTES) . "</td>";
			echo "<tr>";
		}
	 }
	?>
	</table>
	<?php } ?>
	
	<input type="hidden" id="mode" name="mode" value=""/>
	<input type="hidden" id="amendment_id" name="amendment_id" value="<?php echo $amendment_id; ?>"/>
</form>
</body>
</html>