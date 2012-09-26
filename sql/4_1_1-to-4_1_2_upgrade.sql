--
--  Comment Meta Language Constructs:
--
--  #IfNotTable
--    argument: table_name
--    behavior: if the table_name does not exist,  the block will be executed

--  #IfTable
--    argument: table_name
--    behavior: if the table_name does exist, the block will be executed

--  #IfMissingColumn
--    arguments: table_name colname
--    behavior:  if the table exists but the column does not,  the block will be executed

--  #IfNotColumnType
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a column colname with a data type equal to value, then the block will be executed

--  #IfNotRow
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a row where colname = value, the block will be executed.

--  #IfNotRow2D
--    arguments: table_name colname value colname2 value2
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2, the block will be executed.

--  #IfNotRow3D
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3, the block will be executed.

--  #IfNotRow4D
--    arguments: table_name colname value colname2 value2 colname3 value3 colname4 value4
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3 AND colname4 = value4, the block will be executed.

--  #IfNotRow2Dx2
--    desc:      This is a very specialized function to allow adding items to the list_options table to avoid both redundant option_id and title in each element.
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  The block will be executed if both statements below are true:
--               1) The table table_name does not have a row where colname = value AND colname2 = value2.
--               2) The table table_name does not have a row where colname = value AND colname3 = value3.

--  #IfRow2D
--    arguments: table_name colname value colname2 value2
--    behavior:  If the table table_name does have a row where colname = value AND colname2 = value2, the block will be executed.

--  #IfIndex
--    desc:      This function is most often used for dropping of indexes/keys.
--    arguments: table_name colname
--    behavior:  If the table and index exist the relevant statements are executed, otherwise not.

--  #IfNotIndex
--    desc:      This function will allow adding of indexes/keys.
--    arguments: table_name colname
--    behavior:  If the index does not exist, it will be created

--  #EndIf
--    all blocks are terminated with a #EndIf statement.

#IfNotTable report_results
CREATE TABLE `report_results` (
  `report_id` bigint(20) NOT NULL,
  `field_id` varchar(31) NOT NULL default '',
  `field_value` text,
  PRIMARY KEY (`report_id`,`field_id`)
) ENGINE=MyISAM;
#EndIf

#IfMissingColumn version v_acl
ALTER TABLE `version` ADD COLUMN `v_acl` int(11) NOT NULL DEFAULT 0;
#EndIf

--For Forum - Start

