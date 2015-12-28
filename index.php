<?php
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
// Set the site ID if required.  This must be done before any database
// access is attempted.

// Certain parts © EnSoftek, Inc – drcloudemr@ensoftek.com
if (!empty($_GET['site']))
    $site_id = $_GET['site'];
else if (is_dir("sites/" . $_SERVER['HTTP_HOST']))
    $site_id = $_SERVER['HTTP_HOST'];
else
    $site_id = 'default';

if (empty($site_id) || preg_match('/[^A-Za-z0-9\\-.]/', $site_id))
    die("Site ID '".htmlspecialchars($site_id,ENT_NOQUOTES)."' contains invalid characters.");

require_once "sites/$site_id/sqlconf.php";

// Ensoftek: 2014-11-05: Check if this is an SSO signon. 
if ( $sqlconf["sso"] == 'true' )
{
	// Ensoftek: 2014-11-05: Parse the login user name from the format <DOMAIN>\<USER>
	$user_name = '';
	if ( isset($_SERVER['REMOTE_USER']) )
	{
	   $ar_name = explode('\\', $_SERVER['REMOTE_USER']);
	   $user_name = $ar_name[1];
	}
}

if ($config == 1) 
{
    // Ensoftek: 2014-11-05: If its an SSO signon redirect to the SSO login frame page.
    if ( $sqlconf["sso"] == 'true' )
	{
		header("Location: interface/login/login_frame_sso.php?user_name=".$user_name);
	}
	else
	{
		header("Location: interface/login/login_frame.php?site=$site_id");
	}
} 
else 
{
    header("Location: setup.php?site=$site_id");
}
