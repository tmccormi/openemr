<?php
// Copyright (c) 2014 US Peace Corps
//
// This program is protected by copyright laws; you may not redistribute it and/or
// modify it in part or whole for any purpose without prior express written permission 
// from the Peace Corps.
//
//    Get the Active Directory settings from adldap_config table.

/* Active Directory Settings
 * 
 * account_suffix : this is the full domain name of your Active Directory
 * base_dn: Users is the standard windows CN, replace the DC stuff with your domain
 * domain_controllers: the IP address of your domain controller(s)
 * ad_username: a username with simple 'bind' access to Active Directory no special permissions needed
 * ad_password: the password for the user
 * real_primarygroup: leave alone or read adldap.sourceforge.net docs
 * use_ssl: leave alone or read adldap.sourceforge.net docs
 * recursive_groups: leave alone or read adldap.sourceforge.net docs
 */
require_once("../phpseclib/Crypt/AES.php");

$adldap_fetch = sqlQuery("select * from adldap_config"); 

$aes = new Crypt_AES();
$aes->setKey('itsactdirpass');
$plainPass = $aes->decrypt($adldap_fetch['ad_password']);

$adldap_options = array (
"account_suffix" => $adldap_fetch['account_suffix'],
"base_dn" => $adldap_fetch['base_dn'],
"domain_controllers" => array ($adldap_fetch['domain_controllers']),
"ad_username" => $adldap_fetch['ad_username'],
"ad_password" => $plainPass,
"real_primarygroup" => $adldap_fetch['real_primarygroup'],
"use_ssl" => $adldap_fetch['use_ssl'],
"recursive_groups" => $adldap_fetch['recursive_groups'],
"excluded_users" => $adldap_fetch['excluded_users'],
"local_ou" => $adldap_fetch['local_ou'],
"hq_ou" => $adldap_fetch['hq_ou'],
"default_group" => $adldap_fetch['default_group'],
"authorization" => $adldap_fetch['authorization'],
"calendar_ui" => $adldap_fetch['calendar_ui'],
"active" => $adldap_fetch['active']
);

?>
