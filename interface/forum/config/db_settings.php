<?php
require_once("../../sites/default/sqlconf.php");
$db_settings['host'] = $host;
$db_settings['user'] = $login;
$db_settings['password'] = $pass;
$db_settings['database'] = $dbase;
/*
$db_settings['host'] = 'localhost';
$db_settings['user'] = 'root';
$db_settings['password'] = 'vxcare';
$db_settings['database'] = 'forum';
*/
$db_settings['settings_table'] = 'mlf_settings';
$db_settings['forum_table'] = 'mlf_entries';
$db_settings['category_table'] = 'mlf_categories';
$db_settings['userdata_table'] = 'mlf_userdata';
$db_settings['smilies_table'] = 'mlf_smilies';
$db_settings['pages_table'] = 'mlf_pages';
$db_settings['banlists_table'] = 'mlf_banlists';
$db_settings['useronline_table'] = 'mlf_useronline';
$db_settings['login_control_table'] = 'mlf_logincontrol';
$db_settings['entry_cache_table'] = 'mlf_entries_cache';
$db_settings['userdata_cache_table'] = 'mlf_userdata_cache';
?>