#IfNotTable mlf_banlists
CREATE TABLE mlf_banlists (name varchar(255) NOT NULL default '', list text NOT NULL) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_categories
CREATE TABLE mlf_categories (id int(11) NOT NULL auto_increment, order_id int(11) NOT NULL default '0', category varchar(255) NOT NULL default '', description varchar(255) NOT NULL default '',accession tinyint(4) NOT NULL default '0', PRIMARY KEY (id)) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_entries
CREATE TABLE mlf_entries (id int(11) NOT NULL auto_increment, pid int(11) NOT NULL default '0', tid int(11) NOT NULL default '0', uniqid varchar(255) NOT NULL default '', time timestamp NOT NULL default CURRENT_TIMESTAMP, last_reply timestamp NOT NULL default '0000-00-00 00:00:00', edited timestamp NOT NULL default '0000-00-00 00:00:00', edited_by int(11) default NULL, user_id int(11) default '0', name varchar(255) NOT NULL default '', subject varchar(255) NOT NULL default '',category int(11) NOT NULL default '0', email varchar(255) NOT NULL default '', hp varchar(255) NOT NULL default '', location varchar(255) NOT NULL default '', ip varchar(128) NOT NULL default '', text text NOT NULL, tags varchar(255) NOT NULL default '', show_signature tinyint(4) default '0', email_notification tinyint(4) default '0', marked tinyint(4) default '0', locked tinyint(4) default '0', sticky tinyint(4) default '0', views int(11) default '0', spam tinyint(4) default '0', spam_check_status tinyint(4) default '0', edit_key varchar(255) NOT NULL default '', PRIMARY KEY (id), UNIQUE KEY id (id), KEY tid (tid),KEY category (category), KEY pid (pid), KEY sticky (sticky)) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_settings
CREATE TABLE mlf_settings (name varchar(255) NOT NULL default '', value varchar(255) NOT NULL default '') CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_smilies
CREATE TABLE mlf_smilies (id int(11) NOT NULL auto_increment, order_id int(11) NOT NULL default '0', file varchar(100) NOT NULL default '', code_1 varchar(50) NOT NULL default '', code_2 varchar(50) NOT NULL default '', code_3 varchar(50) NOT NULL default '', code_4 varchar(50) NOT NULL default '', code_5 varchar(50) NOT NULL default '', title varchar(255) NOT NULL default '', PRIMARY KEY (id)) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_userdata
CREATE TABLE mlf_userdata (user_id int(11) NOT NULL auto_increment, user_type tinyint(4) NOT NULL default '0', user_name varchar(255) NOT NULL default '', user_real_name varchar(255) NOT NULL default '', gender tinyint(4) NOT NULL default '0', birthday date NOT NULL default '0000-00-00', user_pw varchar(255) NOT NULL default '', user_email varchar(255) NOT NULL default '', email_contact tinyint(4) default '0', user_hp varchar(255) NOT NULL default '', user_location varchar(255) NOT NULL default '', signature varchar(255) NOT NULL default '', profile text NOT NULL, logins int(11) NOT NULL default '0', last_login timestamp NOT NULL default CURRENT_TIMESTAMP, last_logout timestamp NOT NULL default '0000-00-00 00:00:00', user_ip varchar(128) NOT NULL default '', registered timestamp NOT NULL default '0000-00-00 00:00:00', category_selection varchar(255) DEFAULT NULL, thread_order tinyint(4) NOT NULL default '0', user_view tinyint(4) NOT NULL default '0', sidebar tinyint(4) NOT NULL default '1', fold_threads tinyint(4) NOT NULL default '0', thread_display tinyint(4) NOT NULL default '0', new_posting_notification tinyint(4) default '0', new_user_notification tinyint(4) default '0', user_lock tinyint(4) default '0', auto_login_code varchar(50) NOT NULL default '', pwf_code varchar(50) NOT NULL, activate_code varchar(50) NOT NULL default '', language VARCHAR(255) NOT NULL DEFAULT '', time_zone VARCHAR(255) NOT NULL DEFAULT '', time_difference smallint(4) default '0', theme VARCHAR(255) NOT NULL DEFAULT '', entries_read TEXT NOT NULL, PRIMARY KEY (user_id)) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_pages
CREATE TABLE mlf_pages (id int(11) NOT NULL auto_increment,order_id int(11) NOT NULL, title varchar(255) NOT NULL default '', content text NOT NULL, menu_linkname varchar(255) NOT NULL default '', access tinyint(4) NOT NULL default '0', PRIMARY KEY (id)) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_useronline
CREATE TABLE mlf_useronline (ip char(15) NOT NULL default '',time int(14) NOT NULL default '0',user_id int(11) default '0') CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_logincontrol
CREATE TABLE mlf_logincontrol (time timestamp NOT NULL default CURRENT_TIMESTAMP, ip varchar(255) NOT NULL default '', logins int(11) NOT NULL default '0') CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_entries_cache
CREATE TABLE mlf_entries_cache (cache_id int(11) NOT NULL, cache_text mediumtext NOT NULL, PRIMARY KEY (cache_id)) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotTable mlf_userdata_cache
CREATE TABLE mlf_userdata_cache (cache_id int(11) NOT NULL, cache_signature text NOT NULL, cache_profile text NOT NULL, PRIMARY KEY (cache_id)) CHARSET=utf8 COLLATE=utf8_general_ci;
#EndIf

