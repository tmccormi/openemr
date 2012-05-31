<?php
// Copyright (C) 2006-2010 Rod Roark <rod@sunsetsystems.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

// This is a report of cpt financial description.

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

$grand_total_units  = 0;
$grand_total_amt_billed  = 0;
$grand_total_amt_paid  = 0;
$grand_total_amt_adjustment  = 0;
$grand_total_amt_balance  = 0;


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
    header("Content-Disposition: attachment; filename=CPT_financial_report.csv");
    header("Content-Description: File Transfer");
    // CSV headers:
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

<title><?php xl('CPT Report','e') ?></title>
</head>
<body leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' class="body_top">
<span class='title'><?php xl('Report','e'); ?> - <?php xl('CPT Report','e'); ?></span>
<form method='post' action='CPT_financial_report.php' id='theform'>
<div id="report_parameters">
<input type='hidden' name='form_refresh' id='form_refresh' value=''/>
<input type='hidden' name='form_csvexport' id='form_csvexport' value=''/>
<table>
 <tr>
  <td width='70%'>
	<div style='float:left'>
	<table class='text'>
		<tr>
			<td class='label'>
				<?php xl('Facility','e'); ?>:
			</td>
			<td>
			<?php dropdown_facility(strip_escape_custom($form_facility), 'form_facility', true); ?>
			</td>
                        <td><?php xl('Provider','e'); ?>:</td>
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
                                ?>
				</td>
		</tr><tr>
                 <td colspan="2">
                          <?php xl('From','e'); ?>:&nbsp;&nbsp;&nbsp;&nbsp;
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
                        <td>
                           <input type='checkbox' name='form_details'<?php  if ($form_details) echo ' checked'; ?>>
                           <?php  xl('Important Codes','e'); ?>
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
}
   // end not export

  if ($_POST['form_refresh'] || $_POST['form_csvexport']) {
    $rows = array();
    $from_date = $form_from_date;
    $to_date   = $form_to_date;

    if ($INTEGRATED_AR) {
    $query = " select b.pid,b.encounter, b.provider_id,b.code, sum(distinct b.units) as units, sum(distinct b.fee) as billed , " .
        "COALESCE(ar.pay_amount,0) as PaidAmount, COALESCE(sum(ar.adj_amount),0) as AdjustAmout, " .
        "(sum(distinct b.fee)-(COALESCE(ar.pay_amount,0) + COALESCE(sum(ar.adj_amount),0))) as Balance " .
        "FROM billing AS b " .
        "LEFT OUTER JOIN ar_activity as ar on b.pid=ar.pid and b.encounter=ar.encounter " .
        "JOIN form_encounter AS fe ON fe.pid = b.pid AND fe.encounter = b.encounter " .
        "LEFT OUTER JOIN codes AS c ON c.code = b.code AND c.modifier = b.modifier AND c.code_type = b.code_type " .
        "WHERE b.code_type != 'COPAY' AND b.activity = 1 /* AND b.fee != 0 */ AND b.code_type = 'cpt4' AND " .
        "fe.date >= '$from_date 00:00:00' AND fe.date <= '$to_date 23:59:59'";
    // If a facility was specified.
      if ($form_facility) {
        $query .= " AND fe.facility_id = '$form_facility'";
      }
    // If a provider was specified.
      if ($form_provider) {
        $query .= " AND b.provider_id = '$form_provider'";
      }
      $query .= " GROUP BY b.encounter,b.code ORDER BY b.code, fe.date, fe.id ";
      //
      $res = sqlStatement($query);
      
      $grand_total_units  = 0;
      $grand_total_amt_billed  = 0;
      $grand_total_amt_paid  = 0;
      $grand_total_amt_adjustment  = 0;
      $grand_total_amt_balance  = 0;
 
      while ($erow = sqlFetchArray($res)) {
	  $row = array();
      $row['pid'] = $erow['pid'];
      $row['provider_id'] = $erow['provider_id'];
      $row['Procedure codes'] = $erow['code'];
      $row['Units'] = $erow['units'];
      $row['Amt Billed'] = $erow['billed'];
      $row['Paid Amt'] = $erow['PaidAmount'];
      $row['Adjustment Amt'] = $erow['AdjustAmout'];
      $row['Balance Amt'] = $erow['Balance'];
      $rows[$erow['pid'] . '|' . $erow['code'] . '|' . $erow['units']] = $row;
      }
              if ($_POST['form_csvexport']) {
                // CSV headers:
                if (true) {
                  echo '"Procedure codes",';
                  echo '"Units",';
                  echo '"Amt Billed",';
                  echo '"Paid Amt",';
                  echo '"Adjustment Amt",';
                  echo '"Balance Amt",' . "\n";
                }
              } else {
?> <div id="report_results">
<table >
 <thead>
  <th>
   <?php xl('Procedure Codes','e'); ?>
  </th>
  <th >
   <?php xl('Units','e'); ?>
  </th>
  <th>
   <?php xl('Amt Billed','e'); ?>
  </th>
  <th>
   <?php xl('Paid Amt','e'); ?>
  </th>
  <th >
   <?php xl('Adjustment Amt','e'); ?>
  </th>
  <th >
   <?php xl('Balance Amt','e'); ?>
  </th>
 </thead>
 <?php
              }
     $orow = -1;
 $code_query = "select option_id from list_options where list_id='CPT_report_codes'";
        $cores = sqlStatement($code_query);
 while($result=sqlFetchArray($cores)){
 $core[] = $result['option_id'];
 }
     foreach ($rows as $key => $row) {
$print = '';
$csv = '';
		if($_POST['form_details']) {
			 if(in_array($row['Procedure codes'],$core)){
$print = "<tr bgcolor='#FFFFDD'><td class='detail'>".$row['Procedure codes']."</td><td class='detail'>".$row['Units']."</td><td class='detail'>".$row['Amt Billed']."</td><td class='detail'>".$row['Paid Amt']."</td><td class='detail'>".$row['Adjustment Amt']."</td><td class='detail'>".$row['Balance Amt']."</td>";

$csv = '"' . $row['Procedure codes'] . '","' . $row['Units'] . '","' . oeFormatMoney($row['Amt Billed']) . '","' . oeFormatMoney($row['Paid Amt']) . '","' . oeFormatMoney($row['Adjustment Amt']) . '","' . oeFormatMoney($row['Balance Amt']) . '"' . "\n";

$bgcolor = ((++$orow & 1) ? "#ffdddd" : "#ddddff");
                                $grand_total_units  += $row['Units'];
                                                $grand_total_amt_billed  += $row['Amt Billed'];
                                                $grand_total_amt_paid  += $row['Paid Amt'];
                                                $grand_total_amt_adjustment  += $row['Adjustment Amt'];
                                                $grand_total_amt_balance  += $row['Balance Amt'];
	                }

		} else {
 if(in_array($row['Procedure codes'],$core)){ $bgcolor = "#FFFFDD";  }else { $bgcolor = "#FFDDDD";  }
$print = "<tr bgcolor='$bgcolor'><td class='detail'>".$row['Procedure codes']."</td><td class='detail'>".$row['Units']."</td><td class='detail'>".$row['Amt Billed']."</td><td class='detail'>".$row['Paid Amt']."</td><td class='detail'>".$row['Adjustment Amt']."</td><td class='detail'>".$row['Balance Amt']."</td>"; 

$csv = '"' . $row['Procedure codes'] . '","' . $row['Units'] . '","' . oeFormatMoney($row['Amt Billed']) . '","' . oeFormatMoney($row['Paid Amt']) . '","' . oeFormatMoney($row['Adjustment Amt']) . '","' . oeFormatMoney($row['Balance Amt']) . '"' . "\n";

$bgcolor = ((++$orow & 1) ? "#ffdddd" : "#ddddff");
                                $grand_total_units  += $row['Units'];
                                                $grand_total_amt_billed  += $row['Amt Billed'];
                                                $grand_total_amt_paid  += $row['Paid Amt'];
                                                $grand_total_amt_adjustment  += $row['Adjustment Amt'];
                                                $grand_total_amt_balance  += $row['Balance Amt'];
}
        if ($_POST['form_csvexport']) { echo $csv; } 
	else { echo $print;
 }
     }
       if (!$_POST['form_csvexport']) {
         echo "<tr bgcolor='#ffffff'>\n";
         echo " <td class='detail'>Grand Total</td>\n"; 
         echo " <td class='detail'>" . $grand_total_units . "</td>\n";
		 echo " <td class='detail'>" .
         oeFormatMoney($grand_total_amt_billed) . "</td>\n";
		 echo " <td class='detail'>" .
         oeFormatMoney($grand_total_amt_paid) . "</td>\n";
   		 echo " <td class='detail'>" .
         oeFormatMoney($grand_total_amt_adjustment) . "</td>\n";
  		 echo " <td class='detail'>" .
         oeFormatMoney($grand_total_amt_balance) . "</td>\n";
         echo " </tr>\n";
          ?>
                </table>    </div>
        <?php
      }
    }
	}

  if (! $_POST['form_csvexport']) {
       if ( $_POST['form_refresh'] && count($print) != 1)
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
