<?php
// Copyright (C) 2009 Aron Racho <aron@mi-squared.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2

// This form has the typical defaults for a standard physical exam in
// a primary care setting pre-set so that filling out the form is only
// needed for exceptions.  Other jump to the "save' button and go.

require_once ($GLOBALS['fileroot'] . "/library/classes/Controller.class.php");
require_once ($GLOBALS['fileroot'] . "/library/forms.inc");
require_once("FormPCPhysicalExam.class.php");

class C_FormPCPhysicalExam extends Controller {

  var $template_dir;

  function C_FormPCPhysicalExam($template_mod = "general") {
    parent::Controller();
    $this->template_mod = $template_mod;
    $this->template_dir = dirname(__FILE__) . "/templates/";
    $this->assign("FORM_ACTION", $GLOBALS['web_root']);
    $this->assign("DONT_SAVE_LINK",$GLOBALS['form_exit_url']);
    $this->assign("STYLE", $GLOBALS['style']);
  }

  function default_action() {
    $form = new FormPCPhysicalExam();
    $this->assign("data",$form);
    return $this->fetch($this->template_dir . $this->template_mod . "_new.html");
  }

  function view_action($form_id) {
    if (is_numeric($form_id)) {
      $form = new FormPCPhysicalExam($form_id);
    }
    else {
      $form = new FormPCPhysicalExam();
    }
    $dbconn = $GLOBALS['adodb']['db'];
    $this->assign("data",$form);
    return $this->fetch($this->template_dir . $this->template_mod . "_new.html");
  }

  function default_action_process() {
    if ($_POST['process'] != "true")
      return;
    $this->form = new FormPCPhysicalExam($_POST['id']);
    parent::populate_object($this->form);
    $this->form->persist();
    if ($GLOBALS['encounter'] == "") {
      $GLOBALS['encounter'] = date("Ymd");
    }
    if (empty($_POST['id'])) {
      addForm($GLOBALS['encounter'], "Primary Care Physical Exam", $this->form->id, "pc_phy_exam",
        $GLOBALS['pid'], $_SESSION['userauthorized']);
      $_POST['process'] = "";
    }
    return;
  }

}
?>