#IfNotRow2D mlf_banlists name user_agents
INSERT INTO mlf_banlists VALUES ('user_agents', '');
#EndIf

#IfNotRow2D mlf_banlists name ips
INSERT INTO mlf_banlists VALUES ('ips', '');
#EndIf

#IfNotRow2D mlf_banlists name words
INSERT INTO mlf_banlists VALUES ('words', '');
#EndIf

#IfNotRow2D mlf_settings name forum_name
INSERT INTO mlf_settings VALUES ('forum_name', 'Office notes');
#EndIf

#IfNotRow2D mlf_settings name forum_description
INSERT INTO mlf_settings VALUES ('forum_description', 'yet another little forum');
#EndIf

#IfNotRow2D mlf_settings name forum_email
INSERT INTO mlf_settings VALUES ('forum_email', 'admin@oemr.com');
#EndIf

#IfNotRow2D mlf_settings name forum_address
INSERT INTO mlf_settings VALUES ('forum_address', '');
#EndIf

#IfNotRow2D mlf_settings name home_linkaddress
INSERT INTO mlf_settings VALUES ('home_linkaddress', '../');
#EndIf

#IfNotRow2D mlf_settings name home_linkname
INSERT INTO mlf_settings VALUES ('home_linkname', '');
#EndIf

#IfNotRow2D mlf_settings name language_file
INSERT INTO mlf_settings VALUES ('language_file', 'english.lang');
#EndIf

#IfNotRow2D mlf_settings name theme
INSERT INTO mlf_settings VALUES ('theme', 'default');
#EndIf

#IfNotRow2D mlf_settings name access_for_users_only
INSERT INTO mlf_settings VALUES ('access_for_users_only', '0');
#EndIf

#IfNotRow2D mlf_settings name entries_by_users_only
INSERT INTO mlf_settings VALUES ('entries_by_users_only', '0');
#EndIf

#IfNotRow2D mlf_settings name register_mode
INSERT INTO mlf_settings VALUES ('register_mode', '0');
#EndIf

#IfNotRow2D mlf_settings name default_email_contact
INSERT INTO mlf_settings VALUES ('default_email_contact', '0');
#EndIf

#IfNotRow2D mlf_settings name user_area_public
INSERT INTO mlf_settings VALUES ('user_area_public', '0');
#EndIf

#IfNotRow2D mlf_settings name rss_feed
INSERT INTO mlf_settings VALUES ('rss_feed', '0');
#EndIf

#IfNotRow2D mlf_settings name rss_feed_max_items
INSERT INTO mlf_settings VALUES ('rss_feed_max_items', '20');
#EndIf

#IfNotRow2D mlf_settings name session_prefix
INSERT INTO mlf_settings VALUES ('session_prefix', 'mlf_');
#EndIf

#IfNotRow2D mlf_settings name default_view
INSERT INTO mlf_settings VALUES ('default_view', '0');
#EndIf

#IfNotRow2D mlf_settings name remember_userdata
INSERT INTO mlf_settings VALUES ('remember_userdata', '1');
#EndIf

#IfNotRow2D mlf_settings name remember_last_visit
INSERT INTO mlf_settings VALUES ('remember_last_visit', '1');
#EndIf

#IfNotRow2D mlf_settings name empty_postings_possible
INSERT INTO mlf_settings VALUES ('empty_postings_possible', '0');
#EndIf

#IfNotRow2D mlf_settings name email_notification_unregistered
INSERT INTO mlf_settings VALUES ('email_notification_unregistered', '0');
#EndIf

#IfNotRow2D mlf_settings name user_edit
INSERT INTO mlf_settings VALUES ('user_edit', '1');
#EndIf

#IfNotRow2D mlf_settings name user_edit_if_no_replies
INSERT INTO mlf_settings VALUES ('user_edit_if_no_replies', '0');
#EndIf

#IfNotRow2D mlf_settings name show_if_edited
INSERT INTO mlf_settings VALUES ('show_if_edited', '1');
#EndIf

