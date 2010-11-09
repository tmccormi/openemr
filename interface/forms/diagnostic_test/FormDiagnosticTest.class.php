<?php

require_once(dirname(__FILE__) . "/../../../library/classes/ORDataObject.class.php");
require_once("FormDiagnosticTestResultValue.class.php");


/**
 * class FormDiagnosticTest
 *
 */
class FormDiagnosticTest extends ORDataObject {

	/**
	 *
	 * @access public
	 */

	/**
	 *
	 * static
	 */
	var $id;
	var $pid;
  var $test_procedure_id;
  var $test_procedure_record_id;
  var $result_normalcy_id;
  var $result_status_id;
  var $negation_rationale_id;
  var $result_test_type_id;
  var $result_description;
  var $result_type_id;
  var $result_test_status_id;
  var $test_description;
  var $order_date;
  var $test_date;
  var $performed_date;
  var $result_date;
  var $test_result_value;
  var $diagnostic_test_results;
	 
	/**
	 * Constructor sets all Form attributes to their default value
	 */

	function FormDiagnosticTest($id= "", $_prefix = "")	{
		if (is_numeric($id)) {
			$this->id = $id;
		}
		else {
			$id = "";
		}
		
		$this->_table = "form_diagnostic_tests";
		$this->pid = $GLOBALS['pid'];
		if ($id != "") {
			$this->populate();
			//$this->date = $this->get_date();
		}
	}
	function populate() {
		parent::populate();
    $sql = "SELECT * FROM form_diagnostic_test_result_values WHERE diagnostic_test_id = $this->id";
    $res = sqlStatement($sql);
    while ($row = sqlFetchArray($res)) {
      $this->diagnostic_test_results[] = new FormDiagnosticTestResultValue($row['id']);
    }
	}
	function persist() {
		parent::persist();
    if ($this->get_id()) {
      foreach ($this->diagnostic_test_results as $k => $v) {
        if (!empty($v)) {
          $code_a = Code::get_codes_from_short_text($v);

          foreach ($code_a as $l => $w) {
            $result = new FormDiagnosticTestResultValue();
            $result->set_diagnostic_test_id($this->get_id());
            $result->set_result_code_id($w['id']);
            $result->persist();
          }
        }
      }
    }
	}

	function toString($html = false) {
		$string .= "\n"
			."ID: " . $this->id . "\n";

		if ($html) {
			return nl2br($string);
		}
		else {
			return $string;
		}
	}
	function set_id($id) {
		if (!empty($id) && is_numeric($id)) {
			$this->id = $id;
		}
	}
	function get_id() {
		return $this->id;
	}
	function set_pid($pid) {
		if (!empty($pid) && is_numeric($pid)) {
			$this->pid = $pid;
		}
	}
	function get_pid() {
		return $this->pid;
	}
  function set_test_procedure_id($test_procedure_id) {
    $this->test_procedure_id = $test_procedure_id;
  }
  function get_test_procedure_id() {
    return $this->test_procedure_id;
  }

  function set_test_procedure_record_id($test_procedure_record_id) {
    $this->test_procedure_record_id = $test_procedure_record_id;
  }
  function get_test_procedure_record_id() {
    return $this->test_procedure_record_id;
  }

  function set_result_normalcy_id($result_normalcy_id) {
    $this->result_normalcy_id = $result_normalcy_id;
  }
  function get_result_normalcy_id() {
    return $this->result_normalcy_id;
  }

  function set_result_status_id($result_status_id) {
    $this->result_status_id = $result_status_id;
  }
  function get_result_status_id() {
    return $this->result_status_id;
  }

  function set_negation_rationale_id($negation_rationale_id) {
    $this->negation_rationale_id = $negation_rationale_id;
  }
  function get_negation_rationale_id() {
    return $this->negation_rationale_id;
  }

  function set_result_test_type_id($result_test_type_id) {
    $this->result_test_type_id = $result_test_type_id;
  }
  function get_result_test_type_id() {
    return $this->result_test_type_id;
  }

  function set_result_description($result_description) {
    $this->result_description = $result_description;
  }
  function get_result_description() {
    return $this->result_description;
  }

  function set_result_type_id($result_type_id) {
    $this->result_type_id = $result_type_id;
  }
  function get_result_type_id() {
    return $this->result_type_id;
  }

  function set_result_test_status_id($result_test_status_id) {
    $this->result_test_status_id = $result_test_status_id;
  }
  function get_result_test_status_id() {
    return $this->result_test_status_id;
  }

  function set_test_description($test_description) {
    $this->test_description = $test_description;
  }
  function get_test_description() {
    return $this->test_description;
  }

  function set_order_date($order_date) {
    $this->order_date = $order_date;
  }
  function get_order_date() {
    return $this->order_date;
  }

  function set_test_date($test_date) {
    $this->test_date = $test_date;
  }
  function get_test_date() {
    return $this->test_date;
  }

  function set_performed_date($performed_date) {
    $this->performed_date = $performed_date;
  }
  function get_performed_date() {
    return $this->performed_date;
  }

  function set_result_date($result_date) {
    $this->result_date = $result_date;
  }
  function get_result_date() {
    return $this->result_date;
  }

  function set_test_result_value($test_result_value) {
    $this->test_result_value = $test_result_value;
  }
  function get_test_result_value() {
    return $this->test_result_value;
  }

  function set_diagnostic_test_results($diagnostic_test_results) {
    $this->diagnostic_test_results = $diagnostic_test_results;
  }
  function get_diagnostic_test_results() {
    return $this->diagnostic_test_results;
  }

	function set_source($source) {
		if (!empty($source)) {
			$this->source = $source;
		}
	}
	function get_source() {
		return $this->source;
	}



}	// end of Form

?>
