<?php
/**
 *
 * Copyright (C) 2015-2020 Rich Genandt <rgenandt@gmail.com>
 *
 * LICENSE: This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://opensource.org/licenses/gpl-license.php>;.
 *
 * @package OpenEMR
 * @author  WMT
 * @link    http://www.open-emr.org
 */
require_once("../globals.php");
require_once("$srcdir/patient.inc");
require_once("$srcdir/sql-ledger.inc");
require_once("$srcdir/acl.inc");
require_once("$srcdir/formatting.inc.php");
require_once("$srcdir/options.inc.php");
require_once("$srcdir/formdata.inc.php");
include_once("$srcdir/wmt/wmtstandard.inc");
if(!isset($_POST['form_csvexport'])) $_POST['form_csvexport'] = '';
if(!isset($_POST['form_refresh'])) $_POST['form_refresh'] = '';
$rpt_lines = 0;

function bucks($amount) {
  if ($amount) echo oeFormatMoney($amount);
}

function display_desc($desc) {
  if (preg_match('/^\S*?:(.+)$/', $desc, $matches)) {
    $desc = $matches[1];
  }
  return $desc;
}

function userTotals() {
	global $form_user, $user_id, $user_desc, $user_qty, $user_total;
  global $prev_sort, $prev_sort_desc, $prev_user, $prev_user_desc;
	global $sec_sort, $sec_desc, $form_csvexport;
	global $prim_sort, $prim_desc, $prim_sort_left, $prim_desc_left;

	if(!$form_user) {
		if($user_id != $prev_user && $prev_user) {
     	if(!$form_csvexport) { ?>
 				<tr bgcolor="#ddffff">
  				<td class="detail" colspan="3">
						<?php echo 'Total For: ',display_desc($prev_user_desc); ?></td>
					<td class="detail" colspan="3">&nbsp;</td>
  				<td align="right"><?php echo $user_qty; ?></td>
  				<td align="right"><?php bucks($user_total); ?></td>
				</tr>
				<?php if($user_id && $user_id != '^end^') { ?>
				<tr><td colspan="8">&nbsp;</td></tr>
				<tr>
  				<td class="detail" colspan="3">
						<?php echo display_desc($user_desc); ?>&nbsp;</td>
					<td class="detail" colspan="5">&nbsp;</td>
				</tr>	
				<?php	
				}
			}
   		$user_total     = $user_qty = 0;
  		$prev_user      = $user_id;
  		$prev_user_desc = $user_desc;
    }
	}
	if(!$prev_user) {
		if(!$form_csvexport) {
	?>
		<tr>
  		<td class="detail" colspan="3">
				<?php echo display_desc($user_desc); ?>&nbsp;</td>
			<td class="detail" colspan="5">&nbsp;</td>
		</tr>	
	<?php
		}
		$prim_sort_left = $prim_sort;
		$prim_desc_left = $prim_desc;
	}
}

function primSortTotals() {
  global $prim_sort, $prim_desc, $prim_total, $prim_qty;
  global $prev_sort, $prev_sort_desc, $prim_sort_left, $prim_desc_left;
	global $sec_sort, $sec_desc, $form_details, $form_csvexport, $dtl_lines;


  if ($prim_sort != $prev_sort && $prev_sort) {
    // Print primary sort total.
    if ($form_csvexport) {
			// If we are printing details we don't total for spreadsheets
      if(!$form_details) {
        echo '"' . display_desc($prev_sort) . '",';
        echo '"' . display_desc($prev_desc)  . '",';
        echo '"' . $prim_qty. '",';
        echo '"'; bucks($prim_total); echo '"' . "\n";
			}
    } else { 
			if(!$form_details) { ?>
 				<tr bgcolor="#ddffff">
  				<td class="detail"><?php echo display_desc($prev_sort); ?>&nbsp;</td>
  				<td class="detail"><?php echo display_desc($prev_sort_desc); ?>&nbsp;</td>
  				<td align="right"><?php echo $prim_qty; ?></td>
  				<td align="right"><?php bucks($prim_total); ?></td>
 				</tr>
			<?php } else { ?>
 				<tr bgcolor="#ddffff">
  				<td class="detail" colspan="4">
							<?php echo 'Total For: ',display_desc($prev_sort),'&nbsp;-&nbsp;',
								display_desc($prev_sort_desc); ?></td>
					<td class="detail" colspan="2">&nbsp;</td>
  				<td align="right"><?php echo $prim_qty; ?></td>
  				<td align="right"><?php bucks($prim_total); ?></td>
				</tr>
				<?php if($prim_sort && $prim_sort != '^end^') { ?>
				<!-- tr> <td class="detail" colspan="8">&nbsp;</td></tr -->	
			<?php
				}
      } // End not csv export
			// echo "Finished the total Line<br>\n";
    }
    $prim_total     = $prim_qty = 0;
    $prev_sort      = $prim_sort;
    $prev_sort_desc = $prim_desc;
		$prim_sort_left = $prim_sort;
		$prim_desc_left = $prim_desc;
  } else if(!$prev_sort) {
		$prim_sort_left = $prim_sort;
		$prim_desc_left = $prim_desc;
	}
}

