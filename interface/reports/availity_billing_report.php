<?php
// Copyright (C) 2006-2010 Rod Roark <rod@sunsetsystems.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

// This is a report of billing by cpt description.  It's driven from
// SQL-Ledger so as to include all types of invoice items.

require_once("../globals.php");
require_once("$srcdir/patient.inc");
require_once("$srcdir/sql-ledger.inc");
require_once("$srcdir/acl.inc");
require_once("$srcdir/formatting.inc.php");
require_once "$srcdir/options.inc.php";
require_once "$srcdir/formdata.inc.php";

function bucks($amount) {
  if ($amount) echo oeFormatMoney($amount);
}

function display_desc($desc) {
  if (preg_match('/^\S*?:(.+)$/', $desc, $matches)) {
    $desc = $matches[1];
  }
  return $desc;
}

function thisLineItem($patient_id, $encounter_id, $rowcat, $patient, $description, $transdate, $qty, $amount, $insurance, $irnumber='') {
  global $product, $category, $producttotal, $productqty, $cattotal, $catqty, $grandtotal, $grandqty;
  global $productleft, $catleft, $invleft, $dateleft;

  $invnumber = $irnumber ? $irnumber : "$patient_id.$encounter_id";
  $rowamount = sprintf('%01.2f', $amount);

  if (empty($rowcat)) $rowcat = 'None';
  $rowproduct = $description;
  if (! $rowproduct) $rowproduct = 'Unknown';

  if ($product != $rowproduct || $category != $rowcat) {
    if ($product) {
      // Print product total.
      if ($_POST['form_csvexport']) {
        if (! $_POST['form_details']) {
          echo '"' . display_desc($category) . '",';
          // echo '"' . display_desc($patient)  . '",';
          echo '"' . display_desc($product)  . '",';
          echo '"' . $productqty             . '",';
          echo '"'; bucks($producttotal); echo '"' . "\n";
        }
      }
      else {
?>
<?php
      } // End not csv export
    }
    $producttotal = 0;
    $productqty = 0;
    $product = $rowproduct;
    $productleft = $product;
    $invleft = $invnumber;
    $dateleft = $transdate;
  }

  if ($category != $rowcat) {
    if ($category) {
      // Print category total.
      if (!$_POST['form_csvexport']) {
?>

 <tr bgcolor="#ffdddd">
  <td class="detail">
   &nbsp;
  </td>
  <td class="detail" colspan="5">
   <?php echo xl('Total for: ') . ' '; echo display_desc($category); ?>
  </td>
  <td align="right">
   <?php echo $catqty; ?>
  </td>
  <td align="right" colspan="2">
   <?php bucks($cattotal); ?>
  </td><td>&nbsp;</td>
 </tr>
<?php
      } // End not csv export
    }
    $cattotal = 0;
    $catqty = 0;
    $category = $rowcat;
    $catleft = $category;
  }

  if ($_POST['form_details']) {
    if ($_POST['form_csvexport']) {
      echo '"' . display_desc($category ) . '",';
      echo '"' . display_desc($insurance) . '",';
      echo '"' . display_desc($patient  ) . '",';
      echo '"' . display_desc($product  ) . '",';
      echo '"' . oeFormatShortDate(display_desc($transdate)) . '",';
      echo '"' . display_desc($invnumber) . '",';
      echo '"' . display_desc($qty      ) . '",';
      echo '"'; bucks($rowamount); echo '"' . "\n";
    }
    else {
?>

 <tr>
  <td class="detail">
   <?php echo display_desc($catleft); $catleft = "&nbsp;"; ?>
  </td>
   <td >
   <?php echo $insurance; ?>
  </td>
  <td >
   <?php echo $patient; ?>
  </td>
  <td class="detail">
   <?php echo display_desc($productleft);/* $productleft = "&nbsp;";*/ ?>
  </td>
  <td>
   <?php echo oeFormatShortDate($transdate); ?>
  </td>
  <td class="detail">
   <a href='../patient_file/pos_checkout.php?ptid=<?php echo $patient_id; ?>&enc=<?php echo $encounter_id; ?>' class="iframe medium_modal" >
   <?php echo $invnumber; ?></a>
  </td>
  <td align="right">
   <?php echo $qty; ?>
  </td>
  <td align="right">
   <?php bucks($rowamount); ?>
  </td><td align="right">&nbsp;</td><td align="right">&nbsp;</td>
 </tr>
<?php

    } // End not csv export
  } // end details
  $producttotal += $rowamount;
  $cattotal     += $rowamount;
  $grandtotal   += $rowamount;
  $productqty   += $qty;
  $catqty       += $qty;
  $grandqty     += $qty;
} // end function

  if (! acl_check('acct', 'rep')) die(xl("Unauthorized access."));

  $INTEGRATED_AR = $GLOBALS['oer_config']['ws_accounting']['enabled'] === 2;

  if (!$INTEGRATED_AR) SLConnect();

  $form_from_date = fixDate($_POST['form_from_date'], date('Y-m-d'));
  $form_to_date   = fixDate($_POST['form_to_date']  , date('Y-m-d'));
  $form_facility  = $_POST['form_facility'];
  $form_provider  = $_POST['form_provider'];

  if ($_POST['form_csvexport']) {
    header("Pragma: public");
    header("Expires: 0");
    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
    header("Content-Type: application/force-download");
    header("Content-Disposition: attachment; filename=Billing_by_CPT.csv");
    header("Content-Description: File Transfer");
    // CSV headers:
    if ($_POST['form_details']) {
      echo '"Bill Date",';
      echo '"Insurance",';
      echo '"Patient",';
      echo '"CPT",';
      echo '"Date of Service",';
      echo '"Invoice",';
      echo '"Qty",';
      echo '"Amount"' . "\n";
    }
    else {
      echo '"Category",';
      echo '"CPT",';
      echo '"Qty",';
      echo '"Total"' . "\n";
    }
  } // end export
  else {
?>
<html>
<head>
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
<link rel="stylesheet" type="text/css" href="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.css" media="screen" />
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dialog.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.1.3.2.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/common.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery-ui.js"></script>
<script language="Javascript">
$(document).ready(function(){

    // fancy box
    enable_modals();

    // special size for
        $(".medium_modal").fancybox( {
                'overlayOpacity' : 0.0,
                'showCloseButton' : true,
                'frameHeight' : 460,
                'frameWidth' : 650
        });

});

</script>
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
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

<title><?php xl('Availity Billing Report','e') ?></title>
</head>

<body leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' class="body_top">

<span class='title'><?php xl('Report','e'); ?> - <?php xl('Availity Billing Report','e'); ?></span>

<form method='post' action='AvailityBillingReport.php' id='theform'>

<div id="report_parameters">
<input type='hidden' name='form_refresh' id='form_refresh' value=''/>
<input type='hidden' name='form_csvexport' id='form_csvexport' value=''/>
<table>
 <tr>
  <td width='72%' >
	<div style='float:left'>

	<table class='text'>
		<tr>
			<td class='label'>
				<?php xl('Facility','e'); ?>:
			</td>
			<td colspan='3'>
			<?php dropdown_facility(strip_escape_custom($form_facility), 'form_facility', true); ?>
			</td></tr><tr>
			<td class='label'>
			   <?php xl('From','e'); ?>:
			</td>
			<td>
			   <input type='text' name='form_from_date' id="form_from_date" size='10' value='<?php echo $form_from_date ?>'
				onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' title='yyyy-mm-dd'>
			   <img src='../pic/show_calendar.gif' align='absbottom' width='24' height='22'
				id='img_from_date' border='0' alt='[?]' style='cursor:pointer'
				title='<?php xl('Click here to choose a date','e'); ?>'>
			</td>
			<td class='label'>
			   <?php xl('To','e'); ?>:
			</td>
			<td>
			   <input type='text' name='form_to_date' id="form_to_date" size='10' value='<?php echo $form_to_date ?>'
				onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' title='yyyy-mm-dd'>
			   <img src='../pic/show_calendar.gif' align='absbottom' width='24' height='22'
				id='img_to_date' border='0' alt='[?]' style='cursor:pointer'
				title='<?php xl('Click here to choose a date','e'); ?>'>
			</td>
		</tr>
		<tr>
                 <td class='label'><?php xl('Provider','e'); ?>:</td>
                                <td><?php
                        // Build a drop-down list of providers.
                                //
                                $query = "SELECT id, lname, fname FROM users WHERE ".
                                  "authorized = 1 $provider_facility_filter ORDER BY lname, fname"; //(CHEMED) facility filter
                                $ures = sqlStatement($query);
                                echo "   <select name='form_provider'>\n";
                                echo "    <option value=''>-- " . xl('All') . " --\n";
                                while ($urow = sqlFetchArray($ures)) {
                                        $provid = $urow['id'];
                                        echo "    <option value='$provid'";
                                        if ($provid == $_POST['form_provider']) echo " selected";
                                        echo ">" . $urow['lname'] . ", " . $urow['fname'] . "\n";
                                }
                                echo "   </select>\n";
                                ?></td>
			<td colspan='2'>
			   <input type='checkbox' name='form_details'<?php  if ($form_details) echo ' checked'; ?>>
			   <?php  xl('Details','e'); ?>
			</td>
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
					<span>
						<?php xl('Submit','e'); ?>
					</span>
					</a>

					<?php if ($_POST['form_refresh'] || $_POST['form_csvexport']) { ?>
					<div id="controls">
					<a href='#' class='css_button' onclick='window.print()'>
						<span>
							<?php xl('Print','e'); ?>
						</span>
					</a>
					<a href='#' class='css_button' onclick='$("#form_refresh").attr("value",""); $("#form_csvexport").attr("value","true"); $("#theform").submit();'>
						<span>
							<?php xl('CSV Export','e'); ?>
						</span>
					</a>
					</div>
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
 if ($_POST['form_refresh'] || $_POST['form_csvexport']) {
?>
<div id="report_results">
<table >
 <thead>
   <th>
   <?php xl('Billing Date','e'); ?>
  </th>
  <th>
   <?php xl('Insurance','e'); ?>
  </th>
  <?php
  if ($form_details){ ?>
  <th>
   <?php xl('Patient','e'); ?>
  </th>
  <th>
   <?php xl('CPT','e'); ?>
  </th>
  <th>
   <?php xl('Date of Service','e'); ?>
  </th>
  <th>
   <?php xl('Invoice','e'); ?>
  </th> 
  <?php } else {echo "<th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th>";}?>
  <th align="right">
   <?php xl('Qty','e'); ?>
  </th>
 <?php
  if ($form_details){ ?>
  <th align="right">
   <?php xl('Amount','e'); ?>
  </th>
 <?php } else {echo "<th>&nbsp;</th>";}?>
  <th align="right">
    <?php xl('Total','e'); ?>
  </th><th>&nbsp;</th>
 </thead>
<?php
}
  } // end not export

  if ($_POST['form_refresh'] || $_POST['form_csvexport']) {
    $from_date = $form_from_date;
    $to_date   = $form_to_date;

    $category = "";
    $catleft = "";
    $cattotal = 0;
    $catqty = 0;
    $product = "";
    $productleft = "";
    $invleft = "";
    $dateleft = "";
    $producttotal = 0;
    $productqty = 0;
    $grandtotal = 0;
    $grandqty = 0;

    if ($INTEGRATED_AR) {
      $query = "SELECT DISTINCT b.fee, b.pid, b.provider_id, b.encounter, b.code_type, b.code, b.units, " .
        "b.code_text, b.bill_date, fe.date, fe.facility_id, lo.title, " .
        "p.fname, p.lname, " .
        "ins.name " .
        "FROM billing AS b " .
        "JOIN form_encounter AS fe ON fe.pid = b.pid AND fe.encounter = b.encounter " .
        "LEFT JOIN codes AS c ON c.code = b.code AND c.modifier = b.modifier AND c.code_type = b.code_type " .
        "LEFT JOIN patient_data AS p ON p.pid = b.pid " .
        "LEFT JOIN list_options AS lo ON lo.list_id = 'superbill' AND lo.option_id = c.superbill " .
        "LEFT JOIN insurance_companies AS ins ON ins.id = b.payer_id " .
        "WHERE b.code_type != 'COPAY' AND b.activity = 1 /* AND b.fee != 0 */ AND b.code_type = 'cpt4' AND " .
        "b.x12_partner_id = 24605 AND " .
        "b.process_date >= '$from_date 00:00:00' AND b.process_date <= '$to_date 23:59:59'";
      //  "b.bill_date >= '$from_date 00:00:00' AND b.bill_date <= '$to_date 23:59:59'";
      // because bill_date changes with re-opens and marked-cleared
      //  "fe.date >= '$from_date 00:00:00' AND fe.date <= '$to_date 23:59:59'";
      // If a facility was specified.
      if ($form_facility) {
        $query .= " AND fe.facility_id = '$form_facility'";
      }
      // If a provider was specified.
      if ($form_provider) {
        $query .= " AND b.provider_id = '$form_provider'";
      }
      $query .= " ORDER BY DATE(b.bill_date), ins.name, p.lname, fe.date, b.pid, lo.title, b.code, fe.id";
      //
      $res = sqlStatement($query);
      while ($row = sqlFetchArray($res)) {
        thisLineItem($row['pid'], $row['encounter'],
          substr($row['bill_date'], 0, 10),
          $row['lname'] . ', ' . $row['fname'], $row['code']/* . ' ' . $row['code_text']*/,
          substr($row['date'], 0, 10),
          $row['units'], $row['fee'], $row['name']);
      }
      //
      $query = "SELECT s.sale_date, s.fee, s.quantity, s.pid, s.encounter, " .
        "d.name, fe.date, fe.facility_id " .
        "FROM drug_sales AS s " .
        "JOIN drugs AS d ON d.drug_id = s.drug_id " .
        "JOIN form_encounter AS fe ON " .
        "fe.pid = s.pid AND fe.encounter = s.encounter AND " .
        "fe.date >= '$from_date 00:00:00' AND fe.date <= '$to_date 23:59:59' " .
        "WHERE s.fee != 0";
      // If a facility was specified.
      if ($form_facility) {
        $query .= " AND fe.facility_id = '$form_facility'";
      }
      $query .= " ORDER BY d.name, fe.date, fe.id";
      //
      $res = sqlStatement($query);
      while ($row = sqlFetchArray($res)) {
        thisLineItem($row['pid'], $row['encounter'], xl('Products'), $row['name'],
          substr($row['date'], 0, 10), $row['quantity'], $row['fee']);
      }
    }
    else {
      $query = "SELECT ar.invnumber, ar.transdate, " .
        "invoice.description, invoice.qty, invoice.sellprice " .
        "FROM ar, invoice WHERE " .
        "ar.transdate >= '$from_date' AND ar.transdate <= '$to_date' " .
        "AND invoice.trans_id = ar.id " .
        "ORDER BY invoice.description, ar.transdate, ar.id";
      $t_res = SLQuery($query);
      if ($sl_err) die($sl_err);
      for ($irow = 0; $irow < SLRowCount($t_res); ++$irow) {
        $row = SLGetRow($t_res, $irow);
        list($patient_id, $encounter_id) = explode(".", $row['invnumber']);
        // If a facility was specified then skip invoices whose encounters
        // do not indicate that facility.
        if ($form_facility) {
          $tmp = sqlQuery("SELECT count(*) AS count FROM form_encounter WHERE " .
            "pid = '$patient_id' AND encounter = '$encounter_id' AND " .
            "facility_id = '$form_facility'");
          if (empty($tmp['count'])) continue;
        }
        thisLineItem($patient_id, $encounter_id, '', $row['description'],
          $row['transdate'], $row['qty'], $row['sellprice'] * $row['qty']);
      } // end for
    } // end not $INTEGRATED_AR

    if ($_POST['form_csvexport']) {
      if (! $_POST['form_details']) {
        echo '"' . display_desc($catleft) . '",';
	echo '"' . display_desc($product) . '",';
        echo '"' . $productqty            . '",';
        echo '"'; bucks($producttotal); echo '"' . "\n";
      }
    }
    else {
?>


 <tr bgcolor="#ffdddd">
  <td class="detail">
   &nbsp;
  </td>
  <td class="detail" colspan="5">
   <?php echo xl('Total for:') . ' '; echo display_desc($category); ?>
  </td>
  <td align="right">
   <?php echo $catqty; ?>
  </td>
  <td align="right" colspan="2">
   <?php bucks($cattotal); ?>
  </td><td>&nbsp;</td>
 </tr>

 <tr>
  <td class="detail" colspan="6">
   <?php xl('Grand Total','e'); ?>
  </td>
  <td align="right">
   <?php echo $grandqty; ?>
  </td>
  <td align="right" colspan="2">
   <?php bucks($grandtotal); ?>
  </td><td align="right">&nbsp;</td>
 </tr>

<?php
    } // End not csv export
  }
  if (!$INTEGRATED_AR) SLClose();

  if (! $_POST['form_csvexport']) {
?>

</table>
</div> <!-- report results -->
<?php 

if ((isset($_POST['form_refresh']) || isset($_POST['form_csvexport'])) && $grandtotal == '0') 
	{
		echo "<span style='font-size:10pt;'>";
                echo xl('No matches found. Try search again.','e');
                echo "</span>";
		echo '<script>document.getElementById("report_results").style.display="none";</script>';
		echo '<script>document.getElementById("controls").style.display="none";</script>';
		}

if (!$_POST['form_refresh'] && !$_POST['form_csvexport']) { ?>
<div class='text'>
 	<?php echo xl('Please input search criteria above, and click Submit to view results.', 'e' ); ?>
</div>
<?php } ?>
</form>

</body>

<!-- stuff for the popup calendar -->

<link rel='stylesheet' href='<?php echo $css_header ?>' type='text/css'>
<style type="text/css">@import url(../../library/dynarch_calendar.css);</style>
<script type="text/javascript" src="../../library/dynarch_calendar.js"></script>
<?php include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php"); ?>
<script type="text/javascript" src="../../library/dynarch_calendar_setup.js"></script>

<script language="Javascript">
 Calendar.setup({inputField:"form_from_date", ifFormat:"%Y-%m-%d", button:"img_from_date"});
 Calendar.setup({inputField:"form_to_date", ifFormat:"%Y-%m-%d", button:"img_to_date"});
 top.restoreSession();
</script>

</html>
<?php
  } // End not csv export
?>
