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

--  #IfRow3D
--	  arguments: table_name colname value colname2 value2 colname3 value3
--	  behavior:  If the table table_name does have a row where colname = value AND colname2 = value2 AND colname3 = value3, the block will be executed.

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

#IfNotRow4D supported_external_dataloads load_type ICD9 load_source CMS load_release_date 2013-10-01 load_filename cmsv31-master-descriptions.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD9', 'CMS', '2013-10-01', 'cmsv31-master-descriptions.zip', 'fe0d7f9a5338f5ff187683b4737ad2b7');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2012-10-01 load_filename 2013_PCS_long_and_abbreviated_titles.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2012-10-01', '2013_PCS_long_and_abbreviated_titles.zip', '04458ed0631c2c122624ee0a4ca1c475');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2012-10-01 load_filename 2013-DiagnosisGEMs.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2012-10-01', '2013-DiagnosisGEMs.zip', '773aac2a675d6aefd1d7dd149883be51');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2012-10-01 load_filename ICD10CMOrderFiles_2013.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2012-10-01', 'ICD10CMOrderFiles_2013.zip', '1c175a858f833485ef8f9d3e66b4d8bd');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2012-10-01 load_filename ProcedureGEMs_2013.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2012-10-01', 'ProcedureGEMs_2013.zip', '92aa7640e5ce29b9629728f7d4fc81db');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2012-10-01 load_filename 2013-ReimbursementMapping_dx.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2012-10-01', '2013-ReimbursementMapping_dx.zip', '0d5d36e3f4519bbba08a9508576787fb');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2012-10-01 load_filename ReimbursementMapping_pr_2013.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2012-10-01', 'ReimbursementMapping_pr_2013.zip', '4c3920fedbcd9f6af54a1dc9069a11ca');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2013-10-01 load_filename 2014-PCS-long-and-abbreviated-titles.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2013-10-01', '2014-PCS-long-and-abbreviated-titles.zip', '2d03514a0c66d92cf022a0bc28c83d38');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2013-10-01 load_filename DiagnosisGEMs-2014.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2013-10-01', 'DiagnosisGEMs-2014.zip', '3ed7b7c5a11c766102b12d97d777a11b');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2013-10-01 load_filename 2014-ICD10-Code-Descriptions.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2013-10-01', '2014-ICD10-Code-Descriptions.zip', '5458b95f6f37228b5cdfa03aefc6c8bb');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2013-10-01 load_filename ProcedureGEMs-2014.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2013-10-01', 'ProcedureGEMs-2014.zip', 'be46de29f4f40f97315d04821273acf9');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2013-10-01 load_filename 2014-Reimbursement-Mappings-DX.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2013-10-01', '2014-Reimbursement-Mappings-DX.zip', '614b3957304208e3ef7d3ba8b3618888');
#EndIf

#IfNotRow4D supported_external_dataloads load_type ICD10 load_source CMS load_release_date 2013-10-01 load_filename 2014-Reimbursement-Mappings-PR.zip
INSERT INTO `supported_external_dataloads` (`load_type`, `load_source`, `load_release_date`, `load_filename`, `load_checksum`) VALUES ('ICD10', 'CMS', '2013-10-01', '2014-Reimbursement-Mappings-PR.zip', 'f306a0e8c9edb34d28fd6ce8af82b646');
#EndIf

#IfMissingColumn patient_data email_direct
ALTER TABLE `patient_data` ADD COLUMN `email_direct` varchar(255) NOT NULL default '';
INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`, `fld_rows`) VALUES('DEM', 'email_direct', '2Contact', 'Trusted Email', 14, 2, 1, 30, 95, '', 1, 1, '', '', 'Trusted (Direct) Email Address', 0);
#EndIf

#IfMissingColumn users email_direct
ALTER TABLE `users` ADD COLUMN `email_direct` varchar(255) NOT NULL default '';
#EndIf

#IfNotTable erx_ttl_touch
CREATE TABLE `erx_ttl_touch` (
  `patient_id` BIGINT(20) UNSIGNED NOT NULL COMMENT 'Patient record Id', 
  `process` ENUM('allergies','medications') NOT NULL COMMENT 'NewCrop eRx SOAP process',
  `updated` DATETIME NOT NULL COMMENT 'Date and time of last process update for patient', 
  PRIMARY KEY (`patient_id`, `process`) ) 
ENGINE = InnoDB COMMENT = 'Store records last update per patient data process';
#EndIf

#IfMissingColumn form_misc_billing_options box_14_date_qual
ALTER TABLE `form_misc_billing_options` 
ADD COLUMN `box_14_date_qual` CHAR(3) NULL DEFAULT NULL;
#EndIf

#IfMissingColumn form_misc_billing_options box_15_date_qual
ALTER TABLE `form_misc_billing_options` 
ADD COLUMN `box_15_date_qual` CHAR(3) NULL DEFAULT NULL;
#EndIf

#IfNotTable esign_signatures
CREATE TABLE `esign_signatures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL COMMENT 'Table row ID for signature',
  `table` varchar(255) NOT NULL COMMENT 'table name for the signature',
  `uid` int(11) NOT NULL COMMENT 'user id for the signing user',
  `datetime` datetime NOT NULL COMMENT 'datetime of the signature action',
  `is_lock` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'sig, lock or amendment',
  `amendment` text COMMENT 'amendment text, if any',
  `hash` varchar(255) NOT NULL COMMENT 'hash of signed data',
  `signature_hash` varchar(255) NOT NULL COMMENT 'hash of signature itself',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`),
  KEY `table` (`table`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;
#EndIf

#IfMissingColumn layout_options list_backup_id
ALTER TABLE `layout_options` ADD COLUMN `list_backup_id` VARCHAR(31) NOT NULL DEFAULT '';
UPDATE `layout_options` SET `list_backup_id` = 'ethrace' WHERE `layout_options`.`form_id` = 'DEM' AND `layout_options`.`field_id` = 'ethnicity';
UPDATE `layout_options` SET `list_backup_id` = 'ethrace' WHERE `layout_options`.`form_id` = 'DEM' AND `layout_options`.`field_id` = 'race';
#EndIf

UPDATE `layout_options` SET `data_type` = '36' WHERE `layout_options`.`form_id` = 'DEM' AND `layout_options`.`field_id` = 'race';
UPDATE `layout_options` SET `data_type` = '1', `datacols` = '3' WHERE `layout_options`.`form_id` = 'DEM' AND `layout_options`.`field_id` = 'language';

#IfNotTable modules
CREATE TABLE `modules` (
  `mod_id` INT(11) NOT NULL AUTO_INCREMENT,
  `mod_name` VARCHAR(64) NOT NULL DEFAULT '0',
  `mod_directory` VARCHAR(64) NOT NULL DEFAULT '',
  `mod_parent` VARCHAR(64) NOT NULL DEFAULT '',
  `mod_type` VARCHAR(64) NOT NULL DEFAULT '',
  `mod_active` INT(1) UNSIGNED NOT NULL DEFAULT '0',
  `mod_ui_name` VARCHAR(20) NOT NULL DEFAULT '''',
  `mod_relative_link` VARCHAR(64) NOT NULL DEFAULT '',
  `mod_ui_order` TINYINT(3) NOT NULL DEFAULT '0',
  `mod_ui_active` INT(1) UNSIGNED NOT NULL DEFAULT '0',
  `mod_description` VARCHAR(255) NOT NULL DEFAULT '',
  `mod_nick_name` VARCHAR(25) NOT NULL DEFAULT '',
  `mod_enc_menu` VARCHAR(10) NOT NULL DEFAULT 'no',
  `permissions_item_table` CHAR(100) DEFAULT NULL,
  `directory` VARCHAR(255) NOT NULL,
  `date` DATETIME NOT NULL,
  `sql_run` TINYINT(4) DEFAULT '0',
  `type` TINYINT(4) DEFAULT '0',
  PRIMARY KEY (`mod_id`,`mod_directory`)
) ENGINE=InnoDB;
#EndIf

#IfNotTable module_acl_group_settings
CREATE TABLE `module_acl_group_settings` (
  `module_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `allowed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`module_id`,`group_id`,`section_id`)
) ENGINE=InnoDB;
#EndIf

#IfNotTable module_acl_sections
CREATE TABLE `module_acl_sections` (
  `section_id` int(11) DEFAULT NULL,
  `section_name` varchar(255) DEFAULT NULL,
  `parent_section` int(11) DEFAULT NULL,
  `section_identifier` varchar(50) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL
) ENGINE=InnoDB;
#EndIf

#IfNotTable module_acl_user_settings
CREATE TABLE `module_acl_user_settings` (
  `module_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `allowed` int(1) DEFAULT NULL,
  PRIMARY KEY (`module_id`,`user_id`,`section_id`)
) ENGINE=InnoDB;
#EndIf

#IfNotTable module_configuration
CREATE TABLE `module_configuration` (
  `module_config_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned NOT NULL,
  `field_name` varchar(45) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  PRIMARY KEY (`module_config_id`)
) ENGINE=InnoDB;
#EndIf

#IfNotTable modules_hooks_settings
CREATE TABLE `modules_hooks_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mod_id` int(11) DEFAULT NULL,
  `enabled_hooks` varchar(255) DEFAULT NULL,
  `attached_to` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
#EndIf

#IfNotTable modules_settings
CREATE TABLE `modules_settings` (
  `mod_id` INT(11) DEFAULT NULL,
  `fld_type` SMALLINT(6) DEFAULT NULL COMMENT '1=>ACL,2=>preferences,3=>hooks',
  `obj_name` VARCHAR(255) DEFAULT NULL,
  `menu_name` VARCHAR(255) DEFAULT NULL,
  `path` VARCHAR(255) DEFAULT NULL
) ENGINE=InnoDB;
#EndIf

#IfNotRow2D list_options list_id lists option_id insurance_types
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`) VALUES ('lists','insurance_types','Insurance Types',1);
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`) VALUES ('insurance_types','primary'  ,'Primary'  ,10);
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`) VALUES ('insurance_types','secondary','Secondary',20);
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`) VALUES ('insurance_types','tertiary' ,'Tertiary' ,30);
#EndIf

#IfMissingColumn patient_data cmsportal_login
ALTER TABLE `patient_data` ADD COLUMN `cmsportal_login` varchar(60) NOT NULL default '';
INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`, `fld_rows`) VALUES
  ('DEM', 'cmsportal_login', '3Choices', 'CMS Portal Login', 15, 2, 1, 30, 60, '', 1, 1, '', '', 'Login ID for the CMS Patient Portal', 0);
#EndIf

#IfNotColumnType procedure_order control_id varchar(255)
ALTER TABLE `procedure_order` CHANGE `control_id`
  `control_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the CONTROL ID that is sent back from lab';
#EndIf

#IfMissingColumn procedure_providers direction
ALTER TABLE `procedure_providers`
ADD COLUMN `direction` char(1) NOT NULL DEFAULT 'B' COMMENT 'Bidirectional or Results-only';
#EndIf

--Added new Fields for MUOII_3
#IfMissingColumn history_data dc_father
	ALTER TABLE `history_data` ADD `dc_father` text NOT NULL DEFAULT '';
#EndIf
#IfMissingColumn history_data dc_mother
	ALTER TABLE `history_data` ADD `dc_mother` text NOT NULL DEFAULT '';
#EndIf
#IfMissingColumn history_data dc_siblings
	ALTER TABLE `history_data` ADD `dc_siblings` text NOT NULL DEFAULT '';
#EndIf
#IfMissingColumn history_data dc_spouse
	ALTER TABLE `history_data` ADD `dc_spouse` text NOT NULL DEFAULT '';
#EndIf
#IfMissingColumn history_data dc_offspring
	ALTER TABLE `history_data` ADD `dc_offspring` text NOT NULL DEFAULT '';
#EndIf
#IfNotRow2D layout_options form_id HIS field_id dc_father
	INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`, `fld_rows`, `list_backup_id`) VALUES ('HIS', 'dc_father', '2Family History', 'Diagnosis Code', 2, 15, 1, 0, 255, '', 1, 1, '', '', '', 0, '');
        UPDATE `layout_options` SET `seq` = '3' WHERE `layout_options`.`form_id` = 'HIS' AND `layout_options`.`field_id` = 'history_mother';
#EndIf
#IfNotRow2D layout_options form_id HIS field_id dc_mother
	INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`, `fld_rows`, `list_backup_id`) VALUES ('HIS', 'dc_mother', '2Family History', 'Diagnosis Code', 4, 15, 1, 0, 255, '', 1, 1, '', '', '', 0, '');
        UPDATE `layout_options` SET `seq` = '5' WHERE `layout_options`.`form_id` = 'HIS' AND `layout_options`.`field_id` = 'history_siblings';
#EndIf
#IfNotRow2D layout_options form_id HIS field_id dc_siblings
	INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`, `fld_rows`, `list_backup_id`) VALUES ('HIS', 'dc_siblings', '2Family History', 'Diagnosis Code', 6, 15, 1, 0, 255, '', 1, 1, '', '', '', 0, '');
        UPDATE `layout_options` SET `seq` = '7' WHERE `layout_options`.`form_id` = 'HIS' AND `layout_options`.`field_id` = 'history_spouse';
#EndIf
#IfNotRow2D layout_options form_id HIS field_id dc_spouse
	INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`, `fld_rows`, `list_backup_id`) VALUES ('HIS', 'dc_spouse', '2Family History', 'Diagnosis Code', 8, 15, 1, 0, 255, '', 1, 1, '', '', '', 0, '');
        UPDATE `layout_options` SET `seq` = '9' AND `datacols` = '1' WHERE `layout_options`.`form_id` = 'HIS' AND `layout_options`.`field_id` = 'history_offspring';
#EndIf
#IfNotRow2D layout_options form_id HIS field_id dc_offspring
	INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`, `fld_rows`, `list_backup_id`) VALUES ('HIS', 'dc_offspring', '2Family History', 'Diagnosis Code', 10, 15, 1, 0, 255, '', 1, 3, '', '', '', 0, '');
#EndIf

#IfNotRow2D list_options list_id lists option_id amendment_status
	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) 
	VALUES ('lists' ,'amendment_status','Amendment Status', 102, 0);

	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES
	('amendment_status' ,'approved','Approved', 10, 0),
	('amendment_status' ,'rejected','Rejected', 20, 0);
#EndIf

#IfNotRow2D list_options list_id lists option_id amendment_from	
	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) 
	VALUES ('lists' ,'amendment_from','Amendment From', 102, 0);

	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES
	('amendment_from' ,'patient','Patient', 10, 0),
	('amendment_from' ,'insurance','Insurance', 20, 0);
#EndIf

#IfNotTable amendments
	CREATE TABLE `amendments` (
		`amendment_id`	int(11)			NOT NULL AUTO_INCREMENT COMMENT 'Amendment ID',
		`amendment_date` date			NOT NULL	COMMENT 'Amendement request date',
		`amendment_by`	varchar(50)		NOT NULL	COMMENT 'Amendment requested from',
		`amendment_status` varchar(50)	NULL		COMMENT 'Amendment status accepted/rejected/null',
		`pid`			int(11)			NOT NULL	COMMENT 'Patient ID from patient_data',
		`amendment_desc` text			NOT NULL	COMMENT 'Amendment Details',
		`created_by`	int(11)			NOT NULL	COMMENT 'references users.id for session owner',
		`modified_by`	int(11)			NULL		COMMENT 'references users.id for session owner',
		`created_time`	timestamp		NOT NULL DEFAULT '0000-00-00 00:00:00'	COMMENT 'created time',
		`modified_time`	timestamp		NULL		COMMENT 'modified time',
		PRIMARY KEY amendments_id(`amendment_id`),
		KEY amendment_pid(`pid`)
	) ENGINE = MyISAM;
#EndIf

#IfNotTable amendments_history
	CREATE TABLE `amendments_history` (
		`amendment_id`	int(11)			NOT NULL AUTO_INCREMENT COMMENT 'Amendment ID',
		`amendment_note` text			NOT NULL	COMMENT 'Amendment requested from',
		`amendment_status` VARCHAR(50)  NULL 		COMMENT 'Amendment Request Status'
		`created_by`	int(11)			NOT NULL	COMMENT 'references users.id for session owner',
		`created_time`	timestamp		NOT NULL DEFAULT '0000-00-00 00:00:00'	COMMENT 'created time',
		KEY amendment_history_id(`amendment_id`)
	) ENGINE = MyISAM;
#EndIf

#IfNotTable log_comment_encrypt
	CREATE TABLE `log_comment_encrypt` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `log_id` int(11) NOT NULL,
	  `encrypt` enum('Yes','No') NOT NULL DEFAULT 'No',
	  `checksum` longtext NOT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;
#EndIf

#IfNotColumnType clinical_rules amc_code varchar(20)
	ALTER TABLE  `clinical_rules` CHANGE  `amc_code`  `amc_code` varchar(20) NOT NULL default '';
#EndIf

#IfNotRow clinical_rules id family_health_history
	INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, 
	`amc_code`, `patient_reminder_flag` ) VALUES ('family_health_history', 0, 0, 0, 0, '', '', 1, '170.314(a)(13)', 0);
#EndIf

#IfNotRow2D list_options list_id clinical_rules option_id family_health_history
	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'family_health_history', 'Family Health History', 3200, 0);
#EndIf

#IfMissingColumn list_options activity
ALTER TABLE `list_options` ADD COLUMN `activity` TINYINT DEFAULT 1 NOT NULL;
#EndIf

#IfNotTable ccda_components
CREATE TABLE ccda_components (
  ccda_components_id int(11) NOT NULL AUTO_INCREMENT,
  ccda_components_field varchar(100) DEFAULT NULL,
  ccda_components_name varchar(100) DEFAULT NULL,
  PRIMARY KEY (ccda_components_id)
) ENGINE=InnoDB;
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('1','progress_note','Progress Notes');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('2','consultation_note','Consultation Note');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('3','continuity_care_document','Continuity Care Document');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('4','diagnostic_image_reporting','Diagnostic Image Reporting');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('5','discharge_summary','Discharge Summary');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('6','history_physical_note','History and Physical Note');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('7','operative_note','Operative Note');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('8','procedure_note','Procedure Note');
insert into ccda_components (ccda_components_id, ccda_components_field, ccda_components_name) values('9','unstructured_document','Unstructured Document');
#EndIf

