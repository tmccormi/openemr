<?php 
// Copyright (c) 2014 US Peace Corps
//
// This program is protected by copyright laws; you may not redistribute it and/or
// modify it in part or whole for any purpose without prior express written permission 
// from the Peace Corps.
//
// UI accessible from Administration-->Active Directory Sync
// Used to configure and manually synchronize AD users with OpenEMR users.

require_once("../../interface/globals.php");
require_once("$srcdir/sql.inc");
require_once("$srcdir/auth.inc");
require_once("$srcdir/formdata.inc.php");
require_once("$srcdir/phpseclib/Crypt/AES.php");
require_once("../acl.inc");


function setcboxvals($cval){
	if(isset($_POST["$cval"]) && $_POST["$cval"] == 'on'){
		$_POST["$cval"] = 1;
	}else{
		$_POST["$cval"] = 0;
	}
}

// TODO: Get these from the database
$authorization_array= array(1 =>"None", 
							2 => "Only Mine",
							3 => "All");

// TODO: Get these from the database							
$calendarUI_array= array(1 =>"Original", 
						 2 => "Fancy",
						 3 => "Outlook");

// Get the primary business facility. This will be the Local OU.
$facility_row = sqlQuery("SELECT * FROM facility WHERE primary_business_entity='1'");
$local_ou = $facility_row['country_code'];


// List of all existing ACL OpenEMR groups.						 
$list_openemr_groups = acl_get_group_title_list();
						 
						
$tbl = add_escape_custom("adldap_config");
$aes = new Crypt_AES();
$aes->setKey('itsactdirpass');

if(!empty($_GET['cid'])){
	$cid = $_GET['cid'];
	$where =  "where id = $cid";	
}
$erow = sqlQuery("select * from $tbl $where");


if(count($_POST) > 0 ){	
	setcboxvals("real_primarygroup");setcboxvals("use_ssl");setcboxvals("recursive_groups");setcboxvals("active");
$postarr = array($_POST['account_suffix'], $_POST['base_dn'], $_POST['domain_controllers'], $_POST['ad_username'], $aes->encrypt($_POST['ad_password']), $_POST['real_primarygroup'],$_POST['use_ssl'], $_POST['recursive_groups'], $_POST['excluded_users'], $_POST['active'], $_POST['authorization'], $_POST['calendar_ui'], $_POST['default_group'], $_POST['local_ou'], $_POST['hq_ou']);
$execqry = sqlStatement("select * from $tbl");
$rows = sqlNumRows($execqry);
	if($rows == 0){
		 $query = "INSERT INTO ".$tbl." (account_suffix,base_dn,domain_controllers,ad_username,ad_password,real_primarygroup,use_ssl,recursive_groups,excluded_users,active,authorization,calendar_ui,default_group,local_ou,hq_ou) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) "; 
		 $insid = sqlInsert($query,$postarr);
		header("Location: adldap_configure.php?cid=$insid");exit();	
	}elseif($rows == 1){
		array_push($postarr, date("Y-m-d H:i:s"));
		sqlStatement("UPDATE $tbl SET " .
      "account_suffix = ?, base_dn = ?, domain_controllers= ?, " .
      "ad_username = ?, ad_password = ? , real_primarygroup = ? , use_ssl = ? , recursive_groups = ? , excluded_users = ? , active = ? , authorization = ? , calendar_ui = ? , default_group = ? , local_ou = ? , hq_ou = ? , updated_date = ?",
      $postarr );
	}
	header("Location:adldap_configure.php");exit();	
}


?>
<html>
<head>

