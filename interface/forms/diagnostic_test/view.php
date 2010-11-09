<?php
include_once("../../globals.php");
include_once("$srcdir/api.inc");


require ("C_FormDiagnosticTest.class.php");

$c = new C_FormDiagnosticTest();
echo $c->default_action($_GET['id']);
?>