#IfNotTable ccda_sections
CREATE TABLE ccda_sections (
  ccda_sections_id int(11) NOT NULL AUTO_INCREMENT,
  ccda_components_id int(11) DEFAULT NULL,
  ccda_sections_field varchar(100) DEFAULT NULL,
  ccda_sections_name varchar(100) DEFAULT NULL,
  ccda_sections_req_mapping tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (ccda_sections_id)
) ENGINE=InnoDB;
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('1','1','assessment_plan','Assessment and Plan','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('2','2','assessment_plan','Assessment and Plan','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('3','2','history_of_present_illness','History of Present Illness','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('4','2','physical_exam','Physical Exam','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('5','2','reason_of_visit','Reason for Referral/Reason for Visit','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('6','3','allergies','Allergies','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('7','3','medications','Medications','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('8','3','problem_list','Problem List','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('9','3','procedures','Procedures','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('10','3','results','Results','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('11','4','report','Report','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('12','5','allergies','Allergies','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('13','5','hospital_course','Hospital Course','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('14','5','hospital_discharge_diagnosis','Hospital Discharge Diagnosis','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('15','5','hospital_discharge_medications','Hospital Discharge Medications','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('16','5','plan_of_care','Plan of Care','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('17','6','allergies','Allergies','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('19','6','chief_complaint','Chief Complaint / Reason for Visit','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('21','6','family_history','Family History','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('22','6','general_status','General Status','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('23','6','hpi_past_med','History of Past Illness (Past Medical History)','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('24','6','hpi','History of Present Illness','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('25','6','medications','Medications','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('26','6','physical_exam','Physical Exam','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('28','6','results','Results','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('29','6','review_of_systems','Review of Systems','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('30','6','social_history','Social History','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('31','6','vital_signs','Vital Signs','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('32','7','anesthesia','Anesthesia','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('33','7','complications','Complications','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('34','7','post_operative_diagnosis','Post Operative Diagnosis','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('35','7','pre_operative_diagnosis','Pre Operative Diagnosis','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('36','7','procedure_estimated_blood_loss','Procedure Estimated Blood Loss','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('37','7','procedure_findings','Procedure Findings','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('38','7','procedure_specimens_taken','Procedure Specimens Taken','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('39','7','procedure_description','Procedure Description','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('40','8','assessment_plan','Assessment and Plan','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('41','8','complications','Complications','1');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('42','8','postprocedure_diagnosis','Postprocedure Diagnosis','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('43','8','procedure_description','Procedure Description','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('44','8','procedure_indications','Procedure Indications','0');
insert into ccda_sections (ccda_sections_id, ccda_components_id, ccda_sections_field, ccda_sections_name, ccda_sections_req_mapping) values('45','9','unstructured_doc','Document','0');
#EndIf

#IfNotTable ccda_table_mapping
CREATE TABLE ccda_table_mapping (
  id int(11) NOT NULL AUTO_INCREMENT,
  ccda_component varchar(100) DEFAULT NULL,
  ccda_component_section varchar(100) DEFAULT NULL,
  form_dir varchar(100) DEFAULT NULL,
  form_type smallint(6) DEFAULT NULL,
  form_table varchar(100) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  deleted tinyint(4) NOT NULL DEFAULT '0',
  timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
#EndIf

#IfNotTable ccda_field_mapping
CREATE TABLE ccda_field_mapping (
  id int(11) NOT NULL AUTO_INCREMENT,
  table_id int(11) DEFAULT NULL,
  ccda_field varchar(100) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
#EndIf

#IfNotTable ccda
CREATE TABLE ccda (
  id INT(11) NOT NULL AUTO_INCREMENT,
  pid BIGINT(20) DEFAULT NULL,
  encounter BIGINT(20) DEFAULT NULL,
  ccda_data MEDIUMTEXT,
  time VARCHAR(50) DEFAULT NULL,
  status SMALLINT(6) DEFAULT NULL,
  updated_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  user_id VARCHAR(50) null,
  couch_docid VARCHAR(100) NULL,
  couch_revid VARCHAR(100) NULL,
  `view` tinyint(4) NOT NULL DEFAULT '0',
  `transfer` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE KEY unique_key (pid,encounter,time)
) ENGINE=InnoDB;
#EndIf

#IfNotRow list_options list_id religious_affiliation
INSERT INTO list_options(list_id,option_id,title) VALUES ('lists','religious_affiliation','Religious Affiliation');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','adventist','1001','Adventist');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','african_religions','1002','African Religions');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','afro-caribbean_religions','1003','Afro-Caribbean Religions');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','agnosticism','1004','Agnosticism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','anglican','1005','Anglican');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','animism','1006','Animism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','assembly_of_god','1061','Assembly of God');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','atheism','1007','Atheism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','babi_bahai_faiths','1008',"Babi & Baha'I faiths");
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','baptist','1009','Baptist');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','bon','1010','Bon');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','brethren','1062','Brethren');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','cao_dai','1011','Cao Dai');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','celticism','1012','Celticism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','christian_non-catholic_non-specific','1013','Christian (non-Catholic, non-specific)');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','christian_scientist','1063','Christian Scientist');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','church_of_christ','1064','Church of Christ');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','church_of_god','1065','Church of God');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','confucianism','1014','Confucianism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','congregational','1066','Congregational');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','cyberculture_religions','1015','Cyberculture Religions');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','disciples_of_christ','1067','Disciples of Christ');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','divination','1016','Divination');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','eastern_orthodox','1068','Eastern Orthodox');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','episcopalian','1069','Episcopalian');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','evangelical_covenant','1070','Evangelical Covenant');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','fourth_way','1017','Fourth Way');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','free_daism','1018','Free Daism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','friends','1071','Friends');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','full_gospel','1072','Full Gospel');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','gnosis','1019','Gnosis');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','hinduism','1020','Hinduism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','humanism','1021','Humanism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','independent','1022','Independent');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','islam','1023','Islam');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','jainism','1024','Jainism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','jehovahs_witnesses','1025',"Jehovah's Witnesses");
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','judaism','1026','Judaism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','latter_day_saints','1027','Latter Day Saints');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','lutheran','1028','Lutheran');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','mahayana','1029','Mahayana');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','meditation','1030','Meditation');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','messianic_judaism','1031','Messianic Judaism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','methodist','1073','Methodist');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','mitraism','1032','Mitraism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','native_american','1074','Native American');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','nazarene','1075','Nazarene');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','new_age','1033','New Age');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','non-roman_catholic','1034','non-Roman Catholic');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','occult','1035','Occult');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','orthodox','1036','Orthodox');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','paganism','1037','Paganism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','pentecostal','1038','Pentecostal');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','presbyterian','1076','Presbyterian');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','process_the','1039','Process, The');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','protestant','1077','Protestant');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','protestant_no_denomination','1078','Protestant, No Denomination');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','reformed','1079','Reformed');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','reformed_presbyterian','1040','Reformed/Presbyterian');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','roman_catholic_church','1041','Roman Catholic Church');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','salvation_army','1080','Salvation Army');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','satanism','1042','Satanism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','scientology','1043','Scientology');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','shamanism','1044','Shamanism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','shiite_islam','1045','Shiite (Islam)');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','shinto','1046','Shinto');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','sikism','1047','Sikism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','spiritualism','1048','Spiritualism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','sunni_islam','1049','Sunni (Islam)');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','taoism','1050','Taoism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','theravada','1051','Theravada');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','unitarian_universalist','1081','Unitarian Universalist');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','unitarian-universalism','1052','Unitarian-Universalism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','united_church_of_christ','1082','United Church of Christ');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','universal_life_church','1053','Universal Life Church');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','vajrayana_tibetan','1054','Vajrayana (Tibetan)');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','veda','1055','Veda');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','voodoo','1056','Voodoo');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','wicca','1057','Wicca');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','yaohushua','1058','Yaohushua');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','zen_buddhism','1059','Zen Buddhism');
INSERT INTO list_options (list_id, option_id, notes,title) VALUES ('religious_affiliation','zoroastrianism','1060','Zoroastrianism');
#EndIf

#IfNotRow list_options list_id personal_relationship
INSERT INTO list_options(list_id,option_id,title) VALUES ('lists','personal_relationship','Relationship');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','ADOPT','Adopted Child','ADOPT');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','AUNT','Aunt','AUNT');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','CHILD','Child','CHILD');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','CHLDINLAW','Child-In-Law','CHLDINLAW');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','COUSN','Cousin','COUSN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','DOMPART','Domestic Partner','DOMPART');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','FAMMEMB','Family Member','FAMMEMB');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','CHLDFOST','Foster Child','CHLDFOST');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','GRNDCHILD','Grandchild','GRNDCHILD');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','GPARNT','Grandparent','GPARNT');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','GRPRN','Grandparent','GRPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','GGRPRN','Great Grandparent','GGRPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','HSIB','Half Sibling','HSIB');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','MAUNT','Maternal Aunt','MAUNT');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','MCOUSN','Maternal Cousin','MCOUSN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','MGRPRN','Maternal Grandparent','MGRPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','MGGRPRN','Maternal Greatgrandparent','MGGRPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','MUNCLE','Maternal Uncle','MUNCLE');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','NCHILD','Natural Child','NCHILD');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','NPRN','Natural Parent','NPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','NSIB','Natural Sibling','NSIB');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','NBOR','Neighbor','NBOR');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','NIENEPH','Niece/Nephew','NIENEPH');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','PRN','Parent','PRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','PRNINLAW','Parent-In-Law','PRNINLAW');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','PAUNT','Paternal Aunt','PAUNT');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','PCOUSN','Paternal Cousin','PCOUSN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','PGRPRN','Paternal Grandparent','PGRPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','PGGRPRN','Paternal Greatgrandparent','PGGRPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','PUNCLE','Paternal Uncle','PUNCLE');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','ROOM','Room-mate','ROOM');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','SIB','Sibling','SIB');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','SIBINLAW','Sibling-In-Law','SIBINLAW');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','SIGOTHR','Significant Other','SIGOTHR');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','SPS','Spouse','SPS');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','STEP','Step Child','STEP');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','STPPRN','Step Parent','STPPRN');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','STPSIB','Step Sibling','STPSIB');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','UNCLE','Uncle','UNCLE');
INSERT INTO list_options (list_id, option_id, title, notes) VALUES ('personal_relationship','FRND','Unrelated Friend','FRND');
#EndIf

