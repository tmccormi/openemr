
REPLACE INTO code_types (ct_key, ct_id, ct_seq) VALUES ("SNOMED", 5, 1);
REPLACE INTO codes (id, code_text, code_text_short, code, code_type, modifier) VALUES
(1, "Test 1", "SNOMED 1", "123", 5, "SITE"),
(2, "Test 2", "SNOMED 2", "456", 5, "SITE"),
(3, "Test 3", "SNOMED 3", "789", 5, "SITE"),
(4, "Test 4", "SNOMED 4", "012", 5, "SITE");

REPLACE INTO code_types (ct_key, ct_id, ct_seq) VALUES ("HL7patientreason", 6, 2);
REPLACE INTO codes (id, code_text, code_text_short, code, code_type, modifier) VALUES
(5, "Test 1", "HL7patientreason 1", "123", 6, "SITE"),
(6, "Test 2", "HL7patientreason 2", "466", 6, "SITE"),
(7, "Test 3", "HL7patientreason 3", "789", 6, "SITE"),
(8, "Test 4", "HL7patientreason 4", "012", 6, "SITE");

REPLACE INTO code_types (ct_key, ct_id, ct_seq) VALUES ("RXNORM", 7, 3);
REPLACE INTO codes (id, code_text, code_text_short, code, code_type, modifier) VALUES
(9, "Test 1", "RxNORM 1", "123", 7, "SITE"),
(10, "Test 2", "RxNORM 2", "466", 7, "SITE"),
(11, "Test 3", "RxNORM 3", "789", 7, "SITE"),
(12, "Test 4", "RxNORM 4", "012", 7, "SITE");

INSERT INTO registry (name, state, directory, id, sql_run, unpackaged, category) VALUES
('Diagnostic Test', 1, 'diagnostic_test', 20, 1, 1, 'Clincal');