#IfNotRow2D mlf_settings name dont_reg_edit_by_admin
INSERT INTO mlf_settings VALUES ('dont_reg_edit_by_admin', '0');
#EndIf

#IfNotRow2D mlf_settings name dont_reg_edit_by_mod
INSERT INTO mlf_settings VALUES ('dont_reg_edit_by_mod', '0');
#EndIf

#IfNotRow2D mlf_settings name edit_min_time_period
INSERT INTO mlf_settings VALUES ('edit_min_time_period', '5');
#EndIf

#IfNotRow2D mlf_settings name edit_max_time_period
INSERT INTO mlf_settings VALUES ('edit_max_time_period', '60');
#EndIf

#IfNotRow2D mlf_settings name edit_delay
INSERT INTO mlf_settings VALUES ('edit_delay', '3');
#EndIf

#IfNotRow2D mlf_settings name bbcode
INSERT INTO mlf_settings VALUES ('bbcode', '1');
#EndIf

#IfNotRow2D mlf_settings name bbcode_img
INSERT INTO mlf_settings VALUES ('bbcode_img', '1');
#EndIf

#IfNotRow2D mlf_settings name bbcode_color
INSERT INTO mlf_settings VALUES ('bbcode_color', '1');
#EndIf

#IfNotRow2D mlf_settings name bbcode_size
INSERT INTO mlf_settings VALUES ('bbcode_size', '1');
#EndIf

#IfNotRow2D mlf_settings name bbcode_code
INSERT INTO mlf_settings VALUES ('bbcode_code', '0');
#EndIf

#IfNotRow2D mlf_settings name bbcode_tex
INSERT INTO mlf_settings VALUES ('bbcode_tex', '0');
#EndIf

#IfNotRow2D mlf_settings name bbcode_flash
INSERT INTO mlf_settings VALUES ('bbcode_flash', '0');
#EndIf

#IfNotRow2D mlf_settings name flash_default_width
INSERT INTO mlf_settings VALUES ('flash_default_width', '425');
#EndIf

#IfNotRow2D mlf_settings name flash_default_height
INSERT INTO mlf_settings VALUES ('flash_default_height', '344');
#EndIf

#IfNotRow2D mlf_settings name upload_images
INSERT INTO mlf_settings VALUES ('upload_images', '0');
#EndIf

#IfNotRow2D mlf_settings name smilies
INSERT INTO mlf_settings VALUES ('smilies', '0');
#EndIf

#IfNotRow2D mlf_settings name autolink
INSERT INTO mlf_settings VALUES ('autolink', '1');
#EndIf

#IfNotRow2D mlf_settings name count_views
INSERT INTO mlf_settings VALUES ('count_views', '1');
#EndIf

#IfNotRow2D mlf_settings name autologin
INSERT INTO mlf_settings VALUES ('autologin', '1');
#EndIf

#IfNotRow2D mlf_settings name threads_per_page
INSERT INTO mlf_settings VALUES ('threads_per_page', '30');
#EndIf

#IfNotRow2D mlf_settings name search_results_per_page
INSERT INTO mlf_settings VALUES ('search_results_per_page', '20');
#EndIf

#IfNotRow2D mlf_settings name name_maxlength
INSERT INTO mlf_settings VALUES ('name_maxlength', '70');
#EndIf

#IfNotRow2D mlf_settings name name_word_maxlength
INSERT INTO mlf_settings VALUES ('name_word_maxlength', '30');
#EndIf

#IfNotRow2D mlf_settings name email_maxlength
INSERT INTO mlf_settings VALUES ('email_maxlength', '70');
#EndIf

#IfNotRow2D mlf_settings name hp_maxlength
INSERT INTO mlf_settings VALUES ('hp_maxlength', '70');
#EndIf

#IfNotRow2D mlf_settings name location_maxlength
INSERT INTO mlf_settings VALUES ('location_maxlength', '40');
#EndIf