function thisLineItem($transdate, $enc, $qty, $amount) {
  global $prim_sort, $prim_desc, $prim_total, $prim_qty;
	global $sec_sort, $sec_desc, $grand_total, $grand_qty;
	global $form_user, $user_id, $user_desc, $user_qty, $user_total;
  global $prev_sort, $prev_sort_desc, $prev_user, $prev_user_desc;
	global $prim_sort_left, $prim_desc_left, $dtl_lines;
	global $form_csvexport, $form_details, $form_order, $bgcolor;

  $rowamount = sprintf('%01.2f', $amount);

	primSortTotals();
	userTotals();

	$bgcolor = ($bgcolor == "FFDDDD") ? "FFFFDD" : "FFDDDD";

  if($form_details) {
    if($form_csvexport) {
      echo '"' . display_desc($prim_sort) . '","' .
      display_desc($prim_desc) . '","' . display_desc($sec_sort) . '","' .
      display_desc($sec_desc) . '","' . display_desc($enc) . '","' .
      oeFormatShortDate($transdate) . '","' . display_desc($qty) . '","'; 
      bucks($rowamount);
			echo '"' . "\n";
    } else {
			$patient_id = ($form_order == 'CPT') ? $sec_sort : $prim_sort;
?>

 <tr bgcolor="<?php echo $bgcolor; ?>">
  <td class="detail">
		<?php echo display_desc($prim_sort_left); $prim_sort_left = "&nbsp;"; ?>
	&nbsp;</td>
  <td class="detail">
		<?php echo display_desc($prim_desc_left); $prim_desc_left = "&nbsp;"?>
	&nbsp;</td>
  <td class="detail"><?php echo display_desc($sec_sort); ?>&nbsp;</td>
  <td class="detail"><?php echo display_desc($sec_desc); ?>&nbsp;</td>
  <td class="detail">
   <!-- a href='../../patient_file/encounter/patient_encounter.php?pid=<?php // echo $patient_id; ?>&set_encounter=<?php // echo $enc; ?>' -->
   <?php echo $enc; ?>&nbsp;</td>
  <td><?php echo oeFormatShortDate($transdate); ?>&nbsp;</td>
  <td align="right"><?php echo $qty; ?></td>
  <td align="right"><?php bucks($rowamount); ?></td>
 </tr>
<?php

    } // End not csv export
  } // end details
  $prim_total     += $amount;
  $user_total     += $amount;
  $grand_total    += $amount;
  $prim_qty       += $qty;
  $user_qty       += $qty;
  $grand_qty      += $qty;
	$prev_user      =  $user_id;
	$prev_user_desc =  $user_desc;
	$prev_sort      =  $prim_sort;
	$prev_sort_desc =  $prim_desc;
} // end line print function

if (! acl_check('acct', 'rep')) die(xl("Unauthorized access."));

$INTEGRATED_AR = $GLOBALS['oer_config']['ws_accounting']['enabled'] === 2;
if (!$INTEGRATED_AR) SLConnect();

