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
require_once("$srcdir/classes/Prescription.class.php");

if (isset($_GET['mode'])) {
    
    if ($_GET['mode'] == "add" ) {
        $sql = "REPLACE INTO immunizations set 
                      id = ?,
                      administered_date = if(?,?,NULL),  
                      immunization_id = ?,
                      manufacturer = ?,
                      lot_number = ?,
                      administered_by_id = if(?,?,NULL),
                      administered_by = if(?,?,NULL),
                      education_date = if(?,?,NULL), 
                      vis_date = if(?,?,NULL), 
                      product_name = ?,
                      description_code = ?,
                      vaccine_description = ?,
                      negationreason_id = ?,
                      source_id = ?,
                      site_id = ?,
                      route_id = ?,
                      note   = ?,
                      patient_id   = ?,
                      created_by = ?,
                      updated_by = ?,
                      create_date = now() ";
	$sqlBindArray = array(
	             trim($_GET['id']),
		     trim($_GET['administered_date']), trim($_GET['administered_date']),
		     trim($_GET['form_immunization_id']),
		     trim($_GET['manufacturer']),
		     trim($_GET['lot_number']),
		     trim($_GET['administered_by_id']), trim($_GET['administered_by_id']),
		     trim($_GET['administered_by']), trim($_GET['administered_by']),
		     trim($_GET['education_date']), trim($_GET['education_date']),
		     trim($_GET['vis_date']), trim($_GET['vis_date']),
		     trim($_GET['product_name']),
		     trim($_GET['description_code']),
		     trim($_GET['vaccine_description']),
		     trim($_GET['negationreason_id']),
		     trim($_GET['source_id']),
		     trim($_GET['site_id']),
		     trim($_GET['route_id']),
         trim($_GET['note']),
		     $pid,
		     $_SESSION['authId'],
		     $_SESSION['authId']
		     );
        sqlStatement($sql,$sqlBindArray);
        $administered_date=$education_date=date('Y-m-d');
        $immunization_id=$manufacturer=$lot_number=$administered_by_id=$note=$id=$product_name="";
        $administered_by=$vis_date="";
    }
    elseif ($_GET['mode'] == "delete" ) {
        // log the event
        newEvent("delete", $_SESSION['authUser'], $_SESSION['authProvider'], 1, "Immunization id ".$_GET['id']." deleted from pid ".$pid);
        // delete the immunization
        $sql="DELETE FROM immunizations WHERE id =? LIMIT 1";
        sqlStatement($sql, array($_GET['id']));
    }
    elseif ($_GET['mode'] == "edit" ) {
        $sql = "select * from immunizations where id = ?";
        $results = sqlQ($sql, array($_GET['id']));
        while ($row = sqlFetchArray($results)) {
            $administered_date = $row['administered_date'];
            $immunization_id = $row['immunization_id'];
            $product_name = $row['product_name'];
            $description_code = $row['description_code'];
            $vaccine_description = $row['vaccine_description'];
            $negationreason_id = $row['negationreason_id'];
            $source_id = $row['source_id'];
            $site_id = $row['site_id'];
            $route_id = $row['route_id'];
            $manufacturer = $row['manufacturer'];
            $lot_number = $row['lot_number'];
            $administered_by_id = ($row['administered_by_id'] ? $row['administered_by_id'] : 0);
            $administered_by = $row['administered_by'];
            $education_date = $row['education_date'];
            $vis_date = $row['vis_date'];
            $note = $row['note'];
        }
	//set id for page
	$id = $_GET['id'];
    }
}

// set the default sort method for the list of past immunizations
$sortby = $_GET['sortby'];
if (!$sortby) { $sortby = 'vacc'; }

// set the default value of 'administered_by'
if (!$administered_by && !$administered_by_id) { 
    $stmt = "select concat(lname,', ',fname) as full_name ".
            " from users where ".
            " id=?";
    $row = sqlQuery($stmt, array($_SESSION['authId']));
    $administered_by = $row['full_name'];
}
?>
<html>
<head>
<?php html_header_show();?>

<!-- supporting javascript code -->
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/textformat.js"></script>

<!-- page styles -->
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">

<style>
.highlight {
  color: green;
}
tr.selected {
  background-color: white;
}	
.negated {
  color: red;
}
</style>
		