<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
<link rel="stylesheet" type="text/css" href="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.css" media="screen" />
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.1.3.2.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery-ui.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.easydrag.handler.beta2.js"></script>
</head>
<body class="body_top">
<script type="text/javascript">
	
	$(document).ready(function(){
		    
	    // special size for
		$(".iframe_medium").fancybox( {
			'overlayOpacity' : 0.0,
			'showCloseButton' : true,
			'frameHeight' : 450,
			'frameWidth' : 660
		});

	});
	
	function call_fancy(){
		if(validateform()){
			var fbox = document.getElementById("snow");
			fbox.href = "adLDAP_sync.php";
			$('#snow').trigger('click');			
		}
	}
	function trimAll(sString)
	{
		while (sString.substring(0,1) == ' ')
		{
			sString = sString.substring(1, sString.length);
		}
		while (sString.substring(sString.length-1, sString.length) == ' ')
		{
			sString = sString.substring(0,sString.length-1);
		}
		return sString;
	}
	
	function validateform(){
    
	var field_names = {
        "account_suffix" : "<?php echo xlt('Account Suffix'); ?>",
        "base_dn" : "<?php echo xlt('Base DN'); ?>",
        "domain_controllers" : "<?php echo xlt('Domain Controller IP Address'); ?>",
        "ad_username" : "<?php echo xlt('AD Username'); ?>",
        "ad_password" : "<?php echo xlt('AD Password'); ?>",
        "local_ou" : "<?php echo xlt('Local Post OU'); ?>",
        "hq_ou" : "<?php echo xlt('HQ Post OU'); ?>"
    };
    var amsg="";
    for(var index in field_names) {           
        if(trimAll(document.getElementById(index).value) == ""){ 
            amsg += field_names[index] + "\n";
        }         
    }
     if(amsg != ""){
       var headmsg = 'Please input data for the following mandatory field(s) :\n\n';
        var finalmsg = headmsg + amsg ;  
        alert(finalmsg); return false; 
    }else{
    	return true;
    }           
}

</script>	
<form name="configureactdir" id="configureactdir" method="post" action="adldap_configure.php">
<div>
    <div>
       <table>
	  <tr >
		<td scope="row"><b><?php echo xlt('Active Directory Sync Settings'); ?></b></td>
	  </tr>
	  <tr >
		<td>&nbsp;</td>
	  </tr>
	</table>
    </div>
    <div>
        <div>
        	<table cellspacing="0" cellpadding="3" width="500px" style="font-size:9pt;">
			<tbody>
				<tr>
					<td scope="row" width="150px" valign="MIDDLE"><?php echo xlt('Account Suffix'); ?></td>
					<td valign="MIDDLE">
						<input type="text" name="account_suffix" title="<?php echo xlt('Account Suffix'); ?>" id="account_suffix" value="<?php echo $erow['account_suffix']; ?>" size="40" maxlength="255"> *
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Base DN'); ?></td>
					<td valign="MIDDLE">
						<input type="text" name="base_dn" title="<?php echo xlt('Base DN'); ?>" id="base_dn" value="<?php echo $erow['base_dn']; ?>" size="40"> *
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Domain Controller IP Address'); ?></td>
					<td valign="MIDDLE">
						<input type="text" name="domain_controllers" title="<?php echo xlt('Domain Controller IP Address'); ?>" id="domain_controllers" value="<?php echo $erow['domain_controllers']; ?>" size="40" maxlength="255"> *
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('AD Username'); ?></td>
					<td valign="MIDDLE">
                                            <input type="text" name="ad_username" title="<?php echo xlt('AD Username'); ?>" id="ad_username" value="<?php echo $erow['ad_username']; ?>"  size="40" maxlength="255"> *
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('AD Password'); ?></td>
					<td valign="MIDDLE">
                                            <input type="password" name="ad_password" title="<?php echo xlt('AD Password'); ?>" id="ad_password" value="<?php echo $aes->decrypt($erow['ad_password']); ?>" size="40" maxlength="255"> *
					</td>
				</tr>