$default_date = fixDate(date('Y-m-d'), date('Y-m-d'));
if(!isset($_POST['form_from_date'])) $_POST['form_from_date'] = $default_date;
if(!isset($_POST['form_to_date'])) $_POST['form_to_date'] = $default_date;
$form_from_date = fixDate($_POST['form_from_date'], date('Y-m-d'));
$form_to_date   = fixDate($_POST['form_to_date']  , date('Y-m-d'));
$form_facility=isset($_POST['form_facility']) ? $_POST['form_facility'] : '';
$form_user=isset($_POST['form_user']) ? $_POST['form_user'] : '';
$form_details=isset($_POST['form_details']) ? $_POST['form_details'] : '1';
$form_order=isset($_POST['form_order']) ? $_POST['form_order'] : 'PAT';
$form_csvexport = $_POST['form_csvexport'];
$form_details = 1;

if($form_csvexport) {
  header("Pragma: public");
  header("Expires: 0");
  header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
  header("Content-Type: application/force-download");
  header("Content-Disposition: attachment; filename=chgs_by_user_date.csv");
  header("Content-Description: File Transfer");
  // CSV headers:
  if ($form_details) {
		echo ($form_order == 'CPT') ? '"CPT",' : '"PID",';
		echo ($form_order == 'CPT') ? '"Description",' : '"Patient Name",';
		echo ($form_order == 'CPT') ? '"PID",' : '"CPT",';
		echo ($form_order == 'CPT') ? '"Patient Name",' : '"Description",';
    echo '"Encounter",';
    echo '"Date",';
    echo '"Qty",';
    echo '"Amount"' . "\n";
  } else {
		echo ($form_order == 'CPT') ? '"CPT",' : '"PID",';
		echo ($form_order == 'CPT') ? '"Description",' : '"Patient Name",';
    echo '"Qty",';
    echo '"Total"' . "\n";
  }
	// End of Export
} else {
?>
<html>
<head>
<?php html_header_show();?>
<style type="text/css">
/* specifically include & exclude from printing */
@media print {
    #report_parameters {
        visibility: hidden;
        display: none;
    }
    #report_parameters_daterange {
        visibility: visible;
        display: inline;
    }
    #report_results {
       margin-top: 30px;
    }
}

/* specifically exclude some from the screen */
@media screen {
    #report_parameters_daterange {
        visibility: hidden;
        display: none;
    }
}
</style>

<title><?php echo xl('Procedures by Date and Operator') ?></title>
</head>

<body leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' class="body_top">

<span class='title'><?php echo xl('Report'); ?> - <?php echo xl('Procedures by Date and Operator'); ?></span>

<form method='post' action='charges_by_date_user.php' id='theform'>