#IfNotRow2D mlf_settings name location_word_maxlength
INSERT INTO mlf_settings VALUES ('location_word_maxlength', '30');
#EndIf

#IfNotRow2D mlf_settings name subject_maxlength
INSERT INTO mlf_settings VALUES ('subject_maxlength', '60');
#EndIf

#IfNotRow2D mlf_settings name subject_word_maxlength
INSERT INTO mlf_settings VALUES ('subject_word_maxlength', '30');
#EndIf

#IfNotRow2D mlf_settings name text_maxlength
INSERT INTO mlf_settings VALUES ('text_maxlength', '5000');
#EndIf

#IfNotRow2D mlf_settings name profile_maxlength
INSERT INTO mlf_settings VALUES ('profile_maxlength', '5000');
#EndIf

#IfNotRow2D mlf_settings name signature_maxlength
INSERT INTO mlf_settings VALUES ('signature_maxlength', '255');
#EndIf

#IfNotRow2D mlf_settings name text_word_maxlength
INSERT INTO mlf_settings VALUES ('text_word_maxlength', '90');
#EndIf

#IfNotRow2D mlf_settings name email_subject_maxlength
INSERT INTO mlf_settings VALUES ('email_subject_maxlength', '100');
#EndIf

#IfNotRow2D mlf_settings name email_text_maxlength
INSERT INTO mlf_settings VALUES ('email_text_maxlength', '10000');
#EndIf

#IfNotRow2D mlf_settings name quote_symbol
INSERT INTO mlf_settings VALUES ('quote_symbol', '>');
#EndIf

#IfNotRow2D mlf_settings name count_users_online
INSERT INTO mlf_settings VALUES ('count_users_online', '10');
#EndIf

#IfNotRow2D mlf_settings name last_reply_link
INSERT INTO mlf_settings VALUES ('last_reply_link', '0');
#EndIf

#IfNotRow2D mlf_settings name time_difference
INSERT INTO mlf_settings VALUES ('time_difference', '0');
#EndIf

#IfNotRow2D mlf_settings name time_zone
INSERT INTO mlf_settings VALUES ('time_zone', '');
#EndIf

#IfNotRow2D mlf_settings name auto_lock_old_threads
INSERT INTO mlf_settings VALUES ('auto_lock_old_threads', '0');
#EndIf

#IfNotRow2D mlf_settings name upload_max_img_size
INSERT INTO mlf_settings VALUES ('upload_max_img_size', '60');
#EndIf

#IfNotRow2D mlf_settings name upload_max_img_width
INSERT INTO mlf_settings VALUES ('upload_max_img_width', '600');
#EndIf

#IfNotRow2D mlf_settings name upload_max_img_height
INSERT INTO mlf_settings VALUES ('upload_max_img_height', '600');
#EndIf

#IfNotRow2D mlf_settings name mail_parameter
INSERT INTO mlf_settings VALUES ('mail_parameter', '');
#EndIf

#IfNotRow2D mlf_settings name forum_enabled
INSERT INTO mlf_settings VALUES ('forum_enabled', '1');
#EndIf

#IfNotRow2D mlf_settings name forum_readonly
INSERT INTO mlf_settings VALUES ('forum_readonly', '0');
#EndIf

#IfNotRow2D mlf_settings name forum_disabled_message
INSERT INTO mlf_settings VALUES ('forum_disabled_message', '');
#EndIf

#IfNotRow2D mlf_settings name page_browse_range
INSERT INTO mlf_settings VALUES ('page_browse_range', '10');
#EndIf

#IfNotRow2D mlf_settings name page_browse_show_last
INSERT INTO mlf_settings VALUES ('page_browse_show_last', '0');
#EndIf

#IfNotRow2D mlf_settings name deep_reply
INSERT INTO mlf_settings VALUES ('deep_reply', '15');
#EndIf

