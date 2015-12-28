<?php
//  OpenEMR
//  MySQL Config
//  Referenced from /library/sqlconf.php.

global $disable_utf8_flag;
$disable_utf8_flag = false;

$host	= 'localhost';
$port	= '3306';
$login	= 'admin';
$pass	= 'demo';
$dbase	= 'openemr';
$sso    = 'false';  // Ensoftek: 2014-11-05: Flag to indicate SSO sign-on.

$sqlconf = array();
global $sqlconf;
$sqlconf["host"]= $host;
$sqlconf["port"] = $port;
$sqlconf["login"] = $login;
$sqlconf["pass"] = $pass;
$sqlconf["dbase"] = $dbase;
$sqlconf["sso"] = $sso;    // Ensoftek: 2014-11-05: Flag to indicate SSO sign-on.

//////////////////////////
//////////////////////////
//////////////////////////
//////DO NOT TOUCH THIS///
$config = 0; /////////////
//////////////////////////
//////////////////////////
//////////////////////////

// The Peacecorps instance can be configured to be accessed via Active Directory SSO or the traditional approach. 
// $sso    = 'true'; // Active Dir ON
$sso    = 'false';  // Traditional local user login

?>