<div id="report_parameters">
<input type='hidden' name='form_refresh' id='form_refresh' value=''/>
<input type='hidden' name='form_csvexport' id='form_csvexport' value=''/>
<table>
 <tr>
  <td width='750px'>
	<div style='float:left'>

	<table class='text'>
		<tr>
			<td class='label'>
				<?php echo xl('Facility'); ?>:
			</td>
			<td>
			<?php dropdown_facility(strip_escape_custom($form_facility), 'form_facility', true); ?>
			</td>
			<td class='label'>
			   <?php echo xl('From'); ?>:
			</td>
			<td>
			   <input type='text' name='form_from_date' id="form_from_date" size='10' value='<?php echo $form_from_date ?>'
				onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' title='yyyy-mm-dd'>
			   <img src='../../pic/show_calendar.gif' align='absbottom' width='24' height='22'
				id='img_from_date' border='0' alt='[?]' style='cursor:pointer'
				title='<?php echo xl('Click here to choose a date'); ?>'>
			</td>
			<td class='label'>
			   <?php echo xl('To'); ?>:
			</td>
			<td>
			   <input type='text' name='form_to_date' id="form_to_date" size='10' value='<?php echo $form_to_date ?>'
				onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' title='yyyy-mm-dd'>
			   <img src='../../pic/show_calendar.gif' align='absbottom' width='24' height='22'
				id='img_to_date' border='0' alt='[?]' style='cursor:pointer'
				title='<?php echo xl('Click here to choose a date'); ?>'>
			</td>
		</tr>
		<tr>
			<td class='label'>
				<?php echo xl('Operator'); ?>:
			</td>
      <td style='width: 18%;'><?php
        // Build a drop-down list of providers.
        $query = "SELECT id, username, lname, fname FROM users " .
					"WHERE username!='' AND active='1' ORDER BY lname, fname";
        $ures = sqlStatement($query);

        echo "   <select name='form_user' id='form_user'>\n";
        echo "    <option value=''";
				if($form_user == '') { echo " selected"; }
				echo ">-- " . xl('All') . " --</option>\n";
        while ($urow = sqlFetchArray($ures)) {
          $provid = $urow['id'];
          echo "    <option value='$provid'";
          if ($provid == $form_user) echo " selected";
          echo ">" . $urow['lname'] . ", " . $urow['fname'] . "</option>\n";
        }
        echo "   </select>\n";
        ?></td>
			<td class="label"><?php echo xl('Order By'); ?>:</td>
			<td><select name="form_order" id="form_order">
				<option value="PAT" <?php echo ($form_order == "PAT") ? 'selected' : ''; ?> ><?php echo xl('Patient'); ?></option>
				<option value="CPT" <?php echo ($form_order == "CPT") ? 'selected' : ''; ?> ><?php echo xl('Procedure'); ?></option>
			</select></td>
			<!--td>
			   <input type='checkbox' name='form_details'<?php // if ($form_details) echo ' checked'; ?>>
			   <?php // xl('Details','e'); ?>
			</td -->
		</tr>
	</table>

	</div>

  </td>
  <td align='left' valign='middle' height="100%">
	<table style='border-left:1px solid; width:100%; height:100%' >
		<tr>
			<td>
				<div style='margin-left:15px'>
					<a href='#' class='css_button' onclick='$("#form_refresh").attr("value","true"); $("#form_csvexport").attr("value",""); $("#theform").submit();'>
					<span><?php echo xl('Submit'); ?></span></a>

					<?php if ($_POST['form_refresh'] || $_POST['form_csvexport']) { ?>
					<a href='#' class='css_button' onclick='window.print()'>
						<span><?php echo xl('Print'); ?></span></a>
					<a href='#' class='css_button' onclick='$("#form_refresh").attr("value",""); $("#form_csvexport").attr("value","true"); $("#theform").submit();'>
						<span><?php echo xl('CSV Export'); ?></span></a>
					<?php } ?>
				</div>
			</td>
		</tr>
	</table>
  </td>
 </tr>
</table>

</div> <!-- end of parameters -->

<?php
	if($_POST['form_refresh']) {
?>
	<div id="report_results">
	<table >
 	<thead>
  	<th> <?php echo ($form_order == 'CPT') ? xl('CPT') : xl('PID'); ?> </th>
  	<th>
   	<?php echo ($form_order == 'CPT') ? xl('Description') : xl('Patient Name'); ?>
  	</th>
  	<th> <?php echo ($form_order == 'CPT') ? xl('PID') : xl('CPT'); ?> </th>
  	<th>
   	<?php echo ($form_order == 'CPT') ? xl('Patient Name') : xl('Description'); ?>
  	</th>
  	<th> <?php echo xl('Encounter'); ?> </th>
  	<th> <?php echo xl('Date'); ?> </th>
  	<th align="right"> <?php echo xl('Qty'); ?> </th>
  	<th align="right"> <?php echo xl('Amount'); ?> </th>
 	</thead>
<?php
	}
} // end not export