#IfNotRow2D mlf_settings name very_deep_reply
INSERT INTO mlf_settings VALUES ('very_deep_reply', '30');
#EndIf

#IfNotRow2D mlf_settings name users_per_page
INSERT INTO mlf_settings VALUES ('users_per_page', '20');
#EndIf

#IfNotRow2D mlf_settings name username_maxlength
INSERT INTO mlf_settings VALUES ('username_maxlength', '40');
#EndIf

#IfNotRow2D mlf_settings name bad_behavior
INSERT INTO mlf_settings VALUES ('bad_behavior', '0');
#EndIf

#IfNotRow2D mlf_settings name akismet_entry_check
INSERT INTO mlf_settings VALUES ('akismet_entry_check', '0');
#EndIf

#IfNotRow2D mlf_settings name akismet_mail_check
INSERT INTO mlf_settings VALUES ('akismet_mail_check', '0');
#EndIf

#IfNotRow2D mlf_settings name akismet_key
INSERT INTO mlf_settings VALUES ('akismet_key', '');
#EndIf

#IfNotRow2D mlf_settings name akismet_check_registered
INSERT INTO mlf_settings VALUES ('akismet_check_registered', '0');
#EndIf

#IfNotRow2D mlf_settings name tags
INSERT INTO mlf_settings VALUES ('tags', '1');
#EndIf

#IfNotRow2D mlf_settings name tag_cloud
INSERT INTO mlf_settings VALUES ('tag_cloud', '0');
#EndIf

#IfNotRow2D mlf_settings name tag_cloud_day_period
INSERT INTO mlf_settings VALUES ('tag_cloud_day_period', '30');
#EndIf

#IfNotRow2D mlf_settings name tag_cloud_scale_min
INSERT INTO mlf_settings VALUES ('tag_cloud_scale_min', '0');
#EndIf

#IfNotRow2D mlf_settings name tag_cloud_scale_max
INSERT INTO mlf_settings VALUES ('tag_cloud_scale_max', '6');
#EndIf

#IfNotRow2D mlf_settings name latest_postings
INSERT INTO mlf_settings VALUES ('latest_postings', '0');
#EndIf

#IfNotRow2D mlf_settings name terms_of_use_agreement
INSERT INTO mlf_settings VALUES ('terms_of_use_agreement', '0');
#EndIf

#IfNotRow2D mlf_settings name terms_of_use_url
INSERT INTO mlf_settings VALUES ('terms_of_use_url', '');
#EndIf

#IfNotRow2D mlf_settings name syntax_highlighter
INSERT INTO mlf_settings VALUES ('syntax_highlighter', '0');
#EndIf

#IfNotRow2D mlf_settings name save_spam
INSERT INTO mlf_settings VALUES ('save_spam', '1');
#EndIf

#IfNotRow2D mlf_settings name auto_delete_spam
INSERT INTO mlf_settings VALUES ('auto_delete_spam', '168');
#EndIf

#IfNotRow2D mlf_settings name auto_lock
INSERT INTO mlf_settings VALUES ('auto_lock', '0');
#EndIf

#IfNotRow2D mlf_settings name temp_block_ip_after_repeated_failed_logins
INSERT INTO mlf_settings VALUES ('temp_block_ip_after_repeated_failed_logins', '1');
#EndIf

#IfNotRow2D mlf_settings name flood_prevention_minutes
INSERT INTO mlf_settings VALUES ('flood_prevention_minutes', '0');
#EndIf

#IfNotRow2D mlf_settings name fold_threads
INSERT INTO mlf_settings VALUES ('fold_threads', '0');
#EndIf

#IfNotRow2D mlf_settings name avatars
INSERT INTO mlf_settings VALUES ('avatars', '0');
#EndIf

#IfNotRow2D mlf_settings name avatar_max_filesize
INSERT INTO mlf_settings VALUES ('avatar_max_filesize','20');
#EndIf