<!-- 				
				<tr>
					<td valign="MIDDLE"><?php echo xlt('Real PrimaryGroup'); ?></td>
					<td valign="MIDDLE">
						<input type="checkbox" name="real_primarygroup" id="real_primarygroup" <?php if($erow['real_primarygroup'] == 1)echo "checked"; ?> >
					</td>
				</tr>
				<tr>
					<td valign="MIDDLE"><?php echo xlt('Use SSL'); ?></td>
					<td valign="MIDDLE">
						<input type="checkbox" name="use_ssl" id="use_ssl" <?php if($erow['use_ssl'] == 1)echo "checked"; ?>>
					</td>
				</tr>
				<tr>
					<td valign="MIDDLE"><?php echo xlt('Recursive Groups'); ?></td>
					<td valign="MIDDLE">
						<input type="checkbox" name="recursive_groups" id="recursive_groups" <?php if($erow['recursive_groups'] == 1)echo "checked"; ?>>
					</td>
				</tr>
-->				
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Local Post OU'); ?></td>
					<td valign="MIDDLE">
                                            <input type="text" name="local_ou" title="<?php echo xlt('Local Post OU'); ?>" size="10" id="local_ou" value="<?php echo $local_ou; ?>" > *
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('HQ Post OU'); ?></td>
					<td valign="MIDDLE">
                                            <input type="text" name="hq_ou" title="<?php echo xlt('HQ Post OU'); ?>" size="10" id="hq_ou" value="<?php if($erow['hq_ou'] != '') echo $erow['hq_ou']; ?>" > *
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Excluded Users'); ?></td>
					<td valign="MIDDLE">
                                            <input type="text" name="excluded_users" title="<?php echo xlt('Excluded Users'); ?>" size="40" id="excluded_users" value="<?php if($erow['excluded_users'] != '') echo $erow['excluded_users']; ?>" >
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Default ACL Group'); ?></td>
					<td valign="MIDDLE">
                                            <select name="default_group" title="<?php echo xlt('Default ACL Group'); ?>">
						<?php
						foreach ($list_openemr_groups as $group_name) { // See interface\usergroup\facility_admin.php. Line 210
							echo "<option value=\"" . $group_name . "\" ";
		                    if ($erow['default_group'] == $group_name) {
								echo "selected";
							}
							echo ">" . $group_name;
							echo "</option>\n";
						}
						?>
						</select>
					</td>
				</tr>				
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Authorization'); ?></td>
					<td valign="MIDDLE">
                                            <select name="authorization" title="<?php echo xlt('Authorization'); ?>">
						<?php
						foreach ($authorization_array as $key => $value) { // See interface\usergroup\facility_admin.php. Line 210
							echo "<option value=\"" . $key . "\" ";
		                    if ($erow['authorization'] == $key) {
								echo "selected";
							}
							echo ">" . $value;
							echo "</option>\n";
						}
						?>
						</select>
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Calendar UI'); ?></td>
					<td valign="MIDDLE">
                                            <select name="calendar_ui" title="<?php echo xlt('Calendar UI'); ?>">
						<?php
						foreach ($calendarUI_array as $key => $value) { // See interface\usergroup\facility_admin.php. Line 210
							echo "<option value=\"" . $key . "\" ";
		                    if ($erow['calendar_ui'] == $key) {
								echo "selected";
							}
							echo ">" . $value;
							echo "</option>\n";
						}
						?>
						</select>
					</td>
				</tr>
				<tr>
					<td scope="row" valign="MIDDLE"><?php echo xlt('Active'); ?></td>
					<td valign="MIDDLE">
						<input type="checkbox" aria-label="Active" name="active" id="active" <?php if($erow['active'] == 1)echo "checked"; ?>>
					</td>
				</tr>
				
								
<tr height="25"><td scope="row" colspan="2">&nbsp;</td></tr>
<tr>
	<td scope="row" colspan="2">
		<a class="css_button" href="#" onclick="javascript:if(validateform())document.configureactdir.submit();"><span><?php echo xlt('Save'); ?></span></a>
		&nbsp; 
		<a class="css_button" href="javascript:call_fancy();"><span><?php echo xlt('Sync Now'); ?></span></a>
		<div style="display:none">
  		<a href="#" id="snow" class="iframe_medium"></a>   		
		</div>
		</td>
</tr>
</tbody></table>
        </div>
    </div>
</div>
</form>
</body>
</html>