if ($_POST['form_refresh'] || $_POST['form_csvexport']) {
  $from_date = $form_from_date;
  $to_date   = $form_to_date;

  $prim_sort = $prim_desc = $user_id = $user_desc = '';
	$sec_sort = $sec_desc = $bgcolor = '';
	$prim_total = $prim_qty = $user_total = $user_qty = 0;
	$dtl_lines = $rpt_lines = $grand_total = $grand_qty = 0;
	$prev_sort = $prev_sort_desc =  $prev_user = $prev_user_desc = '';

  if ($INTEGRATED_AR) {
    $query = "SELECT b.fee, b.pid, b.encounter, b.code_type, b.code, " .
				"b.units, b.date AS post_dt, b.code_text, b.user, " .
				"fe.date AS serv_dt, fe.facility_id, fe.invoice_refno, " .
				"pat.lname AS plast, pat.fname AS pfirst, pat.mname AS pmi, " .
				"users.lname AS ulast, users.fname AS ufirst, users.mname AS umi, " .
				"lo.title " .
        "FROM billing AS b " .
        "JOIN code_types AS ct ON ct.ct_key = b.code_type " .
        "JOIN form_encounter AS fe ON fe.pid = b.pid AND fe.encounter = b.encounter " .
        "LEFT JOIN codes AS c ON c.code_type = ct.ct_id AND c.code = b.code AND c.modifier = b.modifier " .
				"LEFT JOIN patient_data AS pat ON b.pid = pat.pid " .
				"LEFT JOIN users ON b.user = users.id " .
        "LEFT JOIN list_options AS lo ON lo.list_id = 'superbill' AND lo.option_id = c.superbill " .
        "WHERE b.code_type != 'COPAY' AND b.activity = 1 AND b.fee != 0 AND " .
        "b.date >= '$from_date 00:00:00' AND b.date <= '$to_date 23:59:59'";
    if ($form_facility) $query .= " AND fe.facility_id = '$form_facility'"; 
    if ($form_user) $query .= " AND b.user = '$form_user'"; 
		if($form_order == 'CPT') {
			$query .= " ORDER BY b.user, b.code, b.pid";
		} else {
			$query .= " ORDER BY b.user, b.pid, b.date";
		}
    //$query .= " ORDER BY lo.title, b.code, fe.date, fe.id";
      //
    $res = sqlStatement($query);
    while ($row = sqlFetchArray($res)) {
			$user_id = $row['user'];
			$user_desc = $row['ulast'].', '.$row['ufirst'];
			$prim_sort = ($form_order == 'CPT') ? $row['code'] : $row['pid'];
			$prim_desc = ($form_order == 'CPT') ? $row['code_text'] : $row['plast'].','.$row['pfirst'];
			$sec_sort = ($form_order == 'CPT') ? $row['pid'] : $row['code'];
			$sec_desc = ($form_order == 'CPT') ? $row['plast'].','.$row['pfirst'] : $row['code_text'];
      thisLineItem(substr($row['post_dt'], 0, 10), 
										$row['encounter'], $row['units'], $row['fee']);
			$dtl_lines++;
			$rpt_lines++;
    }
  } else {
		// - NOT Integreated AR is not supported currently
  } // end not $INTEGRATED_AR

	$prim_sort = '^end^';
	$user_id = '^end^';
	primSortTotals();
	userTotals();

	if(!$form_user && !$form_csvexport) {
	?>
 	<tr bgcolor="#ddffff">
 	 <td class="detail" colspan="6"> <?php echo xl('Grand Total'); ?> </td>
 	 <td align="right"> <?php echo $grand_qty; ?> </td>
 	 <td align="right"> <?php bucks($grand_total); ?> </td>
 	</tr>

<?php
	}
}
if (!$INTEGRATED_AR) SLClose();

if(!$_POST['form_csvexport']) {
?>

</table>
</div> <!-- report results -->
	<?php if(!$rpt_lines) { ?>
<div class='text'>
 	<?php echo xl('Please input search criteria above, and click Submit to view results.', 'e' ); ?>
</div>
	<?php } ?>

</form>

</body>

<!-- stuff for the popup calendar -->
<link rel='stylesheet' href='<?php echo $css_header ?>' type='text/css'>
<style type="text/css">@import url(../../../library/dynarch_calendar.css);</style>
<script type="text/javascript" src="../../../library/dynarch_calendar.js"></script>
<?php include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php"); ?>
<script type="text/javascript" src="../../../library/dynarch_calendar_setup.js"></script>
<script type="text/javascript" src="../../../library/js/jquery.1.3.2.js"></script>

<script language="Javascript">
 Calendar.setup({inputField:"form_from_date", ifFormat:"%Y-%m-%d", button:"img_from_date"});
 Calendar.setup({inputField:"form_to_date", ifFormat:"%Y-%m-%d", button:"img_to_date"});
</script>

</html>
<?php
} // End not csv export
?>
