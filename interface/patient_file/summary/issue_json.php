<?php
require_once("../../globals.php");
require_once("$srcdir/classes/Code.class.php");

function get_allergy($issue) {
  $ret_array = array();

  $ret_array['showMain'] = 0;

  $ret_array['data'][0]['name'] = "Title";
  $ret_array['data'][0]['fieldname'] = "form_title";
  $ret_array['data'][0]['type'] = "text";
  $ret_array['data'][0]['value'] = $issue['title'];

  $ret_array['data'][100]['name'] = "Date";
  $ret_array['data'][100]['fieldname'] = "form_begin";
  $ret_array['data'][100]['image'] = "allergy_begin";
  $ret_array['data'][100]['type'] = "date";
  $ret_array['data'][100]['value'] = $issue['begdate'];

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'adversereaction' ORDER BY seq");
  $ret_array['data'][200]['name'] = "Allergy Type";
  $ret_array['data'][200]['fieldname'] = "reaction_id";
  $ret_array['data'][200]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][200]['options'][$row['option_id']] = $row['title'];
  }

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'severity' ORDER BY seq");
  $ret_array['data'][300]['name'] = "Severity";
  $ret_array['data'][300]['fieldname'] = "severity_id";
  $ret_array['data'][300]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][300]['options'][$row['option_id']] = $row['title'];
  }

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'adversestatus' ORDER BY seq");
  $ret_array['data'][400]['name'] = "Status";
  $ret_array['data'][400]['fieldname'] = "status_id";
  $ret_array['data'][400]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][400]['options'][$row['option_id']] = $row['title'];
  }

  $ret_array['data'][500]['name'] = "Agent";
  if ($GLOBALS['adverse_agent'] == 'Enum') {
    $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'adverseagent' ORDER BY seq");
    $ret_array['data'][500]['type'] = "dropdown";
    $ret_array['data'][500]['fieldname'] = "adverse_agent_id";
    while ($row = sqlFetchArray($res)) {
      $ret_array['data'][500]['options'][$row['option_id']] = $row['title'];
    }
  } else if ($GLOBALS['adverse_agent'] == 'Lab') {
    $ret_array['data'][500]['type'] = "text";
    $ret_array['data'][500]['fieldname'] = "adverse_agent_test_id";
  } else if ($GLOBALS['adverse_agent'] == 'Device') {
    $res = sqlStatement("SELECT me.id, c.code_text_short FROM medical_equipment as me INNER JOIN codes as c ON me.device_type = c.id WHERE pid = '{$_GET['pid']}' ORDER BY me.id");
    $ret_array['data'][500]['type'] = "dropdown";
    $ret_array['data'][500]['fieldname'] = "adverse_agent_medical_equipment_id";
    while ($row = sqlFetchArray($res)) {
      $ret_array['data'][500]['options'][$row['id']] = $row['code_text_short'];
    }
  } else {
    $ret_array['data'][500]['type'] = "dropdown";
    $ret_array['data'][500]['fieldname'] = "adverse_agent_ptr_id";
    $codes = Code::get_codes_from_type('adverse_agent');
    foreach ($codes as $row) {
      $ret_array['data'][500]['options'][$row['id']] = $row['code_text_short'];
    }
  }

  $ret_array['data'][600]['name'] = "Description";
  $ret_array['data'][600]['fieldname'] = "comments";
  $ret_array['data'][600]['type'] = "text";

  return $ret_array;
}

