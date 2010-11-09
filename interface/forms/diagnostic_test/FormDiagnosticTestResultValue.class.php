<?php

require_once(dirname(__FILE__) . "/../../../library/classes/ORDataObject.class.php");


/**
 * class FormDiagnosticTestResultValue
 *
 */
class FormDiagnosticTestResultValue extends ORDataObject {

	/**
	 *
	 * @access public
	 */


	/**
	 *
	 * static
	 */
	var $id;
  var $diagnostic_test_id;
  var $result_code_id;
	 
	/**
	 * Constructor sets all Form attributes to their default value
	 */

	function FormDiagnosticTestResultValue($id= "")	{
		if (is_numeric($id)) {
			$this->id = $id;
		}
		else {
			$id = "";
		}
		
		$this->_table = "form_diagnostic_test_result_values";
		if ($id != "") {
			$this->populate();
			//$this->date = $this->get_date();
		}
	}
	function populate() {
		parent::populate();
		//$this->temp_methods = parent::_load_enum("temp_locations",false);		
	}
	function persist() {
		parent::persist();
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

	function set_diagnostic_test_id($diagnostic_test_id) {
		if (!empty($diagnostic_test_id) && is_numeric($diagnostic_test_id)) {
			$this->diagnostic_test_id = $diagnostic_test_id;
		}
	}
	function get_diagnostic_test_id() {
		return $this->diagnostic_test_id;
	}
	
	function set_result_code_id($result_code_id) {
		if (!empty($result_code_id) && is_numeric($result_code_id)) {
			$this->result_code_id = $result_code_id;
		}
	}
	function get_result_code_id() {
		return $this->result_code_id;
	}

  function get_code_name() {
    $sql = "SELECT * FROM codes WHERE id = {$this->get_result_code_id()}";
    $res = sqlStatement($sql);
    $row = sqlFetchArray($res);
    return $row['code_text_short'];
 }

}	// end of Form

?>
