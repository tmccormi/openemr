<?php
require("../../esign/ESign.class.php");

class ESignForm {

    public static function processESignature($password,$form_dir,$form_id)
    {
        $html = "<center>";
        // verify password
        if(! confirm_user_password($_SESSION['authUser'],$password))
        {
            $html .= xl("The password you entered is invalid");
            $html .= "</center>";
            return array("html" => $html);
        }

        // Get the table used by the form 
        $registry = sqlFetchArray(sqlStatement("select * from registry where directory = '". $form_dir ."'"));
        
        if(empty($registry['table_name']))
        {
            $html .= "No valid table association for form using directory: $form_dir";
            $html .= "</center>";
            return array("html" => $html);
        }
        
        // Create esign object
        $esign = new ESign();
        
        // Initialize the esign object
        $esign->init($form_id, $registry['table_name']);

        $sig = $esign->getNewestUnsignedSignature();
        
        

        if ($sig) {
                    
            $sig->setUid($_SESSION['authId']);
            $sig->setSigned(true);
            $sig->saveOrUpdate();
            
            $html .= $registry['name']. " successfully signed";
        } 
        else 
        {
            $html .= "Signature signing process encountered an error.  Please inform your support provider or the community."; 
        }
        
        $html .="</center>";
        
        return array("html" => $html);
    }
    
    public static function getESignatureLog($form_dir, $form_id) 
    {
        
        if(empty($form_dir) || empty($form_id))
        {
            return array("html" => "Error: Missing form directory or id.");
        }
        
        // Get the table used by the form 
        $registry = sqlFetchArray(sqlStatement("select * from registry where directory = '". $form_dir ."'"));
        
        if(empty($registry['table_name']))
        {
            $html = "No valid table association for form using directory: $form_dir";
            
            return array("html" => $html);
        }
        
        // Create esign object
        $esign = new ESign();
        
        // Initialize the esign object
        $esign->init($form_id, $registry['table_name']);
        
        $html = $esign->getDefaultSignatureLog(false);
        
        return array("html" => $html);
    }
    
    public static function getESignaturePrompt($form_dir, $form_id) 
    {
        
        if(empty($form_dir) || empty($form_id))
        {
            return array("html" => "Error: Missing form directory or id.");
        }
        
        // Get the table used by the form 
        $registry = sqlFetchArray(sqlStatement("select * from registry where directory = '". $form_dir ."'"));
        
        if(empty($registry['table_name']))
        {
            $html = "No valid table association for form using directory: $form_dir";
            
            return array("html" => $html);
        }
        
        
        
        $html .= "
            <center>
                <table>
                    <tr>
                        <td align='center'>
                            <form id='login_form' method='post' action=''>
                                <p> <center> 
                                    <span style = 'font-size:small;'>
                                        <h3>". $registry['name'] . "</h3>
                                        <p id='login_prompt' style='font-size:small;'> ".xl("Your password is your signature")." </p>
                                        <input type='hidden' name='sig_status' value = 'approved' />
                                        <input type='hidden' id='tid' name='tid' value = 'id' />
                                        <input type='hidden' id='table_name' name = 'table_name' value = 'formTable' />
                                        <input type='hidden' id='signature_uid' name = 'signature_uid' value = '_SESSION[authUserID]' />
                                        <input type='hidden' id='signature_id' name = 'signature_id' value = 'sigId->getId()' />
                                        <input type='hidden' id='exam_name' name = 'exam_name' value = 'registryRow[nickname]' />
                                        <input type='hidden' id='exam_pid' name = 'exam_pid' value = 'pid' />
                                        <input type='hidden' id='exam_date' name = 'exam_date' value = 'date' />
                                        <label for='login_pass'> Password: </label>
                                        <input type = 'password' id = 'login_pass' name = 'login_pass' size = '10' />
                                    </span>
                                    </center>
                                </p>
                            </form>
                            <input type='button' value='Back' onClick ='$(\".window\").hide();$(\"#mask\").hide();' />
                            <input type='button' value='Sign' onclick='esign.processESignature(\"".$form_dir."\",\"".$form_id."\");return false;' ".$signDisabled . "/>
                        </td>
                    </tr>
                </table>
            </center>";


        
        return array("html" => $html);
    }
}

?>
