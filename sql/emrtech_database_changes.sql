/**********************************************************
 * @author Fei Lung <flung@ambesc.com>
 * @date 2010/10/11 
 * @version 0.1
 *
 * HL7 Changes to OpenEMR
 * OpenEMR $v_database = 2
 *
 ***********************************************************/
/**********************************************************
 * Change tables to InnoDB
 ***********************************************************/
ALTER TABLE `addresses` ENGINE=InnoDB;
ALTER TABLE ar_activity MODIFY COLUMN sequence_no INT;
ALTER TABLE ar_activity DROP PRIMARY KEY;
ALTER TABLE ar_activity ADD PRIMARY KEY (sequence_no);
ALTER TABLE ar_activity MODIFY COLUMN sequence_no INT unsigned NOT NULL auto_increment;
ALTER TABLE ar_activity ADD UNIQUE (pid, encounter, sequence_no);
ALTER TABLE `ar_activity` ENGINE=InnoDB;
ALTER TABLE `ar_session` ENGINE=InnoDB;
ALTER TABLE `array` ENGINE=InnoDB;
ALTER TABLE `automatic_notification` ENGINE=InnoDB;
ALTER TABLE `batchcom` ENGINE=InnoDB;
ALTER TABLE `billing` ENGINE=InnoDB;
ALTER TABLE `categories` ENGINE=InnoDB;
ALTER TABLE `categories_seq` ENGINE=InnoDB;
ALTER TABLE `categories_to_documents` ENGINE=InnoDB;
ALTER TABLE `chart_tracker` ENGINE=InnoDB;
ALTER TABLE claims MODIFY COLUMN version INT;
ALTER TABLE claims DROP PRIMARY KEY;
ALTER TABLE claims ADD PRIMARY KEY (version);
ALTER TABLE claims MODIFY COLUMN version INT unsigned NOT NULL auto_increment;
ALTER TABLE claims ADD UNIQUE (patient_id, encounter_id, version);
ALTER TABLE `claims` ENGINE=InnoDB;
ALTER TABLE `code_types` ENGINE=InnoDB;
ALTER TABLE `codes` ENGINE=InnoDB;
ALTER TABLE `config` ENGINE=InnoDB;
ALTER TABLE `config_seq` ENGINE=InnoDB;
ALTER TABLE `documents` ENGINE=InnoDB;
ALTER TABLE `drug_inventory` ENGINE=InnoDB;
ALTER TABLE `drug_sales` ENGINE=InnoDB;
ALTER TABLE `drug_templates` ENGINE=InnoDB;
ALTER TABLE `drugs` ENGINE=InnoDB;
ALTER TABLE `employer_data` ENGINE=InnoDB;
ALTER TABLE `facility` ENGINE=InnoDB;
ALTER TABLE `fee_sheet_options` ENGINE=InnoDB;
ALTER TABLE `form_dictation` ENGINE=InnoDB;
ALTER TABLE `form_encounter` ENGINE=InnoDB;
ALTER TABLE `form_misc_billing_options` ENGINE=InnoDB;
ALTER TABLE `form_reviewofs` ENGINE=InnoDB;
ALTER TABLE `form_ros` ENGINE=InnoDB;
ALTER TABLE `form_soap` ENGINE=InnoDB;
ALTER TABLE `form_vitals` ENGINE=InnoDB;
ALTER TABLE `forms` ENGINE=InnoDB;
ALTER TABLE `gacl_acl` ENGINE=InnoDB;
ALTER TABLE `gacl_acl_sections` ENGINE=InnoDB;
ALTER TABLE `gacl_acl_seq` ENGINE=InnoDB;
ALTER TABLE `gacl_aco` ENGINE=InnoDB;
ALTER TABLE `gacl_aco_map` ENGINE=InnoDB;
ALTER TABLE `gacl_aco_sections` ENGINE=InnoDB;
ALTER TABLE `gacl_aco_sections_seq` ENGINE=InnoDB;
ALTER TABLE `gacl_aco_seq` ENGINE=InnoDB;
ALTER TABLE `gacl_aro` ENGINE=InnoDB;
ALTER TABLE `gacl_aro_groups` ENGINE=InnoDB;
ALTER TABLE `gacl_aro_groups_id_seq` ENGINE=InnoDB;
ALTER TABLE `gacl_aro_groups_map` ENGINE=InnoDB;
ALTER TABLE `gacl_aro_map` ENGINE=InnoDB;
ALTER TABLE `gacl_aro_sections` ENGINE=InnoDB;
ALTER TABLE `gacl_aro_sections_seq` ENGINE=InnoDB;
ALTER TABLE `gacl_aro_seq` ENGINE=InnoDB;
ALTER TABLE `gacl_axo` ENGINE=InnoDB;
ALTER TABLE `gacl_axo_groups` ENGINE=InnoDB;
ALTER TABLE `gacl_axo_groups_map` ENGINE=InnoDB;
ALTER TABLE `gacl_axo_map` ENGINE=InnoDB;
ALTER TABLE `gacl_axo_sections` ENGINE=InnoDB;
ALTER TABLE `gacl_groups_aro_map` ENGINE=InnoDB;
ALTER TABLE `gacl_groups_axo_map` ENGINE=InnoDB;
ALTER TABLE `gacl_phpgacl` ENGINE=InnoDB;
ALTER TABLE `geo_country_reference` ENGINE=InnoDB;
ALTER TABLE `geo_zone_reference` ENGINE=InnoDB;
ALTER TABLE `globals` ENGINE=InnoDB;
ALTER TABLE `gprelations` ENGINE=InnoDB;
ALTER TABLE `groups` ENGINE=InnoDB;
ALTER TABLE `history_data` ENGINE=InnoDB;
ALTER TABLE `immunizations` ENGINE=InnoDB;
ALTER TABLE `insurance_companies` ENGINE=InnoDB;
ALTER TABLE `insurance_data` ENGINE=InnoDB;
ALTER TABLE `insurance_numbers` ENGINE=InnoDB;
ALTER TABLE `integration_mapping` ENGINE=InnoDB;
ALTER TABLE `issue_encounter` ENGINE=InnoDB;
ALTER TABLE `lang_constants` ENGINE=InnoDB;
ALTER TABLE `lang_custom` ENGINE=InnoDB;
ALTER TABLE `lang_definitions` ENGINE=InnoDB;
ALTER TABLE `lang_languages` ENGINE=InnoDB;
ALTER TABLE `layout_options` ENGINE=InnoDB;
ALTER TABLE `lbf_data` ENGINE=InnoDB;
ALTER TABLE `list_options` ENGINE=InnoDB;
ALTER TABLE `lists` ENGINE=InnoDB;
ALTER TABLE `log` ENGINE=InnoDB;
ALTER TABLE `notes` ENGINE=InnoDB;
ALTER TABLE `notification_log` ENGINE=InnoDB;
ALTER TABLE `notification_settings` ENGINE=InnoDB;
ALTER TABLE `onotes` ENGINE=InnoDB;
ALTER TABLE `openemr_module_vars` ENGINE=InnoDB;
ALTER TABLE `openemr_modules` ENGINE=InnoDB;
ALTER TABLE `openemr_postcalendar_categories` ENGINE=InnoDB;
ALTER TABLE `openemr_postcalendar_events` ENGINE=InnoDB;
ALTER TABLE `openemr_postcalendar_limits` ENGINE=InnoDB;
ALTER TABLE `openemr_postcalendar_topics` ENGINE=InnoDB;
ALTER TABLE `openemr_session_info` ENGINE=InnoDB;
ALTER TABLE `patient_data` ENGINE=InnoDB;
ALTER TABLE `payments` ENGINE=InnoDB;
ALTER TABLE `pharmacies` ENGINE=InnoDB;
ALTER TABLE `phone_numbers` ENGINE=InnoDB;
ALTER TABLE `pma_bookmark` ENGINE=InnoDB;
ALTER TABLE `pma_column_info` ENGINE=InnoDB;
ALTER TABLE `pma_history` ENGINE=InnoDB;
ALTER TABLE `pma_pdf_pages` ENGINE=InnoDB;
ALTER TABLE `pma_relation` ENGINE=InnoDB;
ALTER TABLE `pma_table_coords` ENGINE=InnoDB;
ALTER TABLE `pma_table_info` ENGINE=InnoDB;
ALTER TABLE `pnotes` ENGINE=InnoDB;
ALTER TABLE `prescriptions` ENGINE=InnoDB;
ALTER TABLE `prices` ENGINE=InnoDB;
ALTER TABLE `procedure_order` ENGINE=InnoDB;
ALTER TABLE `procedure_report` ENGINE=InnoDB;
ALTER TABLE `procedure_result` ENGINE=InnoDB;
ALTER TABLE `procedure_type` ENGINE=InnoDB;
ALTER TABLE `registry` ENGINE=InnoDB;
ALTER TABLE `sequences` ENGINE=InnoDB;
ALTER TABLE `syndromic_surveillance` ENGINE=InnoDB;
ALTER TABLE `transactions` ENGINE=InnoDB;
ALTER TABLE `users` ENGINE=InnoDB;
ALTER TABLE `users_facility` ENGINE=InnoDB;
ALTER TABLE `x12_partners` ENGINE=InnoDB;