#IfNotRow2D mlf_settings name avatar_max_width
INSERT INTO mlf_settings VALUES ('avatar_max_width','80');
#EndIf

#IfNotRow2D mlf_settings name avatar_max_height
INSERT INTO mlf_settings VALUES ('avatar_max_height','80');
#EndIf

#IfNotRow2D mlf_settings name captcha_posting
INSERT INTO mlf_settings VALUES ('captcha_posting', '0');
#EndIf

#IfNotRow2D mlf_settings name captcha_email
INSERT INTO mlf_settings VALUES ('captcha_email', '0');
#EndIf

#IfNotRow2D mlf_settings name captcha_register
INSERT INTO mlf_settings VALUES ('captcha_register', '0');
#EndIf

#IfNotRow2D mlf_settings name min_pw_length
INSERT INTO mlf_settings VALUES ('min_pw_length', '8');
#EndIf

#IfNotRow2D mlf_settings name cookie_validity_days
INSERT INTO mlf_settings VALUES ('cookie_validity_days', '30');
#EndIf

#IfNotRow2D mlf_settings name access_permission_checks
INSERT INTO mlf_settings VALUES ('access_permission_checks', '0');
#EndIf

#IfNotRow2D mlf_settings name daily_actions_time
INSERT INTO mlf_settings VALUES ('daily_actions_time', '3:30');
#EndIf

#IfNotRow2D mlf_settings name next_daily_actions
INSERT INTO mlf_settings VALUES ('next_daily_actions', '0');
#EndIf

#IfNotRow2D mlf_settings name auto_lock_old_threads
INSERT INTO mlf_settings VALUES ('auto_lock_old_threads', '0');
#EndIf

#IfNotRow2D mlf_settings name max_read_items
INSERT INTO mlf_settings VALUES ('max_read_items', '200');
#EndIf

#IfNotRow2D mlf_settings name delete_ips
INSERT INTO mlf_settings VALUES ('delete_ips', '0');
#EndIf

#IfNotRow2D mlf_settings name last_changes
INSERT INTO mlf_settings VALUES ('last_changes', '0');
#EndIf

#IfNotRow2D mlf_settings name ajax_preview
INSERT INTO mlf_settings VALUES ('ajax_preview', '0');
#EndIf

#IfNotRow2D mlf_settings name version
INSERT INTO mlf_settings VALUES ('version', '2.3');
#EndIf

#IfNotRow2D mlf_smilies id 1
INSERT INTO mlf_smilies VALUES (1, 1, 'smile.png', ':-)', '', '', '', '', '');
#EndIf

#IfNotRow2D mlf_smilies id 2
INSERT INTO mlf_smilies VALUES (2, 2, 'wink.png', ';-)', '', '', '', '', '');
#EndIf

#IfNotRow2D mlf_smilies id 3
INSERT INTO mlf_smilies VALUES (3, 3, 'tongue.png', ':-P', '', '', '', '', '');
#EndIf

#IfNotRow2D mlf_smilies id 4
INSERT INTO mlf_smilies VALUES (4, 4, 'biggrin.png', ':-D', '', '', '', '', '');
#EndIf

#IfNotRow2D mlf_smilies id 5
INSERT INTO mlf_smilies VALUES (5, 5, 'neutral.png', ':-|', '', '', '', '', '');
#EndIf

#IfNotRow2D mlf_smilies id 6
INSERT INTO mlf_smilies VALUES (6, 6, 'frown.png', ':-(', '', '', '', '', '');
#EndIf

#IfNotRow2D mlf_userdata user_id 1
INSERT INTO mlf_userdata VALUES (1, 2, 'forum_admin', '', 0, '0000-00-00', 'c3ccb88dc0a985b9b5da20bb9333854194dfbc7767d91c6936', 'admin@example.com', 1, '', '', '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', NOW(), NULL, 0, 0, 1, 0, 0, 0, 0, 0, '', '', '', '', '', 0, '', '');
#EndIf
--For Forum - End

