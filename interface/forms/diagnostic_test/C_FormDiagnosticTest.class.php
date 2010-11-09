<?php

require_once ($GLOBALS['fileroot'] . "/library/classes/Controller.class.php");
require_once ($GLOBALS['fileroot'] . "/library/forms.inc");
require_once("FormDiagnosticTest.class.php");
require_once("$srcdir/classes/Code.class.php");
include_once("{$GLOBALS['srcdir']}/dynarch_calendar_en.inc.php");

class C_FormDiagnosticTest extends Controller {

	var $template_dir;

    function C_FormDiagnosticTest($template_mod = "general") {
    	parent::Controller();
    	$this->template_mod = $template_mod;
    	$this->template_dir = dirname(__FILE__) . "/templates/";
    	$this->assign("FORM_ACTION", $GLOBALS['web_root']);
    	$this->assign("DONT_SAVE_LINK", $GLOBALS['form_exit_url']);
    	$this->assign("STYLE", $GLOBALS['style']);
    
    }

    function default_action($form_id = NULL) {
      if (!is_null($form_id) && is_numeric($form_id)) {
        $form = new FormDiagnosticTest($form_id);
      }
      else {
        $form = new FormDiagnosticTest();
      }
    	$this->assign("data",$form);
      $this->assign("result_normalcy", $this->get_result_normalcy_options());
      $this->assign("results_status", $this->get_results_status());
      $this->assign("negation_rationale", Code::get_codes_from_type('diagnostic_negation_rationale'));
      $this->assign("result_test_type", $this->get_result_test_type());
      $this->assign("result_type", $this->get_result_type());
      $this->assign("result_test_status", $this->get_result_test_status());
      $d = $form->get_diagnostic_test_results();
      $x = array();
	if (!empty($d)) {
      foreach ($d as $k => $v) {
        $x[$k]["id"] = $v->get_id();
        $x[$k]["code"] = $v->get_code_name();
      }
	}
      if (empty($x)) {
        $x = null;
      }
      $this->assign("diagnostic_test_results", $x);
      $this->assign("webroot", $GLOBALS['webroot']);
    	return $this->fetch($this->template_dir . $this->template_mod . "_new.html");
    }

	function default_action_process() {
		if ($_POST['process'] != "true")
			return;
		$this->form = new FormDiagnosticTest($_POST['id']);
		parent::populate_object($this->form);

    //dump($this->form, TRUE);
		
		$this->form->persist();
		if ($GLOBALS['encounter'] == "") {
			$GLOBALS['encounter'] = date("Ymd");
		}
		if(empty($_POST['id']))
		{
      addForm($GLOBALS['encounter'], "DiagnosticTest", $this->form->id, "diagnostic_test", $GLOBALS['pid'], $_SESSION['userauthorized']);
			$_POST['process'] = "";
		}
		return;
	}

  private function get_result_normalcy_options() {
    return $this->get_list('diagnosticresultnormalcy');
  }

  private function get_results_status() {
    return $this->get_list('diagnosticresultstatus');
  }

  private function get_result_test_type() {
    return $this->get_list('diagnosticresulttesttype');
  }

  private function get_result_type() {
    return $this->get_list('diagnosticresultstype');
  }

  private function get_result_test_status() {
    return $this->get_list('diagnosticresultteststatus');
  }

  private function get_list($list_name) {
    $ret_array = array();
    $res = sqlStatement("SELECT * FROM list_options WHERE list_id = '$list_name' ORDER BY seq");
    $counter = 0;
    while ($row = sqlFetchArray($res)) {
      $ret_array[$counter]['id'] = $row['option_id'];
      $ret_array[$counter]['value'] = $row['title'];
      $counter++;
    }
    return $ret_array;
  }
    
}



?>