#IfNotRow2D list_options list_id race option_id abenaki
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','abenaki','1006-6','Abenaki', '0',60);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','absentee_shawnee','1579-2','Absentee Shawnee', '0',70);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','acoma','1490-2','Acoma', '0',80);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','afghanistani','2126-1','Afghanistani', '0',90);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','african','2060-2','African', '0',100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','african_american','2058-6','African American', '0',110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','agdaagux','1994-3','Agdaagux', '0',120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','agua_caliente','1212-0','Agua Caliente', '0',130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','agua_caliente_cahuilla','1045-4','Agua Caliente Cahuilla', '0',140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ahtna','1740-0','Ahtna', '0',150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ak-chin','1654-3','Ak-Chin', '0',160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','akhiok','1993-5','Akhiok', '0',170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','akiachak','1897-8','Akiachak', '0',180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','akiak','1898-6','Akiak', '0',190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','akutan','2007-3','Akutan', '0',200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alabama_coushatta','1187-4','Alabama Coushatta', '0',210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alabama_creek','1194-0','Alabama Creek', '0',220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alabama_quassarte','1195-7','Alabama Quassarte', '0',230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alakanuk','1899-4','Alakanuk', '0',240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alamo_navajo','1383-9','Alamo Navajo', '0',250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alanvik','1744-2','Alanvik', '0',260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alaska_indian','1737-6','Alaska Indian', '0',270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alaska_native','1735-0','Alaska Native', '0',280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alaskan_athabascan','1739-2','Alaskan Athabascan', '0',290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alatna','1741-8','Alatna', '0',300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','aleknagik','1900-0','Aleknagik', '0',310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','aleut','1966-1','Aleut', '0',320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','aleut_corporation','2008-1','Aleut Corporation', '0',330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','aleutian','2009-9','Aleutian', '0',340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','aleutian_islander','2010-7','Aleutian Islander', '0',350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alexander','1742-6','Alexander', '0',360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','algonquian','1008-2','Algonquian', '0',370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','allakaket','1743-4','Allakaket', '0',380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','allen_canyon','1671-7','Allen Canyon', '0',390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alpine','1688-1','Alpine', '0',400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alsea','1392-0','Alsea', '0',410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','alutiiq_aleut','1968-7','Alutiiq Aleut', '0',420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ambler','1845-7','Ambler', '0',430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','american_indian','1004-1','American Indian', '0',440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','american_indian_or_alaska','1002-5','American Indian or Alaska Native', '0',450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','anaktuvuk','1846-5','Anaktuvuk', '0',460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','anaktuvuk_pass','1847-3','Anaktuvuk Pass', '0',470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','andreafsky','1901-8','Andreafsky', '0',480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','angoon','1814-3','Angoon', '0',490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','aniak','1902-6','Aniak', '0',500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','anvik','1745-9','Anvik', '0',510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','apache','1010-8','Apache', '0',520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','arab','2129-5','Arab', '0',530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','arapaho','1021-5','Arapaho', '0',540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','arctic','1746-7','Arctic', '0',550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','arctic_slope_corporation','1849-9','Arctic Slope Corporation', '0',560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','arctic_slope_inupiat','1848-1','Arctic Slope Inupiat', '0',570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','arikara','1026-4','Arikara', '0',580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','arizona_tewa','1491-0','Arizona Tewa', '0',590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','armenian','2109-7','Armenian', '0',600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','aroostook','1366-4','Aroostook', '0',610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','asian_indian','2029-7','Asian Indian', '0',630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','assiniboine','1028-0','Assiniboine', '0',640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','assiniboine_sioux','1030-6','Assiniboine Sioux', '0',650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','assyrian','2119-6','Assyrian', '0',660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','atka','2011-5','Atka', '0',670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','atmautluak','1903-4','Atmautluak', '0',680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','atqasuk','1850-7','Atqasuk', '0',690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','atsina','1265-8','Atsina', '0',700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','attacapa','1234-4','Attacapa', '0',710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','augustine','1046-2','Augustine', '0',720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bad_river','1124-7','Bad River', '0',730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bahamian','2067-7','Bahamian', '0',740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bangladeshi','2030-5','Bangladeshi', '0',750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bannock','1033-0','Bannock', '0',760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','barbadian','2068-5','Barbadian', '0',770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','barrio_libre','1712-9','Barrio Libre', '0',780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','barrow','1851-5','Barrow', '0',790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','battle_mountain','1587-5','Battle Mountain', '0',800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bay_mills_chippewa','1125-4','Bay Mills Chippewa', '0',810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','beaver','1747-5','Beaver', '0',820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','belkofski','2012-3','Belkofski', '0',830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bering_straits_inupiat','1852-3','Bering Straits Inupiat', '0',840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bethel','1904-2','Bethel', '0',850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bhutanese','2031-3','Bhutanese', '0',860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','big_cypress','1567-7','Big Cypress', '0',870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bill_moores_slough','1905-9',"Bill Moore's Slough", '0',880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','biloxi','1235-1','Biloxi', '0',890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','birch_creek','1748-3','Birch Creek', '0',900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bishop','1417-5','Bishop', '0',910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','black','2056-0','Black', '0',920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','black_or_african_american','2054-5','Black or African American', '0',930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','blackfeet','1035-5','Blackfeet', '0',940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','blackfoot_sioux','1610-5','Blackfoot Sioux', '0',950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bois_forte','1126-2','Bois Forte', '0',960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','botswanan','2061-0','Botswanan', '0',970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','brevig_mission','1853-1','Brevig Mission', '0',980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bridgeport','1418-3','Bridgeport', '0',990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','brighton','1568-5','Brighton', '0',1000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bristol_bay_aleut','1972-9','Bristol Bay Aleut', '0',1010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','bristol_bay_yupik','1906-7','Bristol Bay Yupik', '0',1020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','brotherton','1037-1','Brotherton', '0',1030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','brule_sioux','1611-3','Brule Sioux', '0',1040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','buckland','1854-9','Buckland', '0',1050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','burmese','2032-1','Burmese', '0',1060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','burns_paiute','1419-1','Burns Paiute', '0',1070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','burt_lake_band','1039-7','Burt Lake Band', '0',1080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','burt_lake_chippewa','1127-0','Burt Lake Chippewa', '0',1090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','burt_lake_ottawa','1412-6','Burt Lake Ottawa', '0',1100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cabazon','1047-0','Cabazon', '0',1110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','caddo','1041-3','Caddo', '0',1120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cahto','1054-6','Cahto', '0',1130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cahuilla','1044-7','Cahuilla', '0',1140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','california_tribes','1053-8','California Tribes', '0',1150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','calista_yupik','1907-5','Calista Yupik', '0',1160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cambodian','2033-9','Cambodian', '0',1170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','campo','1223-7','Campo', '0',1180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','canadian_latinamerican_indian','1068-6','Canadian and Latin American Indian', '0',1190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','canadian_indian','1069-4','Canadian Indian', '0',1200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','canoncito_navajo','1384-7','Canoncito Navajo', '0',1210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cantwell','1749-1','Cantwell', '0',1220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','capitan_grande','1224-5','Capitan Grande', '0',1230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','carolinian','2092-5','Carolinian', '0',1240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','carson','1689-9','Carson', '0',1250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','catawba','1076-9','Catawba', '0',1260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cayuga','1286-4','Cayuga', '0',1270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cayuse','1078-5','Cayuse', '0',1280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cedarville','1420-9','Cedarville', '0',1290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','celilo','1393-8','Celilo', '0',1300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','central_american_indian','1070-2','Central American Indian', '0',1310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tlingit_and_haida_tribes','1815-0','Central Council of Tlingit and Haida Tribes', '0',1320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','central_pomo','1465-4','Central Pomo', '0',1330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chalkyitsik','1750-9','Chalkyitsik', '0',1340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chamorro','2088-3','Chamorro', '0',1350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chefornak','1908-3','Chefornak', '0',1360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chehalis','1080-1','Chehalis', '0',1370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chemakuan','1082-7','Chemakuan', '0',1380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chemehuevi','1086-8','Chemehuevi', '0',1390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chenega','1985-1','Chenega', '0',1400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cherokee','1088-4','Cherokee', '0',1410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cherokee_alabama','1089-2','Cherokee Alabama', '0',1420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cherokee_shawnee','1100-7','Cherokee Shawnee', '0',1430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cherokees_of_northeast_alabama','1090-0','Cherokees of Northeast Alabama', '0',1440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cherokees_of_southeast_alabama','1091-8','Cherokees of Southeast Alabama', '0',1450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chevak','1909-1','Chevak', '0',1460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cheyenne','1102-3','Cheyenne', '0',1470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cheyenne_river_sioux','1612-1','Cheyenne River Sioux', '0',1480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cheyenne-arapaho','1106-4','Cheyenne-Arapaho', '0',1490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chickahominy','1108-0','Chickahominy', '0',1500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chickaloon','1751-7','Chickaloon', '0',1510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chickasaw','1112-2','Chickasaw', '0',1520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chignik','1973-7','Chignik', '0',1530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chignik_lagoon','2013-1','Chignik Lagoon', '0',1540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chignik_lake','1974-5','Chignik Lake', '0',1550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chilkat','1816-8','Chilkat', '0',1560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chilkoot','1817-6','Chilkoot', '0',1570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chimariko','1055-3','Chimariko', '0',1580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chinese','2034-7','Chinese', '0',1590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chinik','1855-6','Chinik', '0',1600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chinook','1114-8','Chinook', '0',1610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chippewa','1123-9','Chippewa', '0',1620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chippewa_cree','1150-2','Chippewa Cree', '0',1630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chiricahua','1011-6','Chiricahua', '0',1640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chistochina','1752-5','Chistochina', '0',1650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chitimacha','1153-6','Chitimacha', '0',1660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chitina','1753-3','Chitina', '0',1670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','choctaw','1155-1','Choctaw', '0',1680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chuathbaluk','1910-9','Chuathbaluk', '0',1690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chugach_aleut','1984-4','Chugach Aleut', '0',1700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chugach_corporation','1986-9','Chugach Corporation', '0',1710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chukchansi','1718-6','Chukchansi', '0',1720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chumash','1162-7','Chumash', '0',1730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','chuukese','2097-4','Chuukese', '0',1740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','circle','1754-1','Circle', '0',1750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','citizen_band_potawatomi','1479-5','Citizen Band Potawatomi', '0',1760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','clarks_point','1911-7',"Clark's Point", '0',1770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','clatsop','1115-5','Clatsop', '0',1780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','clear_lake','1165-0','Clear Lake', '0',1790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','clifton_choctaw','1156-9','Clifton Choctaw', '0',1800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coast_miwok','1056-1','Coast Miwok', '0',1810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coast_yurok','1733-5','Coast Yurok', '0',1820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cochiti','1492-8','Cochiti', '0',1830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cocopah','1725-1','Cocopah', '0',1840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coeur_dalene','1167-6',"Coeur D'Alene", '0',1850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coharie','1169-2','Coharie', '0',1860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','colorado_river','1171-8','Colorado River', '0',1870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','columbia','1394-6','Columbia', '0',1880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','columbia_river_chinook','1116-3','Columbia River Chinook', '0',1890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','colville','1173-4','Colville', '0',1900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','comanche','1175-9','Comanche', '0',1910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cook_inlet','1755-8','Cook Inlet', '0',1920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coos','1180-9','Coos', '0',1930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coos_lower_umpqua_siuslaw','1178-3','Coos, Lower Umpqua, Siuslaw', '0',1940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','copper_center','1756-6','Copper Center', '0',1950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','copper_river','1757-4','Copper River', '0',1960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coquilles','1182-5','Coquilles', '0',1970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','costanoan','1184-1','Costanoan', '0',1980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','council','1856-4','Council', '0',1990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','coushatta','1186-6','Coushatta', '0',2000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cow_creek_umpqua','1668-3','Cow Creek Umpqua', '0',2010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cowlitz','1189-0','Cowlitz', '0',2020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','craig','1818-4','Craig', '0',2030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cree','1191-6','Cree', '0',2040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','creek','1193-2','Creek', '0',2050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','croatan','1207-0','Croatan', '0',2060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','crooked_creek','1912-5','Crooked Creek', '0',2070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','crow','1209-6','Crow', '0',2080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','crow_creek_sioux','1613-9','Crow Creek Sioux', '0',2090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cupeno','1211-2','Cupeno', '0',2100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','cuyapaipe','1225-2','Cuyapaipe', '0',2110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','dakota_sioux','1614-7','Dakota Sioux', '0',2120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','deering','1857-2','Deering', '0',2130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','delaware','1214-6','Delaware', '0',2140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','diegueno','1222-9','Diegueno', '0',2150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','digger','1057-9','Digger', '0',2160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','dillingham','1913-3','Dillingham', '0',2170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','dominica_islander','2070-1','Dominica Islander', '0',2180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','dominican','2069-3','Dominican', '0',2190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','dot_lake','1758-2','Dot Lake', '0',2200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','douglas','1819-2','Douglas', '0',2210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','doyon','1759-0','Doyon', '0',2220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','dresslerville','1690-7','Dresslerville', '0',2230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','dry_creek','1466-2','Dry Creek', '0',2240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','duck_valley','1603-0','Duck Valley', '0',2250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','duckwater','1588-3','Duckwater', '0',2260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','duwamish','1519-8','Duwamish', '0',2270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eagle','1760-8','Eagle', '0',2280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_cherokee','1092-6','Eastern Cherokee', '0',2290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_chickahominy','1109-8','Eastern Chickahominy', '0',2300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_creek','1196-5','Eastern Creek', '0',2310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_delaware','1215-3','Eastern Delaware', '0',2320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_muscogee','1197-3','Eastern Muscogee', '0',2330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_pomo','1467-0','Eastern Pomo', '0',2340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_shawnee','1580-0','Eastern Shawnee', '0',2350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eastern_tribes','1233-6','Eastern Tribes', '0',2360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','echota_cherokee','1093-4','Echota Cherokee', '0',2370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eek','1914-1','Eek', '0',2380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','egegik','1975-2','Egegik', '0',2390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','egyptian','2120-4','Egyptian', '0',2400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eklutna','1761-6','Eklutna', '0',2410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ekuk','1915-8','Ekuk', '0',2420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ekwok','1916-6','Ekwok', '0',2430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','elim','1858-0','Elim', '0',2440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','elko','1589-1','Elko', '0',2450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ely','1590-9','Ely', '0',2460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','emmonak','1917-4','Emmonak', '0',2470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','english','2110-5','English', '0',2480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','english_bay','1987-7','English Bay', '0',2490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eskimo','1840-8','Eskimo', '0',2500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','esselen','1250-0','Esselen', '0',2510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ethiopian','2062-8','Ethiopian', '0',2520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','etowah_cherokee','1094-2','Etowah Cherokee', '0',2530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','european','2108-9','European', '0',2540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','evansville','1762-4','Evansville', '0',2550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','eyak','1990-1','Eyak', '0',2560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fallon','1604-8','Fallon', '0',2570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','false_pass','2015-6','False Pass', '0',2580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fijian','2101-4','Fijian', '0',2590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','filipino','2036-2','Filipino', '0',2600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','flandreau_santee','1615-4','Flandreau Santee', '0',2610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','florida_seminole','1569-3','Florida Seminole', '0',2620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fond_du_lac','1128-8','Fond du Lac', '0',2630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','forest_county','1480-3','Forest County', '0',2640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_belknap','1252-6','Fort Belknap', '0',2650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_berthold','1254-2','Fort Berthold', '0',2660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_bidwell','1421-7','Fort Bidwell', '0',2670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_hall','1258-3','Fort Hall', '0',2680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_independence','1422-5','Fort Independence', '0',2690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_mcdermitt','1605-5','Fort McDermitt', '0',2700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_mcdowell','1256-7','Fort Mcdowell', '0',2710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_peck','1616-2','Fort Peck', '0',2720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_peck_assiniboine_sioux','1031-4','Fort Peck Assiniboine Sioux', '0',2730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_sill_apache','1012-4','Fort Sill Apache', '0',2740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','fort_yukon','1763-2','Fort Yukon', '0',2750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','french','2111-3','French', '0',2760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','french_american_indian','1071-0','French American Indian', '0',2770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gabrieleno','1260-9','Gabrieleno', '0',2780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gakona','1764-0','Gakona', '0',2790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','galena','1765-7','Galena', '0',2800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gambell','1892-9','Gambell', '0',2810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gay_head_wampanoag','1680-8','Gay Head Wampanoag', '0',2820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','georgetown_eastern_tribes','1236-9','Georgetown (Eastern Tribes)', '0',2830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','georgetown_yupik-eskimo','1962-0','Georgetown (Yupik-Eskimo)', '0',2840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','german','2112-1','German', '0',2850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gila_bend','1655-0','Gila Bend', '0',2860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gila_river_pima-maricopa','1457-1','Gila River Pima-Maricopa', '0',2870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','golovin','1859-8','Golovin', '0',2880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','goodnews_bay','1918-2','Goodnews Bay', '0',2890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','goshute','1591-7','Goshute', '0',2900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','grand_portage','1129-6','Grand Portage', '0',2910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','grand_ronde','1262-5','Grand Ronde', '0',2920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','grand_traverse_band','1130-4','Grand Traverse Band of Ottawa/Chippewa', '0',2930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','grayling','1766-5','Grayling', '0',2940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','greenland_eskimo','1842-4','Greenland Eskimo', '0',2950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gros_ventres','1264-1','Gros Ventres', '0',2960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','guamanian','2087-5','Guamanian', '0',2970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','guamanian_or_chamorro','2086-7','Guamanian or Chamorro', '0',2980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','gulkana','1767-3','Gulkana', '0',2990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','haida','1820-0','Haida', '0',3000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','haitian','2071-9','Haitian', '0',3010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','haliwa','1267-4','Haliwa', '0',3020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hannahville','1481-1','Hannahville', '0',3030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','havasupai','1726-9','Havasupai', '0',3040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','healy_lake','1768-1','Healy Lake', '0',3050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hidatsa','1269-0','Hidatsa', '0',3060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hmong','2037-0','Hmong', '0',3070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ho-chunk','1697-2','Ho-chunk', '0',3080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hoh','1083-5','Hoh', '0',3090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hollywood_seminole','1570-1','Hollywood Seminole', '0',3100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','holy_cross','1769-9','Holy Cross', '0',3110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hoonah','1821-8','Hoonah', '0',3120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hoopa','1271-6','Hoopa', '0',3130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hoopa_extension','1275-7','Hoopa Extension', '0',3140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hooper_bay','1919-0','Hooper Bay', '0',3150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hopi','1493-6','Hopi', '0',3160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','houma','1277-3','Houma', '0',3170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hualapai','1727-7','Hualapai', '0',3180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hughes','1770-7','Hughes', '0',3190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','huron_potawatomi','1482-9','Huron Potawatomi', '0',3200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','huslia','1771-5','Huslia', '0',3210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','hydaburg','1822-6','Hydaburg', '0',3220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','igiugig','1976-0','Igiugig', '0',3230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iliamna','1772-3','Iliamna', '0',3240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','illinois_miami','1359-9','Illinois Miami', '0',3250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','inaja-cosmit','1279-9','Inaja-Cosmit', '0',3260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','inalik_diomede','1860-6','Inalik Diomede', '0',3270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','indian_township','1442-3','Indian Township', '0',3280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','indiana_miami','1360-7','Indiana Miami', '0',3290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','indonesian','2038-8','Indonesian', '0',3300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','inupiaq','1861-4','Inupiaq', '0',3310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','inupiat_eskimo','1844-0','Inupiat Eskimo', '0',3320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iowa','1281-5','Iowa', '0',3330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iowa_of_kansas-nebraska','1282-3','Iowa of Kansas-Nebraska', '0',3340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iowa_of_oklahoma','1283-1','Iowa of Oklahoma', '0',3350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iowa_sac_and_fox','1552-9','Iowa Sac and Fox', '0',3360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iqurmuit_russian_mission','1920-8','Iqurmuit (Russian Mission)', '0',3370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iranian','2121-2','Iranian', '0',3380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iraqi','2122-0','Iraqi', '0',3390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','irish','2113-9','Irish', '0',3400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iroquois','1285-6','Iroquois', '0',3410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','isleta','1494-4','Isleta', '0',3420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','israeili','2127-9','Israeili', '0',3430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','italian','2114-7','Italian', '0',3440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ivanof_bay','1977-8','Ivanof Bay', '0',3450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','iwo_jiman','2048-7','Iwo Jiman', '0',3460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','jamaican','2072-7','Jamaican', '0',3470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','jamestown','1313-6','Jamestown', '0',3480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','japanese','2039-6','Japanese', '0',3490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','jemez','1495-1','Jemez', '0',3500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','jena_choctaw','1157-7','Jena Choctaw', '0',3510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','jicarilla_apache','1013-2','Jicarilla Apache', '0',3520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','juaneno','1297-1','Juaneno', '0',3530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kaibab','1423-3','Kaibab', '0',3540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kake','1823-4','Kake', '0',3550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kaktovik','1862-2','Kaktovik', '0',3560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kalapuya','1395-3','Kalapuya', '0',3570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kalispel','1299-7','Kalispel', '0',3580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kalskag','1921-6','Kalskag', '0',3590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kaltag','1773-1','Kaltag', '0',3600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','karluk','1995-0','Karluk', '0',3610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','karuk','1301-1','Karuk', '0',3620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kasaan','1824-2','Kasaan', '0',3630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kashia','1468-8','Kashia', '0',3640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kasigluk','1922-4','Kasigluk', '0',3650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kathlamet','1117-1','Kathlamet', '0',3660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kaw','1303-7','Kaw', '0',3670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kawaiisu','1058-7','Kawaiisu', '0',3680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kawerak','1863-0','Kawerak', '0',3690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kenaitze','1825-9','Kenaitze', '0',3700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','keres','1496-9','Keres', '0',3710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kern_river','1059-5','Kern River', '0',3720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ketchikan','1826-7','Ketchikan', '0',3730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','keweenaw','1131-2','Keweenaw', '0',3740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kialegee','1198-1','Kialegee', '0',3750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kiana','1864-8','Kiana', '0',3760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kickapoo','1305-2','Kickapoo', '0',3770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kikiallus','1520-6','Kikiallus', '0',3780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','king_cove','2014-9','King Cove', '0',3790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','king_salmon','1978-6','King Salmon', '0',3800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kiowa','1309-4','Kiowa', '0',3810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kipnuk','1923-2','Kipnuk', '0',3820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kiribati','2096-6','Kiribati', '0',3830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kivalina','1865-5','Kivalina', '0',3840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','klallam','1312-8','Klallam', '0',3850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','klamath','1317-7','Klamath', '0',3860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','klawock','1827-5','Klawock', '0',3870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kluti_kaah','1774-9','Kluti Kaah', '0',3880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','knik','1775-6','Knik', '0',3890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kobuk','1866-3','Kobuk', '0',3900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kodiak','1996-8','Kodiak', '0',3910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kokhanok','1979-4','Kokhanok', '0',3920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','koliganek','1924-0','Koliganek', '0',3930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kongiganak','1925-7','Kongiganak', '0',3940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','koniag_aleut','1992-7','Koniag Aleut', '0',3950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','konkow','1319-3','Konkow', '0',3960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kootenai','1321-9','Kootenai', '0',3970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','korean','2040-4','Korean', '0',3980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kosraean','2093-3','Kosraean', '0',3990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kotlik','1926-5','Kotlik', '0',4000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kotzebue','1867-1','Kotzebue', '0',4010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','koyuk','1868-9','Koyuk', '0',4020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','koyukuk','1776-4','Koyukuk', '0',4030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kwethluk','1927-3','Kwethluk', '0',4040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kwigillingok','1928-1','Kwigillingok', '0',4050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','kwiguk','1869-7','Kwiguk', '0',4060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','la_jolla','1332-6','La Jolla', '0',4070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','la_posta','1226-0','La Posta', '0',4080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lac_courte_oreilles','1132-0','Lac Courte Oreilles', '0',4090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lac_du_flambeau','1133-8','Lac du Flambeau', '0',4100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lac_vieux_desert_chippewa','1134-6','Lac Vieux Desert Chippewa', '0',4110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','laguna','1497-7','Laguna', '0',4120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lake_minchumina','1777-2','Lake Minchumina', '0',4130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lake_superior','1135-3','Lake Superior', '0',4140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lake_traverse_sioux','1617-0','Lake Traverse Sioux', '0',4150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','laotian','2041-2','Laotian', '0',4160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','larsen_bay','1997-6','Larsen Bay', '0',4170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','las_vegas','1424-1','Las Vegas', '0',4180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lassik','1323-5','Lassik', '0',4190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lebanese','2123-8','Lebanese', '0',4200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','leech_lake','1136-1','Leech Lake', '0',4210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lenni-lenape','1216-1','Lenni-Lenape', '0',4220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','levelock','1929-9','Levelock', '0',4230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','liberian','2063-6','Liberian', '0',4240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lime','1778-0','Lime', '0',4250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lipan_apache','1014-0','Lipan Apache', '0',4260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','little_shell_chippewa','1137-9','Little Shell Chippewa', '0',4270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lone_pine','1425-8','Lone Pine', '0',4280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','long_island','1325-0','Long Island', '0',4290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','los_coyotes','1048-8','Los Coyotes', '0',4300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lovelock','1426-6','Lovelock', '0',4310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lower_brule_sioux','1618-8','Lower Brule Sioux', '0',4320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lower_elwha','1314-4','Lower Elwha', '0',4330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lower_kalskag','1930-7','Lower Kalskag', '0',4340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lower_muscogee','1199-9','Lower Muscogee', '0',4350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lower_sioux','1619-6','Lower Sioux', '0',4360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lower_skagit','1521-4','Lower Skagit', '0',4370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','luiseno','1331-8','Luiseno', '0',4380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lumbee','1340-9','Lumbee', '0',4390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','lummi','1342-5','Lummi', '0',4400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','machis_lower_creek_indian','1200-5','Machis Lower Creek Indian', '0',4410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','madagascar','2052-9','Madagascar', '0',4420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','maidu','1344-1','Maidu', '0',4430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','makah','1348-2','Makah', '0',4440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','malaysian','2042-0','Malaysian', '0',4450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','maldivian','2049-5','Maldivian', '0',4460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','malheur_paiute','1427-4','Malheur Paiute', '0',4470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','maliseet','1350-8','Maliseet', '0',4480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mandan','1352-4','Mandan', '0',4490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','manley_hot_springs','1780-6','Manley Hot Springs', '0',4500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','manokotak','1931-5','Manokotak', '0',4510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','manzanita','1227-8','Manzanita', '0',4520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mariana_islander','2089-1','Mariana Islander', '0',4530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','maricopa','1728-5','Maricopa', '0',4540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','marshall','1932-3','Marshall', '0',4550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','marshallese','2090-9','Marshallese', '0',4560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','marshantucket_pequot','1454-8','Marshantucket Pequot', '0',4570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','marys_igloo','1889-5',"Mary's Igloo", '0',4580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mashpee_wampanoag','1681-6','Mashpee Wampanoag', '0',4590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','matinecock','1326-8','Matinecock', '0',4600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mattaponi','1354-0','Mattaponi', '0',4610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mattole','1060-3','Mattole', '0',4620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mauneluk_inupiat','1870-5','Mauneluk Inupiat', '0',4630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mcgrath','1779-8','Mcgrath', '0',4640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mdewakanton_sioux','1620-4','Mdewakanton Sioux', '0',4650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mekoryuk','1933-1','Mekoryuk', '0',4660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','melanesian','2100-6','Melanesian', '0',4670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','menominee','1356-5','Menominee', '0',4680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mentasta_lake','1781-4','Mentasta Lake', '0',4690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mesa_grande','1228-6','Mesa Grande', '0',4700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mescalero_apache','1015-7','Mescalero Apache', '0',4710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','metlakatla','1838-2','Metlakatla', '0',4720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mexican_american_indian','1072-8','Mexican American Indian', '0',4730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','miami','1358-1','Miami', '0',4740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','miccosukee','1363-1','Miccosukee', '0',4750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','michigan_ottawa','1413-4','Michigan Ottawa', '0',4760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','micmac','1365-6','Micmac', '0',4770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','micronesian','2085-9','Micronesian', '0',4780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','middle_eastern_north_african','2118-8','Middle Eastern or North African', '0',4790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mille_lacs','1138-7','Mille Lacs', '0',4800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','miniconjou','1621-2','Miniconjou', '0',4810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','minnesota_chippewa','1139-5','Minnesota Chippewa', '0',4820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','minto','1782-2','Minto', '0',4830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mission_indians','1368-0','Mission Indians', '0',4840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mississippi_choctaw','1158-5','Mississippi Choctaw', '0',4850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','missouri_sac_and_fox','1553-7','Missouri Sac and Fox', '0',4860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','miwok','1370-6','Miwok', '0',4870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','moapa','1428-2','Moapa', '0',4880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','modoc','1372-2','Modoc', '0',4890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mohave','1729-3','Mohave', '0',4900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mohawk','1287-2','Mohawk', '0',4910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mohegan','1374-8','Mohegan', '0',4920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','molala','1396-1','Molala', '0',4930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mono','1376-3','Mono', '0',4940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','montauk','1327-6','Montauk', '0',4950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','moor','1237-7','Moor', '0',4960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','morongo','1049-6','Morongo', '0',4970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mountain_maidu','1345-8','Mountain Maidu', '0',4980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mountain_village','1934-9','Mountain Village', '0',4990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','mowa_band_of_choctaw','1159-3','Mowa Band of Choctaw', '0',5000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','muckleshoot','1522-2','Muckleshoot', '0',5010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','munsee','1217-9','Munsee', '0',5020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','naknek','1935-6','Naknek', '0',5030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nambe','1498-5','Nambe', '0',5040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','namibian','2064-4','Namibian', '0',5050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nana_inupiat','1871-3','Nana Inupiat', '0',5060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nansemond','1238-5','Nansemond', '0',5070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nanticoke','1378-9','Nanticoke', '0',5080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','napakiak','1937-2','Napakiak', '0',5090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','napaskiak','1938-0','Napaskiak', '0',5100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','napaumute','1936-4','Napaumute', '0',5110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','narragansett','1380-5','Narragansett', '0',5120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','natchez','1239-3','Natchez', '0',5130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','native_hawaiian','2079-2','Native Hawaiian', '0',5140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nativehawaiian_pacificislander','2076-8','Native Hawaiian or Other Pacific Islander', '0',5150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nausu_waiwash','1240-1','Nausu Waiwash', '0',5160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','navajo','1382-1','Navajo', '0',5170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nebraska_ponca','1475-3','Nebraska Ponca', '0',5180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nebraska_winnebago','1698-0','Nebraska Winnebago', '0',5190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nelson_lagoon','2016-4','Nelson Lagoon', '0',5200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nenana','1783-0','Nenana', '0',5210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nepalese','2050-3','Nepalese', '0',5220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','new_hebrides','2104-8','New Hebrides', '0',5230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','new_stuyahok','1940-6','New Stuyahok', '0',5240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','newhalen','1939-8','Newhalen', '0',5250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','newtok','1941-4','Newtok', '0',5260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nez_perce','1387-0','Nez Perce', '0',5270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nigerian','2065-1','Nigerian', '0',5280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nightmute','1942-2','Nightmute', '0',5290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nikolai','1784-8','Nikolai', '0',5300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nikolski','2017-2','Nikolski', '0',5310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ninilchik','1785-5','Ninilchik', '0',5320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nipmuc','1241-9','Nipmuc', '0',5330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nishinam','1346-6','Nishinam', '0',5340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nisqually','1523-0','Nisqually', '0',5350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','noatak','1872-1','Noatak', '0',5360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nomalaki','1389-6','Nomalaki', '0',5370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nome','1873-9','Nome', '0',5380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nondalton','1786-3','Nondalton', '0',5390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nooksack','1524-8','Nooksack', '0',5400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','noorvik','1874-7','Noorvik', '0',5410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','northern_arapaho','1022-3','Northern Arapaho', '0',5420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','northern_cherokee','1095-9','Northern Cherokee', '0',5430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','northern_cheyenne','1103-1','Northern Cheyenne', '0',5440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','northern_paiute','1429-0','Northern Paiute', '0',5450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','northern_pomo','1469-6','Northern Pomo', '0',5460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','northway','1787-1','Northway', '0',5470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','northwest_tribes','1391-2','Northwest Tribes', '0',5480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nuiqsut','1875-4','Nuiqsut', '0',5490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nulato','1788-9','Nulato', '0',5500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','nunapitchukv','1943-0','Nunapitchukv', '0',5510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oglala_sioux','1622-0','Oglala Sioux', '0',5520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','okinawan','2043-8','Okinawan', '0',5530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_apache','1016-5','Oklahoma Apache', '0',5540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_cado','1042-1','Oklahoma Cado', '0',5550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_choctaw','1160-1','Oklahoma Choctaw', '0',5560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_comanche','1176-7','Oklahoma Comanche', '0',5570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_delaware','1218-7','Oklahoma Delaware', '0',5580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_kickapoo','1306-0','Oklahoma Kickapoo', '0',5590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_kiowa','1310-2','Oklahoma Kiowa', '0',5600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_miami','1361-5','Oklahoma Miami', '0',5610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_ottawa','1414-2','Oklahoma Ottawa', '0',5620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_pawnee','1446-4','Oklahoma Pawnee', '0',5630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_peoria','1451-4','Oklahoma Peoria', '0',5640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_ponca','1476-1','Oklahoma Ponca', '0',5650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_sac_and_fox','1554-5','Oklahoma Sac and Fox', '0',5660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oklahoma_seminole','1571-9','Oklahoma Seminole', '0',5670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','old_harbor','1998-4','Old Harbor', '0',5680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','omaha','1403-5','Omaha', '0',5690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oneida','1288-0','Oneida', '0',5700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','onondaga','1289-8','Onondaga', '0',5710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ontonagon','1140-3','Ontonagon', '0',5720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oregon_athabaskan','1405-0','Oregon Athabaskan', '0',5730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','osage','1407-6','Osage', '0',5740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','oscarville','1944-8','Oscarville', '0',5750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','other_pacific_islander','2500-7','Other Pacific Islander', '0',5760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','other_race','2131-1','Other Race', '0',5770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','otoe-missouria','1409-2','Otoe-Missouria', '0',5780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ottawa','1411-8','Ottawa', '0',5790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ouzinkie','1999-2','Ouzinkie', '0',5800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','owens_valley','1430-8','Owens Valley', '0',5810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','paiute','1416-7','Paiute', '0',5820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pakistani','2044-6','Pakistani', '0',5830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pala','1333-4','Pala', '0',5840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','palauan','2091-7','Palauan', '0',5850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','palestinian','2124-6','Palestinian', '0',5860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pamunkey','1439-9','Pamunkey', '0',5870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','panamint','1592-5','Panamint', '0',5880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','papua_new_guinean','2102-2','Papua New Guinean', '0',5890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pascua_yaqui','1713-7','Pascua Yaqui', '0',5900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','passamaquoddy','1441-5','Passamaquoddy', '0',5910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','paugussett','1242-7','Paugussett', '0',5920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pauloff_harbor','2018-0','Pauloff Harbor', '0',5930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pauma','1334-2','Pauma', '0',5940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pawnee','1445-6','Pawnee', '0',5950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','payson_apache','1017-3','Payson Apache', '0',5960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pechanga','1335-9','Pechanga', '0',5970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pedro_bay','1789-7','Pedro Bay', '0',5980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pelican','1828-3','Pelican', '0',5990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','penobscot','1448-0','Penobscot', '0',6000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','peoria','1450-6','Peoria', '0',6010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pequot','1453-0','Pequot', '0',6020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','perryville','1980-2','Perryville', '0',6030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','petersburg','1829-1','Petersburg', '0',6040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','picuris','1499-3','Picuris', '0',6050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pilot_point','1981-0','Pilot Point', '0',6060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pilot_station','1945-5','Pilot Station', '0',6070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pima','1456-3','Pima', '0',6080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pine_ridge_sioux','1623-8','Pine Ridge Sioux', '0',6090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pipestone_sioux','1624-6','Pipestone Sioux', '0',6100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','piro','1500-8','Piro', '0',6110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','piscataway','1460-5','Piscataway', '0',6120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pit_river','1462-1','Pit River', '0',6130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pitkas_point','1946-3','Pitkas Point', '0',6140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','platinum','1947-1','Platinum', '0',6150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pleasant_point_passamaquoddy','1443-1','Pleasant Point Passamaquoddy', '0',6160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','poarch_band','1201-3','Poarch Band', '0',6170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pocomoke_acohonock','1243-5','Pocomoke Acohonock', '0',6180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pohnpeian','2094-1','Pohnpeian', '0',6190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','point_hope','1876-2','Point Hope', '0',6200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','point_lay','1877-0','Point Lay', '0',6210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pojoaque','1501-6','Pojoaque', '0',6220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pokagon_potawatomi','1483-7','Pokagon Potawatomi', '0',6230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','polish','2115-4','Polish', '0',6240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','polynesian','2078-4','Polynesian', '0',6250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pomo','1464-7','Pomo', '0',6260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ponca','1474-6','Ponca', '0',6270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','poospatuck','1328-4','Poospatuck', '0',6280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','port_gamble_klallam','1315-1','Port Gamble Klallam', '0',6290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','port_graham','1988-5','Port Graham', '0',6300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','port_heiden','1982-8','Port Heiden', '0',6310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','port_lions','2000-8','Port Lions', '0',6320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','port_madison','1525-5','Port Madison', '0',6330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','portage_creek','1948-9','Portage Creek', '0',6340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','potawatomi','1478-7','Potawatomi', '0',6350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','powhatan','1487-8','Powhatan', '0',6360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','prairie_band','1484-5','Prairie Band', '0',6370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','prairie_island_sioux','1625-3','Prairie Island Sioux', '0',6380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','principal_creek_indian_nation','1202-1','Principal Creek Indian Nation', '0',6390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','prior_lake_sioux','1626-1','Prior Lake Sioux', '0',6400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pueblo','1489-4','Pueblo', '0',6410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','puget_sound_salish','1518-0','Puget Sound Salish', '0',6420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','puyallup','1526-3','Puyallup', '0',6430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','pyramid_lake','1431-6','Pyramid Lake', '0',6440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','qagan_toyagungin','2019-8','Qagan Toyagungin', '0',6450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','qawalangin','2020-6','Qawalangin', '0',6460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','quapaw','1541-2','Quapaw', '0',6470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','quechan','1730-1','Quechan', '0',6480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','quileute','1084-3','Quileute', '0',6490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','quinault','1543-8','Quinault', '0',6500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','quinhagak','1949-7','Quinhagak', '0',6510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ramah_navajo','1385-4','Ramah Navajo', '0',6520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','rampart','1790-5','Rampart', '0',6530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','rampough_mountain','1219-5','Rampough Mountain', '0',6540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','rappahannock','1545-3','Rappahannock', '0',6550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','red_cliff_chippewa','1141-1','Red Cliff Chippewa', '0',6560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','red_devil','1950-5','Red Devil', '0',6570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','red_lake_chippewa','1142-9','Red Lake Chippewa', '0',6580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','red_wood','1061-1','Red Wood', '0',6590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','reno-sparks','1547-9','Reno-Sparks', '0',6600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','rocky_boys_chippewa_cree','1151-0',"Rocky Boy's Chippewa Cree", '0',6610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','rosebud_sioux','1627-9','Rosebud Sioux', '0',6620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','round_valley','1549-5','Round Valley', '0',6630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ruby','1791-3','Ruby', '0',6640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ruby_valley','1593-3','Ruby Valley', '0',6650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sac_and_fox','1551-1','Sac and Fox', '0',6660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','saginaw_chippewa','1143-7','Saginaw Chippewa', '0',6670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','saipanese','2095-8','Saipanese', '0',6680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','salamatof','1792-1','Salamatof', '0',6690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','salinan','1556-0','Salinan', '0',6700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','salish','1558-6','Salish', '0',6710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','salish_and_kootenai','1560-2','Salish and Kootenai', '0',6720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','salt_river_pima-maricopa','1458-9','Salt River Pima-Maricopa', '0',6730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','samish','1527-1','Samish', '0',6740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','samoan','2080-0','Samoan', '0',6750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_carlos_apache','1018-1','San Carlos Apache', '0',6760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_felipe','1502-4','San Felipe', '0',6770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_ildefonso','1503-2','San Ildefonso', '0',6780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_juan','1506-5','San Juan', '0',6790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_juan_de','1505-7','San Juan De', '0',6800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_juan_pueblo','1504-0','San Juan Pueblo', '0',6810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_juan_southern_paiute','1432-4','San Juan Southern Paiute', '0',6820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_manual','1574-3','San Manual', '0',6830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_pasqual','1229-4','San Pasqual', '0',6840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','san_xavier','1656-8','San Xavier', '0',6850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sand_hill','1220-3','Sand Hill', '0',6860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sand_point','2023-0','Sand Point', '0',6870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sandia','1507-3','Sandia', '0',6880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sans_arc_sioux','1628-7','Sans Arc Sioux', '0',6890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santa_ana','1508-1','Santa Ana', '0',6900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santa_clara','1509-9','Santa Clara', '0',6910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santa_rosa','1062-9','Santa Rosa', '0',6920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santa_rosa_cahuilla','1050-4','Santa Rosa Cahuilla', '0',6930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santa_ynez','1163-5','Santa Ynez', '0',6940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santa_ysabel','1230-2','Santa Ysabel', '0',6950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santee_sioux','1629-5','Santee Sioux', '0',6960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','santo_domingo','1510-7','Santo Domingo', '0',6970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sauk-suiattle','1528-9','Sauk-Suiattle', '0',6980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sault_ste_marie_chippewa','1145-2','Sault Ste. Marie Chippewa', '0',6990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','savoonga','1893-7','Savoonga', '0',7000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','saxman','1830-9','Saxman', '0',7010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','scammon_bay','1952-1','Scammon Bay', '0',7020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','schaghticoke','1562-8','Schaghticoke', '0',7030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','scott_valley','1564-4','Scott Valley', '0',7040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','scottish','2116-2','Scottish', '0',7050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','scotts_valley','1470-4','Scotts Valley', '0',7060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','selawik','1878-8','Selawik', '0',7070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','seldovia','1793-9','Seldovia', '0',7080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sells','1657-6','Sells', '0',7090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','seminole','1566-9','Seminole', '0',7100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','seneca','1290-6','Seneca', '0',7110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','seneca_nation','1291-4','Seneca Nation', '0',7120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','seneca-cayuga','1292-2','Seneca-Cayuga', '0',7130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','serrano','1573-5','Serrano', '0',7140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','setauket','1329-2','Setauket', '0',7150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shageluk','1795-4','Shageluk', '0',7160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shaktoolik','1879-6','Shaktoolik', '0',7170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shasta','1576-8','Shasta', '0',7180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shawnee','1578-4','Shawnee', '0',7190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sheldons_point','1953-9',"Sheldon's Point", '0',7200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shinnecock','1582-6','Shinnecock', '0',7210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shishmaref','1880-4','Shishmaref', '0',7220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shoalwater_bay','1584-2','Shoalwater Bay', '0',7230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shoshone','1586-7','Shoshone', '0',7240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shoshone_paiute','1602-2','Shoshone Paiute', '0',7250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','shungnak','1881-2','Shungnak', '0',7260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','siberian_eskimo','1891-1','Siberian Eskimo', '0',7270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','siberian_yupik','1894-5','Siberian Yupik', '0',7280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','siletz','1607-1','Siletz', '0',7290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','singaporean','2051-1','Singaporean', '0',7300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sioux','1609-7','Sioux', '0',7310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sisseton_sioux','1631-1','Sisseton Sioux', '0',7320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sisseton-wahpeton','1630-3','Sisseton-Wahpeton', '0',7330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sitka','1831-7','Sitka', '0',7340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','siuslaw','1643-6','Siuslaw', '0',7350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','skokomish','1529-7','Skokomish', '0',7360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','skull_valley','1594-1','Skull Valley', '0',7370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','skykomish','1530-5','Skykomish', '0',7380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','slana','1794-7','Slana', '0',7390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sleetmute','1954-7','Sleetmute', '0',7400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','snohomish','1531-3','Snohomish', '0',7410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','snoqualmie','1532-1','Snoqualmie', '0',7420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','soboba','1336-7','Soboba', '0',7430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sokoagon_chippewa','1146-0','Sokoagon Chippewa', '0',7440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','solomon','1882-0','Solomon', '0',7450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','solomon_islander','2103-0','Solomon Islander', '0',7460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','south_american_indian','1073-6','South American Indian', '0',7470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','south_fork_shoshone','1595-8','South Fork Shoshone', '0',7480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','south_naknek','2024-8','South Naknek', '0',7490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','southeast_alaska','1811-9','Southeast Alaska', '0',7500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','southeastern_indians','1244-3','Southeastern Indians', '0',7510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','southern_arapaho','1023-1','Southern Arapaho', '0',7520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','southern_cheyenne','1104-9','Southern Cheyenne', '0',7530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','southern_paiute','1433-2','Southern Paiute', '0',7540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','spanish_american_indian','1074-4','Spanish American Indian', '0',7550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','spirit_lake_sioux','1632-9','Spirit Lake Sioux', '0',7560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','spokane','1645-1','Spokane', '0',7570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','squaxin_island','1533-9','Squaxin Island', '0',7580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sri_lankan','2045-3','Sri Lankan', '0',7590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','st_croix_chippewa','1144-5','St. Croix Chippewa', '0',7600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','st_george','2021-4','St. George', '0',7610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','st_marys','1963-8',"St. Mary's", '0',7620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','st_michael','1951-3','St. Michael', '0',7630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','st_paul','2022-2','St. Paul', '0',7640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','standing_rock_sioux','1633-7','Standing Rock Sioux', '0',7650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','star_clan_of_muscogee_creeks','1203-9','Star Clan of Muscogee Creeks', '0',7660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','stebbins','1955-4','Stebbins', '0',7670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','steilacoom','1534-7','Steilacoom', '0',7680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','stevens','1796-2','Stevens', '0',7690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','stewart','1647-7','Stewart', '0',7700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','stillaguamish','1535-4','Stillaguamish', '0',7710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','stockbridge','1649-3','Stockbridge', '0',7720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','stony_river','1797-0','Stony River', '0',7730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','stonyford','1471-2','Stonyford', '0',7740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sugpiaq','2002-4','Sugpiaq', '0',7750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sulphur_bank','1472-0','Sulphur Bank', '0',7760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','summit_lake','1434-0','Summit Lake', '0',7770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','suqpigaq','2004-0','Suqpigaq', '0',7780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','suquamish','1536-2','Suquamish', '0',7790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','susanville','1651-9','Susanville', '0',7800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','susquehanock','1245-0','Susquehanock', '0',7810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','swinomish','1537-0','Swinomish', '0',7820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','sycuan','1231-0','Sycuan', '0',7830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','syrian','2125-3','Syrian', '0',7840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','table_bluff','1705-3','Table Bluff', '0',7850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tachi','1719-4','Tachi', '0',7860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tahitian','2081-8','Tahitian', '0',7870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','taiwanese','2035-4','Taiwanese', '0',7880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','takelma','1063-7','Takelma', '0',7890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','takotna','1798-8','Takotna', '0',7900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','talakamish','1397-9','Talakamish', '0',7910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tanacross','1799-6','Tanacross', '0',7920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tanaina','1800-2','Tanaina', '0',7930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tanana','1801-0','Tanana', '0',7940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tanana_chiefs','1802-8','Tanana Chiefs', '0',7950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','taos','1511-5','Taos', '0',7960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tatitlek','1969-5','Tatitlek', '0',7970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tazlina','1803-6','Tazlina', '0',7980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','telida','1804-4','Telida', '0',7990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','teller','1883-8','Teller', '0',8000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','temecula','1338-3','Temecula', '0',8010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','te-moak_western_shoshone','1596-6','Te-Moak Western Shoshone', '0',8020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tenakee_springs','1832-5','Tenakee Springs', '0',8030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tenino','1398-7','Tenino', '0',8040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tesuque','1512-3','Tesuque', '0',8050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tetlin','1805-1','Tetlin', '0',8060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','teton_sioux','1634-5','Teton Sioux', '0',8070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tewa','1513-1','Tewa', '0',8080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','texas_kickapoo','1307-8','Texas Kickapoo', '0',8090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','thai','2046-1','Thai', '0',8100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','thlopthlocco','1204-7','Thlopthlocco', '0',8110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tigua','1514-9','Tigua', '0',8120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tillamook','1399-5','Tillamook', '0',8130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','timbi-sha_shoshone','1597-4','Timbi-Sha Shoshone', '0',8140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tlingit','1833-3','Tlingit', '0',8150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tlingit-haida','1813-5','Tlingit-Haida', '0',8160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tobagoan','2073-5','Tobagoan', '0',8170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','togiak','1956-2','Togiak', '0',8180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tohono_oodham','1653-5',"Tohono O'Odham", '0',8190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tok','1806-9','Tok', '0',8200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tokelauan','2083-4','Tokelauan', '0',8210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','toksook','1957-0','Toksook', '0',8220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tolowa','1659-2','Tolowa', '0',8230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tonawanda_seneca','1293-0','Tonawanda Seneca', '0',8240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tongan','2082-6','Tongan', '0',8250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tonkawa','1661-8','Tonkawa', '0',8260);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','torres-martinez','1051-2','Torres-Martinez', '0',8270);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','trinidadian','2074-3','Trinidadian', '0',8280);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','trinity','1272-4','Trinity', '0',8290);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tsimshian','1837-4','Tsimshian', '0',8300);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tuckabachee','1205-4','Tuckabachee', '0',8310);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tulalip','1538-8','Tulalip', '0',8320);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tule_river','1720-2','Tule River', '0',8330);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tulukskak','1958-8','Tulukskak', '0',8340);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tunica_biloxi','1246-8','Tunica Biloxi', '0',8350);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tuntutuliak','1959-6','Tuntutuliak', '0',8360);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tununak','1960-4','Tununak', '0',8370);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','turtle_mountain','1147-8','Turtle Mountain', '0',8380);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tuscarora','1294-8','Tuscarora', '0',8390);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tuscola','1096-7','Tuscola', '0',8400);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','twenty-nine_palms','1337-5','Twenty-Nine Palms', '0',8410);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','twin_hills','1961-2','Twin Hills', '0',8420);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','two_kettle_sioux','1635-2','Two Kettle Sioux', '0',8430);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tygh','1663-4','Tygh', '0',8440);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','tyonek','1807-7','Tyonek', '0',8450);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ugashik','1970-3','Ugashik', '0',8460);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','uintah_ute','1672-5','Uintah Ute', '0',8470);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','umatilla','1665-9','Umatilla', '0',8480);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','umkumiate','1964-6','Umkumiate', '0',8490);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','umpqua','1667-5','Umpqua', '0',8500);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','unalakleet','1884-6','Unalakleet', '0',8510);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','unalaska','2025-5','Unalaska', '0',8520);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','unangan_aleut','2006-5','Unangan Aleut', '0',8530);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','unga','2026-3','Unga', '0',8540);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','united_ketowah_band_of_cheroke','1097-5','United Keetowah Band of Cherokee', '0',8550);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','upper_chinook','1118-9','Upper Chinook', '0',8560);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','upper_sioux','1636-0','Upper Sioux', '0',8570);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','upper_skagit','1539-6','Upper Skagit', '0',8580);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ute','1670-9','Ute', '0',8590);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','ute_mountain_ute','1673-3','Ute Mountain Ute', '0',8600);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','utu_utu_gwaitu_paiute','1435-7','Utu Utu Gwaitu Paiute', '0',8610);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','venetie','1808-5','Venetie', '0',8620);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','vietnamese','2047-9','Vietnamese', '0',8630);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','waccamaw-siousan','1247-6','Waccamaw-Siousan', '0',8640);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wahpekute_sioux','1637-8','Wahpekute Sioux', '0',8650);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wahpeton_sioux','1638-6','Wahpeton Sioux', '0',8660);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wailaki','1675-8','Wailaki', '0',8670);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wainwright','1885-3','Wainwright', '0',8680);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wakiakum_chinook','1119-7','Wakiakum Chinook', '0',8690);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wales','1886-1','Wales', '0',8700);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','walker_river','1436-5','Walker River', '0',8710);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','walla-walla','1677-4','Walla-Walla', '0',8720);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wampanoag','1679-0','Wampanoag', '0',8730);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wappo','1064-5','Wappo', '0',8740);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','warm_springs','1683-2','Warm Springs', '0',8750);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wascopum','1685-7','Wascopum', '0',8760);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','washakie','1598-2','Washakie', '0',8770);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','washoe','1687-3','Washoe', '0',8780);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wazhaza_sioux','1639-4','Wazhaza Sioux', '0',8790);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wenatchee','1400-1','Wenatchee', '0',8800);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','west_indian','2075-0','West Indian', '0',8810);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','western_cherokee','1098-3','Western Cherokee', '0',8820);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','western_chickahominy','1110-6','Western Chickahominy', '0',8830);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','whilkut','1273-2','Whilkut', '0',8840);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','white','2106-3','White', '0',8850);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','white_earth','1148-6','White Earth', '0',8860);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','white_mountain','1887-9','White Mountain', '0',8870);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','white_mountain_apache','1019-9','White Mountain Apache', '0',8880);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','white_mountain_inupiat','1888-7','White Mountain Inupiat', '0',8890);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wichita','1692-3','Wichita', '0',8900);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wicomico','1248-4','Wicomico', '0',8910);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','willapa_chinook','1120-5','Willapa Chinook', '0',8920);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wind_river','1694-9','Wind River', '0',8930);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wind_river_arapaho','1024-9','Wind River Arapaho', '0',8940);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wind_river_shoshone','1599-0','Wind River Shoshone', '0',8950);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','winnebago','1696-4','Winnebago', '0',8960);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','winnemucca','1700-4','Winnemucca', '0',8970);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wintun','1702-0','Wintun', '0',8980);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wisconsin_potawatomi','1485-2','Wisconsin Potawatomi', '0',8990);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wiseman','1809-3','Wiseman', '0',9000);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wishram','1121-3','Wishram', '0',9010);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wiyot','1704-6','Wiyot', '0',9020);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wrangell','1834-1','Wrangell', '0',9030);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','wyandotte','1295-5','Wyandotte', '0',9040);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yahooskin','1401-9','Yahooskin', '0',9050);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yakama','1707-9','Yakama', '0',9060);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yakama_cowlitz','1709-5','Yakama Cowlitz', '0',9070);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yakutat','1835-8','Yakutat', '0',9080);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yana','1065-2','Yana', '0',9090);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yankton_sioux','1640-2','Yankton Sioux', '0',9100);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yanktonai_sioux','1641-0','Yanktonai Sioux', '0',9110);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yapese','2098-2','Yapese', '0',9120);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yaqui','1711-1','Yaqui', '0',9130);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yavapai','1731-9','Yavapai', '0',9140);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yavapai_apache','1715-2','Yavapai Apache', '0',9150);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yerington_paiute','1437-3','Yerington Paiute', '0',9160);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yokuts','1717-8','Yokuts', '0',9170);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yomba','1600-6','Yomba', '0',9180);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yuchi','1722-8','Yuchi', '0',9190);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yuki','1066-0','Yuki', '0',9200);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yuman','1724-4','Yuman', '0',9210);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yupik_eskimo','1896-0','Yupik Eskimo', '0',9220);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','yurok','1732-7','Yurok', '0',9230);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','zairean','2066-9','Zairean', '0',9240);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','zia','1515-6','Zia', '0',9250);
INSERT INTO list_options (list_id, option_id, notes, title, activity, seq) VALUES ('race','zuni','1516-4','Zuni', '0',9260);
#EndIf

