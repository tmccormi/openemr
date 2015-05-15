<?php
/**
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
if(!isset($_POST['form_zero_pmt'])) $_POST['form_zero_pmt'] = '';
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

function GetAllUnapplied($user='') {
	global $form_zero_pmt, $from_date, $to_date;
  $all = array();
	if(!$user) return($all);
  $sql = "SELECT ar_session.*, ins.name, " .
			"pat.lname, pat.fname, pat.mname, " .
			"(SELECT SUM(ar_activity.pay_amount) FROM ar_activity WHERE " .
			"ar_activity.session_id = ar_session.session_id) AS applied " .
      "FROM ar_session " .
      "LEFT JOIN insurance_companies AS ins on ar_session.payer_id = ins.id " .
      "LEFT JOIN patient_data AS pat on ar_session.patient_id = pat.pid " .
      "WHERE " .
      "ar_session.created_time >= '$from_date 00:00:00' AND " .
			"ar_session.created_time <= '$to_date 23:59:59'" .
			"AND ar_session.user_id=?";
	if(!$form_zero_pmt) $query .= " AND ar_session.pay_total != 0";
  $result = sqlStatement($sql, array($user));
  $iter = 0;
  while($row = sqlFetchArray($result)) {
    $all[$iter] = $row;
    $iter++;
  }
	return($all);
}

function PrintUacHeader() {
	global $hdr_printed;	
	echo "<tr><td class='bold' colspan='9'>Unapplied Detail</td></tr>\n";
	$hdr_printed = true;
}

function printUacDetail($uac) {
	global $user_qty, $grand_qty, $user_pmt_total, $user_adj_total;
	global $prev_user_desc, $bgcolor, $form_csvexport, $form_details;
	global $grand_pmt_total, $hdr_printed;

	$uac_total = 0;
	$hdr_printed = false;
	$bgcolor = ($bgcolor == "FFDDDD") ? "FFFFDD" : "FFDDDD";
	if(!$form_csvexport && $form_details) {
	}
	foreach($uac as $dtl) {
		if(($dtl['pay_total'] - $dtl['applied']) == 0) continue;
  	$pmt = sprintf('%01.2f', ($dtl['pay_total'] - $dtl['applied']));
  	$pmt_orig = sprintf('%01.2f', $dtl['pay_total']);
		if($form_details) {
			if(!$hdr_printed && !$form_csvexport) PrintUacHeader();
			$addl = '';
			if($dtl['patient_id']) { 
				$addl = $dtl['lname'].', '.$dtl['fname'].' '.$dtl['mname'];
			}
			if($form_csvexport) {
      	echo '"'.display_desc(ListLook($dtl['payment_type'],'payment_type')).
							'",';
      	echo '"'.display_desc($dtl['description']) . '",';
      	echo '"'.oeFormatShortDate(substr($dtl['created_time'],0,10)) . '",';
      	echo '"'.display_desc('Payment to Unapplied Credt') . '",';
      	echo '"'.display_desc($addl).'",';
      	echo '"'.display_desc(ListLook($method, 'payment_method')) . '",';
      	echo '"'.display_desc($dtl['reference']) . '",';
      	echo '"';
				bucks($pmt_orig);
				echo '",';
      	echo '"';
				bucks($pmt);
				echo '"' . "\n";
			} else {
				$bgcolor = ($bgcolor == "FFDDDD") ? "FFFFDD" : "FFDDDD";
			?>
				<tr bgcolor="<?php echo $bgcolor; ?>">
  				<td class="detail">
						<?php echo display_desc(ListLook($dtl['payment_type'],'payment_type'));?>
					&nbsp;</td>
  				<td class="detail"><?php echo display_desc($dtl['description']); ?>&nbsp;</td>
  				<td>
						<?php echo oeFormatShortDate(substr($dtl['created_time'],0,10)); ?>
					&nbsp;</td>
  				<td class="detail">Unapplied Credit --&gt; Original Total / Remaining</td>
  				<td class="detail"><?php echo display_desc($addl); ?>&nbsp;</td>
  				<td class="detail">
   				<?php echo display_desc(ListLook($method, 'payment_method')); ?>&nbsp;
  				</td>
  				<td align="right"><?php echo display_desc($dtl['reference']); ?>&nbsp;
					</td>
  				<td align="right"><?php bucks($pmt_orig); ?></td>
  				<td align="right"><?php bucks($pmt); ?></td>
 				</tr>
			<?php
			}
		}
		$user_pmt_total  += $pmt; 
  	$grand_pmt_total += $pmt;
		$uac_total       += $pmt;
		$user_qty++;
		$grand_qty++;
	}	
	// Just a one line summary of the UAC
	if(!$form_details) {
		if($form_csvexport) {
      echo '"Total UAC For: '.display_desc($prev_user_desc) . '",';
      echo '" ",';
      echo '" ",';
      echo '" ",';
      echo '"';
			bucks($pmt);
			echo '"' . "\n";
		} else {
		?>
 			<tr bgcolor="#ddffff">
  			<td class="detail">
					<?php echo 'Total Unapplied For: ',display_desc($prev_user_desc); ?>
				</td>
				<td class="detail">&nbsp;</td>
  			<td align="right">&nbsp;</td>
  			<td align="right">&nbsp;</td>
  			<td align="right"><?php bucks($uac_total); ?></td>
			</tr>
	<?php
		}
	}
}

function userTotals() {
	global $user_id, $user_desc, $user_qty, $user_pmt_total, $user_adj_total;
  global $prev_sort, $prev_sort_desc, $prev_user, $prev_user_desc;
	global $form_user, $form_csvexport, $from_date, $to_date, $bgcolor;
	global $prim_sort, $prim_desc, $prim_sort_left, $prim_desc_left;
	global $form_zero_pmt;

	if(!$form_user) {
		if($user_id != $prev_user && $prev_user) {
			$uac = GetAllUnapplied($prev_user);
     	if(!$form_csvexport) {
				if(count($uac) > 0) printUacDetail($uac);
				?>
 				<tr bgcolor="#ddffff">
  				<td class="detail" colspan="3">
						<?php echo 'Total For: ',display_desc($prev_user_desc); ?>&nbsp;
					</td>
					<td class="detail" colspan="3">&nbsp;</td>
  				<td align="right"><?php echo $user_qty; ?></td>
  				<td align="right"><?php bucks($user_adj_total); ?></td>
  				<td align="right"><?php bucks($user_pmt_total); ?></td>
				</tr>
				<?php if($user_id && $user_id != '^end^') { ?>
				<tr><td colspan="9">&nbsp;</td></tr>
				<tr>
  				<td class="detail" colspan="3">
						<?php echo display_desc($user_desc); ?>&nbsp;</td>
					<td class="detail" colspan="6">&nbsp;</td>
				</tr>	
				<?php	
				}
			} else {
				// Need to provide the unapplied detail	
			}
   		$user_pmt_total = $user_adj_total = $user_qty = 0;
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
			<td class="detail" colspan="6">&nbsp;</td>
		</tr>	
	<?php
		}
		$prim_sort_left = $prim_sort;
		$prim_desc_left = $prim_desc;
	}
}

function primSortTotals() {
  global $prim_sort, $prim_desc, $prim_pmt_total, $prim_adj_total, $prim_qty;
  global $prev_sort, $prev_sort_desc, $prim_sort_left, $prim_desc_left;
	global $form_details, $form_csvexport, $dtl_lines;

  if ($prim_sort != $prev_sort && $prev_sort) {
    // Print primary sort total.
    if ($form_csvexport) {
			// If we are printing details we don't total for spreadsheets
      if(!$form_details) {
        echo '"' . display_desc($prev_sort) . '",';
        echo '"' . display_desc($prev_desc)  . '",';
        echo '"' . $prim_qty. '",';
        echo '"'; bucks($prim_adj_total); echo '"';
        echo '"'; bucks($prim_pmt_total); echo '"' . "\n";
			}
    } else { 
			if(!$form_details) { ?>
 				<tr bgcolor="#ddffff">
  				<td class="detail"><?php echo display_desc($prev_sort); ?>&nbsp;</td>
  				<td class="detail"><?php echo display_desc($prev_sort_desc); ?>&nbsp;
					</td>
  				<td align="right"><?php echo $prim_qty; ?></td>
  				<td align="right"><?php bucks($prim_adj_total); ?></td>
  				<td align="right"><?php bucks($prim_pmt_total); ?></td>
 				</tr>
			<?php
			} else {
				if($dtl_lines > 1) {
			?>
 				<tr bgcolor="#ddffff">
  				<td class="detail" colspan="4">
							<?php echo 'Total For: ',display_desc($prev_sort),'&nbsp;-&nbsp;',
								display_desc($prev_sort_desc); ?></td>
					<td class="detail" colspan="2">&nbsp;</td>
  				<td align="right"><?php echo $prim_qty; ?></td>
  				<td align="right"><?php bucks($prim_adj_total); ?></td>
  				<td align="right"><?php bucks($prim_pmt_total); ?></td>
				</tr>
				<?php 
				}
				if($prim_sort && $prim_sort != '^end^') { ?>
				<!-- tr> <td class="detail" colspan="8">&nbsp;</td></tr -->	
			<?php
				}
      } // End not csv export
			// echo "Finished the total Line<br>\n";
    }
    $prim_pmt_total = $prim_adj_total = $prim_qty = $dtl_lines = 0;
    $prev_sort      = $prim_sort;
    $prev_sort_desc = $prim_desc;
		$prim_sort_left = $prim_sort;
		$prim_desc_left = $prim_desc;
  } else if(!$prev_sort) {
		$prim_sort_left = $prim_sort;
		$prim_desc_left = $prim_desc;
	}
}

function thisLineItem($dt,$desc,$method,$ref,$memo,$qty,$adj,$pmt) {
  global $prim_sort, $prim_desc, $prim_pmt_total, $prim_adj_total, $prim_qty;
	global $grand_pmt_total, $grand_adj_total, $grand_qty;
	global $user_id, $user_desc, $user_qty, $user_pmt_total, $user_adj_total;
  global $prev_sort, $prev_sort_desc, $prev_user, $prev_user_desc;
	global $prim_sort_left, $prim_desc_left, $dtl_lines, $from_date, $to_date;
	global $form_user, $form_csvexport, $form_details, $primary_sort, $bgcolor;
	global $form_zero_pmt;

  $row_pmt = sprintf('%01.2f', $pmt);
  $row_adj = sprintf('%01.2f', $adj);

	primSortTotals();
	userTotals();

	$bgcolor = ($bgcolor == "FFDDDD") ? "FFFFDD" : "FFDDDD";

  if($form_details) {
    if($form_csvexport) {
      echo '"' . display_desc($prim_sort) . '",';
      echo '"' . display_desc($prim_desc) . '",';
      echo '"' . oeFormatShortDate($dt) . '",';
      echo '"' . display_desc($desc) . '",';
      echo '"' . display_desc($memo)  . '",';
      echo '"' . display_desc(ListLook($method, 'payment_method')) . '",';
      echo '"' . display_desc($ref) . '",';
      echo '"'; bucks($row_adj); echo '",';
      echo '"'; bucks($row_pmt); echo '"' . "\n";
    } else {
?>

 <tr bgcolor="<?php echo $bgcolor; ?>">
  <td class="detail">
		<?php echo display_desc($prim_sort_left); $prim_sort_left = "&nbsp;"; ?>
	&nbsp;</td>
  <td class="detail">
		<?php echo display_desc($prim_desc_left); $prim_desc_left = "&nbsp;"?>
	&nbsp;</td>
  <td><?php echo oeFormatShortDate($dt); ?>&nbsp;</td>
  <td class="detail"><?php echo display_desc($desc); ?>&nbsp;</td>
  <td class="detail"><?php echo display_desc($memo); ?>&nbsp;</td>
  <td class="detail">
   <?php echo display_desc(ListLook($method, 'payment_method')); ?>&nbsp;
  </td>
  <td align="right"><?php echo display_desc($ref); ?>&nbsp;</td>
  <td align="right"><?php bucks($row_adj); ?></td>
  <td align="right"><?php bucks($row_pmt); ?></td>
 </tr>
<?php

    } // End not csv export
  } // end details
  $prim_pmt_total  += $pmt;
  $prim_adj_total  += $adj;
  $user_pmt_total  += $pmt;
  $user_adj_total  += $adj;
  $grand_pmt_total += $pmt;
  $grand_adj_total += $adj;
  $prim_qty        += $qty;
  $user_qty        += $qty;
  $grand_qty       += $qty;
	$prev_user       =  $user_id;
	$prev_user_desc  =  $user_desc;
	$prev_sort       =  $prim_sort;
	$prev_sort_desc  =  $prim_desc;
	$dtl_lines++;
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
$form_csvexport = $_POST['form_csvexport'];
$form_zero_pmt = $_POST['form_zero_pmt'];
$form_details = 1;
$primary_sort = 'CPT';

if($form_csvexport) {
  header("Pragma: public");
  header("Expires: 0");
  header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
  header("Content-Type: application/force-download");
  header("Content-Disposition: attachment; filename=pmts_by_user_date.csv");
  header("Content-Description: File Transfer");
  // CSV headers:
  if ($form_details) {
		echo '"PID",';
		echo '"Patient Name",';
    echo '"Post To Date",';
		echo '"Description",';
		echo '"Memo",';
    echo '"Method",';
    echo '"Reference",';
    echo '"Adjustment"';
    echo '"Payment"' . "\n";
  } else {
		echo '"PID",';
		echo '"Patient Name",';
    echo '"Qty",';
    echo '"Adjustment",';
    echo '"Payment"' . "\n";
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

<title><?php echo xl('Payments by Date and Operator') ?></title>
</head>

<body leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' class="body_top">

<span class='title'><?php echo xl('Report'); ?> - <?php echo xl('Payments by Date and Operator'); ?></span>

<form method='post' action='payments_by_date_user.php' id='theform'>

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
			<td colspan="2" class="label">
			   <input type='checkbox' name="form_zero_pmt" id="form_zero_pmt" <?php if($form_zero_pmt) echo 'checked'; ?>>&nbsp;&nbsp;<label for="form_zero_pmt"><?php echo xl('Include Zero $ Pmts'); ?></label>
			</td>
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
  <th> <?php echo xl('PID'); ?> </th>
  <th> <?php echo xl('Patient Name'); ?> </th>
  <th> <?php echo xl('Post To Date'); ?> </th>
  <th> <?php echo xl('Description'); ?> </th>
  <th> <?php echo xl('Memo'); ?> </th>
  <th> <?php echo xl('Method'); ?> </th>
  <th> <?php echo xl('Reference'); ?> </th>
  <th align="right"> <?php echo xl('Adjustment'); ?> </th>
  <th align="right"> <?php echo xl('Payment'); ?> </th>
 	</thead>
<?php
	}
} // end not export

if ($_POST['form_refresh'] || $_POST['form_csvexport']) {
  $from_date = $form_from_date;
  $to_date   = $form_to_date;

  $prim_sort = $prim_desc = $user_id = $user_desc = $bgcolor = '';
	$prim_pmt_total = $prim_adj_total = $prim_qty = 0;
	$user_pmt_total = $user_adj_total = $user_qty = 0;
	$grand_pmt_total = $grand_adj_total = $grand_qty = 0;
	$dtl_lines = $rpt_lines = 0;
	$prev_sort = $prev_sort_desc = $prev_user = $prev_user_desc = '';

  if ($INTEGRATED_AR) {
    $query = "SELECT ar.pid, ar.encounter, ar.sequence_no, " .
			"ar.post_time AS post_dt, ar.post_user AS user, ar.session_id, " .
			"ar.memo, ar.pay_amount AS pmt_applied, ar.adj_amount AS adj_applied, " .
			"ar.follow_up, ar.follow_up_note, ar.reason_code, " . 
			"ss.reference, ss.payment_type, ss.description, ss.adjustment_code, " .
			"ss.payment_method, ss.payer_id, ss.post_to_date, " .
			"pat.lname AS plast, pat.fname AS pfirst, pat.mname AS pmi, " .
			"users.lname AS ulast, users.fname AS ufirst, users.mname AS umi, " .
			"fe.facility_id, fe.facility " .
      "FROM ar_activity AS ar " .
			"LEFT JOIN ar_session AS ss USING(session_id) " .
			"LEFT JOIN form_encounter AS fe USING(encounter) " .
			"LEFT JOIN patient_data AS pat ON ar.pid = pat.pid " .
			"LEFT JOIN users ON ar.post_user = users.id " .
      "WHERE ar.post_time >= '$from_date 00:00:00' AND " .
			"ar.post_time <= '$to_date 23:59:59'";
		if(!$form_zero_pmt) {
			$query .= " AND (ar.pay_amount != 0 OR ar.adj_amount != 0)";
		}
    // If a facility was specified.
    if ($form_facility) $query .= " AND fe.facility_id = '$form_facility'";
    if ($form_user) $query .= " AND ar.post_user = '$form_user'";
		$query .= " ORDER BY ar.post_user, ss.post_to_date, ar.pid";
    $res = sqlStatement($query);
    while ($row = sqlFetchArray($res)) {
			$user_id = $row['user'];
			$user_desc = $row['ulast'].', '.$row['ufirst'];
			$prim_sort = $row['pid'];
			$prim_desc = $row['plast'].','.$row['pfirst'];
      thisLineItem(substr($row['post_to_date'], 0, 10), $row['description'], 
				$row['payment_method'], $row['reference'], $row['memo'], 
				1, $row['adj_applied'], $row['pmt_applied']);
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
 	 <td align="right"> <?php bucks($grand_adj_total); ?> </td>
 	 <td align="right"> <?php bucks($grand_pmt_total); ?> </td>
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
