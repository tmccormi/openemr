<?php
/*
 * Syncronize users with the Active Directory
 * - read user names and info from Active Directory
 * - update the Users table in OpenEMR
 * - handles deleted usernames
 * - handles new usernames
 *
 * 12 Dec 2007 - Jason Morrill
 * Certain parts © EnSoftek, Inc – drcloudemr@ensoftek.com
 *   - Altered the script to be runnable from the UI as well as scheduled task.
 *   - When run as task, pass the site name and logfile as parameters. Eg "adLDAP_sync.php default c:\logs\adldap.log"
 *   - When adding the AD user into OpenEMR tables, add it to the OpenEMR groups with names corresponding to the users's AD group.
 *   - Added logging.
 */

 // Ensoftek: This flag determines whether the script was run from UI or Task Scheduler.
 $schedularAccess = false;
 
 // Ensoftek: Get the parameters when run as scheduled task.
 if( isset($argv) && (count($argv) > 0) )
 {
	$site = trim($argv[1]);
	$logpath = trim($argv[2]);
	session_start();
	$_SESSION['site_id'] = $site;
	$ignoreAuth = true; 
	$schedularAccess = true;
 }
 
 // Ensoftek: Added the global include.
include_once("../../interface/globals.php");
 
require_once("adLDAP.php");
require_once("../sql.inc");
require_once("adLDAP_conf.inc");

 // Ensoftek: Added to access ACL.
require_once("../acl.inc");

/*====================================================
  Usernames to ignore when querying Active Directory
  ** CHANGE THIS ** to accommodate your AD userbase
 *====================================================*/

 /*
// Ensoftek: This is gotten from the database now.
$excludedUsers = array ("SQLServer", "SQLDebugger", 
                        "TsInternetUser", "someotheruser"
                        );
*/

$excludedUsers = explode(',',$adldap_options["excluded_users"]);


/*====================================================
 * No changes below here should be necessary 
 *===================================================*/


// the attributes we pull from Active Directory
$ldapAttributes = array("givenname", "sn", "displayname", 
                        "physicaldeliveryofficename", "homephone",
                        "telephonenumber", "mobile", "pager",
                        "facsimiletelephonenumber", "mail", "title",
                        "department", "streetaddress", "postofficebox",
                        "l", "st", "postalcode", "countrycode"
                        );

// mapping of Active Directory attributes to OpenEMR Users table columns
$attributeMapping = array (
                        "givenname" => "fname"
                        ,"sn" => "lname"
                        //,"displayname" => ""
                        //,"physicaldeliveryofficename" => ""
                        //,"homephone"  => ""
                        ,"telephonenumber" => "phonew1"
                        ,"mobile" => "phonecell"
                        //,"pager" => ""
                        ,"facsimiletelephonenumber" => "fax"
                        ,"mail" => "email"
                        ,"title" => "specialty"
                        //,"department" => ""
                        ,"streetaddress" => "street"
                        ,"postofficebox" => "streetb"
                        ,"l" => "city"
                        ,"st" => "state"
                        ,"postalcode" => "zip"
						,"countrycode" => "country_code" // Ensoftek: Added to get the POST(HQ, etc.)
                    );

// create new instance and connect to AD with user & pass
// defined in adLDAP_conf.inc 
$adldap = new adLDAP($adldap_options);

// gather all our known usernames from OpenEMR
// they will be used to compare what is found in Active Directory
$oemrUsers = array();
$sqlH = sqlStatement("select id, username from users");
while ($onerow = sqlFetchArray($sqlH)) { array_push($oemrUsers, $onerow); }

// Ensoftek: get all openemr groups
$list_openemr_groups = acl_get_group_title_list();

$adUsers = $adldap->all_users();

// Ensoftek: Start logging
if(count($adUsers) > 0)
{
	Logger('adLDAP Sync', "Started", $site, $logpath);
}

$local_ou = $adldap_options["local_ou"];
$hq_ou = $adldap_options["hq_ou"];
Logger('adLDAP Sync', 'Update', $site, $logpath, 'LOCAL OU: ' . $local_ou);
Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
Logger('adLDAP Sync', 'Update', $site, $logpath, 'HQ OU: ' . $hq_ou);
Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);