ALTER TABLE ar_activity ADD FOREIGN KEY (session_id) REFERENCES ar_session (session_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ar_activity MODIFY COLUMN pid bigint(20) NOT NULL;
ALTER TABLE ar_activity ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ar_session MODIFY COLUMN user_id bigint(20) NOT NULL;
ALTER TABLE ar_session ADD FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ar_session ADD FOREIGN KEY (payer_id) REFERENCES insurance_companies (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE batchcom ADD FOREIGN KEY (sent_by) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE batchcom MODIFY COLUMN patient_id bigint(20) NOT NULL;
ALTER TABLE batchcom ADD FOREIGN KEY (patient_id) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE billing MODIFY COLUMN provider_id bigint(20) NOT NULL;
ALTER TABLE billing ADD FOREIGN KEY (provider_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE billing MODIFY COLUMN `user` bigint(20) NOT NULL;
ALTER TABLE billing ADD FOREIGN KEY (`user`) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE billing ADD FOREIGN KEY (x12_partner_id) REFERENCES x12_partners (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE billing MODIFY COLUMN pid bigint(20) NOT NULL;
ALTER TABLE billing ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE billing ADD FOREIGN KEY (payer_id) REFERENCES insurance_companies (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE billing MODIFY COLUMN encounter int(11) DEFAULT NULL;

ALTER TABLE categories_to_documents ADD FOREIGN KEY (category_id) REFERENCES categories (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE categories_to_documents ADD FOREIGN KEY (document_id) REFERENCES documents (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE chart_tracker MODIFY COLUMN `ct_pid` bigint(20) NOT NULL;
ALTER TABLE chart_tracker ADD FOREIGN KEY (ct_pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE chart_tracker MODIFY COLUMN `ct_userid` bigint(20) NOT NULL;
ALTER TABLE chart_tracker ADD FOREIGN KEY (ct_userid) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE claims MODIFY COLUMN `patient_id` bigint(20) NOT NULL;
ALTER TABLE claims ADD FOREIGN KEY (patient_id) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE claims MODIFY COLUMN `payer_id` int(11) NOT NULL;
ALTER TABLE claims ADD FOREIGN KEY (payer_id) REFERENCES insurance_companies (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE claims MODIFY COLUMN `x12_partner_id` int(11) DEFAULT NULL;
ALTER TABLE claims ADD FOREIGN KEY (x12_partner_id) REFERENCES x12_partners (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE codes MODIFY COLUMN `code_type` int(11) DEFAULT NULL;
ALTER TABLE codes ADD FOREIGN KEY (code_type) REFERENCES code_types (ct_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE documents ADD FOREIGN KEY (list_id) REFERENCES lists (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE drug_inventory ADD FOREIGN KEY (drug_id) REFERENCES drugs (drug_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE drug_sales ADD FOREIGN KEY (drug_id) REFERENCES drugs (drug_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE drug_templates ADD FOREIGN KEY (drug_id) REFERENCES drugs (drug_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE employer_data ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE form_dictation ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE form_encounter ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE form_encounter MODIFY COLUMN `pc_catid` int(11) unsigned  DEFAULT NULL;
ALTER TABLE form_encounter ADD FOREIGN KEY (pc_catid) REFERENCES openemr_postcalendar_categories (pc_catid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE form_encounter MODIFY COLUMN `provider_id` bigint(20) DEFAULT NULL;
ALTER TABLE form_encounter ADD FOREIGN KEY (provider_id ) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE form_encounter MODIFY COLUMN `supervisor_id` bigint(20) DEFAULT NULL;
ALTER TABLE form_encounter ADD FOREIGN KEY (supervisor_id ) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE form_misc_billing_options ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE form_reviewofs ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE form_ros MODIFY COLUMN `pid` bigint(20) DEFAULT NULL;
ALTER TABLE form_ros ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE form_soap ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE form_vitals ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE forms ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE geo_zone_reference ADD FOREIGN KEY (zone_country_id) REFERENCES geo_country_reference (countries_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE history_data ADD FOREIGN KEY (pid ) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE immunizations MODIFY COLUMN `patient_id` bigint(20) DEFAULT NULL;
ALTER TABLE immunizations ADD FOREIGN KEY (patient_id) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE insurance_data ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE insurance_numbers MODIFY COLUMN `provider_id` bigint(20) DEFAULT NULL;
ALTER TABLE insurance_numbers ADD FOREIGN KEY (provider_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE insurance_numbers ADD FOREIGN KEY (insurance_company_id) REFERENCES insurance_companies(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE issue_encounter MODIFY COLUMN `list_id` bigint(20) DEFAULT NULL;
ALTER TABLE issue_encounter ADD FOREIGN KEY (list_id) REFERENCES lists(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE lang_definitions ADD FOREIGN KEY (cons_id) REFERENCES lang_constants (cons_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE lang_definitions ADD FOREIGN KEY (lang_id) REFERENCES lang_languages (lang_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE lbf_data MODIFY COLUMN `form_id` bigint(20) DEFAULT NULL;
ALTER TABLE lbf_data ADD FOREIGN KEY (form_id) REFERENCES forms (id) ON UPDATE CASCADE ON DELETE CASCADE;

/*
ALTER TABLE log MODIFY COLUMN `patient_id` bigint(20) DEFAULT NULL;
ALTER TABLE log ADD FOREIGN KEY (patient_id) REFERENCES patient_data(id) ON UPDATE CASCADE ON DELETE CASCADE;
*/

ALTER TABLE list_options ADD INDEX (option_id);

ALTER TABLE openemr_postcalendar_events MODIFY COLUMN `pc_catid` int(11) unsigned;
ALTER TABLE openemr_postcalendar_events ADD FOREIGN KEY (pc_catid) REFERENCES openemr_postcalendar_categories (pc_catid) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE openemr_postcalendar_limits MODIFY COLUMN `pc_catid` int(11) unsigned;
ALTER TABLE openemr_postcalendar_limits ADD FOREIGN KEY (pc_catid) REFERENCES openemr_postcalendar_categories (pc_catid) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE payments ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE pnotes ADD FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE prescriptions MODIFY COLUMN `patient_id` bigint(20) ;
ALTER TABLE prescriptions ADD FOREIGN KEY (patient_id) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE prescriptions MODIFY COLUMN `provider_id` bigint(20) ;
ALTER TABLE prescriptions ADD FOREIGN KEY (provider_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE prescriptions ADD FOREIGN KEY (drug_id) REFERENCES drugs (drug_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE procedure_order ADD FOREIGN KEY (provider_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE procedure_order ADD FOREIGN KEY (patient_id) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE procedure_order ADD FOREIGN KEY (encounter_id) REFERENCES form_encounter (id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE procedure_report ADD FOREIGN KEY (procedure_order_id) REFERENCES procedure_order (procedure_order_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE procedure_report ADD FOREIGN KEY (source) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE procedure_result ADD FOREIGN KEY (procedure_report_id) REFERENCES procedure_report (procedure_report_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE procedure_result ADD FOREIGN KEY (procedure_type_id) REFERENCES procedure_type (procedure_type_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE procedure_type ADD FOREIGN KEY (parent) REFERENCES procedure_type (procedure_type_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE procedure_type ADD FOREIGN KEY (lab_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE transactions ADD FOREIGN KEY (pid) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE users_facility ADD FOREIGN KEY (facility_id) REFERENCES facility (id) ON UPDATE CASCADE ON DELETE CASCADE;

/**********************************************************
 *  Start new tables
 ***********************************************************/

DROP TABLE IF EXISTS patient_reason_codes;
CREATE TABLE patient_reason_codes (
  id int unsigned not null auto_increment,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
DROP TABLE IF EXISTS medical_reason_codes;
CREATE TABLE medical_reason_codes (
  id int unsigned not null auto_increment,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
DROP TABLE IF EXISTS system_reason_codes;
CREATE TABLE system_reason_codes (
  id int unsigned not null auto_increment,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

/* Medication */

DELETE FROM list_options WHERE list_id = 'medicationstatus';
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("medicationstatus", 0, "", 0, 1, 0, 0),
("medicationstatus", 10, "Active", 10, 0, 10, 0),
("medicationstatus", 20, "Administered", 20, 0, 20, 0),
("medicationstatus", 30, "Ordered", 30, 0, 30, 0),
("medicationstatus", 40, "Dispensed", 40, 0, 40, 0),
("medicationstatus", 50, "On Hold", 50, 0, 50, 0),
("medicationstatus", 60, "Prior History No Longer Active", 60, 0, 60, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("medicationproducttype", 0, "", 0, 1, 0, 0),
("medicationproducttype", 10, "Medication", 10, 0, 10, 0),
("medicationproducttype", 20, "IV Fluid", 20, 0, 20, 0),
("medicationproducttype", 30, "Parental Nutrition", 30, 0, 30, 0),
("medicationproducttype", 40, "Supplemental Nutrition", 40, 0, 40, 0),
("medicationproducttype", 50, "Immunization", 50, 0, 50, 0),
("medicationproducttype", 60, "Disposable", 60, 0, 60, 0),
("medicationproducttype", 70, "Supplies", 70, 0, 70, 0),
("medicationproducttype", 80, "Device", 80, 0, 80, 0),
("medicationproducttype", 90, "Implantable Device", 90, 0, 90, 0),
("medicationproducttype", 100, "Durable Medical Equipment", 100, 0, 100, 0);

DELETE FROM list_options WHERE list_id = 'drug_route';
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("drug_route", 0, "", 0, 1, 0, 0),
("drug_route", 10, "Apply Externally", 10, 0, 10, 0),
("drug_route", 20, "Buccal", 20, 0, 20, 0),
("drug_route", 30, "Dental", 30, 0, 30, 0),
("drug_route", 40, "Epidural", 40, 0, 40, 0),
("drug_route", 50, "Endotrachial Tube", 50, 0, 50, 0),
("drug_route", 60, "Gastrostomy Tube", 60, 0, 60, 0),
("drug_route", 70, "Irrigant", 70, 0, 70, 0),
("drug_route", 80, "Immerse", 80, 0, 80, 0),
("drug_route", 90, "(Soak) Body Part", 90, 0, 90, 0),
("drug_route", 100, "Intra-arterial", 100, 0, 100, 0),
("drug_route", 110, "Intrabursal", 110, 0, 110, 0),
("drug_route", 120, "Intracardiac", 120, 0, 120, 0),
("drug_route", 130, "Intracervical", 130, 0, 130, 0),
("drug_route", 140, "Intradermal", 140, 0, 140, 0),
("drug_route", 150, "Inhalation", 150, 0, 150, 0),
("drug_route", 160, "Intrahepatic Artery", 160, 0, 160, 0),
("drug_route", 170, "Intramuscular", 170, 0, 170, 0),
("drug_route", 180, "Intranasal", 180, 0, 180, 0),
("drug_route", 190, "Intraocular", 190, 0, 190, 0),
("drug_route", 200, "Intraperitoneal", 200, 0, 200, 0),
("drug_route", 210, "Intrasynovial", 210, 0, 210, 0),
("drug_route", 220, "Intrathecal", 220, 0, 220, 0),
("drug_route", 230, "Intrauterine", 230, 0, 230, 0),
("drug_route", 240, "Intraveneous", 240, 0, 240, 0),
("drug_route", 250, "Mouth/Throat", 250, 0, 250, 0),
("drug_route", 260, "Nasal", 260, 0, 260, 0),
("drug_route", 270, "Nasogastric", 270, 0, 270, 0),
("drug_route", 280, "Nasal Prongs", 280, 0, 280, 0),
("drug_route", 290, "Nasotrachial Tube", 290, 0, 290, 0),
("drug_route", 300, "Opthamalic", 300, 0, 300, 0),
("drug_route", 310, "Otic", 310, 0, 310, 0),
("drug_route", 320, "Other/Miscellaneous", 320, 0, 320, 0),
("drug_route", 330, "Perfusion", 330, 0, 330, 0),
("drug_route", 340, "Oral", 340, 0, 340, 0),
("drug_route", 350, "Rectal", 350, 0, 350, 0),
("drug_route", 360, "Rebreather Mask", 360, 0, 360, 0),
("drug_route", 370, "Soaked Dressing", 370, 0, 370, 0),
("drug_route", 380, "Subcutaneous", 380, 0, 380, 0),
("drug_route", 390, "Sublingual", 390, 0, 390, 0),
("drug_route", 400, "Topical", 400, 0, 400, 0),
("drug_route", 410, "Tracheostomy", 410, 0, 410, 0),
("drug_route", 420, "Transdemal", 420, 0, 420, 0),
("drug_route", 430, "Transligual", 430, 0, 430, 0),
("drug_route", 440, "Urethral", 440, 0, 440, 0),
("drug_route", 450, "Vaginal", 450, 0, 450, 0),
("drug_route", 460, "Ventimask", 460, 0, 460, 0),
("drug_route", 470, "Wound", 470, 0, 470, 0);
/*
ALTER TABLE prescriptions 
  DROP COLUMN negation_rational_type,
  DROP COLUMN negation_rational_id,
  DROP COLUMN rxnorm_id,
  DROP COLUMN site_id;
  */

ALTER TABLE lists
  ADD COLUMN negationrationale_id int DEFAULT NULL COMMENT "Ptr to patient_reason_code, medical_reason_code, system_reason_code, or codes",
  ADD FOREIGN KEY (negationrationale_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN rxnorm_id int DEFAULT NULL COMMENT "RxNORM Ptr to codes:id",
  ADD FOREIGN KEY (rxnorm_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN site_id int DEFAULT NULL COMMENT "Site Ptr to codes:id",
  ADD FOREIGN KEY (site_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN producttype_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options:option_id list 'medicationproducttype'",
  ADD FOREIGN KEY (producttype_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN route_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'drug_route'",
  ADD FOREIGN KEY (route_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN medication_form VARCHAR(255) DEFAULT NULL COMMENT "Medication field - form",
  ADD COLUMN medication_strength VARCHAR(255) DEFAULT NULL COMMENT "Medication field - strength",
  ADD COLUMN medication_quantity VARCHAR(255) DEFAULT NULL COMMENT "Medication field - quantity",
  ADD COLUMN medication_directions VARCHAR(255) DEFAULT NULL COMMENT "Medication field - directions",
  ADD COLUMN medication_frequency VARCHAR(255) DEFAULT NULL COMMENT "Medication field - frequency",
  ADD COLUMN medication_route VARCHAR(255) DEFAULT NULL COMMENT "Medication field - route",
  ADD COLUMN medication_dose VARCHAR(255) DEFAULT NULL COMMENT "Medication field - dose",
  ADD COLUMN medication_value VARCHAR(255) DEFAULT NULL COMMENT "Medication field - value",
  ADD COLUMN medication_unit VARCHAR(255) DEFAULT NULL COMMENT "Medication field - unit",
  ADD COLUMN medication_indications VARCHAR(255) DEFAULT NULL COMMENT "Medication field - indications",
  ADD COLUMN medication_patient_instructions VARCHAR(255) DEFAULT NULL COMMENT "Medication field - patient instructions",
  ADD COLUMN medication_refills VARCHAR(255) DEFAULT NULL COMMENT "Medication field - refills",
  ADD COLUMN medication_source VARCHAR(255) DEFAULT NULL COMMENT "Medication field - source"
;
/*
ALTER TABLE lists
  ADD COLUMN medication_form VARCHAR(255) DEFAULT NULL COMMENT "Medication field - form",
  ADD COLUMN medication_strength VARCHAR(255) DEFAULT NULL COMMENT "Medication field - strength",
  ADD COLUMN medication_quantity VARCHAR(255) DEFAULT NULL COMMENT "Medication field - quantity",
  ADD COLUMN medication_directions VARCHAR(255) DEFAULT NULL COMMENT "Medication field - directions",
  ADD COLUMN medication_frequency VARCHAR(255) DEFAULT NULL COMMENT "Medication field - frequency",
  ADD COLUMN medication_route VARCHAR(255) DEFAULT NULL COMMENT "Medication field - route",
  ADD COLUMN medication_dose VARCHAR(255) DEFAULT NULL COMMENT "Medication field - dose",
  ADD COLUMN medication_value VARCHAR(255) DEFAULT NULL COMMENT "Medication field - value",
  ADD COLUMN medication_unit VARCHAR(255) DEFAULT NULL COMMENT "Medication field - unit",
  ADD COLUMN medication_indications VARCHAR(255) DEFAULT NULL COMMENT "Medication field - indications",
  ADD COLUMN medication_patient_instructions VARCHAR(255) DEFAULT NULL COMMENT "Medication field - patient instructions",
  ADD COLUMN medication_refills VARCHAR(255) DEFAULT NULL COMMENT "Medication field - refills",
  ADD COLUMN medication_source VARCHAR(255) DEFAULT NULL COMMENT "Medication field - source"
*/

/* Devices / Medical Equipment */
DROP TABLE IF EXISTS medical_equipment;
CREATE TABLE medical_equipment (
  id int(11) UNSIGNED NOT NULL auto_increment,
  pid bigint(20)  NOT NULL DEFAULT 0,
  device_type int(11) NOT NULL DEFAULT 0,
  ordered datetime NOT NULL,
  applied datetime NOT NULL,
  negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  negation_rationale_type int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  INDEX (negation_rationale_id),
  PRIMARY KEY (id),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (device_type) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


/* Allergy, Adverse Reaction */
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping, notes) VALUES 
("adversereaction", 0, "", 0, 1, 0, 0, ""),
("adversereaction","10","Propensity to Adverse Reaction to Drug",10,1,10,0,"419511003"),
("adversereaction","20","Propensity to Adverse Reaction to Food",20,0,20,0,"418471000"),
("adversereaction","30","Propensity to Adverse Reaction to Substance",30,0,30,0,"418038007"),
("adversereaction","40","Propensity to Adverse Reaction",40,0,40,0,"420134006"),
("adversereaction","50","Adverse Event to Device",50,0,50,0,""),
("adversereaction","60","Adverse Event to Lab Test",60,0,60,0,""),
("adversereaction","70","Adverse Event to Procedure",70,0,70,0,""),
("adversereaction","80","Adverse Event to Substance",80,0,80,0,""),
("adversereaction","90","Adverse Event to Diagnostic Study",90,0,90,0,""),
("adversereaction","100","Allergy to Drug",100,0,100,0,"4106098002"),
("adversereaction","110","Allergy to Food",110,0,110,0,"41142850011"),
("adversereaction","120","Allergy to Substance",120,0,120,0,"41291299007"),
("adversereaction","130","Allergy to Device",130,0,130,0,""),
("adversereaction","140","Intolerance to Drug",140,0,140,0,"59037007"),
("adversereaction","150","Intolerance to Food",150,0,150,0,"2357159002"),
("adversereaction","160","Intolerance to Device",160,0,160,0,""),
("adversereaction","170","Intolerance to Lab Test",170,0,170,0,""),
("adversereaction","180","Intolerance to Procedure",180,0,180,0,""),
("adversereaction","190","Intolerance to Substance",190,0,190,0,""),
("adversereaction","200","Intolerance to Diagnostic Study",200,0,200,0,""),
("adversereaction","210","Alert",210,0,210,0,""),
("adversereaction","220","Critical Result",220,0,220,0,"");

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping, notes) VALUES 
("severity", 0, "", 0, 1, 0, 0, ""),
("severity","10","Minimal",10,1,10,0,""),
("severity","20","Mild",20,0,20,0,""),
("severity","30","Moderate",30,0,30,0,""),
("severity","40","Severe",40,0,40,0,""),
("severity","50","Life Threatening",50,0,50,0,""),
("severity","60","Critical",60,0,60,0,""),
("severity","70","Fatal",70,0,70,0,"");

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping, notes) VALUES 
("adversestatus", 0, "", 0, 1, 0, 0, ""),
("adversestatus","10","Active",10,1,10,0,""),
("adversestatus","20","Prior History No Longer Active",20,0,20,0,"");

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("adverseagent", 0, "", 0, 1, 0, 0),
("adverseagent", 10, "Food", 10, 0, 10, 0),
("adverseagent", 20, "Product", 20, 0, 20, 0),
("adverseagent", 30, "Substance", 30, 0, 30, 0),
("adverseagent", 40, "Environment", 40, 0, 40, 0);

ALTER TABLE lists 
  ADD COLUMN reaction_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'adversereaction'",
  ADD FOREIGN KEY (reaction_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN severity_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'severity'",
  ADD FOREIGN KEY (severity_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN adverse_agent_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'adverseagent'",
  ADD FOREIGN KEY (adverse_agent_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN adverse_agent_ptr_id int DEFAULT NULL COMMENT "Agent Ptr to codes:id",
  ADD FOREIGN KEY (adverse_agent_ptr_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN adverse_agent_medical_equipment_id int unsigned DEFAULT NULL COMMENT "Agent Ptr to medical_equipment:id",
  ADD FOREIGN KEY (adverse_agent_medical_equipment_id) REFERENCES medical_equipment (id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN adverse_agent_test_id bigint DEFAULT NULL COMMENT "Agent Ptr to prodedure_result:id",
  ADD FOREIGN KEY (adverse_agent_test_id) REFERENCES procedure_result (procedure_result_id) ON UPDATE CASCADE ON DELETE CASCADE
;


/* Diagnosis / Problem / Condition / Issue */
ALTER TABLE lists
  ADD COLUMN problem_type_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosisproblemtype'",
  ADD FOREIGN KEY (problem_type_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN diagnosis_type_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosistype'",
  ADD FOREIGN KEY (diagnosis_type_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN healthstatus_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'issuehealthstatus'",
  ADD FOREIGN KEY (healthstatus_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN status_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'issuestatus'",
  ADD FOREIGN KEY (status_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN description_code_id int DEFAULT NULL COMMENT "Description Ptr to codes:id",
  ADD FOREIGN KEY (description_code_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE
;


INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping, notes) VALUES 
("diagnosistype", 0, "", 0, 1, 0, 0, ""),
("diagnosistype","10","Admitting",10,1,10,0,""),
("diagnosistype","20","Final",20,0,20,0,""),
("diagnosistype","30","Working",30,0,30,0,"");

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("issuehealthstatus", 0, "", 0, 1, 0, 0),
("issuehealthstatus", 10, "Alive and Well", 10, 0, 10, 0),
("issuehealthstatus", 20, "In Remission", 20, 0, 20, 0),
("issuehealthstatus", 30, "Symptom Free", 30, 0, 30, 0),
("issuehealthstatus", 40, "Chronically Ill", 40, 0, 40, 0),
("issuehealthstatus", 50, "Severely Ill", 50, 0, 50, 0),
("issuehealthstatus", 60, "Disabled", 60, 0, 60, 0),
("issuehealthstatus", 70, "Severely Disabled", 70, 0, 70, 0),
("issuehealthstatus", 80, "Deceased", 80, 0, 80, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("diagnosisproblemtype", 0, "", 0, 1, 0, 0),
("diagnosisproblemtype", 10, "Problem", 10, 0, 10, 0),
("diagnosisproblemtype", 20, "Condition", 20, 0, 20, 0),
("diagnosisproblemtype", 30, "Diagnosis", 30, 0, 30, 0),
("diagnosisproblemtype", 40, "Symptom", 40, 0, 40, 0),
("diagnosisproblemtype", 50, "Finding", 50, 0, 50, 0),
("diagnosisproblemtype", 60, "Complaint", 60, 0, 60, 0),
("diagnosisproblemtype", 70, "Functional Limitation", 70, 0, 70, 0),
("diagnosisproblemtype", 80, "Family History", 80, 0, 80, 0),
("diagnosisproblemtype", 90, "Risk-Of", 90, 0, 90, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("diagnosisstatus", 0, "", 0, 1, 0, 0),
("diagnosisstatus", 10, "Active", 10, 0, 10, 0),
("diagnosisstatus", 20, "Assessed", 20, 0, 20, 0),
("diagnosisstatus", 30, "Inactive", 30, 0, 30, 0),
("diagnosisstatus", 40, "Chronically ill", 40, 0, 40, 0),
("diagnosisstatus", 50, "Intermittent", 50, 0, 50, 0),
("diagnosisstatus", 60, "Recurrent", 60, 0, 60, 0),
("diagnosisstatus", 70, "Rule Out", 70, 0, 70, 0),
("diagnosisstatus", 80, "Ruled Out", 80, 0, 80, 0),
("diagnosisstatus", 90, "Resolved", 90, 0, 90, 0);

/* Immunizations */
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("immunizationnegationreason", 0, "", 0, 1, 0, 0),
("immunizationnegationreason", 10, "Immunity ", 10, 0, 10, 0),
("immunizationnegationreason", 20, "Medical Precaution ", 20, 0, 20, 0),
("immunizationnegationreason", 30, "Out of stock ", 30, 0, 30, 0),
("immunizationnegationreason", 40, "Patient Objection ", 40, 0, 40, 0),
("immunizationnegationreason", 50, "Philosophical Objection ", 50, 0, 50, 0),
("immunizationnegationreason", 60, "Religious Objection ", 60, 0, 60, 0),
("immunizationnegationreason", 70, "Vaccine Efficacy Concerns ", 70, 0, 70, 0),
("immunizationnegationreason", 80, "Vaccine Safety Concerns ", 80, 0, 80, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("immunizationsource", 0, "", 0, 1, 0, 0),
("immunizationsource", 10, "New immunization record", 10, 0, 10, 0),
("immunizationsource", 20, "Historical information - source unspecified", 20, 0, 20, 0),
("immunizationsource", 30, "Historical information - from other provider", 30, 0, 30, 0),
("immunizationsource", 40, "Historical information - from parent's written record", 40, 0, 40, 0),
("immunizationsource", 50, "Historical information - from parent's recall", 50, 0, 50, 0),
("immunizationsource", 60, "Historical information - from other registry", 60, 0, 60, 0),
("immunizationsource", 70, "Historical information - from birth certificate", 70, 0, 70, 0),
("immunizationsource", 80, "Historical information - from school record", 80, 0, 80, 0),
("immunizationsource", 90, "Historical information - from public agency", 90, 0, 90, 0);

ALTER TABLE immunizations
  ADD COLUMN product_name VARCHAR(255) DEFAULT NULL COMMENT "Product Name / Brand Name",
  ADD COLUMN description_code VARCHAR(255) DEFAULT NULL COMMENT "Description Code, PTR to CVX Code",
  ADD COLUMN vaccine_description VARCHAR(255) DEFAULT NULL COMMENT "Vaccine Description",
  ADD COLUMN negationreason_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'immunizationnegationreason'",
  ADD FOREIGN KEY (negationreason_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN source_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'immunizationsource'",
  ADD FOREIGN KEY (source_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE

;

ALTER TABLE immunizations
  ADD COLUMN site_id int DEFAULT NULL COMMENT "Site Ptr to codes:id",
  ADD FOREIGN KEY (site_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN route_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'drug_route'",
  ADD FOREIGN KEY (route_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE
;
  
/* Procedure */

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("procedurestatus", 0, "", 0, 1, 0, 0),
("procedurestatus", 10, "Ordered", 10, 0, 10, 0),
("procedurestatus", 20, "Canceled", 20, 0, 20, 0),
("procedurestatus", 30, "On Hold", 30, 0, 30, 0),
("procedurestatus", 40, "In Progress", 40, 0, 40, 0),
("procedurestatus", 50, "Not Completed", 50, 0, 50, 0),
("procedurestatus", 60, "Completed", 60, 0, 60, 0);

ALTER TABLE procedure_type
  ADD COLUMN negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rational HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD INDEX (negation_rationale_id),
  ADD COLUMN negation_rationale_type VARCHAR(31) DEFAULT NULL COMMENT "Negation Rational HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD COLUMN status_id varchar(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'procedurestatus'",
  ADD FOREIGN KEY (status_id) REFERENCES list_options (option_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD COLUMN vaccination_type varchar(31) DEFAULT NULL COMMENT "Vaccination Type",
  ADD COLUMN method varchar(255) NOT NULL DEFAULT '' COMMENT "HL7 Method",
  ADD COLUMN position varchar(255) NOT NULL DEFAULT '' COMMENT "HL7 Position",
  ADD COLUMN body_location varchar(255) NOT NULL DEFAULT '' COMMENT "HL7 Body Location",
  ADD COLUMN substance varchar(255) NOT NULL DEFAULT '' COMMENT "HL7 Substance",
  ADD COLUMN procedure_source varchar(255) NOT NULL DEFAULT '' COMMENT "HL7 Procedure Source, URI to local or external provider directory",
  ADD COLUMN practitioner varchar(255) NOT NULL DEFAULT '' COMMENT "HL7 Practitioner, URI to local or external provider directory"
;

ALTER TABLE lists
  ADD COLUMN procedure_id bigint(20) DEFAULT NULL COMMENT "Related Problem / Issue, Ptr to procedure_type:procedure_type_id",
  ADD FOREIGN KEY (procedure_id) REFERENCES procedure_type (procedure_type_id) ON UPDATE CASCADE ON DELETE CASCADE
;

ALTER TABLE prescriptions
  ADD COLUMN procedure_id bigint(20) DEFAULT NULL COMMENT "Related Medication, Ptr to procedure_type:procedure_type_id",
  ADD FOREIGN KEY (procedure_id) REFERENCES procedure_type (procedure_type_id) ON UPDATE CASCADE ON DELETE CASCADE
;


/* Diagnostic */
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("diagnosticresultnormalcy", 0, "", 0, 1, 0, 0),
("diagnosticresultnormalcy", 10, "Better", 10, 0, 10, 0),
("diagnosticresultnormalcy", 20, "Decreased", 20, 0, 20, 0),
("diagnosticresultnormalcy", 30, "Increased", 30, 0, 30, 0),
("diagnosticresultnormalcy", 40, "Worse", 40, 0, 40, 0),
("diagnosticresultnormalcy", 50, "Low off scale", 50, 0, 50, 0),
("diagnosticresultnormalcy", 60, "High off scale", 60, 0, 60, 0),
("diagnosticresultnormalcy", 70, "Abnormal", 70, 0, 70, 0),
("diagnosticresultnormalcy", 80, "Abnormal alert", 80, 0, 80, 0),
("diagnosticresultnormalcy", 90, "High alert", 90, 0, 90, 0),
("diagnosticresultnormalcy", 100, "Low alert", 100, 0, 100, 0),
("diagnosticresultnormalcy", 110, "High", 110, 0, 110, 0),
("diagnosticresultnormalcy", 120, "Low", 120, 0, 120, 0),
("diagnosticresultnormalcy", 130, "Normal", 130, 0, 130, 0),
("diagnosticresultnormalcy", 140, "Intermediate", 140, 0, 140, 0),
("diagnosticresultnormalcy", 150, "Moderately susceptible", 150, 0, 150, 0),
("diagnosticresultnormalcy", 160, "Resistant", 160, 0, 160, 0),
("diagnosticresultnormalcy", 170, "Susceptible", 170, 0, 170, 0),
("diagnosticresultnormalcy", 180, "Very susceptible", 180, 0, 180, 0),
("diagnosticresultnormalcy", 190, "Above high threshold", 190, 0, 190, 0),
("diagnosticresultnormalcy", 200, "Below low threshold", 200, 0, 200, 0);


INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("diagnosticresulttesttype", 0, "", 0, 1, 0, 0),
("diagnosticresulttesttype", 10, "Observation", 10, 0, 10, 0),
("diagnosticresulttesttype", 20, "Result", 20, 0, 20, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("diagnosticresultstype", 0, "", 0, 1, 0, 0),
("diagnosticresultstype", 10, "Hematology", 10, 0, 10, 0),
("diagnosticresultstype", 20, "Chemistry", 20, 0, 20, 0),
("diagnosticresultstype", 30, "Serology", 30, 0, 30, 0),
("diagnosticresultstype", 40, "Virology", 40, 0, 40, 0),
("diagnosticresultstype", 50, "Toxicology", 50, 0, 50, 0),
("diagnosticresultstype", 60, "Microbiology", 60, 0, 60, 0),
("diagnosticresultstype", 70, "Imaging & X-ray", 70, 0, 70, 0),
("diagnosticresultstype", 80, "Ultrasound", 80, 0, 80, 0),
("diagnosticresultstype", 90, "CT", 90, 0, 90, 0),
("diagnosticresultstype", 100, "MRI", 100, 0, 100, 0),
("diagnosticresultstype", 110, "Angiography", 110, 0, 110, 0),
("diagnosticresultstype", 120, "Cardiac Echo", 120, 0, 120, 0),
("diagnosticresultstype", 130, "Nuclear Medicine", 130, 0, 130, 0),
("diagnosticresultstype", 140, "Pathology", 140, 0, 140, 0),
("diagnosticresultstype", 150, "Procedure", 150, 0, 150, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("diagnosticresultstatus", 0, "", 0, 1, 0, 0),
("diagnosticresultstatus", 10, "Completed", 10, 0, 10, 0),
("diagnosticresultstatus", 20, "Aborted", 20, 0, 20, 0),
("diagnosticresultstatus", 30, "Active", 30, 0, 30, 0),
("diagnosticresultstatus", 40, "Canceled", 40, 0, 40, 0),
("diagnosticresultstatus", 50, "Held", 50, 0, 50, 0),
("diagnosticresultstatus", 60, "New", 60, 0, 60, 0),
("diagnosticresultstatus", 70, "Suspended", 70, 0, 70, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("diagnosticresultteststatus", 0, "", 0, 1, 0, 0),
("diagnosticresultteststatus", 10, "Pending", 10, 0, 10, 0),
("diagnosticresultteststatus", 20, "In Process", 20, 0, 20, 0),
("diagnosticresultteststatus", 30, "Preliminary", 30, 0, 30, 0),
("diagnosticresultteststatus", 40, "Results", 40, 0, 40, 0),
("diagnosticresultteststatus", 50, "Final Results", 50, 0, 50, 0),
("diagnosticresultteststatus", 60, "Corrected Results", 60, 0, 60, 0);


DROP TABLE IF EXISTS form_diagnostic_tests;
CREATE TABLE form_diagnostic_tests (
  id int unsigned not null auto_increment,
  pid bigint(20) NOT NULL DEFAULT 0 COMMENT "Patient ID",
  test_procedure_id int DEFAULT NULL COMMENT "CPT-4, LOINC, SNOMED, or HCPCS Ptr to codes:id",
  test_procedure_record_id bigint(20) DEFAULT NULL COMMENT "procedure_results:procedure_result_id",
  result_normalcy_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresultnormalcy",
  result_status_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresultstatus",
  negation_rationale_id int DEFAULT NULL COMMENT "HL7 Patient Reason Code, Medical Reason code, or SNOMED Code Ptr to codes:id",
  result_test_type_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresulttesttype",
  result_description text DEFAULT NULL,
  result_type_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresulttype",
  result_test_status_id VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresultteststatus",
  test_description text DEFAULT NULL,
  order_date datetime DEFAULT NULL,
  test_date datetime DEFAULT NULL,
  performed_date datetime DEFAULT NULL,
  result_date datetime DEFAULT NULL,
  test_result_value text DEFAULT NULL,
  source varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (test_procedure_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (test_procedure_record_id) REFERENCES procedure_result (procedure_result_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (negation_rationale_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX(test_procedure_id),
  INDEX(test_procedure_record_id),
  INDEX(result_normalcy_id),
  INDEX(result_status_id),
  INDEX(result_test_type_id),
  INDEX(result_test_status_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS diagnostic_test_result_values;
CREATE TABLE form_diagnostic_test_result_values (
  id bigint unsigned not null auto_increment,
  diagnostic_test_id int unsigned NOT NULL COMMENT "Ptr to diagnostic_tests:id",
  result_code_id int NOT NULL COMMENT "Ptr to codes:id",
  PRIMARY KEY (id),
  FOREIGN KEY (diagnostic_test_id) REFERENCES form_diagnostic_tests (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (result_code_id) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (diagnostic_test_id, result_code_id)
) ENGINE=InnoDB;
/*
ALTER TABLE procedure_result
  ADD COLUMN negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rational HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD INDEX (negation_rationale_id),
  ADD COLUMN negation_rationale_type VARCHAR(31) DEFAULT NULL COMMENT "Negation Rational HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD COLUMN result_test_type VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresulttesttype'",
  ADD COLUMN result_description VARCHAR(255) DEFAULT NULL COMMENT "Text description associated with the test procedure code",
  ADD COLUMN results_type VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresultstype'",
  ADD COLUMN test_result_value_codes VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'diagnosticresultstype'"
;
*/

/* Encounter */
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("encounterclass", 0, "", 0, 1, 0, 0),
("encounterclass", 10, "Emergency", 10, 0, 10, 0),
("encounterclass", 20, "Inpatient Encounter", 20, 0, 20, 0),
("encounterclass", 30, "Ambulatory", 30, 0, 30, 0);

ALTER TABLE form_encounter
  ADD COLUMN encounter_class VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'encounterclass'",
  ADD COLUMN encounter_type_id int(11) unsigned DEFAULT NULL COMMENT "Encounter HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD INDEX (encounter_type_id),
  ADD COLUMN encounter_type_type VARCHAR(31) DEFAULT NULL COMMENT "Encounter HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD COLUMN encounter_type_description VARCHAR(255) DEFAULT NULL COMMENT "Text description associated with the encounter type code",
  ADD COLUMN encounter_id VARCHAR(255) DEFAULT NULL COMMENT "HL7 Encounter ID",
  ADD COLUMN indications text DEFAULT NULL COMMENT "HL7 indications"
;

/* Vital Signs */
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("vitalsignresult", 0, "", 0, 1, 0, 0),
("vitalsignresult", 10, "Respiratory Rate ", 10, 0, 10, 0),
("vitalsignresult", 20, "Heart Rate ", 20, 0, 20, 0),
("vitalsignresult", 30, "O2 % BldC Oximetry ", 30, 0, 30, 0),
("vitalsignresult", 40, "BP Systolic ", 40, 0, 40, 0),
("vitalsignresult", 50, "BP Diastolic ", 50, 0, 50, 0),
("vitalsignresult", 60, "Body Temperature ", 60, 0, 60, 0),
("vitalsignresult", 70, "Height ", 70, 0, 70, 0),
("vitalsignresult", 80, "Height (Lying) ", 80, 0, 80, 0),
("vitalsignresult", 90, "Head Circumference ", 90, 0, 90, 0),
("vitalsignresult", 100, "Weight Measured", 100, 0, 100, 0),
("vitalsignresult", 110, "BMI", 110, 0, 110, 0);

ALTER TABLE form_vitals
  ADD COLUMN vital_sign_result VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'vitalsignresult'",
  ADD COLUMN vital_sign_id int(11) unsigned DEFAULT NULL COMMENT "Vital Sign HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD INDEX (vital_sign_id),
  ADD COLUMN vital_sign_type VARCHAR(31) DEFAULT NULL COMMENT "Vital Sign HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  ADD COLUMN vital_sign_value text DEFAULT NULL COMMENT "HL7 Vital Sign Value"
;

/* Pregnancy */
DROP TABLE IF EXISTS pregnancy;
CREATE TABLE pregnancy (
  id int(11) UNSIGNED NOT NULL auto_increment,
  pid bigint(20) NOT NULL DEFAULT 0 COMMENT "Patient ID",
  estimated_date_of_conception int(11) DEFAULT NULL  COMMENT "SNOMED CT Code",
  anti_d_immune_globulin bigint(20) DEFAULT NULL COMMENT "Ptr to Medication Record",
  drh_negative_id int(11) unsigned DEFAULT NULL COMMENT "D(Rh) negative HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  drh_negative_type VARCHAR(31) DEFAULT NULL COMMENT "D(Rh) Negative HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  delivery_live_diagnosis bigint(20) DEFAULT NULL COMMENT "HL7 Delivery Live diagnosis Ptr to lists:id",
  delivery_live_procedure bigint(20) DEFAULT NULL COMMENT "HL7 Delivery Live procedure Ptr to procedure_type:procedure_type_id",
  multigravida_diagnosis_active bigint(20) DEFAULT NULL COMMENT "HL7 Multigravida Diagnosis Active Ptr to lists:id",
  primigravida_diagnosis_active bigint(20) DEFAULT NULL COMMENT "HL7 Primigravida Diagnosis Active Ptr to lists:id",
  prenatal_visit bigint(20) DEFAULT NULL COMMENT "HL7 Prenatal Visit Ptr to form_encounter:id",
  rh_status_baby bigint(20) DEFAULT NULL COMMENT "HL7 RH Status baby Ptr to procedure_result:procedure_result_id",
  rh_status_mother bigint(20) DEFAULT NULL COMMENT "HL7 RH Status baby Ptr to procedure_result:procedure_result_id",
  baby_record_id int(11) NOT NULL DEFAULT 0 COMMENT "Baby's Record # in this OpenEMR",
  delivery_date date DEFAULT NULL  COMMENT "Delivery Date",
  PRIMARY KEY(id),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (estimated_date_of_conception) REFERENCES codes (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (anti_d_immune_globulin) REFERENCES lists (id) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX (drh_negative_id),
  FOREIGN KEY (delivery_live_diagnosis) REFERENCES lists (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (delivery_live_procedure) REFERENCES procedure_type (procedure_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (multigravida_diagnosis_active) REFERENCES lists (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (primigravida_diagnosis_active) REFERENCES lists (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (prenatal_visit) REFERENCES form_encounter (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (rh_status_baby) REFERENCES procedure_result (procedure_result_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (rh_status_mother) REFERENCES procedure_result (procedure_result_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

/* Plan of Care */
INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("caretype", 0, "", 0, 1, 0, 0),
("caretype", 10, "Reminder", 10, 0, 10, 0),
("caretype", 20, "Order", 20, 0, 20, 0),
("caretype", 30, "Prescription", 30, 0, 30, 0),
("caretype", 40, "Request for Authorization", 40, 0, 40, 0),
("caretype", 50, "Authorization", 50, 0, 50, 0),
("caretype", 60, "Referral", 60, 0, 60, 0),
("caretype", 70, "Request for Consultation", 70, 0, 70, 0),
("caretype", 80, "Treatment Recommendation", 80, 0, 80, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("carestatus", 0, "", 0, 1, 0, 0),
("carestatus", 10, "Pending", 10, 0, 10, 0),
("carestatus", 20, "In Process", 20, 0, 20, 0),
("carestatus", 30, "On Hold", 30, 0, 30, 0),
("carestatus", 40, "Canceled", 40, 0, 40, 0);

INSERT INTO list_options (list_id, option_id, title, seq, is_default, option_value, mapping) VALUES 
("careorderrequeststatus", 0, "", 0, 1, 0, 0),
("careorderrequeststatus", 10, "Ordered", 10, 0, 10, 0),
("careorderrequeststatus", 20, "Requested", 20, 0, 20, 0),
("careorderrequeststatus", 30, "Pending", 30, 0, 30, 0),
("careorderrequeststatus", 40, "On Hold", 40, 0, 40, 0),
("careorderrequeststatus", 50, "Repeat", 50, 0, 50, 0),
("careorderrequeststatus", 60, "No Show", 60, 0, 60, 0),
("careorderrequeststatus", 70, "Canceled", 70, 0, 70, 0);


DROP TABLE IF EXISTS plan_of_care;
CREATE TABLE plan_of_care (
  id int(11) unsigned NOT NULL auto_increment,
  pid bigint(20)  NOT NULL DEFAULT 0,
  care_goal_id int(11) unsigned DEFAULT NULL COMMENT "Care Goal HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  care_goal_type VARCHAR(31) DEFAULT NULL COMMENT "Care Goal HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  care_goal_date timestamp NOT NULL default NOW(),
  negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rational HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  negation_rationale_type VARCHAR(31) DEFAULT NULL COMMENT "Negation Rational HL7 Patient Reason, HL7 Medical Reason, HL7 System Reason, or SNOMED",
  care_type VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'caretype'",
  care_status VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'carestatus'",
  order_request_status VARCHAR(31) DEFAULT NULL COMMENT "Ptr to list_options, list_id 'careorderrequeststatus'",
  description text not null DEFAULT '' COMMENT "Description",
  recommendation text not null DEFAULT '' COMMENT "Recommendation",
  schedule text not null DEFAULT '' COMMENT "Schedule",
  duration text not null DEFAULT '' COMMENT "Duration, Duration Units",
  `interval` text not null DEFAULT '' COMMENT "Interval, Interval Units",
  location  text not null DEFAULT '' COMMENT "Valid Information Source",
  PRIMARY KEY(id),
  INDEX (care_goal_id),
  INDEX (negation_rationale_id),
  INDEX (care_type),
  INDEX (care_status),
  INDEX (order_request_status),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE
) Engine=InnoDB;

DROP TABLE IF EXISTS plan_of_care_reference;
CREATE TABLE plan_of_care_reference (
  id int(11) UNSIGNED NOT NULL auto_increment,
  plan_of_care_id int(11) unsigned NOT NULL DEFAULT 0,
  reference_id bigint(20) NOT NULL DEFAULT 0,
  reference_type varchar(31) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  FOREIGN KEY (plan_of_care_id) REFERENCES plan_of_care (id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (plan_of_care_id, reference_id, reference_type)
) ENGINE=InnoDB;


/* Communication */
DROP TABLE IF EXISTS communication;
CREATE TABLE communication (
  id int(11) UNSIGNED NOT NULL auto_increment,
  pid bigint(20)  NOT NULL DEFAULT 0,
  provider_to_patient_id int(11) unsigned DEFAULT NULL COMMENT "Communication to patient id",
  provider_to_patient_type int(11) unsigned DEFAULT NULL COMMENT "Communication to patient type",
  provider_to_provider_id int(11) unsigned DEFAULT NULL COMMENT "Communication from another provider id",
  provider_to_provider_type int(11) unsigned DEFAULT NULL COMMENT "Communication from another provider type",
  patient_to_provider_id int(11) unsigned DEFAULT NULL COMMENT "Communication from patient id",
  patient_to_provider_type int(11) unsigned DEFAULT NULL COMMENT "Communication from patient type",
  negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  negation_rationale_type int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  PRIMARY KEY (id),
  INDEX (provider_to_patient_id),
  INDEX (provider_to_provider_id),
  INDEX (patient_to_provider_id),
  INDEX (negation_rationale_id),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

/* Smoking */
ALTER TABLE patient_data
  ADD COLUMN smoking_status int(11) DEFAULT NULL COMMENT "Smoking Status";

/* Physical Exam */
DROP TABLE IF EXISTS physical_exam;
CREATE TABLE physical_exam (
  id int(11) UNSIGNED NOT NULL auto_increment,
  pid bigint(20)  NOT NULL DEFAULT 0,
  negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  negation_rationale_type int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  exam_date datetime,
  INDEX (negation_rationale_id),
  PRIMARY KEY (id),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS physical_exam_finding;
CREATE TABLE physical_exam_finding (
  id int(11) UNSIGNED NOT NULL auto_increment,
  physical_exam_id int(11) unsigned not null default 0,
  finding_id int(11) NOT NULL DEFAULT 0,
  finding_type varchar(31) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  INDEX (finding_id),
  FOREIGN KEY (physical_exam_id) REFERENCES physical_exam (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

/* Individual Characteristic */
/* ???? */

/* Substance */
DROP TABLE IF EXISTS substance;
CREATE TABLE substance (
  id int(11) UNSIGNED NOT NULL auto_increment,
  pid bigint(20)  NOT NULL DEFAULT 0,
  substance_name text NOT NULL DEFAULT '',
  ordered datetime NOT NULL,
  applied datetime NOT NULL,
  negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  negation_rationale_type int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  INDEX (negation_rationale_id),
  PRIMARY KEY (id),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


/* Diagnostic Study */
DROP TABLE IF EXISTS diagnostic_study;
CREATE TABLE diagnostic_study (
  id int(11) UNSIGNED NOT NULL auto_increment,
  pid bigint(20)  NOT NULL DEFAULT 0,
  diagnostic_study_name text NOT NULL DEFAULT '',
  ordered datetime NOT NULL,
  performed datetime NOT NULL,
  result datetime NOT NULL,
  negation_rationale_id int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  negation_rationale_type int(11) unsigned DEFAULT NULL COMMENT "Negation Rationale",
  INDEX (negation_rationale_id),
  PRIMARY KEY (id),
  FOREIGN KEY (pid) REFERENCES patient_data (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


/* Just to get OpenEMR to work */
ALTER TABLE procedure_type DROP FOREIGN KEY procedure_type_ibfk_1;
ALTER TABLE procedure_type DROP FOREIGN KEY procedure_type_ibfk_2;
ALTER TABLE procedure_order DROP FOREIGN KEY procedure_order_ibfk_3;

