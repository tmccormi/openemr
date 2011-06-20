CREATE TABLE IF NOT EXISTS form_clinical_soap (
 id                bigint(20)   NOT NULL auto_increment,
 activity          tinyint(1)   NOT NULL DEFAULT 1,  -- 0 if deleted
 findings          text         NOT NULL DEFAULT '',
 radiology         text         NOT NULL DEFAULT '',
 assessment        text         NOT NULL DEFAULT '',
 plan              text         NOT NULL DEFAULT '',

 followup_required int(11)      NOT NULL DEFAULT 0,  -- radio
 followup_timing   varchar(255) NOT NULL DEFAULT '',

 -- resolved, improved, status quo, worse:
 -- outcome           int(11)      NOT NULL DEFAULT 0,  -- radio

 -- gp, hospital specialist:
 -- destination       int(11)      NOT NULL DEFAULT 0,  -- radio

 PRIMARY KEY (id)
) TYPE=MyISAM;
