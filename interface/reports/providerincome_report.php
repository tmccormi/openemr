<?php
// Copyright (C) OEMR.ORG 
// Ported by Visolve and Medical Information Integration

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

require_once("../globals.php");

$INTEGRATED_AR = $GLOBALS['oer_config']['ws_accounting']['enabled'] === 2;
if (!$INTEGRATED_AR)
{

    echo "Sorry, this report must be used with the integrated Accounts Receivable\n";
    exit;
}

require_once("$srcdir/patient.inc");
require_once("$srcdir/sql-ledger.inc");
require_once("$srcdir/acl.inc");
require_once("$srcdir/formatting.inc.php");
require_once "$srcdir/options.inc.php";
require_once "$srcdir/formdata.inc.php";
require_once("../../library/invoice_summary.inc.php");
require_once("../../library/sl_eob.inc.php");

function bucks($amount) {
  if ($amount) echo oeFormatMoney($amount);
}

$alertmsg = '';
$bgcolor = "#aaaaaa";

$today = date("Y-m-d");

$form_from_date      = fixDate($_POST['form_from_date'], "");
$form_to_date   = fixDate($_POST['form_to_date'], "");
$is_summary = $_POST['form_cb_summary'];


// In the case of CSV export only, a download will be forced.
if ($_POST['form_csvexport']) {
  header("Pragma: public");
  header("Expires: 0");
  header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
  header("Content-Type: application/force-download");
  header("Content-Disposition: attachment; filename=providerincome_report.csv");
  header("Content-Description: File Transfer");
}
else {

?>
<html>
<head>
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
<link rel="stylesheet" type="text/css" href="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.css" media="screen" />
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dialog.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.1.3.2.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/common.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery-ui.js"></script>
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

<title><?php xl('Provider Income Report','e') ?></title>
</head>

<body leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' class="body_top">

<span class='title'><?php xl('Report','e'); ?> - <?php xl('Provider Income Report','e'); ?></span>

<form method='post' action='providerincome_report.php' id='theform'>

<div id="report_parameters">
<input type='hidden' name='form_refresh' id='form_refresh' value=''/>
<input type='hidden' name='form_csvexport' id='form_csvexport' value=''/>
<table>
 <tr>
  <td width='72%'>
	<div style='float:left'>

	<table class='text'>
		<tr>
			<td class='label'>
				<?php xl('Provider','e'); ?>:
			</td>
			<td>
                           <?php
			  // Build a drop-down list of providers
			  //
			  $query="select f.provider_id as id, CONCAT(u.fname,' ',u.lname) as provider from form_encounter as f left join users as u on f.provider_id=u.id group by provider";
			  $fres = sqlStatement($query);
			  echo "   <select name='form_provider'>\n";
			  echo "    <option value=''>-- " . xl('All Providers') . " --\n";
			  while ($frow = sqlFetchArray($fres)) {
			  $provid = $frow['id'];
			  if ($provid == 0 || $provid == 1) continue;
			  echo "    <option value='$provid'";
		          if ($provid == $form_provider) echo " selected";
		          echo ">" . $frow['provider'] . "\n";
			  }
			  echo "   </select>\n";
			?>
			</td></tr><tr>
			<td class='label'>
			   <?php xl('Service Date From','e'); ?>:
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

 if ($_POST['form_refresh'] || $_POST['form_csvexport']) {

   $rows = array();
  $where = "";

  if ($form_from_date) {
      if ($where) $where .= " AND ";
      if ($form_to_date) {
        $where .= "f.date >= '$form_from_date 00:00:00' AND f.date <= '$form_to_date 23:59:59'";
      }
      else {
        $where .= "f.date >= '$form_from_date 00:00:00' AND f.date <= '$form_from_date 23:59:59'";
      }
    }
    if ($form_provider) {
      if ($where) $where .= " AND ";
      $where .= "f.provider_id = '$form_provider'";
    }
    if (! $where) {
      $where = "1 = 1";
    }
    $query = "SELECT f.provider_id as provid, CONCAT(eu.fname,' ', eu.lname) AS provider, f.date," .
        "( SELECT SUM(b.fee) FROM billing AS b WHERE " .
        "b.pid = f.pid AND b.encounter = f.encounter AND " .
        "b.activity = 1 AND b.code_type != 'COPAY' ) AS charges, " .
        "( SELECT SUM(b.fee) FROM billing AS b WHERE " .
        "b.pid = f.pid AND b.encounter = f.encounter AND " .
        "b.activity = 1 AND b.code_type = 'COPAY' ) AS copays, " .
        "( SELECT SUM(s.fee) FROM drug_sales AS s WHERE " .
        "s.pid = f.pid AND s.encounter = f.encounter ) AS sales, " .
        "( SELECT SUM(a.pay_amount) FROM ar_activity AS a WHERE " .
        "a.pid = f.pid AND a.encounter = f.encounter ) AS payments, " .
        "( SELECT SUM(a.adj_amount) FROM ar_activity AS a WHERE " .
        "a.pid = f.pid AND a.encounter = f.encounter ) AS adjustments " .
        "FROM form_encounter AS f " .
        "LEFT OUTER JOIN users AS eu ON eu.id = f.provider_id " .
        "WHERE $where " .
        "AND eu.fname is not NULL and eu.lname is not NULL " .
        "order by provider,f.date" ;

    $eres = sqlStatement($query);
    while ($erow = sqlFetchArray($eres)) {
        if ( $erow["provid"] == 0 || $erow["provid"] == 1 )
            continue;
          $provider = $erow['provider'];


        foreach ($erow as $name => $value)
        {
            if ($name == "provider")
            {
                $index=$value;
                continue;
            }

            // this is a running set of totals.  The first time, $rows[$index][$name] ought to be zero!\
            // convert to cents!
            $value=bcmul($value,"100",2);

            if ( isset ($rows[$index][$name]) )
            $rows[$index][$name] = $value + $rows[$index][$name];
            else
            $rows[$index][$name] = $value;
        }

    } // end while

  ksort($rows);   
 
   if ($_POST['form_csvexport']) {
    echo "jason was here!";
    // CSV headers:
    if (true) {
      echo '"Provider",';
      echo '"Charges",';
      echo '"Copays",';
      echo '"Sales",';
      echo '"Adjustments",';
      echo '"Payments",';
      echo '"Total"' . "\n";
    }
  }

    else {
?>
  <div id="report_results">
<table >
 <thead>
  <th>
   <?php xl('Provider','e'); ?>
  </th>
  <th align="right">
   <?php xl('Charges','e'); ?>
  </th>
  <th align="right">
   <?php xl('Copays','e'); ?>
  </th>
  <th align="right">
   <?php xl('Sales','e'); ?>
  </th>
  <th align="right" >
   <?php xl('Adjustments','e'); ?>
  </th>
  <th align="right">
   <?php xl('Payments','e'); ?>
  </th>
  <th align="right">
   <?php xl('Total','e'); ?>
  </th>
 </thead>
<?php
}
 
   foreach ($rows as $key => $row)
        {
                // the following expression is done in cents!
                $rowtotal=$rows[$key]['charges'] + $rows[$key]['sales'] + $rows[$key]['copays'] - $rows[$key]['adjustments'] - $rows[$key]['payments'];

                $rowtotal=bcdiv($rowtotal,100,2);
                $rows[$key]['charges'] = bcdiv( $rows[$key]['charges'],100,2);
                $rows[$key]['copays'] = bcdiv( $rows[$key]['copays'],100,2);
                $rows[$key]['sales'] = bcdiv( $rows[$key]['sales'],100,2);
                $rows[$key]['adjustments'] = bcdiv( $rows[$key]['adjustments'],100,2);
                $rows[$key]['payments'] = bcdiv( $rows[$key]['payments'],100,2);

                $pagetotal += $rowtotal;

        // if we are just outputing html
        if ( $_POST['form_csvexport'])
        {
            echo '"' . $key                       . '",';
            echo '"' . $rows[$key]['charges']     . '",';
            echo '"' . $rows[$key]['copays']      . '",';
            echo '"' . $rows[$key]['sales']       . '",';
            echo '"' . $rows[$key]['adjustments'] . '",';
            echo '"' . $rows[$key]['payments']    . '",';
            echo '"' . $rowtotal                  . '"' . "\n";

        }
         else {
        ?>
        <tr bgcolor="#ddddff">
            <td class='detail' >&nbsp;<?php echo $key?></td>
            <td class='detail' align='right'>&nbsp;<?php echo sprintf("%.2f", $rows[$key]['charges'])?></td>
            <td class='detail' align='right'>&nbsp;<?php echo sprintf("%.2f", $rows[$key]['copays'])?></td>
            <td class='detail' align='right'>&nbsp;<?php echo sprintf("%.2f", $rows[$key]['sales'])?></td>
            <td class='detail' align='right'>&nbsp;<?php echo sprintf("%.2f", $rows[$key]['adjustments'])?></td>
            <td class='detail' align='right'>&nbsp;<?php echo sprintf("%.2f", $rows[$key]['payments'])?></td>
            <?php
                ?>
            <td class='detail' align='right'>&nbsp;<?php echo sprintf("%.2f", $rowtotal)?></td>
            <?php
        } // end printing html

                $pagecharges += $rows[$key]['charges'];
                $pagecopays += $rows[$key]['copays'];
                $pagesales += $rows[$key]['sales'];
                $pageadjustments += $rows[$key]['adjustments'];
                $pagepayments += $rows[$key]['payments'];

            ?>
        <?php
        } // end of foreach "($rows" loop ?>
        </tr>
        
       <?php

if ( $_POST['form_csvexport'])
{
    echo '"' . xl('Report Totals')  . '",';
    echo '"' . $pagecharges         . '",';
    echo '"' . $pagecopays          . '",';
    echo '"' . $pagesales           . '",';
    echo '"' . $pageadjustments     . '",';
    echo '"' . $pagepayments        . '",';
    echo '"' . $pagetotal           . '"' . "\n";
}
else {

     echo " <tr bgcolor='#ffdddd'>\n";
	echo "  <td class='dehead'>&nbsp;" . xl('Report Totals') . ":</td>\n";
	echo "  <td class='dehead' align='right'>&nbsp;" .
	sprintf("%.2f", $pagecharges) . "&nbsp;</td>\n";
	echo "  <td class='dehead' align='right'>&nbsp;" .
	sprintf("%.2f", $pagecopays) . "&nbsp;</td>\n";
	echo "  <td class='dehead' align='right'>&nbsp;" .
	sprintf("%.2f", $pagesales) . "&nbsp;</td>\n";
	echo "  <td class='dehead' align='right'>&nbsp;" .
	sprintf("%.2f", $pageadjustments) . "&nbsp;</td>\n";
	echo "  <td class='dehead' align='right'>&nbsp;" .
	sprintf("%.2f", $pagepayments) . "&nbsp;</td>\n";
	echo "  <td class='dehead' align='right'>&nbsp;" .
	sprintf("%.2f", $pagetotal) . "&nbsp;</td>\n";
	echo "</tr>\n";
        }
} // end if form_search

  if (! $_POST['form_csvexport']) {
?>
</table>
</div> <!-- report results -->
<?php 
if ((isset($_POST['form_refresh']) || isset($_POST['form_csvexport'])) && round($pagetotal) == '0') 
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
<script language="JavaScript">
<?php
  if ($alertmsg) {
    echo "alert('" . htmlentities($alertmsg) . "')\n";
  }
?>
</script>
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