#IfMissingColumn lists severity_al
ALTER TABLE lists ADD COLUMN severity_al VARCHAR(50) NULL;
#EndIf

#IfNotRow list_options list_id severity_ccda
INSERT INTO list_options (list_id, option_id, title) VALUES ('lists','severity_ccda','Severity');
INSERT INTO list_options (list_id, option_id, title, codes, seq) values ('severity_ccda','fatal','Fatal','SNOMED-CT:399166001','1');
INSERT INTO list_options (list_id, option_id, title, codes, seq) values ('severity_ccda','life_threatening_severity','Life threatening severity','SNOMED-CT:442452003','2');
INSERT INTO list_options (list_id, option_id, title, codes, seq) values ('severity_ccda','mild','Mild','SNOMED-CT:255604002','3');
INSERT INTO list_options (list_id, option_id, title, codes, seq) values ('severity_ccda','mild_to_moderate','Mild to moderate','SNOMED-CT:371923003','4');
INSERT INTO list_options (list_id, option_id, title, codes, seq) values ('severity_ccda','moderate','Moderate','SNOMED-CT:6736007','5');
INSERT INTO list_options (list_id, option_id, title, codes, seq) values ('severity_ccda','moderate_to_severe','Moderate to severe','SNOMED-CT:371924009','6');
INSERT INTO list_options (list_id, option_id, title, codes, seq) values ('severity_ccda','severe','Severe','SNOMED-CT:24484000','7');
#EndIf