foreach ($adUsers as $adUser) {
    // loop over all the Active Directory users

    // skip the excluded usernames
    $skip = 0;
    foreach ($excludedUsers as $ex) {
        if ($ex == $adUser) { $skip = 1; break; }
    }
    if ($skip == 1) { continue; }

    // query LDAP for the full user info
    $userInfo = $adldap->user_info($adUser, $ldapAttributes);
	$adlDapDn = $userInfo[0]["dn"];
	$dn_array = ldap_explode_dn($adlDapDn, 0);
	$HQ_OU_STR = 'OU=' . $hq_ou;
	$LOCAL_OU_STR = 'OU=' . $local_ou;

	// Only add users whose POST is HQ or Local
	if ( (array_search($HQ_OU_STR, $dn_array) == false) && (array_search($LOCAL_OU_STR, $dn_array) == false) )
	{
		continue;
	}
	
    if (NewUser($adUser, $oemrUsers)) 
	{
	    // Ensoftek: Get all AD groups this user is a member of
		$list_user_ad_groups = $adldap->user_groups($adUser);
		

        // Add new user
        $dispStr =  'Adding user "' . $adUser . '"...';
		Logger('adLDAP Sync', 'Update', $site, $logpath, $dispStr);
		Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
	    Logger('adLDAP Sync', 'Update', $site, $logpath, 'distinguishedName: ' . $adlDapDn);
	    Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
		
        if (AddUserAD($adUser, $userInfo, $list_openemr_groups, $list_user_ad_groups)) 
		{
			Logger('adLDAP Sync', 'Update', $site, $logpath, "OK");
		}
        else 
		{ 
			Logger('adLDAP Sync', 'Update', $site, $logpath, "FAILED");
		}
		
		Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
		Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
    }
    else 
	{
        // update existing users with Active Directory info
		$dispStr = 'Existing user "' . $adUser . '"';
		Logger('adLDAP Sync', 'Update', $site, $logpath, $dispStr);
		Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
	    Logger('adLDAP Sync', 'Update', $site, $logpath, 'distinguishedName: ' . $adlDapDn);
	    Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
		
        if (UpdateUser($adUser, $userInfo)) 
		{
			Logger('adLDAP Sync', 'Update', $site, $logpath, "OK");
		}
        else
		{ 
			Logger('adLDAP Sync', 'Update', $site, $logpath, "FAILED");
		}
		
		Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
		Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);

    }
}

// Ensoftek: End logging.
if( count($adUsers) > 0 )
{
	Logger('adLDAP Sync', "End", $site, $logpath);
}

/*
// Test: Add user 'Buck'' to groip 'Clinicians'
echo "Existing user buck to group Clinicians...";
add_user_aros("buck", "Clinicians");
echo ", DONE\n"; 
*/

// re-query in case we have updated a username in the previous loop
$oemrUsers = array();
$sqlH = sqlStatement("select id, username from users");
while ($onerow = sqlFetchArray($sqlH)) { array_push($oemrUsers, $onerow); }

// Ensoftek: Commented out until this is a requirement.
/*
// for all the usernames in OpenEMR and NOT IN Active Directory
// de-activate them in OpenEMR
foreach ($oemrUsers as $user) {
    $found = false;
    foreach ($adUsers as $adUser) {
        if ($user['username'] == $adUser) { $found = true; break; }
    }
    if ($found == false) {
        $sqlstmt = "update users set active=0 where ".
                    "id=".$user['id'];
        if (sqlStatement($sqlstmt)) { echo "Deactivated ".$user['username']." from OpenEMR\n"; }
        else { echo "Failed to deactivate ".$user['username']." from OpenEMR\n"; }
    }
}
*/
exit;


/*=====================================
  Add a user to the OpenEMR database
  =====================================*/
