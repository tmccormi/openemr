<?php
require("../../../interface/globals.php");
require_once("{$GLOBALS['srcdir']}/sql.inc");

require("classes/ESignForm.class.php");


if(get_magic_quotes_gpc()){
	
	// If magic quotes is enabled, strip the extra slashes
	array_walk_recursive($_GET,create_function('&$v,$k','$v = stripslashes($v);'));
	array_walk_recursive($_POST,create_function('&$v,$k','$v = stripslashes($v);'));
}


try{
	
	$response = array();
	
	// Handling the supported actions:
	
	switch($_GET['action']){
		
                case 'processESignature':
                    $response = ESignForm::processESignature($_POST['password'], $_POST['form_dir'], $_POST['form_id']);
                    break;
		case 'getESignatureLog':
                    $response = ESignForm::getESignatureLog($_POST['form_dir'], $_POST['form_id']);
                    break;
                case 'getESignaturePrompt':
                    $response = ESignForm::getESignaturePrompt($_POST['form_dir'], $_POST['form_id']);
                    break;
		default:
                    throw new Exception('Wrong action');
	}
	
	echo json_encode($response);
}
catch(Exception $e)
{
    die(json_encode(array('error' => $e->getMessage())));
}

?>