function get_diagnosis($issue) {
  $ret_array = array();

  $ret_array['showMain'] = 0;

  $ret_array['data'][0]['name'] = "Title";
  $ret_array['data'][0]['fieldname'] = "form_title";
  $ret_array['data'][0]['type'] = "text";
  $ret_array['data'][0]['value'] = $issue['title'];

  $ret_array['data'][100]['name'] = "Date";
  $ret_array['data'][100]['fieldname'] = "form_begin";
  $ret_array['data'][100]['image'] = "allergy_begin";
  $ret_array['data'][100]['type'] = "date";
  $ret_array['data'][100]['value'] = $issue['begdate'];

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'diagnosisproblemtype' ORDER BY seq");
  $ret_array['data'][200]['name'] = "Problem Type";
  $ret_array['data'][200]['fieldname'] = "problem_type_id";
  $ret_array['data'][200]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][200]['options'][$row['option_id']] = $row['title'];
  }

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'issuehealthstatus' ORDER BY seq");
  $ret_array['data'][300]['name'] = "Health Status";
  $ret_array['data'][300]['fieldname'] = "healthstatus_id";
  $ret_array['data'][300]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][300]['options'][$row['option_id']] = $row['title'];
  }

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'diagnosistype' ORDER BY seq");
  $ret_array['data'][500]['name'] = "Diagnosis Type";
  $ret_array['data'][500]['fieldname'] = "diagnosis_type_id";
  $ret_array['data'][500]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][500]['options'][$row['option_id']] = $row['title'];
  }

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'diagnosisstatus' ORDER BY seq");
  $ret_array['data'][600]['name'] = "Status";
  $ret_array['data'][600]['fieldname'] = "status_id";
  $ret_array['data'][600]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][600]['options'][$row['option_id']] = $row['title'];
  }

  $ret_array['data'][700]['name'] = "Description Code";
  $ret_array['data'][700]['fieldname'] = "description_code_id";
  $ret_array['data'][700]['type'] = "dropdown";
  $codes = Code::get_codes_from_type('diagnosis_description_code');
  foreach ($codes as $row) {
    $ret_array['data'][700]['options'][$row['id']] = $row['code_text_short'];
  }

  return $ret_array;

}