// Ensoftek: Changed function name because of clash
function AddUserAD($adUsername, $adLDAPinfo, $list_openemr_groups, $list_user_ad_groups) {
    global $attributeMapping;
	global $adldap_options;
	global $schedularAccess, $site, $logpath;

    ksort($attributeMapping);
	
	// Ensoftek: Add values for authorized, see_auth, active, cal_ui
    $sqlstmt = "insert into users (id, authorized, see_auth, active, cal_ui, username";
    foreach ($attributeMapping as $key=>$value) {
        $sqlstmt .= ", ".$value;
    }
		
	$sqlstmt .= ") values (null, 1," . $adldap_options["authorization"] . "," . $adldap_options["active"] . "," . $adldap_options["calendar_ui"] . "," . "'".$adUsername."'"; 
    foreach ($attributeMapping as $key=>$value) {
        $sqlstmt .= ", '".addslashes($adLDAPinfo[0][$key][0])."'";
    }
    $sqlstmt .= ")";
    if (sqlStatement($sqlstmt) == false) { return false; }
	
	$username_openemr_groups = acl_get_group_titles($adUsername);

    foreach ($list_user_ad_groups as $user_ad_group)
	{
	    if ( in_array($user_ad_group, $list_openemr_groups) )
		{
			if ( empty($username_openemr_groups) || !in_array($user_ad_group, $username_openemr_groups) )
			{
				$dispStr = 'Adding "' . $adUsername . '" to group "' . $user_ad_group . '"...';
				Logger('adLDAP Sync', 'Update', $site, $logpath, $dispStr);

				// Ensoftek: Add user to the corresponding OpenEMR group.
				add_user_aros($adUsername, $user_ad_group);	
				
				Logger('adLDAP Sync', 'Update', $site, $logpath, "Done");
				Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);
			}
		}
		else
		{
			$dispStr = 'AD group "'. $user_ad_group. '" is not a part of OpenEMR groups list.';
			Logger('adLDAP Sync', 'Update', $site, $logpath, $dispStr);
			Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />' , true);
		}			
	}

	// Ensoftek: Add the user to the Default Group
	$dispStr = 'Adding "' . $adUsername . '" to default group "' . $adldap_options["default_group"] . '"...';
	Logger('adLDAP Sync', 'Update', $site, $logpath, $dispStr);
	add_user_aros($adUsername, $adldap_options["default_group"]);	
	Logger('adLDAP Sync', 'Update', $site, $logpath, "Done");
	Logger('adLDAP Sync', 'Update', $site, $logpath, '<br  />', true);


    // add the user to the default group
    $sqlstmt = "insert into groups (".
                "name, user ".
                ") values (".
                "'Default'".
                ", '".$adUsername."'".
                ")";
    if (sqlStatement($sqlstmt) == false) { return false; }

    return true;
}


/*=====================================
  Update and existing user in the OpenEMR database
  =====================================*/
function UpdateUser($adUsername, $adLDAPinfo) {
    global $attributeMapping;
    ksort($attributeMapping);

    $sqlstmt = "update users set ";
    $comma = "";
    foreach ($attributeMapping as $key=>$value) {
        $sqlstmt .= $comma . $value . "='". addslashes($adLDAPinfo[0][$key][0])."'";
        $comma = ", ";
    }
    $sqlstmt .= " where username = '".$adUsername."'";

    return sqlStatement($sqlstmt);
}


/*=====================================
  Determine if the supplied username
  exists in the OpenEMR Users table
  =====================================*/
function NewUser($username, $oemrUsers) {
    foreach ($oemrUsers as $user) {
        if ($user['username'] == $username) { return false; }
    }
    return true;
}

/*=====================================
  Utility function to log.
  =====================================*/
function Logger($schedule_for, $exe_status, $site_name, $logpath, $datastr="", $ui_only=false)
{
    global $schedularAccess;
	
	if ( $schedularAccess == false )
	{
		echo $datastr;
		return;
	}
	
	if ( $ui_only == true )
	{
		return;
	}

	$log_fname = $logpath;
	if( file_exists($log_fname) )
		$fileLogOPen = fopen($log_fname, "a");
	else
		$fileLogOPen = fopen($log_fname, "w");

	if($exe_status == "Started")
	{
		$strSchedularLog = "================== ".$schedule_for." STARTED AT ".date("d-M-Y h:i:s")." ======================\n\n";
	}
	else if($exe_status == "Update")
	{
		$strSchedularLog .= $datastr."\n\n";
	}
	else if($exe_status == "End")
	{
		$strSchedularLog = "================== ".$schedule_for." ENDED AT ".date("d-M-Y h:i:s")." =======================\n\n";
	}
	
	fwrite($fileLogOPen, $strSchedularLog);
	fclose($fileLogOPen);
}



?>