<!-- pop up calendar -->
<style type="text/css">@import url(<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.css);</style>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.js"></script>
<?php include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php"); ?>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_setup.js"></script>

<script language="JavaScript">
// required to validate date text boxes
var mypcc = '<?php echo htmlspecialchars( $GLOBALS['phone_country_code'], ENT_QUOTES); ?>';
</script>

</head>

<body class="body_top">

<?php if ($GLOBALS['concurrent_layout']) { ?>
    <span class="title"><?php echo htmlspecialchars( xl('Immunizations'), ENT_NOQUOTES); ?></span>
<?php } else { ?>
    <a href="patient_summary.php" target="Main" onclick="top.restoreSession()">
    <span class="title"><?php echo htmlspecialchars( xl('Immunizations'), ENT_NOQUOTES); ?></span>
    <span class=back><?php echo htmlspecialchars( $tback, ENT_NOQUOTES); ?></span></a>
<?php } ?>

<form action="immunizations.php" name="add_immunization" id="add_immunization">
<input type="hidden" name="mode" id="mode" value="add">
<input type="hidden" name="id" id="id" value="<?php echo htmlspecialchars( $id, ENT_QUOTES); ?>"> 
<input type="hidden" name="pid" id="pid" value="<?php echo htmlspecialchars( $pid, ENT_QUOTES); ?>"> 
<br>
      <table border=0 cellpadding=1 cellspacing=1>

        <tr>
          <td align="right">
            <span class=text>
              <?php echo htmlspecialchars( xl('Immunization'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td>
              <?php
               	// Modified 7/2009 by BM to incorporate the immunization items into the list_options listings
		generate_form_field(array('data_type'=>1,'field_id'=>'immunization_id','list_id'=>'immunizations','empty_title'=>'SKIP'), $immunization_id);
              ?>
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class=text>
              <?php echo htmlspecialchars( xl('Date Administered'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td>

   <input type='text' size='10' name="administered_date" id="administered_date"
    value='<?php echo $administered_date ? htmlspecialchars( $administered_date, ENT_QUOTES) : date('Y-m-d'); ?>'
    title='<?php echo htmlspecialchars( xl('yyyy-mm-dd'), ENT_QUOTES); ?>'
    onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc);'
    />
   <img src='<?php echo $rootdir; ?>/pic/show_calendar.gif' align='absbottom' width='24' height='22'
    id='img_administered_date' border='0' alt='[?]' style='cursor:pointer;cursor:hand'
    title='<?php echo htmlspecialchars( xl('Click here to choose a date'), ENT_QUOTES); ?>'>

          </td>
        </tr>
        <tr>
          <td align="right">
            <span class=text>
              <?php echo htmlspecialchars( xl('Product Name'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td>
            <input class='text' type='text' name="product_name" size="25" value="<?php echo htmlspecialchars( $product_name, ENT_QUOTES); ?>">
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class=text>
              <?php echo htmlspecialchars( xl('Description Code'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td>
            <input class='text' type='text' name="description_code" size="25" value="<?php echo htmlspecialchars( $description_code, ENT_QUOTES); ?>">
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class=text>
              <?php echo htmlspecialchars( xl('Vaccine Description'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td>
            <input class='text' type='text' name="vaccine_description" size="25" value="<?php echo htmlspecialchars( $vaccine_description, ENT_QUOTES); ?>">
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class=text>
              <?php echo htmlspecialchars( xl('Immunization Manufacturer'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td>
            <input class='text' type='text' name="manufacturer" size="25" value="<?php echo htmlspecialchars( $manufacturer, ENT_QUOTES); ?>">
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class=text>
              <?php echo htmlspecialchars( xl('Immunization Lot Number'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td>
            <input class='text' type='text' name="lot_number" size="25" value="<?php echo htmlspecialchars( $lot_number, ENT_QUOTES); ?>">
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class='text'>
              <?php echo htmlspecialchars( xl('Name and Title of Immunization Administrator'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td class='text'>
            <input type="text" name="administered_by" id="administered_by" size="25" value="<?php echo htmlspecialchars( $administered_by, ENT_QUOTES); ?>">
            <?php echo htmlspecialchars( xl('or choose'), ENT_NOQUOTES); ?>
<!-- NEEDS WORK -->
            <select name="administered_by_id" id='administered_by_id'>
            <option value=""></option>
              <?php
                $sql = "select id, concat(lname,', ',fname) as full_name " .
                       "from users where username != '' " .
                       "order by concat(lname,', ',fname)";

                $result = sqlStatement($sql);
                while($row = sqlFetchArray($result)){
                  echo '<OPTION VALUE=' . htmlspecialchars( $row{'id'}, ENT_QUOTES);
                  echo (isset($administered_by_id) && $administered_by_id != "" ? $administered_by_id : $_SESSION['authId']) == $row{'id'} ? ' selected>' : '>';
                  echo htmlspecialchars( $row{'full_name'}, ENT_NOQUOTES) . '</OPTION>';
                }
              ?>
            </select>
          </td>
        </tr>
        <tr>
          <td align="right" class="text">
              <?php echo htmlspecialchars( xl('Date Immunization Information Statements Given'), ENT_NOQUOTES); ?>
          </td>
          <td>
            <input type='text' size='10' name="education_date" id="education_date"
                    value='<?php echo $education_date? htmlspecialchars( $education_date, ENT_QUOTES) : date('Y-m-d'); ?>'
                    title='<?php echo htmlspecialchars( xl('yyyy-mm-dd'), ENT_QUOTES); ?>'
                    onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc);'
            />
            <img src='<?php echo $rootdir; ?>/pic/show_calendar.gif' align='absbottom' width='24' height='22'
                id='img_education_date' border='0' alt='[?]' style='cursor:pointer;'
                title='<?php echo htmlspecialchars( xl('Click here to choose a date'), ENT_QUOTES); ?>'
            />
          </td>
        </tr>
        <tr>
          <td align="right" class="text">
              <?php echo htmlspecialchars( xl('Date of VIS Statement'), ENT_NOQUOTES); ?>
              (<a href="http://www.cdc.gov/vaccines/pubs/vis/default.htm" title="<?php echo htmlspecialchars( xl('Help'), ENT_QUOTES); ?>" target="_blank">?</a>)
          </td>
          <td>
            <input type='text' size='10' name="vis_date" id="vis_date"
                    value='<?php echo $vis_date ? htmlspecialchars( $vis_date, ENT_QUOTES) : date('Y-m-d'); ?>'
                    title='<?php echo htmlspecialchars( xl('yyyy-mm-dd'), ENT_QUOTES); ?>'
                    onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc);'
            />
            <img src='<?php echo $rootdir; ?>/pic/show_calendar.gif' align='absbottom' width='24' height='22'
                id='img_vis_date' border='0' alt='[?]' style='cursor:pointer;'
                title='<?php echo htmlspecialchars( xl('Click here to choose a date'), ENT_QUOTES); ?>'
            />
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class='text'>
              <?php echo htmlspecialchars( xl('Site'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td class='text'>
            <select name="site_id" id='site_id'>
              <?php
                $a = load_snomed_codes();

                foreach ($a as $k => $v) {
                  echo '<OPTION VALUE=' . htmlspecialchars( $k, ENT_QUOTES);
                  echo (isset($site_id) && $site_id == $k) ? ' selected>' : '>';
                  echo htmlspecialchars( $v, ENT_NOQUOTES) . '</OPTION>';
                }
              ?>
            </select>
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class='text'>
              <?php echo htmlspecialchars( xl('Route'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td class='text'>
            <select name="route_id" id='route_id'>
              <?php
                $sql = "SELECT * FROM list_options WHERE list_id = 'drug_route' ORDER BY seq";

                $result = sqlStatement($sql);
                while($row = sqlFetchArray($result)){
                  echo '<OPTION VALUE=' . htmlspecialchars( $row['option_id'], ENT_QUOTES);
                  echo (isset($route_id) && $route_id == $row['option_id']) ? ' selected>' : '>';
                  echo htmlspecialchars( $row['title'], ENT_NOQUOTES) . '</OPTION>';
                }
              ?>
            </select>
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class='text'>
              <?php echo htmlspecialchars( xl('No Immunization Reason'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td class='text'>
            <select name="negationreason_id" id='negationreason_id'>
              <?php
                $sql = "SELECT * FROM list_options WHERE list_id = 'immunizationnegationreason' ORDER BY seq";

                $result = sqlStatement($sql);
                while($row = sqlFetchArray($result)){
                  echo '<OPTION VALUE=' . htmlspecialchars( $row['option_id'], ENT_QUOTES);
                  echo (isset($negationreason_id) && $negationreason_id == $row['option_id']) ? ' selected>' : '>';
                  echo htmlspecialchars( $row['title'], ENT_NOQUOTES) . '</OPTION>';
                }
              ?>
            </select>
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class='text'>
              <?php echo htmlspecialchars( xl('Source'), ENT_NOQUOTES); ?>
            </span>
          </td>
          <td class='text'>
            <select name="source_id" id='source_id'>
              <?php
                $sql = "SELECT * FROM list_options WHERE list_id = 'immunizationsource' ORDER BY seq";

                $result = sqlStatement($sql);
                while($row = sqlFetchArray($result)){
                  echo '<OPTION VALUE=' . htmlspecialchars( $row['option_id'], ENT_QUOTES);
                  echo (isset($source_id) && $source_id == $row['option_id']) ? ' selected>' : '>';
                  echo htmlspecialchars( $row['title'], ENT_NOQUOTES) . '</OPTION>';
                }
              ?>
            </select>
          </td>
        </tr>
        <tr>
          <td align="right" class='text'>
              <?php echo htmlspecialchars( xl('Notes'), ENT_NOQUOTES); ?>
          </td>
          <td>
            <textarea class='text' name="note" id="note" rows=5 cols=25><?php echo htmlspecialchars( $note, ENT_NOQUOTES); ?></textarea>
          </td>
        </tr>
        <tr>
          <td colspan="3" align="center">
	
	    <input type="button" name="save" id="save" value="<?php echo htmlspecialchars( xl('Save Immunization'), ENT_QUOTES); ?>">
	
            <input type="button" name="print" id="print" value="<?php echo htmlspecialchars( xl('Print Record') . xl('PDF','',' (',')'), ENT_QUOTES); ?>">
	
	    <input type="button" name="printHtml" id="printHtml" value="<?php echo htmlspecialchars( xl('Print Record') . xl('HTML','',' (',')'), ENT_QUOTES); ?>">
            
            <input type="reset" name="clear" id="clear" value="<?php echo htmlspecialchars( xl('Clear'), ENT_QUOTES); ?>">
          </td>
        </tr>
      </table>
    </form>

<div id="immunization_list">

    <table border=0 cellpadding=3 cellspacing=0>

    <!-- some columns are sortable -->
    <tr class='text bold'>
    <th>
        <a href="javascript:top.restoreSession();location.href='immunizations.php?sortby=vacc';" title='<?php echo htmlspecialchars( xl('Sort by vaccine'), ENT_QUOTES); ?>'>
          <?php echo htmlspecialchars( xl('Vaccine'), ENT_NOQUOTES); ?></a>
        <span class='small' style='font-family:arial'><?php if ($sortby == 'vacc') { echo 'v'; } ?></span>
    </th>
    <th>
        <a href="javascript:top.restoreSession();location.href='immunizations.php?sortby=date';" title='<?php echo htmlspecialchars( xl('Sort by date'), ENT_QUOTES); ?>'>
          <?php echo htmlspecialchars( xl('Date'), ENT_NOQUOTES); ?></a>
        <span class='small' style='font-family:arial'><?php if ($sortby == 'date') { echo 'v'; } ?></span>
    </th>
    <th><?php echo htmlspecialchars( xl('Manufacturer'), ENT_NOQUOTES); ?></th>
    <th><?php echo htmlspecialchars( xl('Product Name'), ENT_NOQUOTES); ?></th>
    <th><?php echo htmlspecialchars( xl('Lot Number'), ENT_NOQUOTES); ?></th>
    <th><?php echo htmlspecialchars( xl('Administered By'), ENT_NOQUOTES); ?></th>
    <th><?php echo htmlspecialchars( xl('Education Date'), ENT_NOQUOTES); ?></th>
    <th><?php echo htmlspecialchars( xl('Note'), ENT_NOQUOTES); ?></th>
    <th>&nbsp;</th>
    </tr>
    
<?php
        $sql = "select i1.id ,i1.immunization_id ,i1.administered_date ".
                ",i1.manufacturer ,i1.lot_number, i1.product_name, i1.negationreason_id ".
                ",ifnull(concat(u.lname,', ',u.fname),'Other') as administered_by ".
                ",i1.education_date ,i1.note ".
                " from immunizations i1 ".
                " left join users u on i1.administered_by_id = u.id ".
                " where patient_id = ? ".
                " order by ";
        if ($sortby == "vacc") { $sql .= " i1.immunization_id, i1.administered_date DESC"; }
        else { $sql .= " administered_date desc"; }

        $result = sqlStatement($sql, array($pid) );
        while($row = sqlFetchArray($result)) {
            if ($row["id"] == $id) {
                echo "<tr class='immrow text selected' id='".htmlspecialchars( $row["id"], ENT_QUOTES)."'>";
            }
            else if (!empty($row['negationreason_id'])) {
                echo "<tr class='immrow text negated' id='".htmlspecialchars( $row["id"], ENT_QUOTES)."'>";
            }
            else {
                echo "<tr class='immrow text' id='".htmlspecialchars( $row["id"], ENT_QUOTES)."'>";
            }
	    // Modified 7/2009 by BM to utilize immunization items from the pertinent list in list_options
            echo "<td>" . generate_display_field(array('data_type'=>'1','list_id'=>'immunizations'), $row['immunization_id']) . "</td>";
            echo "<td>" . htmlspecialchars( $row["administered_date"], ENT_NOQUOTES) . "</td>";
            echo "<td>" . htmlspecialchars( $row["manufacturer"], ENT_NOQUOTES) . "</td>";
            echo "<td>" . htmlspecialchars( $row["product_name"], ENT_NOQUOTES) . "</td>";
            echo "<td>" . htmlspecialchars( $row["lot_number"], ENT_NOQUOTES) . "</td>";
            echo "<td>" . htmlspecialchars( $row["administered_by"], ENT_NOQUOTES) . "</td>";
            echo "<td>" . htmlspecialchars( $row["education_date"], ENT_NOQUOTES) . "</td>";
            echo "<td>" . htmlspecialchars( $row["note"], ENT_NOQUOTES) . "</td>";
            echo "<td><input type='button' class='delete' id='".htmlspecialchars( $row["id"], ENT_QUOTES)."' value='" . htmlspecialchars( xl('Delete'), ENT_QUOTES) . "'></td>";
            echo "</tr>";
        }

?>

    </table>
</div> <!-- end immunizations -->

  </body>

<script language="javascript">
/* required for popup calendar */
Calendar.setup({inputField:"administered_date", ifFormat:"%Y-%m-%d", button:"img_administered_date"});
Calendar.setup({inputField:"education_date", ifFormat:"%Y-%m-%d", button:"img_education_date"});
Calendar.setup({inputField:"vis_date", ifFormat:"%Y-%m-%d", button:"img_vis_date"});

// jQuery stuff to make the page a little easier to use

$(document).ready(function(){
    $("#save").click(function() { SaveForm(); });
    $("#print").click(function() { PrintForm("pdf"); });
    $("#printHtml").click(function() { PrintForm("html"); });
    $(".immrow").click(function() { EditImm(this); });
    $(".delete").click(function(event) { DeleteImm(this); event.stopPropagation(); });

    $(".immrow").mouseover(function() { $(this).toggleClass("highlight"); });
    $(".immrow").mouseout(function() { $(this).toggleClass("highlight"); });


    $("#administered_by_id").change(function() { $("#administered_by").val($("#administered_by_id :selected").text()); });
});

var PrintForm = function(typ) {
    top.restoreSession();
    newURL='shot_record.php?output='+typ+'&sortby=<?php echo $sortby; ?>';
    if (typ=="pdf") {
        location.href=newURL;
    }
    else { // typ=html
        window.open(newURL, '_blank', "menubar=1,toolbar=1,scrollbars=1,resizable=1,width=600,height=450");
    }	
}

var SaveForm = function() {
    top.restoreSession();
    $("#add_immunization").submit();
}

var EditImm = function(imm) {
    top.restoreSession();
    location.href='immunizations.php?mode=edit&id='+imm.id;
}

var DeleteImm = function(imm) {
    if (confirm("<?php echo htmlspecialchars( xl('This action cannot be undone.'), ENT_QUOTES); ?>" + "\n" +"<?php echo htmlspecialchars( xl('Do you wish to PERMANENTLY delete this immunization record?'), ENT_QUOTES); ?>")) {
        top.restoreSession();
        location.href='immunizations.php?mode=delete&id='+imm.id;
    }
}

</script>

</html>