function get_medication($issue) {
  $ret_array = array();

  $ret_array['showMain'] = 0;

  $ret_array['data'][0]['name'] = "Title";
  $ret_array['data'][0]['fieldname'] = "form_title";
  $ret_array['data'][0]['type'] = "text";
  $ret_array['data'][0]['value'] = $issue['title'];

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'medicationstatus' ORDER BY seq");
  $ret_array['data'][1]['name'] = "Status";
  $ret_array['data'][1]['fieldname'] = "status_id";
  $ret_array['data'][1]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][1]['options'][$row['option_id']] = $row['title'];
  }

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'medicationproducttype' ORDER BY seq");
  $ret_array['data'][2]['name'] = "Product Type";
  $ret_array['data'][2]['fieldname'] = "producttype_id";
  $ret_array['data'][2]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][2]['options'][$row['option_id']] = $row['title'];
  }

  $ret_array['data'][3]['name'] = "Brand Name";
  $ret_array['data'][3]['fieldname'] = "rxnorm_id";
  $ret_array['data'][3]['type'] = "dropdown";
  $codes = Code::get_codes('RXNORM');
  foreach ($codes as $row) {
    $ret_array['data'][3]['options'][$row['id']] = $row['code_text_short'];
  }

  $res = sqlStatement("SELECT * FROM list_options WHERE list_id = 'drug_route' ORDER BY seq");
  $ret_array['data'][4]['name'] = "Route of Administration";
  $ret_array['data'][4]['fieldname'] = "route_id";
  $ret_array['data'][4]['type'] = "dropdown";
  while ($row = sqlFetchArray($res)) {
    $ret_array['data'][4]['options'][$row['option_id']] = $row['title'];
  }

  $ret_array['data'][5]['name'] = "Site";
  $ret_array['data'][5]['fieldname'] = "site_id";
  $ret_array['data'][5]['type'] = "dropdown";
  $codes = Code::get_codes('SNOMED');
  foreach ($codes as $row) {
    $ret_array['data'][5]['options'][$row['id']] = $row['code_text_short'];
  }

  $ret_array['data'][6]['name'] = "Medication Date";
  $ret_array['data'][6]['fieldname'] = "form_begin";
  $ret_array['data'][6]['image'] = "medication_begin";
  $ret_array['data'][6]['type'] = "date";
  $ret_array['data'][6]['value'] = $issue['begdate'];

  $ret_array['data'][7]['name'] = "Form";
  $ret_array['data'][7]['fieldname'] = "medication_form";
  $ret_array['data'][7]['type'] = "text";

  $ret_array['data'][8]['name'] = "Strength";
  $ret_array['data'][8]['fieldname'] = "medication_strength";
  $ret_array['data'][8]['type'] = "text";

  $ret_array['data'][9]['name'] = "Quantity";
  $ret_array['data'][9]['fieldname'] = "medication_quantity";
  $ret_array['data'][9]['type'] = "text";

  $ret_array['data'][10]['name'] = "Directions";
  $ret_array['data'][10]['fieldname'] = "medication_directions";
  $ret_array['data'][10]['type'] = "text";

  $ret_array['data'][11]['name'] = "Frequency";
  $ret_array['data'][11]['fieldname'] = "medication_frequency";
  $ret_array['data'][11]['type'] = "text";

  $ret_array['data'][12]['name'] = "Route";
  $ret_array['data'][12]['fieldname'] = "medication_route";
  $ret_array['data'][12]['type'] = "text";

  $ret_array['data'][13]['name'] = "Dose";
  $ret_array['data'][13]['fieldname'] = "medication_dose";
  $ret_array['data'][13]['type'] = "text";

  $ret_array['data'][14]['name'] = "Value";
  $ret_array['data'][14]['fieldname'] = "medication_value";
  $ret_array['data'][14]['type'] = "text";

  $ret_array['data'][15]['name'] = "Unit";
  $ret_array['data'][15]['fieldname'] = "medication_unit";
  $ret_array['data'][15]['type'] = "text";

  $ret_array['data'][16]['name'] = "Indications";
  $ret_array['data'][16]['fieldname'] = "medication_indications";
  $ret_array['data'][16]['type'] = "text";

  $ret_array['data'][17]['name'] = "Patient Instructions";
  $ret_array['data'][17]['fieldname'] = "medication_patient_instructions";
  $ret_array['data'][17]['type'] = "text";

  $ret_array['data'][18]['name'] = "Refills";
  $ret_array['data'][18]['fieldname'] = "medication_refills";
  $ret_array['data'][18]['type'] = "text";

  $ret_array['data'][19]['name'] = "Medication Source";
  $ret_array['data'][19]['fieldname'] = "medication_source";
  $ret_array['data'][19]['type'] = "text";

  $ret_array['data'][20]['name'] = "Negation Rationale";
  $ret_array['data'][20]['fieldname'] = "negationrationale_id";
  $ret_array['data'][20]['type'] = "dropdown";
  $codes = Code::get_codes_from_type('medication_negation_rationale');
  foreach ($codes as $row) {
    $ret_array['data'][20]['options'][$row['id']] = $row['code_text_short'];
  }
  return $ret_array;

}

$type = $_GET['type'];


$issue = array();
if (!empty($_GET['id'])) {
  $sql = "SELECT * FROM lists WHERE id = ?";
  $bindArray = array($_GET['id']);
  $results = sqlQ($sql, $bindArray);
  $issue = sqlFetchArray($results);
}
header('Content-Type: text/javascript; charset=utf8');
$custom = array();
switch ($type) {
  case 1: //Alergy
    $custom = get_allergy($issue);
    break;
  case 2: //Medication
    $custom = get_medication($issue);
    break;
  case 5: //Diagnosis / Problem / Condition / Issue
    $custom = get_diagnosis($issue);
    break;
  default:
    break;
}

if (!empty($issue)) {
  foreach ($custom['data'] as $k => $v) {
    if (!isset($v['value'])) {
      if (isset($issue[$v['fieldname']])) {
        $custom['data'][$k]['value'] = $issue[$v['fieldname']];
      }
    }
  }
}
//dump($issue, TRUE);
//dump($custom, TRUE);
echo json_encode($custom);

?>