#IfRow2D list_options list_id drug_route option_id 1
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '1';
#EndIf

#IfRow2D list_options list_id drug_route option_id 2
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '2';
#EndIf

#IfRow2D list_options list_id drug_route option_id 3
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '3';
#EndIf

#IfRow2D list_options list_id drug_route option_id 4
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '4';
#EndIf

#IfRow2D list_options list_id drug_route option_id 5
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '5';
#EndIf

#IfRow2D list_options list_id drug_route option_id 6
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '6';
#EndIf

#IfRow2D list_options list_id drug_route option_id 7
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '7';
#EndIf

#IfRow2D list_options list_id drug_route option_id 8
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '8';
#EndIf

#IfRow2D list_options list_id drug_route option_id 9
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '9';
#EndIf

#IfRow2D list_options list_id drug_route option_id 10
UPDATE list_options SET list_options.notes = 'IM' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '10';
#EndIf

#IfRow2D list_options list_id drug_route option_id 11
UPDATE list_options SET list_options.notes = 'IV' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '11';
#EndIf

#IfRow2D list_options list_id drug_route option_id 12
UPDATE list_options SET list_options.notes = 'NS' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '12';
#EndIf

#IfRow2D list_options list_id drug_route option_id 13
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '13';
#EndIf

#IfRow2D list_options list_id drug_route option_id 14
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '14';
#EndIf

#IfRow2D list_options list_id drug_route option_id 15
UPDATE list_options SET list_options.notes = 'OTH' WHERE list_options.list_id = 'drug_route' AND list_options.option_id = '15';
#EndIf

#IfNotRow2Dx2 list_options list_id drug_route option_id intradermal title Intradermal
INSERT INTO list_options ( list_id, option_id, title, seq, is_default, notes ) VALUES ('drug_route', 'intradermal', 'Intradermal', 16, 0, 'ID');
#EndIf

#IfNotRow2Dx2 list_options list_id drug_route option_id oral title Oral
INSERT INTO list_options( list_id, option_id, title, seq, is_default, notes ) VALUES ('drug_route', 'oral', 'Oral', 17, 0, 'PO');
#EndIf

#IfNotRow2Dx2 list_options list_id drug_route option_id other title Other/Miscellaneous
INSERT INTO list_options ( list_id, option_id, title, seq, is_default, notes ) VALUES ('drug_route', 'other', 'Other/Miscellaneous', 17, 0, 'OTH');
#EndIf

#IfNotRow2Dx2 list_options list_id drug_route option_id subcutaneous title Subcutaneous
INSERT INTO list_options ( list_id, option_id, title, seq, is_default, notes ) VALUES ('drug_route', 'subcutaneous', 'Subcutaneous', 19, 0, 'SC');
#EndIf

#IfNotRow2Dx2 list_options list_id drug_route option_id transdermal title Transdermal
INSERT INTO list_options ( list_id, option_id, title, seq, is_default, notes ) VALUES ('drug_route', 'transdermal', 'Transdermal', 20, 0, 'TD');
#EndIf

#IfNotRow list_options list_id physician_type
INSERT INTO list_options (list_id,option_id,title) VALUES ('lists','physician_type','Physician Type');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','attending_physician_occupation','SNOMED-CT:405279007','Attending physician', '1');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','audiological_physician_occupation','SNOMED-CT:310172001','Audiological physician', '2');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','chest_physician_occupation','SNOMED-CT:309345004','Chest physician', '3');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','community_health_physician_occupation','SNOMED-CT:23278007','Community health physician', '4');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','consultant_physician_occupation','SNOMED-CT:158967008','Consultant physician', '5');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','general_physician_occupation','SNOMED-CT:59058001','General physician', '6');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','genitourinary_medicine_physician_occupation','SNOMED-CT:309358003','Genitourinary medicine physician', '7');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','occupational_physician_occupation','SNOMED-CT:158973009','Occupational physician', '8');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','palliative_care_physician_occupation','SNOMED-CT:309359006','Palliative care physician', '9');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','physician_occupation','SNOMED-CT:309343006','Physician', '10');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','public_health_physician_occupation','SNOMED-CT:56466003','Public health physician', '11');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','rehabilitation_physician_occupation','SNOMED-CT:309360001','Rehabilitation physician', '12');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','resident_physician_occupation','SNOMED-CT:405277009','Resident physician', '13');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','specialized_physician_occupation','SNOMED-CT:69280009','Specialized physician', '14');
INSERT INTO list_options (list_id, option_id, codes,title, seq) VALUES ('physician_type','thoracic_physician_occupation','SNOMED-CT:309346003','Thoracic physician', '15');
#EndIf

#IfNotRow3D list_options list_id marital option_id married notes M
update list_options set notes = 'M' where list_id = 'marital' and option_id = 'married';
#EndIf

#IfNotRow3D list_options list_id marital option_id single notes S
update list_options set notes = 'S' where list_id = 'marital' and option_id = 'single';
#EndIf

#IfNotRow3D list_options list_id marital option_id divorced notes D
update list_options set notes = 'D' where list_id = 'marital' and option_id = 'divorced';
#EndIf

#IfNotRow3D list_options list_id marital option_id widowed notes W
update list_options set notes = 'W' where list_id = 'marital' and option_id = 'widowed';
#EndIf

#IfNotRow3D list_options list_id marital option_id separated notes L
update list_options set notes = 'L' where list_id = 'marital' and option_id = 'separated';
#EndIf

#IfNotRow3D list_options list_id marital seq 6 notes T
update list_options set notes = 'T' where list_id = 'marital' and option_id = 'domestic partner';
#EndIf

#IfMissingColumn users physician_type
ALTER TABLE users ADD COLUMN physician_type VARCHAR(50);
#EndIf

#IfMissingColumn facility facility_code
ALTER TABLE facility ADD COLUMN facility_code VARCHAR(20);
#EndIf

#IfMissingColumn documents audit_master_approval_status
ALTER TABLE documents ADD COLUMN audit_master_approval_status TINYINT DEFAULT 1 NOT NULL COMMENT 'approval_status from audit_master table';
#EndIf

#IfMissingColumn documents audit_master_id
ALTER TABLE documents ADD COLUMN  audit_master_id int(11) default NULL;
#EndIf

#IfMissingColumn lists severity_al
ALTER TABLE `lists` ADD `severity_al` VARCHAR( 50 ) NULL;
#EndIf

#IfRow2D layout_options field_id religion form_id DEM
UPDATE layout_options SET list_id='religious_affiliation' WHERE field_id='religion' AND form_id='DEM';
#EndIf

#IfNotRow2D list_options list_id abook_type option_id ccda
INSERT INTO list_options (list_id, option_id, title) VALUES ('abook_type', 'ccda', 'Care Coordination');
#EndIf

#IfMissingColumn patient_data religion
SET @group_name = (SELECT group_name FROM layout_options WHERE field_id='ethnicity' AND form_id='DEM');
SET @seq = (SELECT MAX(seq) FROM layout_options WHERE group_name=@group_name AND form_id='DEM');
INSERT INTO `layout_options` (`form_id`, `field_id`, `group_name`, `title`, `seq`, `data_type`, `uor`, `fld_length`, `max_length`, `list_id`, `titlecols`, `datacols`, `default_value`, `edit_options`, `description`) VALUES ('DEM', 'religion', @group_name, 'Religion', @seq+1, 1, 1, 0, 0, 'religious_affiliation', 1, 1, '', '', 'Patient Religion' ) ;
ALTER TABLE patient_data ADD COLUMN religion TEXT NOT NULL;
#EndIf

#IfNotTable list_codes
CREATE TABLE `list_codes` (
  `list_code_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `list_id` int(11) NOT NULL,
  `list_code` varchar(255) DEFAULT NULL,
  `icd9_code` varchar(255) DEFAULT NULL,
  `icd10_code` varchar(255) DEFAULT NULL,
  `snomed_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`list_code_id`)
) ENGINE=InnoDB;
#EndIf

#IfMissingColumn prescriptions erx_diagnosis
ALTER TABLE `prescriptions` ADD COLUMN `erx_diagnosis` VARCHAR(10) NULL;
#EndIf

#IfMissingColumn prescriptions erx_diagnosis_name
ALTER TABLE `prescriptions` ADD COLUMN `erx_diagnosis_name` TEXT NULL;
#EndIf

#IfNotTable procedure_subtest_result
CREATE TABLE `procedure_subtest_result` (
  `procedure_subtest_result_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `procedure_report_id` bigint(20) NOT NULL COMMENT 'references procedure_report.procedure_report_id',
  `subtest_code` varchar(30) NOT NULL DEFAULT '',
  `subtest_desc` varchar(255) NOT NULL DEFAULT '',
  `result_value` varchar(255) NOT NULL DEFAULT '',
  `units` varchar(30) NOT NULL DEFAULT '',
  `range` varchar(255) NOT NULL DEFAULT '',
  `abnormal_flag` varchar(31) NOT NULL DEFAULT '' COMMENT 'no,yes,high,low',
  `result_status` varchar(31) NOT NULL DEFAULT '' COMMENT 'preliminary, cannot be done, final, corrected, incompete...etc.',
  `result_time` datetime DEFAULT NULL,
  `providers_id` bigint(20) NOT NULL DEFAULT '0',
  `comments` text NOT NULL COMMENT 'comments of subtest',
  `order_title` varchar(255) DEFAULT NULL,
  `code_suffix` varchar(255) DEFAULT NULL,
  `profile_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`procedure_subtest_result_id`),
  KEY `procedure_report_id` (`procedure_report_id`)
) ENGINE=InnoDB;
#EndIf

#IfMissingColumn procedure_result order_title
ALTER TABLE procedure_result
  ADD COLUMN `order_title`    varchar(255) DEFAULT NULL,
  ADD COLUMN `code_suffix`     varchar(255) DEFAULT NULL,
  ADD COLUMN `profile_title`  varchar(255) DEFAULT NULL;
#EndIf

#IfNotRow categories name CCDA
INSERT INTO categories (id, name, value, parent, lft, rght) select (select MAX(id) from categories) + 1, 'CCDA', '', 1, rght, rght + 1 from categories where name = 'Categories';
UPDATE categories SET rght = rght + 2 WHERE name = 'Categories';
UPDATE categories_seq SET id = (select MAX(id) from categories);
#Endif
#IfNotColumnType billing units int(11)
  ALTER TABLE `billing` CHANGE `units` `units` int(11) DEFAULT NULL;
#EndIf

#IfNotColumnType codes units int(11)
  ALTER TABLE `codes`   CHANGE `units` `units` int(11) DEFAULT NULL;
#EndIf

#IfNotRow2D list_options list_id language option_id declne_to_specfy
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'declne_to_specfy', 'Declined To Specify', 0, 0, 0);
#EndIf

#IfNotRow2D list_options list_id ethrace option_id declne_to_specfy
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('ethrace', 'declne_to_specfy', 'Declined To Specify', 0, 0, 0);
#EndIf

#IfNotRow2D list_options list_id race option_id declne_to_specfy
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('race', 'declne_to_specfy', 'Declined To Specify', 0, 0, 0);
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id abkhazian title Abkhazian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'abkhazian', 'Abkhazian', 10, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id abkhazian
UPDATE `list_options` SET `notes` = 'abk' WHERE `option_id` = 'abkhazian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Abkhazian
UPDATE `list_options` SET `notes` = 'abk' WHERE `title` = 'Abkhazian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id afar title Afar
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'afar', 'Afar', 20, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id afar
UPDATE `list_options` SET `notes` = 'aar' WHERE `option_id` = 'afar' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Afar
UPDATE `list_options` SET `notes` = 'aar' WHERE `title` = 'Afar' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id afrikaans title Afrikaans
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'afrikaans', 'Afrikaans', 30, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id afrikaans
UPDATE `list_options` SET `notes` = 'afr' WHERE `option_id` = 'afrikaans' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Afrikaans
UPDATE `list_options` SET `notes` = 'afr' WHERE `title` = 'Afrikaans' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id akan title Akan
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'akan', 'Akan', 40, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id akan
UPDATE `list_options` SET `notes` = 'aka' WHERE `option_id` = 'akan' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Akan
UPDATE `list_options` SET `notes` = 'aka' WHERE `title` = 'Akan' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id albanian title Albanian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'albanian', 'Albanian', 50, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id albanian
UPDATE `list_options` SET `notes` = 'alb(B)|sqi(T)' WHERE `option_id` = 'albanian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Albanian
UPDATE `list_options` SET `notes` = 'alb(B)|sqi(T)' WHERE `title` = 'Albanian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id amharic title Amharic
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'amharic', 'Amharic', 60, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id amharic
UPDATE `list_options` SET `notes` = 'amh' WHERE `option_id` = 'amharic' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Amharic
UPDATE `list_options` SET `notes` = 'amh' WHERE `title` = 'Amharic' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id arabic title Arabic
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'arabic', 'Arabic', 70, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id arabic
UPDATE `list_options` SET `notes` = 'ara' WHERE `option_id` = 'arabic' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Arabic
UPDATE `list_options` SET `notes` = 'ara' WHERE `title` = 'Arabic' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id aragonese title Aragonese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'aragonese', 'Aragonese', 80, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id aragonese
UPDATE `list_options` SET `notes` = 'arg' WHERE `option_id` = 'aragonese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Aragonese
UPDATE `list_options` SET `notes` = 'arg' WHERE `title` = 'Aragonese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id armenian title Armenian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'armenian', 'Armenian', 90, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id armenian
UPDATE `list_options` SET `notes` = 'arm(B)|hye(T)' WHERE `option_id` = 'armenian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Armenian
UPDATE `list_options` SET `notes` = 'arm(B)|hye(T)' WHERE `title` = 'Armenian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 10 option_id armenian
UPDATE `list_options` SET `seq` = 90 WHERE `option_id` = 'armenian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 10 title Armenian
UPDATE `list_options` SET `seq` = 90 WHERE `title` = 'Armenian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id assamese title Assamese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'assamese', 'Assamese', 100, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id assamese
UPDATE `list_options` SET `notes` = 'asm' WHERE `option_id` = 'assamese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Assamese
UPDATE `list_options` SET `notes` = 'asm' WHERE `title` = 'Assamese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id avaric title Avaric
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'avaric', 'Avaric', 110, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id avaric
UPDATE `list_options` SET `notes` = 'ava' WHERE `option_id` = 'avaric' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Avaric
UPDATE `list_options` SET `notes` = 'ava' WHERE `title` = 'Avaric' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id avestan title Avestan
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'avestan', 'Avestan', 120, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id avestan
UPDATE `list_options` SET `notes` = 'ave' WHERE `option_id` = 'avestan' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Avestan
UPDATE `list_options` SET `notes` = 'ave' WHERE `title` = 'Avestan' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id aymara title Aymara
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'aymara', 'Aymara', 130, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id aymara
UPDATE `list_options` SET `notes` = 'aym' WHERE `option_id` = 'aymara' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Aymara
UPDATE `list_options` SET `notes` = 'aym' WHERE `title` = 'Aymara' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id azerbaijani title Azerbaijani
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'azerbaijani', 'Azerbaijani', 140, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id azerbaijani
UPDATE `list_options` SET `notes` = 'aze' WHERE `option_id` = 'azerbaijani' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Azerbaijani
UPDATE `list_options` SET `notes` = 'aze' WHERE `title` = 'Azerbaijani' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bambara title Bambara
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bambara', 'Bambara', 150, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bambara
UPDATE `list_options` SET `notes` = 'bam' WHERE `option_id` = 'bambara' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bambara
UPDATE `list_options` SET `notes` = 'bam' WHERE `title` = 'Bambara' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bashkir title Bashkir
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bashkir', 'Bashkir', 160, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bashkir
UPDATE `list_options` SET `notes` = 'bak' WHERE `option_id` = 'bashkir' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bashkir
UPDATE `list_options` SET `notes` = 'bak' WHERE `title` = 'Bashkir' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id basque title Basque
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'basque', 'Basque', 170, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id basque
UPDATE `list_options` SET `notes` = 'baq(B)|eus(T)' WHERE `option_id` = 'basque' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Basque
UPDATE `list_options` SET `notes` = 'baq(B)|eus(T)' WHERE `title` = 'Basque' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id belarusian title Belarusian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'belarusian', 'Belarusian', 180, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id belarusian
UPDATE `list_options` SET `notes` = 'bel' WHERE `option_id` = 'belarusian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Belarusian
UPDATE `list_options` SET `notes` = 'bel' WHERE `title` = 'Belarusian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bengali title Bengali
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bengali', 'Bengali', 190, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bengali
UPDATE `list_options` SET `notes` = 'ben' WHERE `option_id` = 'bengali' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bengali
UPDATE `list_options` SET `notes` = 'ben' WHERE `title` = 'Bengali' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bihari_languages title Bihari languages
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bihari_languages', 'Bihari languages', 200, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bihari_languages
UPDATE `list_options` SET `notes` = 'bih' WHERE `option_id` = 'bihari_languages' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bihari languages
UPDATE `list_options` SET `notes` = 'bih' WHERE `title` = 'Bihari languages' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bislama title Bislama
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bislama', 'Bislama', 210, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bislama
UPDATE `list_options` SET `notes` = 'bis' WHERE `option_id` = 'bislama' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bislama
UPDATE `list_options` SET `notes` = 'bis' WHERE `title` = 'Bislama' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bokmal_norwegian_norwegian_bok title Bokmål, Norwegian; Norwegian Bokmål
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bokmal_norwegian_norwegian_bok', 'Bokmål, Norwegian; Norwegian Bokmål', 220, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bokmal_norwegian_norwegian_bok
UPDATE `list_options` SET `notes` = 'nob' WHERE `option_id` = 'bokmal_norwegian_norwegian_bok' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bokmål, Norwegian; Norwegian Bokmål
UPDATE `list_options` SET `notes` = 'nob' WHERE `title` = 'Bokmål, Norwegian; Norwegian Bokmål' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bosnian title Bosnian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bosnian', 'Bosnian', 230, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bosnian
UPDATE `list_options` SET `notes` = 'bos' WHERE `option_id` = 'bosnian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bosnian
UPDATE `list_options` SET `notes` = 'bos' WHERE `title` = 'Bosnian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id breton title Breton
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'breton', 'Breton', 240, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id breton
UPDATE `list_options` SET `notes` = 'bre' WHERE `option_id` = 'breton' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Breton
UPDATE `list_options` SET `notes` = 'bre' WHERE `title` = 'Breton' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id bulgarian title Bulgarian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'bulgarian', 'Bulgarian', 250, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id bulgarian
UPDATE `list_options` SET `notes` = 'bul' WHERE `option_id` = 'bulgarian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Bulgarian
UPDATE `list_options` SET `notes` = 'bul' WHERE `title` = 'Bulgarian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id burmese title Burmese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'burmese', 'Burmese', 260, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id burmese
UPDATE `list_options` SET `notes` = 'bur(B)|mya(T)' WHERE `option_id` = 'burmese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Burmese
UPDATE `list_options` SET `notes` = 'bur(B)|mya(T)' WHERE `title` = 'Burmese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id catalan_valencian title Catalan; Valencian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, option_value ) VALUES ('language', 'catalan_valencian', 'Catalan; Valencian', 270, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id catalan_valencian
UPDATE `list_options` SET `notes` = 'cat' WHERE `option_id` = 'catalan_valencian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Catalan; Valencian
UPDATE `list_options` SET `notes` = 'cat' WHERE `title` = 'Catalan; Valencian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id central_khmer title Central Khmer
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'central_khmer', 'Central Khmer', 280, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id central_khmer
UPDATE `list_options` SET `notes` = 'khm' WHERE `option_id` = 'central_khmer' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Central Khmer
UPDATE `list_options` SET `notes` = 'khm' WHERE `title` = 'Central Khmer' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id chamorro title Chamorro
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'chamorro', 'Chamorro', 290, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id chamorro
UPDATE `list_options` SET `notes` = 'cha' WHERE `option_id` = 'chamorro' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Chamorro
UPDATE `list_options` SET `notes` = 'cha' WHERE `title` = 'Chamorro' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id chechen title Chechen
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'chechen', 'Chechen', 300, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id chechen
UPDATE `list_options` SET `notes` = 'che' WHERE `option_id` = 'chechen' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Chechen
UPDATE `list_options` SET `notes` = 'che' WHERE `title` = 'Chechen' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id chichewa_chewa_nyanja title Chichewa; Chewa; Nyanja
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'chichewa_chewa_nyanja', 'Chichewa; Chewa; Nyanja', 310, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id chichewa_chewa_nyanja
UPDATE `list_options` SET `notes` = 'nya' WHERE `option_id` = 'chichewa_chewa_nyanja' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Chichewa; Chewa; Nyanja
UPDATE `list_options` SET `notes` = 'nya' WHERE `title` = 'Chichewa; Chewa; Nyanja' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id chinese title Chinese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'chinese', 'Chinese', 320, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id chinese
UPDATE `list_options` SET `notes` = 'chi(B)|zho(T)' WHERE `option_id` = 'chinese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Chinese
UPDATE `list_options` SET `notes` = 'chi(B)|zho(T)' WHERE `title` = 'Chinese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 20 option_id chinese
UPDATE `list_options` SET `seq` = 320 WHERE `option_id` = 'chinese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 20  title Chinese
UPDATE `list_options` SET `seq` = 320 WHERE `title` = 'Chinese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id church_slavic_old_slavonic_chu title Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'church_slavic_old_slavonic_chu', 'Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic', 330, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id church_slavic_old_slavonic_chu
UPDATE `list_options` SET `notes` = 'chu' WHERE `option_id` = 'church_slavic_old_slavonic_chu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic
UPDATE `list_options` SET `notes` = 'chu' WHERE `title` = 'Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id chuvash title Chuvash
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'chuvash', 'Chuvash', 340, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id chuvash
UPDATE `list_options` SET `notes` = 'chv' WHERE `option_id` = 'chuvash' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Chuvash
UPDATE `list_options` SET `notes` = 'chv' WHERE `title` = 'Chuvash' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id cornish title Cornish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'cornish', 'Cornish', 350, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id cornish
UPDATE `list_options` SET `notes` = 'cor' WHERE `option_id` = 'cornish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Cornish
UPDATE `list_options` SET `notes` = 'cor' WHERE `title` = 'Cornish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id corsican title Corsican
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'corsican', 'Corsican', 360, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id corsican
UPDATE `list_options` SET `notes` = 'cos' WHERE `option_id` = 'corsican' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Corsican
UPDATE `list_options` SET `notes` = 'cos' WHERE `title` = 'Corsican' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id cree title Cree
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'cree', 'Cree', 370, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id cree
UPDATE `list_options` SET `notes` = 'cre' WHERE `option_id` = 'cree' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Cree
UPDATE `list_options` SET `notes` = 'cre' WHERE `title` = 'Cree' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id croatian title Croatian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'croatian', 'Croatian', 380, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id croatian
UPDATE `list_options` SET `notes` = 'hrv' WHERE `option_id` = 'croatian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Croatian
UPDATE `list_options` SET `notes` = 'hrv' WHERE `title` = 'Croatian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id czech title Czech
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'czech', 'Czech', 390, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id czech
UPDATE `list_options` SET `notes` = 'cze(B)|ces(T)' WHERE `option_id` = 'czech' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Czech
UPDATE `list_options` SET `notes` = 'cze(B)|ces(T)' WHERE `title` = 'Czech' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id danish title Danish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'danish', 'Danish', 400, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id danish
UPDATE `list_options` SET `notes` = 'dan' WHERE `option_id` = 'danish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Danish
UPDATE `list_options` SET `notes` = 'dan' WHERE `title` = 'Danish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 30 option_id danish
UPDATE `list_options` SET `seq` = 400 WHERE `option_id` = 'danish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 30 title Danish
UPDATE `list_options` SET `seq` = 400 WHERE `title` = 'Danish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 40 option_id deaf
UPDATE `list_options` SET `seq` = 405 WHERE `option_id` = 'deaf' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 40 title Deaf
UPDATE `list_options` SET `seq` = 405 WHERE `title` = 'Deaf' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id divehi_dhivehi_maldivian title Divehi; Dhivehi; Maldivian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'divehi_dhivehi_maldivian', 'Divehi; Dhivehi; Maldivian', 410, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id divehi_dhivehi_maldivian
UPDATE `list_options` SET `notes` = 'div' WHERE `option_id` = 'divehi_dhivehi_maldivian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Divehi; Dhivehi; Maldivian
UPDATE `list_options` SET `notes` = 'div' WHERE `title` = 'Divehi; Dhivehi; Maldivian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id dutch_flemish title Dutch; Flemish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'dutch_flemish', 'Dutch; Flemish', 420, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id dutch_flemish
UPDATE `list_options` SET `notes` = 'dut(B)|nld(T)' WHERE `option_id` = 'dutch_flemish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Dutch; Flemish
UPDATE `list_options` SET `notes` = 'dut(B)|nld(T)' WHERE `title` = 'Dutch; Flemish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id dzongkha title Dzongkha
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'dzongkha', 'Dzongkha', 430, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id dzongkha
UPDATE `list_options` SET `notes` = 'dzo' WHERE `option_id` = 'dzongkha' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Dzongkha
UPDATE `list_options` SET `notes` = 'dzo' WHERE `title` = 'Dzongkha' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id English title English
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'English', 'English', 440, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id English
UPDATE `list_options` SET `notes` = 'eng' WHERE `option_id` = 'English' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title English
UPDATE `list_options` SET `notes` = 'eng' WHERE `title` = 'English' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 50 option_id English
UPDATE `list_options` SET `seq` = 440 WHERE `option_id` = 'English' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 50 title English
UPDATE `list_options` SET `seq` = 440 WHERE `title` = 'English' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id esperanto title Esperanto
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'esperanto', 'Esperanto', 450, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id esperanto
UPDATE `list_options` SET `notes` = 'epo' WHERE `option_id` = 'esperanto' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Esperanto
UPDATE `list_options` SET `notes` = 'epo' WHERE `title` = 'Esperanto' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id estonian title Estonian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'estonian', 'Estonian', 460, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id estonian
UPDATE `list_options` SET `notes` = 'est' WHERE `option_id` = 'estonian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Estonian
UPDATE `list_options` SET `notes` = 'est' WHERE `title` = 'Estonian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ewe title Ewe
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ewe', 'Ewe', 470, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ewe
UPDATE `list_options` SET `notes` = 'ewe' WHERE `option_id` = 'ewe' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ewe
UPDATE `list_options` SET `notes` = 'ewe' WHERE `title` = 'Ewe' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id faroese title Faroese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'faroese', 'Faroese', 480, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id faroese
UPDATE `list_options` SET `notes` = 'fao' WHERE `option_id` = 'faroese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Faroese
UPDATE `list_options` SET `notes` = 'fao' WHERE `title` = 'Faroese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 60 option_id farsi
UPDATE `list_options` SET `seq` = 485 WHERE `option_id` = 'farsi' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 60 title Farsi
UPDATE `list_options` SET `seq` = 485 WHERE `title` = 'Farsi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id fijian title Fijian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'fijian', 'Fijian', 490, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id fijian
UPDATE `list_options` SET `notes` = 'fij' WHERE `option_id` = 'fijian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Fijian
UPDATE `list_options` SET `notes` = 'fij' WHERE `title` = 'Fijian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id finnish title Finnish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'finnish', 'Finnish', 500, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id finnish
UPDATE `list_options` SET `notes` = 'fin' WHERE `option_id` = 'finnish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Finnish
UPDATE `list_options` SET `notes` = 'fin' WHERE `title` = 'Finnish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id french title French
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'french', 'French', 510, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id french
UPDATE `list_options` SET `notes` = 'fre(B)|fra(T)' WHERE `option_id` = 'french' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title French
UPDATE `list_options` SET `notes` = 'fre(B)|fra(T)' WHERE `title` = 'French' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 70 option_id french
UPDATE `list_options` SET `seq` = 510 WHERE `option_id` = 'french' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 70 title French
UPDATE `list_options` SET `seq` = 510 WHERE `title` = 'French' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id fulah title Fulah
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'fulah', 'Fulah', 520, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id fulah
UPDATE `list_options` SET `notes` = 'ful' WHERE `option_id` = 'fulah' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Fulah
UPDATE `list_options` SET `notes` = 'ful' WHERE `title` = 'Fulah' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id gaelic_scottish_gaelic title Gaelic; Scottish Gaelic
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'gaelic_scottish_gaelic', 'Gaelic; Scottish Gaelic', 530, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id gaelic_scottish_gaelic
UPDATE `list_options` SET `notes` = 'gla' WHERE `option_id` = 'gaelic_scottish_gaelic' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Gaelic; Scottish Gaelic
UPDATE `list_options` SET `notes` = 'gla' WHERE `title` = 'Gaelic; Scottish Gaelic' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id galician title Galician
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'galician', 'Galician', 540, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id galician
UPDATE `list_options` SET `notes` = 'glg' WHERE `option_id` = 'galician' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Galician
UPDATE `list_options` SET `notes` = 'glg' WHERE `title` = 'Galician' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ganda title Ganda
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ganda', 'Ganda', 550, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ganda
UPDATE `list_options` SET `notes` = 'lug' WHERE `option_id` = 'ganda' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ganda
UPDATE `list_options` SET `notes` = 'lug' WHERE `title` = 'Ganda' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id georgian title Georgian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'georgian', 'Georgian', 560, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id georgian
UPDATE `list_options` SET `notes` = 'geo(B)|kat(T)' WHERE `option_id` = 'georgian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Georgian
UPDATE `list_options` SET `notes` = 'geo(B)|kat(T)' WHERE `title` = 'Georgian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id german title German
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'german', 'German', 570, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id german
UPDATE `list_options` SET `notes` = 'ger(B)|deu(T)' WHERE `option_id` = 'german' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title German
UPDATE `list_options` SET `notes` = 'ger(B)|deu(T)' WHERE `title` = 'German' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 80 option_id german
UPDATE `list_options` SET `seq` = 570 WHERE `option_id` = 'german' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 80 title German
UPDATE `list_options` SET `seq` = 570 WHERE `title` = 'German' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id greek title Greek, Modern (1453-)
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'greek', 'Greek, Modern (1453-)', 580, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id greek
UPDATE `list_options` SET `notes` = 'gre(B)|ell(T)' WHERE `option_id` = 'greek' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Greek, Modern (1453-)
UPDATE `list_options` SET `notes` = 'gre(B)|ell(T)' WHERE `title` = 'Greek, Modern (1453-)' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Greek
UPDATE `list_options` SET `notes` = 'gre(B)|ell(T)' WHERE `title` = 'Greek' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 90 option_id greek
UPDATE `list_options` SET `seq` = 580 WHERE `option_id` = 'greek' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 90 title Greek, Modern (1453-)
UPDATE `list_options` SET `seq` = 580 WHERE `title` = 'Greek, Modern (1453-)' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 90 title Greek
UPDATE `list_options` SET `seq` = 580 WHERE `title` = 'Greek' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id guarani title Guarani
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'guarani', 'Guarani', 590, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id guarani
UPDATE `list_options` SET `notes` = 'grn' WHERE `option_id` = 'guarani' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Guarani
UPDATE `list_options` SET `notes` = 'grn' WHERE `title` = 'Guarani' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id gujarati title Gujarati
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'gujarati', 'Gujarati', 600, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id gujarati
UPDATE `list_options` SET `notes` = 'guj' WHERE `option_id` = 'gujarati' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Gujarati
UPDATE `list_options` SET `notes` = 'guj' WHERE `title` = 'Gujarati' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id haitian_haitian_creole title Haitian; Haitian Creole
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'haitian_haitian_creole', 'Haitian; Haitian Creole', 610, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id haitian_haitian_creole
UPDATE `list_options` SET `notes` = 'hat' WHERE `option_id` = 'haitian_haitian_creole' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Haitian; Haitian Creole
UPDATE `list_options` SET `notes` = 'hat' WHERE `title` = 'Haitian; Haitian Creole' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id hausa title Hausa
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'hausa', 'Hausa', 620, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id hausa
UPDATE `list_options` SET `notes` = 'hau' WHERE `option_id` = 'hausa' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Hausa
UPDATE `list_options` SET `notes` = 'hau' WHERE `title` = 'Hausa' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id hebrew title Hebrew
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'hebrew', 'Hebrew', 630, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id hebrew
UPDATE `list_options` SET `notes` = 'heb' WHERE `option_id` = 'hebrew' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Hebrew
UPDATE `list_options` SET `notes` = 'heb' WHERE `title` = 'Hebrew' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id herero title Herero
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'herero', 'Herero', 640, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id herero
UPDATE `list_options` SET `notes` = 'her' WHERE `option_id` = 'herero' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Herero
UPDATE `list_options` SET `notes` = 'her' WHERE `title` = 'Herero' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id hindi title Hindi
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'hindi', 'Hindi', 650, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id hindi
UPDATE `list_options` SET `notes` = 'hin' WHERE `option_id` = 'hindi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Hindi
UPDATE `list_options` SET `notes` = 'hin' WHERE `title` = 'Hindi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id hiri_motu title Hiri Motu
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'hiri_motu', 'Hiri Motu', 660, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id hiri_motu
UPDATE `list_options` SET `notes` = 'hmo' WHERE `option_id` = 'hiri_motu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Hiri Motu
UPDATE `list_options` SET `notes` = 'hmo' WHERE `title` = 'Hiri Motu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language option_id hmong
UPDATE `list_options` SET `notes` = 'hmn' WHERE `option_id` = 'hmong' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Hmong
UPDATE `list_options` SET `notes` = 'hmn' WHERE `title` = 'Hmong' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 100 option_id hmong
UPDATE `list_options` SET `seq` = 665 WHERE `option_id` = 'hmong' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 100 title Hmong
UPDATE `list_options` SET `seq` = 665 WHERE `title` = 'Hmong' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id hungarian title Hungarian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'hungarian', 'Hungarian', 670, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id hungarian
UPDATE `list_options` SET `notes` = 'hun' WHERE `option_id` = 'hungarian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Hungarian
UPDATE `list_options` SET `notes` = 'hun' WHERE `title` = 'Hungarian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id icelandic title Icelandic
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'icelandic', 'Icelandic', 680, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id icelandic
UPDATE `list_options` SET `notes` = 'ice(B)|isl(T)' WHERE `option_id` = 'icelandic' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Icelandic
UPDATE `list_options` SET `notes` = 'ice(B)|isl(T)' WHERE `title` = 'Icelandic' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ido title Ido
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES (
'language', 'ido', 'Ido', 690, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ido
UPDATE `list_options` SET `notes` = 'ido' WHERE `option_id` = 'ido' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ido
UPDATE `list_options` SET `notes` = 'ido' WHERE `title` = 'Ido' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id igbo title Igbo
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'igbo', 'Igbo', 700, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id igbo
UPDATE `list_options` SET `notes` = 'ibo' WHERE `option_id` = 'igbo' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Igbo
UPDATE `list_options` SET `notes` = 'ibo' WHERE `title` = 'Igbo' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id indonesian title Indonesian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'indonesian', 'Indonesian', 710, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id indonesian
UPDATE `list_options` SET `notes` = 'ind' WHERE `option_id` = 'indonesian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Indonesian
UPDATE `list_options` SET `notes` = 'ind' WHERE `title` = 'Indonesian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id interlingua_international_auxi title Interlingua (International Auxiliary Language Association)
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'interlingua_international_auxi', 'Interlingua (International Auxiliary Language Association)', 720, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id interlingua_international_auxi
UPDATE `list_options` SET `notes` = 'ina' WHERE `option_id` = 'interlingua_international_auxi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Interlingua (International Auxiliary Language Association)
UPDATE `list_options` SET `notes` = 'ina' WHERE `title` = 'Interlingua (International Auxiliary Language Association)' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id interlingue_occidental title Interlingue; Occidental
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'interlingue_occidental', 'Interlingue; Occidental', 730, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id interlingue_occidental
UPDATE `list_options` SET `notes` = 'ile' WHERE `option_id` = 'interlingue_occidental' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Interlingue; Occidental
UPDATE `list_options` SET `notes` = 'ile' WHERE `title` = 'Interlingue; Occidental' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id inuktitut title Inuktitut
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'inuktitut', 'Inuktitut', 740, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id inuktitut
UPDATE `list_options` SET `notes` = 'iku' WHERE `option_id` = 'inuktitut' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Inuktitut
UPDATE `list_options` SET `notes` = 'iku' WHERE `title` = 'Inuktitut' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id inupiaq title Inupiaq
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'inupiaq', 'Inupiaq', 750, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id inupiaq
UPDATE `list_options` SET `notes` = 'ipk' WHERE `option_id` = 'inupiaq' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Inupiaq
UPDATE `list_options` SET `notes` = 'ipk' WHERE `title` = 'Inupiaq' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id irish title Irish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'irish', 'Irish', 760, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id irish
UPDATE `list_options` SET `notes` = 'gle' WHERE `option_id` = 'irish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Irish
UPDATE `list_options` SET `notes` = 'gle' WHERE `title` = 'Irish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id italian title Italian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'italian', 'Italian', 770, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id italian
UPDATE `list_options` SET `notes` = 'ita' WHERE `option_id` = 'italian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Italian
UPDATE `list_options` SET `notes` = 'ita' WHERE `title` = 'Italian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 110 option_id italian
UPDATE `list_options` SET `seq` = 770 WHERE `option_id` = 'italian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 110 title Italian
UPDATE `list_options` SET `seq` = 770 WHERE `title` = 'Italian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id japanese title Japanese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'japanese', 'Japanese', 780, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id japanese
UPDATE `list_options` SET `notes` = 'jpn' WHERE `option_id` = 'japanese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Japanese
UPDATE `list_options` SET `notes` = 'jpn' WHERE `title` = 'Japanese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 120 option_id japanese
UPDATE `list_options` SET `seq` = 780 WHERE `option_id` = 'japanese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 120 title Japanese
UPDATE `list_options` SET `seq` = 780 WHERE `title` = 'Japanese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id javanese title Javanese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'javanese', 'Javanese', 790, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id javanese
UPDATE `list_options` SET `notes` = 'jav' WHERE `option_id` = 'javanese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Javanese
UPDATE `list_options` SET `notes` = 'jav' WHERE `title` = 'Javanese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kalaallisut_greenlandic title Kalaallisut; Greenlandic
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kalaallisut_greenlandic', 'Kalaallisut; Greenlandic', 800, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kalaallisut_greenlandic
UPDATE `list_options` SET `notes` = 'kal' WHERE `option_id` = 'kalaallisut_greenlandic' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kalaallisut; Greenlandic
UPDATE `list_options` SET `notes` = 'kal' WHERE `title` = 'Kalaallisut; Greenlandic' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kannada title Kannada
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kannada', 'Kannada', 810, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kannada
UPDATE `list_options` SET `notes` = 'kan' WHERE `option_id` = 'kannada' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kannada
UPDATE `list_options` SET `notes` = 'kan' WHERE `title` = 'Kannada' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kanuri title Kanuri
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kanuri', 'Kanuri', 820, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kanuri
UPDATE `list_options` SET `notes` = 'kau' WHERE `option_id` = 'kanuri' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kanuri
UPDATE `list_options` SET `notes` = 'kau' WHERE `title` = 'Kanuri' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kashmiri title Kashmiri
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kashmiri', 'Kashmiri', 830, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kashmiri
UPDATE `list_options` SET `notes` = 'kas' WHERE `option_id` = 'kashmiri' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kashmiri
UPDATE `list_options` SET `notes` = 'kas' WHERE `title` = 'Kashmiri' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kazakh title Kazakh
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kazakh', 'Kazakh', 840, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kazakh
UPDATE `list_options` SET `notes` = 'kaz' WHERE `option_id` = 'kazakh' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kazakh
UPDATE `list_options` SET `notes` = 'kaz' WHERE `title` = 'Kazakh' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kikuyu_gikuyu title Kikuyu; Gikuyu
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kikuyu_gikuyu', 'Kikuyu; Gikuyu', 850, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kikuyu_gikuyu
UPDATE `list_options` SET `notes` = 'kik' WHERE `option_id` = 'kikuyu_gikuyu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kikuyu; Gikuyu
UPDATE `list_options` SET `notes` = 'kik' WHERE `title` = 'Kikuyu; Gikuyu' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kinyarwanda title Kinyarwanda
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kinyarwanda', 'Kinyarwanda', 860, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kinyarwanda
UPDATE `list_options` SET `notes` = 'kin' WHERE `option_id` = 'kinyarwanda' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kinyarwanda
UPDATE `list_options` SET `notes` = 'kin' WHERE `title` = 'Kinyarwanda' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kirghiz_kyrgyz title Kirghiz; Kyrgyz
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kirghiz_kyrgyz', 'Kirghiz; Kyrgyz', 870, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kirghiz_kyrgyz
UPDATE `list_options` SET `notes` = 'kir' WHERE `option_id` = 'kirghiz_kyrgyz' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kirghiz; Kyrgyz
UPDATE `list_options` SET `notes` = 'kir' WHERE `title` = 'Kirghiz; Kyrgyz' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id komi title Komi
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'komi', 'Komi', 880, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id komi
UPDATE `list_options` SET `notes` = 'kom' WHERE `option_id` = 'komi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Komi
UPDATE `list_options` SET `notes` = 'kom' WHERE `title` = 'Komi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kongo title Kongo
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kongo', 'Kongo', 890, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kongo
UPDATE `list_options` SET `notes` = 'kon' WHERE `option_id` = 'kongo' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kongo
UPDATE `list_options` SET `notes` = 'kon' WHERE `title` = 'Kongo' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id korean title Korean
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'korean', 'Korean', 900, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id korean
UPDATE `list_options` SET `notes` = 'kor' WHERE `option_id` = 'korean' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Korean
UPDATE `list_options` SET `notes` = 'kor' WHERE `title` = 'Korean' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 130 option_id korean
UPDATE `list_options` SET `seq` = 900 WHERE `option_id` = 'korean' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 130 title Korean
UPDATE `list_options` SET `seq` = 900 WHERE `title` = 'Korean' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kuanyama_kwanyama title Kuanyama; Kwanyama
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kuanyama_kwanyama', 'Kuanyama; Kwanyama', 910, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kuanyama_kwanyama
UPDATE `list_options` SET `notes` = 'kua' WHERE `option_id` = 'kuanyama_kwanyama' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kuanyama; Kwanyama
UPDATE `list_options` SET `notes` = 'kua' WHERE `title` = 'Kuanyama; Kwanyama' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id kurdish title Kurdish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'kurdish', 'Kurdish', 920, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id kurdish
UPDATE `list_options` SET `notes` = 'kur' WHERE `option_id` = 'kurdish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Kurdish
UPDATE `list_options` SET `notes` = 'kur' WHERE `title` = 'Kurdish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id laotian title Lao
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'laotian', 'Lao', 930, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id laotian
UPDATE `list_options` SET `notes` = 'lao' WHERE `option_id` = 'laotian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Lao
UPDATE `list_options` SET `notes` = 'lao' WHERE `title` = 'Lao' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Laotian
UPDATE `list_options` SET `notes` = 'lao' WHERE `title` = 'Laotian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 140 option_id laotian
UPDATE `list_options` SET `seq` = 930 WHERE `option_id` = 'laotian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 140 title Lao
UPDATE `list_options` SET `seq` = 930 WHERE `title` = 'Lao' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 140 title Laotian
UPDATE `list_options` SET `seq` = 930 WHERE `title` = 'Laotian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id latin title Latin
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'latin', 'Latin', 940, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id latin
UPDATE `list_options` SET `notes` = 'lat' WHERE `option_id` = 'latin' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Latin
UPDATE `list_options` SET `notes` = 'lat' WHERE `title` = 'Latin' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id latvian title Latvian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'latvian', 'Latvian', 950, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id latvian
UPDATE `list_options` SET `notes` = 'lav' WHERE `option_id` = 'latvian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Latvian
UPDATE `list_options` SET `notes` = 'lav' WHERE `title` = 'Latvian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id limburgan_limburger_limburgish title Limburgan; Limburger; Limburgish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'limburgan_limburger_limburgish', 'Limburgan; Limburger; Limburgish', 960, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id limburgan_limburger_limburgish
UPDATE `list_options` SET `notes` = 'lim' WHERE `option_id` = 'limburgan_limburger_limburgish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Limburgan; Limburger; Limburgish
UPDATE `list_options` SET `notes` = 'lim' WHERE `title` = 'Limburgan; Limburger; Limburgish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id lingala title Lingala
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'lingala', 'Lingala', 970, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id lingala
UPDATE `list_options` SET `notes` = 'lin' WHERE `option_id` = 'lingala' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Lingala
UPDATE `list_options` SET `notes` = 'lin' WHERE `title` = 'Lingala' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id lithuanian title Lithuanian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'lithuanian', 'Lithuanian', 980, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id lithuanian
UPDATE `list_options` SET `notes` = 'lit' WHERE `option_id` = 'lithuanian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Lithuanian
UPDATE `list_options` SET `notes` = 'lit' WHERE `title` = 'Lithuanian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id luba-katanga title Luba-Katanga
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'luba-katanga', 'Luba-Katanga', 990, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id luba-katanga
UPDATE `list_options` SET `notes` = 'lub' WHERE `option_id` = 'luba-katanga' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Luba-Katanga
UPDATE `list_options` SET `notes` = 'lub' WHERE `title` = 'Luba-Katanga' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id luxembourgish_letzeburgesch title Luxembourgish; Letzeburgesch
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'luxembourgish_letzeburgesch', 'Luxembourgish; Letzeburgesch', 1000, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id luxembourgish_letzeburgesch
UPDATE `list_options` SET `notes` = 'ltz' WHERE `option_id` = 'luxembourgish_letzeburgesch' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Luxembourgish; Letzeburgesch
UPDATE `list_options` SET `notes` = 'ltz' WHERE `title` = 'Luxembourgish; Letzeburgesch' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id macedonian title Macedonian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'macedonian', 'Macedonian', 1010, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id macedonian
UPDATE `list_options` SET `notes` = 'mac(B)|mkd(T)' WHERE `option_id` = 'macedonian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Macedonian
UPDATE `list_options` SET `notes` = 'mac(B)|mkd(T)' WHERE `title` = 'Macedonian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id malagasy title Malagasy
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'malagasy', 'Malagasy', 1020, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id malagasy
UPDATE `list_options` SET `notes` = 'mlg' WHERE `option_id` = 'malagasy' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Malagasy
UPDATE `list_options` SET `notes` = 'mlg' WHERE `title` = 'Malagasy' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id malay title Malay
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'malay', 'Malay', 1030, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id malay
UPDATE `list_options` SET `notes` = 'may(B)|msa(T)' WHERE `option_id` = 'malay' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Malay
UPDATE `list_options` SET `notes` = 'may(B)|msa(T)' WHERE `title` = 'Malay' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id malayalam title Malayalam
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'malayalam', 'Malayalam', 1040, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id malayalam
UPDATE `list_options` SET `notes` = 'mal' WHERE `option_id` = 'malayalam' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Malayalam
UPDATE `list_options` SET `notes` = 'mal' WHERE `title` = 'Malayalam' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id maltese title Maltese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'maltese', 'Maltese', 1050, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id maltese
UPDATE `list_options` SET `notes` = 'mlt' WHERE `option_id` = 'maltese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Maltese
UPDATE `list_options` SET `notes` = 'mlt' WHERE `title` = 'Maltese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id manx title Manx
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'manx', 'Manx', 1060, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id manx
UPDATE `list_options` SET `notes` = 'glv' WHERE `option_id` = 'manx' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Manx
UPDATE `list_options` SET `notes` = 'glv' WHERE `title` = 'Manx' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id maori title Maori
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'maori', 'Maori', 1070, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id maori
UPDATE `list_options` SET `notes` = 'mao(B)|mri(T)' WHERE `option_id` = 'maori' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Maori
UPDATE `list_options` SET `notes` = 'mao(B)|mri(T)' WHERE `title` = 'Maori' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id marathi title Marathi
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'marathi', 'Marathi', 1080, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id marathi
UPDATE `list_options` SET `notes` = 'mar' WHERE `option_id` = 'marathi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Marathi
UPDATE `list_options` SET `notes` = 'mar' WHERE `title` = 'Marathi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id marshallese title Marshallese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'marshallese', 'Marshallese', 1090, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id marshallese
UPDATE `list_options` SET `notes` = 'mah' WHERE `option_id` = 'marshallese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Marshallese
UPDATE `list_options` SET `notes` = 'mah' WHERE `title` = 'Marshallese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 150 option_id mien
UPDATE `list_options` SET `seq` = 1095 WHERE `option_id` = 'mien' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 150 title Mien
UPDATE `list_options` SET `seq` = 1095 WHERE `title` = 'Mien' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id mongolian title Mongolian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'mongolian', 'Mongolian', 1100, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id mongolian
UPDATE `list_options` SET `notes` = 'mon' WHERE `option_id` = 'mongolian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Mongolian
UPDATE `list_options` SET `notes` = 'mon' WHERE `title` = 'Mongolian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id nauru title Nauru
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'nauru', 'Nauru', 1110, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id nauru
UPDATE `list_options` SET `notes` = 'nau' WHERE `option_id` = 'nauru' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Nauru
UPDATE `list_options` SET `notes` = 'nau' WHERE `title` = 'Nauru' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id navajo_navaho title Navajo; Navaho
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'navajo_navaho', 'Navajo; Navaho', 1120, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id navajo_navaho
UPDATE `list_options` SET `notes` = 'nav' WHERE `option_id` = 'navajo_navaho' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Navajo; Navaho
UPDATE `list_options` SET `notes` = 'nav' WHERE `title` = 'Navajo; Navaho' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ndebele_north_north_ndebele title Ndebele, North; North Ndebele
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ndebele_north_north_ndebele', 'Ndebele, North; North Ndebele', 1130, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ndebele_north_north_ndebele
UPDATE `list_options` SET `notes` = 'nde' WHERE `option_id` = 'ndebele_north_north_ndebele' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ndebele, North; North Ndebele
UPDATE `list_options` SET `notes` = 'nde' WHERE `title` = 'Ndebele, North; North Ndebele' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ndebele_south_south_ndebele title Ndebele, South; South Ndebele
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ndebele_south_south_ndebele', 'Ndebele, South; South Ndebele', 1140, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ndebele_south_south_ndebele
UPDATE `list_options` SET `notes` = 'nbl' WHERE `option_id` = 'ndebele_south_south_ndebele' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ndebele, South; South Ndebele
UPDATE `list_options` SET `notes` = 'nbl' WHERE `title` = 'Ndebele, South; South Ndebele' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ndonga title Ndonga
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ndonga', 'Ndonga', 1150, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ndonga
UPDATE `list_options` SET `notes` = 'ndo' WHERE `option_id` = 'ndonga' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ndonga
UPDATE `list_options` SET `notes` = 'ndo' WHERE `title` = 'Ndonga' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id nepali title Nepali
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'nepali', 'Nepali', 1160, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id nepali
UPDATE `list_options` SET `notes` = 'nep' WHERE `option_id` = 'nepali' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Nepali
UPDATE `list_options` SET `notes` = 'nep' WHERE `title` = 'Nepali' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id northern_sami title Northern Sami
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'northern_sami', 'Northern Sami', 1170, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id northern_sami
UPDATE `list_options` SET `notes` = 'sme' WHERE `option_id` = 'northern_sami' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Northern Sami
UPDATE `list_options` SET `notes` = 'sme' WHERE `title` = 'Northern Sami' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id norwegian title Norwegian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'norwegian', 'Norwegian', 1180, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id norwegian
UPDATE `list_options` SET `notes` = 'nor' WHERE `option_id` = 'norwegian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Norwegian
UPDATE `list_options` SET `notes` = 'nor' WHERE `title` = 'Norwegian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 160 option_id norwegian
UPDATE `list_options` SET `seq` = 1180 WHERE `option_id` = 'norwegian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 160 title Norwegian
UPDATE `list_options` SET `seq` = 1180 WHERE `title` = 'Norwegian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id norwegian_nynorsk_nynorsk_norw title Norwegian Nynorsk; Nynorsk, Norwegian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'norwegian_nynorsk_nynorsk_norw', 'Norwegian Nynorsk; Nynorsk, Norwegian', 1190, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id norwegian_nynorsk_nynorsk_norw
UPDATE `list_options` SET `notes` = 'nno' WHERE `option_id` = 'norwegian_nynorsk_nynorsk_norw' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Norwegian Nynorsk; Nynorsk, Norwegian
UPDATE `list_options` SET `notes` = 'nno' WHERE `title` = 'Norwegian Nynorsk; Nynorsk, Norwegian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id occitan_post_1500 title Occitan (post 1500)
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'occitan_post_1500', 'Occitan (post 1500)', 1200, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id occitan_post_1500
UPDATE `list_options` SET `notes` = 'oci' WHERE `option_id` = 'occitan_post_1500' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Occitan (post 1500)
UPDATE `list_options` SET `notes` = 'oci' WHERE `title` = 'Occitan (post 1500)' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ojibwa title Ojibwa
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ojibwa', 'Ojibwa', 1210, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ojibwa
UPDATE `list_options` SET `notes` = 'oji' WHERE `option_id` = 'ojibwa' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ojibwa
UPDATE `list_options` SET `notes` = 'oji' WHERE `title` = 'Ojibwa' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id oriya title Oriya
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'oriya', 'Oriya', 1220, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id oriya
UPDATE `list_options` SET `notes` = 'ori' WHERE `option_id` = 'oriya' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Oriya
UPDATE `list_options` SET `notes` = 'ori' WHERE `title` = 'Oriya' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id oromo title Oromo
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'oromo', 'Oromo', 1230, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id oromo
UPDATE `list_options` SET `notes` = 'orm' WHERE `option_id` = 'oromo' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Oromo
UPDATE `list_options` SET `notes` = 'orm' WHERE `title` = 'Oromo' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ossetian_ossetic title Ossetian; Ossetic
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ossetian_ossetic', 'Ossetian; Ossetic', 1240, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ossetian_ossetic
UPDATE `list_options` SET `notes` = 'oss' WHERE `option_id` = 'ossetian_ossetic' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ossetian; Ossetic
UPDATE `list_options` SET `notes` = 'oss' WHERE `title` = 'Ossetian; Ossetic' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 170 option_id othrs
UPDATE `list_options` SET `seq` = 1245 WHERE `option_id` = 'othrs' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 170 title Others
UPDATE `list_options` SET `seq` = 1245 WHERE `title` = 'Others' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id pali title Pali
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'pali', 'Pali', 1250, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id pali
UPDATE `list_options` SET `notes` = 'pli' WHERE `option_id` = 'pali' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Pali
UPDATE `list_options` SET `notes` = 'pli' WHERE `title` = 'Pali' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id persian title Persian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'persian', 'Persian', 1260, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id persian
UPDATE `list_options` SET `notes` = 'per(B)|fas(T)' WHERE `option_id` = 'persian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Persian
UPDATE `list_options` SET `notes` = 'per(B)|fas(T)' WHERE `title` = 'Persian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id polish title Polish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'polish', 'Polish', 1270, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id polish
UPDATE `list_options` SET `notes` = 'pol' WHERE `option_id` = 'polish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Polish
UPDATE `list_options` SET `notes` = 'pol' WHERE `title` = 'Polish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id portuguese title Portuguese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'portuguese', 'Portuguese', 1280, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id portuguese
UPDATE `list_options` SET `notes` = 'por' WHERE `option_id` = 'portuguese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Portuguese
UPDATE `list_options` SET `notes` = 'por' WHERE `title` = 'Portuguese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 180 option_id portuguese
UPDATE `list_options` SET `seq` = 1280 WHERE `option_id` = 'portuguese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 180 title Portuguese
UPDATE `list_options` SET `seq` = 1280 WHERE `title` = 'Portuguese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id punjabi title Punjabi
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'punjabi', 'Punjabi', 1290, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id portuguese
UPDATE `list_options` SET `notes` = 'pan' WHERE `option_id` = 'punjabi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Punjabi
UPDATE `list_options` SET `notes` = 'pan' WHERE `title` = 'Punjabi' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 190 option_id punjabi
UPDATE `list_options` SET `seq` = 1290 WHERE `option_id` = 'punjabi' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 190 title Punjabi
UPDATE `list_options` SET `seq` = 1290 WHERE `title` = 'Punjabi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id pushto_pashto title Pushto; Pashto
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'pushto_pashto', 'Pushto; Pashto', 1300, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id pushto_pashto
UPDATE `list_options` SET `notes` = 'pus' WHERE `option_id` = 'pushto_pashto' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Pushto; Pashto
UPDATE `list_options` SET `notes` = 'pus' WHERE `title` = 'Pushto; Pashto' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id quechua title Quechua
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'quechua', 'Quechua', 1310, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id quechua
UPDATE `list_options` SET `notes` = 'que' WHERE `option_id` = 'quechua' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Quechua
UPDATE `list_options` SET `notes` = 'que' WHERE `title` = 'Quechua' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id romanian_moldavian_moldovan title Romanian; Moldavian; Moldovan
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'romanian_moldavian_moldovan', 'Romanian; Moldavian; Moldovan', 1320, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id romanian_moldavian_moldovan
UPDATE `list_options` SET `notes` = 'rum(B)|ron(T)' WHERE `option_id` = 'romanian_moldavian_moldovan' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Romanian; Moldavian; Moldovan
UPDATE `list_options` SET `notes` = 'rum(B)|ron(T)' WHERE `title` = 'Romanian; Moldavian; Moldovan' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id romansh title Romansh
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'romansh', 'Romansh', 1330, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id romansh
UPDATE `list_options` SET `notes` = 'roh' WHERE `option_id` = 'romansh' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Romansh
UPDATE `list_options` SET `notes` = 'roh' WHERE `title` = 'Romansh' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id rundi title Rundi
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'rundi', 'Rundi', 1340, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id rundi
UPDATE `list_options` SET `notes` = 'run' WHERE `option_id` = 'rundi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Rundi
UPDATE `list_options` SET `notes` = 'run' WHERE `title` = 'Rundi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id russian title Russian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'russian', 'Russian', 1350, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id russian
UPDATE `list_options` SET `notes` = 'rus' WHERE `option_id` = 'russian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Russian
UPDATE `list_options` SET `notes` = 'rus' WHERE `title` = 'Russian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 200 option_id russian
UPDATE `list_options` SET `seq` = 1350 WHERE `option_id` = 'russian' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 200 title Russian
UPDATE `list_options` SET `seq` = 1350 WHERE `title` = 'Russian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id samoan title Samoan
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'samoan', 'Samoan', 1360, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id samoan
UPDATE `list_options` SET `notes` = 'smo' WHERE `option_id` = 'samoan' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Samoan
UPDATE `list_options` SET `notes` = 'smo' WHERE `title` = 'Samoan' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sango title Sango
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sango', 'Sango', 1370, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sango
UPDATE `list_options` SET `notes` = 'sag' WHERE `option_id` = 'sango' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sango
UPDATE `list_options` SET `notes` = 'sag' WHERE `title` = 'Sango' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sanskrit title Sanskrit
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sanskrit', 'Sanskrit', 1380, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sanskrit
UPDATE `list_options` SET `notes` = 'san' WHERE `option_id` = 'sanskrit' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sanskrit
UPDATE `list_options` SET `notes` = 'san' WHERE `title` = 'Sanskrit' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sardinian title Sardinian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sardinian', 'Sardinian', 1390, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sardinian
UPDATE `list_options` SET `notes` = 'srd' WHERE `option_id` = 'sardinian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sardinian
UPDATE `list_options` SET `notes` = 'srd' WHERE `title` = 'Sardinian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id serbian title Serbian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'serbian', 'Serbian', 1400, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id serbian
UPDATE `list_options` SET `notes` = 'srp' WHERE `option_id` = 'serbian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Serbian
UPDATE `list_options` SET `notes` = 'srp' WHERE `title` = 'Serbian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id shona title Shona
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'shona', 'Shona', 1410, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id shona
UPDATE `list_options` SET `notes` = 'sna' WHERE `option_id` = 'shona' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Shona
UPDATE `list_options` SET `notes` = 'sna' WHERE `title` = 'Shona' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sichuan_yi_nuosu title Sichuan Yi; Nuosu
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sichuan_yi_nuosu', 'Sichuan Yi; Nuosu', 1420, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sichuan_yi_nuosu
UPDATE `list_options` SET `notes` = 'iii' WHERE `option_id` = 'sichuan_yi_nuosu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sichuan Yi; Nuosu
UPDATE `list_options` SET `notes` = 'iii' WHERE `title` = 'Sichuan Yi; Nuosu' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sindhi title Sindhi
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sindhi', 'Sindhi', 1430, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sindhi
UPDATE `list_options` SET `notes` = 'snd' WHERE `option_id` = 'sindhi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sindhi
UPDATE `list_options` SET `notes` = 'snd' WHERE `title` = 'Sindhi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sinhala_sinhalese title Sinhala; Sinhalese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sinhala_sinhalese', 'Sinhala; Sinhalese', 1440, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sinhala_sinhalese
UPDATE `list_options` SET `notes` = 'sin' WHERE `option_id` = 'sinhala_sinhalese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sinhala; Sinhalese
UPDATE `list_options` SET `notes` = 'sin' WHERE `title` = 'Sinhala; Sinhalese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id slovak title Slovak
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'slovak', 'Slovak', 1450, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id slovak
UPDATE `list_options` SET `notes` = 'slo(B)|slk(T)' WHERE `option_id` = 'slovak' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Slovak
UPDATE `list_options` SET `notes` = 'slo(B)|slk(T)' WHERE `title` = 'Slovak' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id slovenian title Slovenian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'slovenian', 'Slovenian', 1460, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id slovenian
UPDATE `list_options` SET `notes` = 'slv' WHERE `option_id` = 'slovenian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Slovenian
UPDATE `list_options` SET `notes` = 'slv' WHERE `title` = 'Slovenian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id somali title Somali
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'somali', 'Somali', 1470, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id somali
UPDATE `list_options` SET `notes` = 'som' WHERE `option_id` = 'somali' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Somali
UPDATE `list_options` SET `notes` = 'som' WHERE `title` = 'Somali' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sotho_southern title Sotho, Southern
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sotho_southern', 'Sotho, Southern', 1480, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sotho_southern
UPDATE `list_options` SET `notes` = 'sot' WHERE `option_id` = 'sotho_southern' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sotho, Southern
UPDATE `list_options` SET `notes` = 'sot' WHERE `title` = 'Sotho, Southern' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id Spanish title Spanish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'Spanish', 'Spanish', 1490, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id Spanish
UPDATE `list_options` SET `notes` = 'spa' WHERE `option_id` = 'Spanish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Spanish
UPDATE `list_options` SET `notes` = 'spa' WHERE `title` = 'Spanish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 210 option_id Spanish
UPDATE `list_options` SET `seq` = 1490 WHERE `option_id` = 'Spanish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 210 title Spanish
UPDATE `list_options` SET `seq` = 1490 WHERE `title` = 'Spanish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id sundanese title Sundanese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'sundanese', 'Sundanese', 1500, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id sundanese
UPDATE `list_options` SET `notes` = 'sun' WHERE `option_id` = 'sundanese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Sundanese
UPDATE `list_options` SET `notes` = 'sun' WHERE `title` = 'Sundanese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id swahili title Swahili
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'swahili', 'Swahili', 1510, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id swahili
UPDATE `list_options` SET `notes` = 'swa' WHERE `option_id` = 'swahili' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Swahili
UPDATE `list_options` SET `notes` = 'swa' WHERE `title` = 'Swahili' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id swati title Swati
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'swati', 'Swati', 1520, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id swati
UPDATE `list_options` SET `notes` = 'ssw' WHERE `option_id` = 'swati' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Swati
UPDATE `list_options` SET `notes` = 'ssw' WHERE `title` = 'Swati' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id swedish title Swedish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'swedish', 'Swedish', 1530, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id swedish
UPDATE `list_options` SET `notes` = 'swe' WHERE `option_id` = 'swedish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Swedish
UPDATE `list_options` SET `notes` = 'swe' WHERE `title` = 'Swedish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tagalog title Tagalog
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tagalog', 'Tagalog', 1540, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tagalog
UPDATE `list_options` SET `notes` = 'tgl' WHERE `option_id` = 'tagalog' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tagalog
UPDATE `list_options` SET `notes` = 'tgl' WHERE `title` = 'Tagalog' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 220 option_id tagalog
UPDATE `list_options` SET `seq` = 1540 WHERE `option_id` = 'tagalog' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 220 title Tagalog
UPDATE `list_options` SET `seq` = 1540 WHERE `title` = 'Tagalog' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tahitian title Tahitian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tahitian', 'Tahitian', 1550, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tahitian
UPDATE `list_options` SET `notes` = 'tah' WHERE `option_id` = 'tahitian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tahitian
UPDATE `list_options` SET `notes` = 'tah' WHERE `title` = 'Tahitian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tajik title Tajik
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tajik', 'Tajik', 1560, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tajik
UPDATE `list_options` SET `notes` = 'tgk' WHERE `option_id` = 'tajik' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tajik
UPDATE `list_options` SET `notes` = 'tgk' WHERE `title` = 'Tajik' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tamil title Tamil
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tamil', 'Tamil', 1570, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tamil
UPDATE `list_options` SET `notes` = 'tam' WHERE `option_id` = 'tamil' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tamil
UPDATE `list_options` SET `notes` = 'tam' WHERE `title` = 'Tamil' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tatar title Tatar
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tatar', 'Tatar', 1580, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tatar
UPDATE `list_options` SET `notes` = 'tat' WHERE `option_id` = 'tatar' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tatar
UPDATE `list_options` SET `notes` = 'tat' WHERE `title` = 'Tatar' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id telugu title Telugu
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'telugu', 'Telugu', 1590, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id telugu
UPDATE `list_options` SET `notes` = 'tel' WHERE `option_id` = 'telugu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Telugu
UPDATE `list_options` SET `notes` = 'tel' WHERE `title` = 'Telugu' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id thai title Thai
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'thai', 'Thai', 1600, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id thai
UPDATE `list_options` SET `notes` = 'tha' WHERE `option_id` = 'thai' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Thai
UPDATE `list_options` SET `notes` = 'tha' WHERE `title` = 'Thai' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tibetan title Tibetan
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tibetan', 'Tibetan', 1610, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tibetan
UPDATE `list_options` SET `notes` = 'tib(B)|bod(T)' WHERE `option_id` = 'tibetan' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tibetan
UPDATE `list_options` SET `notes` = 'tib(B)|bod(T)' WHERE `title` = 'Tibetan' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tigrinya title Tigrinya
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tigrinya', 'Tigrinya', 1620, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tigrinya
UPDATE `list_options` SET `notes` = 'tir' WHERE `option_id` = 'tigrinya' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tigrinya
UPDATE `list_options` SET `notes` = 'tir' WHERE `title` = 'Tigrinya' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tonga_tonga_islands title Tonga (Tonga Islands)
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tonga_tonga_islands', 'Tonga (Tonga Islands)', 1630, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tonga_tonga_islands
UPDATE `list_options` SET `notes` = 'ton' WHERE `option_id` = 'tonga_tonga_islands' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tonga (Tonga Islands)
UPDATE `list_options` SET `notes` = 'ton' WHERE `title` = 'Tonga (Tonga Islands)' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tsonga title Tsonga
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tsonga', 'Tsonga', 1640, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tsonga
UPDATE `list_options` SET `notes` = 'tso' WHERE `option_id` = 'tsonga' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tsonga
UPDATE `list_options` SET `notes` = 'tso' WHERE `title` = 'Tsonga' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id tswana title Tswana
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'tswana', 'Tswana', 1650, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id tswana
UPDATE `list_options` SET `notes` = 'tsn' WHERE `option_id` = 'tswana' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Tswana
UPDATE `list_options` SET `notes` = 'tsn' WHERE `title` = 'Tswana' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id turkish title Turkish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'turkish', 'Turkish', 1660, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id turkish
UPDATE `list_options` SET `notes` = 'tur' WHERE `option_id` = 'turkish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Turkish
UPDATE `list_options` SET `notes` = 'tur' WHERE `title` = 'Turkish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 230 option_id turkish
UPDATE `list_options` SET `seq` = 1660 WHERE `option_id` = 'turkish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 230 title Turkish
UPDATE `list_options` SET `seq` = 1660 WHERE `title` = 'Turkish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id turkmen title Turkmen
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'turkmen', 'Turkmen', 1670, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id turkmen
UPDATE `list_options` SET `notes` = 'tuk' WHERE `option_id` = 'turkmen' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Turkmen
UPDATE `list_options` SET `notes` = 'tuk' WHERE `title` = 'Turkmen' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id twi title Twi
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'twi', 'Twi', 1680, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id twi
UPDATE `list_options` SET `notes` = 'twi' WHERE `option_id` = 'twi' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Twi
UPDATE `list_options` SET `notes` = 'twi' WHERE `title` = 'Twi' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id uighur_uyghur title Uighur; Uyghur
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'uighur_uyghur', 'Uighur; Uyghur', 1690, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id uighur_uyghur
UPDATE `list_options` SET `notes` = 'uig' WHERE `option_id` = 'uighur_uyghur' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Uighur; Uyghur
UPDATE `list_options` SET `notes` = 'uig' WHERE `title` = 'Uighur; Uyghur' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id ukrainian title Ukrainian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'ukrainian', 'Ukrainian', 1700, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id ukrainian
UPDATE `list_options` SET `notes` = 'ukr' WHERE `option_id` = 'ukrainian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Ukrainian
UPDATE `list_options` SET `notes` = 'ukr' WHERE `title` = 'Ukrainian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id urdu title Urdu
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'urdu', 'Urdu', 1710, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id urdu
UPDATE `list_options` SET `notes` = 'urd' WHERE `option_id` = 'urdu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Urdu
UPDATE `list_options` SET `notes` = 'urd' WHERE `title` = 'Urdu' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id uzbek title Uzbek
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'uzbek', 'Uzbek', 1720, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id uzbek
UPDATE `list_options` SET `notes` = 'uzb' WHERE `option_id` = 'uzbek' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Uzbek
UPDATE `list_options` SET `notes` = 'uzb' WHERE `title` = 'Uzbek' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id venda title Venda
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'venda', 'Venda', 1730, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id venda
UPDATE `list_options` SET `notes` = 'ven' WHERE `option_id` = 'venda' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Venda
UPDATE `list_options` SET `notes` = 'ven' WHERE `title` = 'Venda' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id vietnamese title Vietnamese
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'vietnamese', 'Vietnamese', 1740, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id vietnamese
UPDATE `list_options` SET `notes` = 'vie' WHERE `option_id` = 'vietnamese' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Vietnamese
UPDATE `list_options` SET `notes` = 'vie' WHERE `title` = 'Vietnamese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 240 option_id vietnamese
UPDATE `list_options` SET `seq` = 1740 WHERE `option_id` = 'vietnamese' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 240 title Vietnamese
UPDATE `list_options` SET `seq` = 1740 WHERE `title` = 'Vietnamese' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id volapuk title Volapük
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'volapuk', 'Volapük', 1750, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id volapuk
UPDATE `list_options` SET `notes` = 'vol' WHERE `option_id` = 'volapuk' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Volapük
UPDATE `list_options` SET `notes` = 'vol' WHERE `title` = 'Volapük' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id walloon title Walloon
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'walloon', 'Walloon', 1760, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id walloon
UPDATE `list_options` SET `notes` = 'wln' WHERE `option_id` = 'walloon' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Walloon
UPDATE `list_options` SET `notes` = 'wln' WHERE `title` = 'Walloon' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id welsh title Welsh
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'welsh', 'Welsh', 1770, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id welsh
UPDATE `list_options` SET `notes` = 'wel(B)|cym(T)' WHERE `option_id` = 'welsh' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Welsh
UPDATE `list_options` SET `notes` = 'wel(B)|cym(T)' WHERE `title` = 'Welsh' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id western_frisian title Western Frisian
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'western_frisian', 'Western Frisian', 1780, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id western_frisian
UPDATE `list_options` SET `notes` = 'fry' WHERE `option_id` = 'western_frisian' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Western Frisian
UPDATE `list_options` SET `notes` = 'fry' WHERE `title` = 'Western Frisian' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id wolof title Wolof
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'wolof', 'Wolof', 1790, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id wolof
UPDATE `list_options` SET `notes` = 'wol' WHERE `option_id` = 'wolof' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Wolof
UPDATE `list_options` SET `notes` = 'wol' WHERE `title` = 'Wolof' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id xhosa title Xhosa
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'xhosa', 'Xhosa', 1800, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id xhosa
UPDATE `list_options` SET `notes` = 'xho' WHERE `option_id` = 'xhosa' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Xhosa
UPDATE `list_options` SET `notes` = 'xho' WHERE `title` = 'Xhosa' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id yiddish title Yiddish
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'yiddish', 'Yiddish', 1810, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id yiddish
UPDATE `list_options` SET `notes` = 'yid' WHERE `option_id` = 'yiddish' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Yiddish
UPDATE `list_options` SET `notes` = 'yid' WHERE `title` = 'Yiddish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 250 option_id yiddish
UPDATE `list_options` SET `seq` = 1810 WHERE `option_id` = 'yiddish' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 250 title Yiddish
UPDATE `list_options` SET `seq` = 1810 WHERE `title` = 'Yiddish' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id yoruba title Yoruba
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'yoruba', 'Yoruba', 1820, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id yoruba
UPDATE `list_options` SET `notes` = 'yor' WHERE `option_id` = 'yoruba' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Yoruba
UPDATE `list_options` SET `notes` = 'yor' WHERE `title` = 'Yoruba' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id zhuang_chuang title Zhuang; Chuang
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'zhuang_chuang', 'Zhuang; Chuang', 1830, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id zhuang_chuang
UPDATE `list_options` SET `notes` = 'zha' WHERE `option_id` = 'zhuang_chuang' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Zhuang; Chuang
UPDATE `list_options` SET `notes` = 'zha' WHERE `title` = 'Zhuang; Chuang' AND `list_id` = 'language';
#EndIf

#IfNotRow2Dx2 list_options list_id language option_id zulu title Zulu
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value` ) VALUES ('language', 'zulu', 'Zulu', 1840, 0, 0);
#EndIf

#IfRow2D list_options list_id language option_id zulu
UPDATE `list_options` SET `notes` = 'zul' WHERE `option_id` = 'zulu' AND `list_id` = 'language';
#EndIf

#IfRow2D list_options list_id language title Zulu
UPDATE `list_options` SET `notes` = 'zul' WHERE `title` = 'Zulu' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 260 option_id zulu
UPDATE `list_options` SET `seq` = 1840 WHERE `option_id` = 'zulu' AND `list_id` = 'language';
#EndIf

#IfRow3D list_options list_id language seq 260 title Zulu
UPDATE `list_options` SET `seq` = 1840 WHERE `title` = 'Zulu' AND `list_id` = 'language';
#EndIf

#IfMissingColumn code_types ct_drug
ALTER TABLE `code_types` ADD COLUMN ct_drug tinyint(1) NOT NULL default 0 COMMENT '1 if this is a medication';
#EndIf

#IfNotRow code_types ct_key RXCUI
DROP TABLE IF EXISTS `temp_table_one`;
CREATE TABLE `temp_table_one` (`id` int(11) NOT NULL DEFAULT '0',`seq` int(11) NOT NULL DEFAULT '0') ENGINE=MyISAM;
INSERT INTO `temp_table_one` (`id`, `seq`) VALUES (
  IF(((SELECT MAX(`ct_id` ) FROM `code_types`) >= 100), ((SELECT MAX(`ct_id` ) FROM `code_types`) + 1), 100),
  IF(((SELECT MAX(`ct_seq`) FROM `code_types`) >= 100), ((SELECT MAX(`ct_seq`) FROM `code_types`) + 1), 100));
INSERT INTO code_types (ct_key, ct_id, ct_seq, ct_mod, ct_just, ct_fee, ct_rel, ct_nofs, ct_diag, ct_active, ct_label, ct_drug ) VALUES
  ('RXCUI', (SELECT MAX(`id`) FROM `temp_table_one`), (SELECT MAX(`seq`) FROM `temp_table_one`), 0, '', 0, 0, 1, 0, 0, 'RXCUI Medication', 1);
DROP TABLE `temp_table_one`;
#EndIf
#IfNotColumnType immunizations amount_administered decimal(12,2)
ALTER TABLE  `immunizations` CHANGE  `amount_administered`  `amount_administered` DECIMAL( 12, 2 ) NULL DEFAULT NULL;
#EndIf

#IfNotColumnType immunizations amount_administered decimal(12,2)
ALTER TABLE  `immunizations` CHANGE  `amount_administered`  `amount_administered` DECIMAL( 12, 2 ) NULL DEFAULT NULL;
#EndIf

#IfNotRow clinical_rules id electronic_notes
	INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('electronic_notes', 0, 0, 0, 0, '', '', 1, '170.314(a)(9)', 0);
#EndIf

#IfNotRow2D list_options list_id clinical_rules option_id electronic_notes
	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'electronic_notes', 'Electronic Notes', 3000, 0);
#EndIf

#IfNotRow clinical_rules id image_results
	INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('image_results', 0, 0, 0, 0, '', '', 1, '170.314(a)(12)', 0);
#EndIf

#IfNotRow2D list_options list_id clinical_rules option_id image_results
	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'image_results', 'Image Results', 3100, 0);
#EndIf

#IfNotRow2D list_options list_id clinical_rules option_id electronic_notes_amc
	INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'electronic_notes_amc', 'Electronic Notes', 3200, 0);
#EndIf

#IfMissingColumn documents encounter_id
  ALTER TABLE `documents` ADD `encounter_id` bigint(20) NULL DEFAULT '0';
#EndIf

#IfMissingColumn documents encounter_check
	ALTER TABLE `documents` ADD `encounter_check` TINYINT(1) NULL DEFAULT 0;
#EndIf
