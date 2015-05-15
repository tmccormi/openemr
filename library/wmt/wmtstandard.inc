<?php 
if(!isset($GLOBALS['fileroot'])) { include_once('../../globals.php'); }
require_once($GLOBALS['fileroot'].'/custom/code_types.inc.php');
require_once($GLOBALS['srcdir'].'/lists.inc');

function ReportMissingPID()
{
	echo "<h><b>The Session Patient ID Seems To Be Missing!</b></h><br/>\n";
	echo "<b>This is usually due to an idle session timing out, please log out and back in to reset session variables</b><br/>\n";
	exit;
}

function ReportMissingEncounter()
{
	echo "<h><b>The Session Encounter ID Seems To Be Missing!</b></h><br/>\n";
	echo "<b>This is usually due to an idle session timing out, please log out and back in to reset session variables</b><br/>\n";
	exit;
}

function ReportMissingID()
{
	echo "<h><b>The Form ID Seems To Be Missing!</b></h><br/>\n";
	echo "<b>This is usually due to an idle session timing out, please log out and back in to reset session variables</b><br/>\n";
	exit;
}

function FlagListSel($thisField, $thisList, $exists, $default) {
  $rlist= sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? AND ".
			"(UPPER(notes) NOT LIKE '%DO NOT USE%') ORDER BY seq", array($thisList));
  echo "<option value=''";
  if(!$thisField && $exists) echo " selected='selected'";
  echo ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['option_id'] . "'";
    if(($thisField == $rrow['option_id']) || (!$exists && ($rrow['option_id'] == $default))) echo " selected='selected'";
    echo ">" . $rrow['title'];
    echo "</option>";
  }
}

function DrugUseListSel($thisField) {
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  echo "<option value='neverrecreational_drugs'";
  if($thisField == 'neverrecreational_drugs') echo " selected='selected'";
  echo ">Never</option>\n";
  echo "<option value='currentrecreational_drugs'";
  if($thisField == 'currentrecreational_drugs') echo " selected='selected'";
  echo ">Current</option>\n";
  echo "<option value='quitrecreational_drugs'";
  if($thisField == 'quitrecreational_drugs') echo " selected='selected'";
  echo ">Quit</option>\n";
  echo "<option value='not_applicablerecreational_drugs'";
  if($thisField == 'not_applicablerecreational_drugs') echo " selected='selected'";
  echo ">N/A</option>\n";
}

function DrugUseListLook($thisField) {
	$ret = '';
  if($thisField == 'neverrecreational_drugs') { $ret = 'Never'; }
  if($thisField == 'currentrecreational_drugs') { $ret = 'Current'; }
  if($thisField == 'quitrecreational_drugs') { $ret = 'Quit'; }
  if($thisField == 'not_applicablerecreational_drugs') { $ret = 'N/A'; }
	return $ret;
}

function AlcoholUseListSel($thisField) {
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  echo "<option value='neveralcohol'";
  if($thisField == 'neveralcohol') echo " selected='selected'";
  echo ">Never</option>\n";
  echo "<option value='currentalcohol'";
  if($thisField == 'currentalcohol') echo " selected='selected'";
  echo ">Current</option>\n";
  echo "<option value='quitalcohol'";
  if($thisField == 'quitalcohol') echo " selected='selected'";
  echo ">Quit</option>\n";
  echo "<option value='not_applicablealcohol'";
  if($thisField == 'not_applicablealcohol') echo " selected='selected'";
  echo ">N/A</option>\n";
}

function AlcoholUseListLook($thisField) {
	$ret = '';
  if($thisField == 'neveralcohol') { $ret = 'Never'; }
  if($thisField == 'currentalcohol') { $ret = 'Current'; }
  if($thisField == 'quitalcohol') { $ret = 'Quit'; }
  if($thisField == 'not_applicablealcohol') { $ret = 'N/A'; }
	return $ret;
}

function ListSel($thisField, $thisList, $empty_label = '') {
  $rlist= sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? AND ".
		"seq >= 0 AND (UPPER(notes) NOT LIKE '%DO NOT USE%') ".
		"ORDER BY seq, title",array($thisList));
  echo "<option value=''";
  // if(!$thisField) echo " selected='selected'";
  echo ">$empty_label&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow{'option_id'} . "'";
    if($thisField == $rrow{'option_id'}) {
			echo " selected='selected'";
		} else if(empty($thisField)) {
			if($rrow{'is_default'} == 1) {
				echo " selected='selected'";
			}
		}
    echo ">" . $rrow{'title'};
    echo "</option>";
  }
}

function getListOptions($thisList) {
  $rlist= sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? AND ".
		"seq >= 0 AND (UPPER(notes) NOT LIKE '%DO NOT USE%') ORDER BY seq, title",
		array($thisList));
	$all = array();
	$iter = 0;
  while($row = sqlFetchArray($rlist)) {
  	$all[$iter] = $row;
		$iter++;
	}
	return $all;
}

function ListSelString($thisField, $thisList) {
  $rlist= sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? AND ".
		"seq >= 0 AND (UPPER(notes) NOT LIKE '%DO NOT USE%') ORDER BY seq, title", 
		array($thisList));
  $ret = "<option value=''";
  // if(!$thisField) $ret .= " selected='selected'";
  $ret .= ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    $ret .= "<option value='" . $rrow{'option_id'} . "'";
    if($thisField == $rrow{'option_id'}) {
			echo " selected='selected'";
		} else if(empty($thisField)) {
			if($rrow{'is_default'} == 1) {
				echo " selected='selected'";
			}
		}
    $ret .= ">". $rrow{'title'}."</option>";
  }
	return $ret;
}

function ListSelAlpha($thisField, $thisList) {
  $rlist= sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? AND ".
		"seq >= 0 AND (UPPER(notes) NOT LIKE '%DO NOT USE%') ORDER BY title, seq", 
		array($thisList));
  echo "<option value=''";
  // if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow{'option_id'} . "'";
    if($thisField == $rrow{'option_id'}) {
			echo " selected='selected'";
		} else if(empty($thisField)) {
			if($rrow{'is_default'} == 1) {
				echo " selected='selected'";
			}
		}
    echo ">" . $rrow{'title'};
    echo "</option>";
  }
}

function MultListSel($thisArray, $thisList, $thisVal='') {
  $rlist= sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? AND ".
		"seq >= 0 AND (UPPER(notes) NOT LIKE '%DO NOT USE%') ORDER BY seq",
		array($thisList));
  echo "<option value=''";
  // if(!$thisArray[0]) echo " selected='selected'";
	if(count($thisArray) == 0) { 
		echo " selected='selected'"; 
	} elseif ($thisArray[0] == '') {
		echo " selected='selected'"; 
	}
  echo ">Unassigned</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['option_id'] . "'";
    if(is_array($thisArray)) {
      if(in_array($rrow['option_id'],$thisArray)) echo " selected='selected'";
    }
    echo ">" . $rrow['title'];
    echo "</option>";
  }
}

function MultLook($thisArray, $thisList, $thisVal='') {
  $dispVal='';
  if((!($thisArray[0])) || (!is_array($thisArray))) {
    echo "<option value='' selected='selected'>Unassigned</option>";
    return;
  }
  foreach ($thisArray as $rrow) {
    $lres = sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? AND ".
				"option_id =?",array($thisList, $rrow));
    $llist = sqlFetchArray($lres);
    echo "<option value='".$rrow."' selected='selected'>".$llist['title']."</option>";
  }
}

function MultPrint($thisArray, $thisList, $thisVal='') {
  $dispVal='';
  if(!is_array($thisArray)) { return $dispVal; }
  if(!($thisArray[0])) { return $dispVal; }
  foreach ($thisArray as $rrow) {
    $lres = sqlStatementNoLog("SELECT * FROM list_options WHERE " .
         "list_id =? AND option_id =?",array($thisList, $rrow));
    $llist = sqlFetchArray($lres);
    if($disp_val) { $dispVal=$dispVal.'<br />'; }
    $dispVal=$dispVal.$llist['title'];
  }
  return $dispVal;
}

function ListLook($thisData, $thisList) {
  if($thisList == 'occurrence') {
    if(!$thisData || $thisData == '') return 'Unknown or N/A'; 
  }
  if($thisData == '') return ''; 
  $fres=sqlStatementNoLog("SELECT * FROM list_options WHERE list_id=? ".
        "AND option_id=?", array($thisList, $thisData));
  if($fres) {
    $rret=sqlFetchArray($fres);
    $dispValue= $rret{'title'};
    if($thisList == 'occurrence' && $dispValue == '') {
      $dispValue = 'Unknown or N/A';
    }
  } else {
    $dispValue= '* Not Found *';
  }
  return $dispValue;
}

function SetSmokingDesc($thisValue) {
  $retval= '0';
  if(!$thisValue) $retval='0';
  if($thisValue == 1) $retval='currenttobacco';
  if($thisValue == 2) $retval='currenttobacco';
  if($thisValue == 3) $retval='quittobacco';
  if($thisValue == 4) $retval='nevertobacco';
  if($thisValue == 5) $retval='not_applicabletobacco';
  if($thisValue == 9) $retval='not_applicabletobacco';
  return $retval;
}

function getPastPregnancies($thisPid, $thisEnc='') {
  $sql= "SELECT * FROM form_whc_pp WHERE pid=? ORDER BY pp_date_of_pregnancy";
	$binds=array($thisPid);
	$all=array();
	if($thisEnc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, form_whc_pp.* FROM form_wmt_ll ".
			"LEFT JOIN form_whc_pp on form_wmt_ll.list_id=form_whc_pp.id WHERE ".
			"form_wmt_ll.pid=? AND form_wmt_ll.list_type=? AND ".
			"form_wmt_ll.encounter_id=? ORDER BY pp_date_of_pregnancy";
		$binds=array($thisPid, 'past_pregnancy', $thisEnc);
	}
  $res= sqlStatementNoLog($sql, $binds);

	$iter = 0;
  while($row = sqlFetchArray($res)) {
  	$all[$iter] = $row;
		$sql = "SELECT COUNT(*) FROM form_wmt_ll WHERE form_wmt_ll.list_type=? ".
				"AND form_wmt_ll.list_id=?";
		$chk = sqlStatementNoLog($sql, array('past_pregnancy', $all[$iter]['id']));
		$num = sqlFetchArray($chk);
		$all[$iter]['num_links']= $num['COUNT(*)'];
		$iter++;
	}
  return $all;
}

function getNextOrder($thisPid, $cols='*') {
  $retVal=0;
  $sql= "SELECT $cols FROM form_whc_pp WHERE pid=? ORDER BY ".
		"pp_order DESC LIMIT 1";
  $result=sqlStatementNoLog($sql, array($thisPid));
  if($result) {
    $row=sqlFetchArray($result);
    if($row{'pp_order'}) $retVal=$row{'pp_order'};
  }
  $retVal++;
  return($retVal);
}

function GetList($thisPid, $type, $enc='', $dt='') {
  $sql = "SELECT * FROM lists WHERE pid=? AND type=? ORDER BY begdate";
	if($type == 'allergy') {
  	$sql = "SELECT * FROM lists WHERE pid=? AND type=? " .
         "AND (enddate IS NULL || enddate='0000-00-00') ORDER BY begdate";
	}
	$binds=array($thisPid, $type);
	if($type == 'ultrasound' && $dt != '') {
  	$sql = "SELECT * FROM lists WHERE pid=? AND type=? " .
         "AND begdate > ? ORDER BY begdate";
		$binds=array($thisPid, $type, $dt);
	}
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, lists.* FROM form_wmt_ll LEFT JOIN ".
				"lists on form_wmt_ll.list_id=lists.id WHERE form_wmt_ll.pid=? ".
				"AND form_wmt_ll.list_type=? AND form_wmt_ll.encounter_id=? ".
				"ORDER BY begdate";
		$binds=array($thisPid, $type, $enc);
	}

	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
	$iter=0;
  while($row = sqlFetchArray($res)) {
  	$all[$iter] = $row;
		$sql = "SELECT COUNT(*) FROM form_wmt_ll WHERE form_wmt_ll.list_type=? ".
				"AND form_wmt_ll.list_id=?";
		$chk = sqlStatementNoLog($sql, array($type, $all[$iter]['id']));
		$num = sqlFetchArray($chk);
		$all[$iter]['num_links']= $num['COUNT(*)'];
		$iter++;
	}
  return $all;
}

function GetCodeDescription($type='ICD9', $code) {
	$ret = "Invalid Key [$type] - No Description Found";
	$sql = "SELECT ct_id FROM code_types WHERE ct_key='$type'";
  $res = sqlStatementNoLog($sql);
	$row = sqlFetchArray($res);
	$key = $row{'ct_id'};
	if($key == '' || !$key) { return $ret; }
	$sql = "SELECT code_text, code_text_short FROM codes WHERE ".
			"code_type='$key' AND code='$code'";
  $res = sqlStatementNoLog($sql);
	$row = sqlFetchArray($res);
	$ret = trim($row{'code_text'});
	return $ret;
}

function GetProblemsWithDiags($thisPid,$mode='all',$thisID=0,$type='ICD') {
	// echo "In the Function, the encounter is :",$thisID,"<br/>\n";
	// $sql = "SELECT id, title, begdate, enddate, occurrence, diagnosis, ".
		// "comments, outcome from lists WHERE type='medical_problem' AND ".
		// "pid='$thisPid' AND (enddate='' OR enddate IS NULL) ".
		// "AND diagnosis LIKE 'ICD%' ORDER BY begdate";
	// if($mode=='all') {
		// $sql = "SELECT id, title, begdate, enddate, occurrence, diagnosis, ".
			// "comments, outcome from lists WHERE type='medical_problem' ".
			// "AND pid='$thisPid' AND diagnosis LIKE '".$type."%' ORDER BY begdate";
	// }
	// if($mode=='encounter') {
		// $sql = "SELECT id, title, begdate, enddate, occurrence, diagnosis, ".
			// "comments, outcome, resolved from issue_encounter, lists WHERE ".
			// "issue_encounter.list_id=lists.id AND type='medical_problem' AND ".
			// "issue_encounter.pid='$thisPid' AND issue_encounter.encounter='$thisID' ".
			// "AND diagnosis LIKE 'ICD%' ORDER BY begdate";
	// }
	// Select all here, set a flag in the row so we know if it's linked or not
	$sql = "SELECT id, title, begdate, enddate, occurrence, diagnosis, ".
			"comments, outcome, list_id, encounter, issue_encounter.seq FROM lists ".
			"LEFT JOIN issue_encounter ON list_id=id AND encounter=? WHERE ".
			"type='medical_problem' AND lists.pid=? AND diagnosis LIKE ".
			"? ORDER BY seq * 1 ASC, seq ASC";
	$all=array();
	// echo "This Statement: ",$sql,"<br/>\n";
  $res = sqlStatementNoLog($sql,array($thisID, $thisPid, $type.'%'));
  for($iter =0;$row = sqlFetchArray($res);$iter++) {
  	$all[$iter] = $row;
		// echo "Result Row: ",$row{'id'},"  Seq: ",$row{'seq'},"  Diag: ",$row{'diagnosis'},"  Enc: ",$row{'encounter'},"<br>\n";
	}
  return $all;
}

function GetListbyTitle($thisPid, $type, $title) {
	$title='%'.$title.'%';
  $sql = "SELECT * FROM lists WHERE pid=? AND type=? " .
         "AND title LIKE ? ORDER BY begdate";
	$all=array();
  $res = sqlStatementNoLog($sql,array($thisPid, $type, $title));
  for($iter =0;$row = sqlFetchArray($res);$iter++)
  $all[$iter] = $row;
  return $all;
}

function GetFYI($thisPid) {
  $sql = "SELECT fyi FROM form_fyi WHERE pid=?";
  $res = sqlStatementNoLog($sql,array($thisPid));
  $rrow = sqlFetchArray($res);
  return($rrow['fyi']);
}

function UpdateFYI($thisPid, $fyi) {
  $sql = "INSERT INTO form_fyi (date, pid, user, groupname, authorized, ".
        "activity, fyi) VALUES (NOW(), ?, ?, ?, ?, '1', ?) ".
				"ON DUPLICATE KEY UPDATE fyi=?, date=NOW(), user=?, authorized=?";
	$binds=array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
			$_SESSION['userauthorized'], $fyi, $fyi, $_SESSION['authUser'], 
			$_SESSION['userauthorized']);
  sqlInsert($sql, $binds);
  return(true);
}

function DiagSel($thisField) {
  $rlist= sqlStatementNoLog("SELECT * FROM codes WHERE code_type='2' ".
           "AND active='1' ORDER BY code");
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['code']. "'";
    if($thisField == $rrow['code']) echo " selected='selected'";
    echo ">" . $rrow['code'] . " - " . $rrow['code_text'];
    echo "</option>";
  }
}

function ICD9DiagSel($thisField) {
  $rlist= sqlStatementNoLog("SELECT * FROM codes WHERE code_type='2' ".
           "AND active='1' ORDER BY code");
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='ICD9: " . $rrow['code']. "'";
    if($thisField == $rrow['code']) echo " selected='selected'";
    echo '>' . $rrow['code'] . ' - ' . $rrow['code_text'];
    echo '</option>';
  }
}

function DiagLook($thisData) {
  if(!$thisData || $thisData == '') {
    return ''; 
  }
  $fres= sqlStatementNoLog("SELECT * FROM codes WHERE code_type='2' ".
           "AND active='1' AND code=?", array($thisData));
  $rret=sqlFetchArray($fres);
  $dispValue= $rret{'code'}.'-'.$rret{'code_text'};
  return $dispValue;
}

function DiagDescLook($thisData) {
  if(!$thisData || $thisData == '') {
    return ''; 
  }
  $fres= sqlStatementNoLog("SELECT code_text FROM codes WHERE code_type='2' ".
           "AND active='1' AND code=?", array($thisData));
  $rret=sqlFetchArray($fres);
  $dispValue= $rret{'code_text'};
  return $dispValue;
}

function UserSelect($thisField, $blank='') {
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE " .
           "active=1 AND username != '' ORDER BY lname");
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">$blank&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['username'] . "'";
    if($thisField == $rrow['username']) echo " selected='selected'";
    echo ">" . $rrow['lname'].', '.$rrow['fname'].' '.$rrow['mname'];
    echo "</option>";
  }
}

function DoctorSelect($thisField) {
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE " .
           "active=1 AND username != '' ORDER BY lname");
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['username'] . "'";
    if($thisField == $rrow['username']) echo " selected='selected'";
    echo ">" . $rrow['lname'].', '.$rrow['fname'].' '.$rrow['mname'];
    echo "</option>";
  }
}

function IsSupervisor($user) {
	if(!$user) return false;
	$sql = "SELECT id, username, specialty FROM users WHERE username=?";
	$fres = sqlQuery($sql, array($user));
	$test = strtolower($fres{'specialty'});
	$val = strpos($test,'supervisor');
	if($val === false) return false;
	return true;
}

function ReferringSelect($thisField, $special_title='', $specialty='', $display_extra = '', $allow_empty=true) {
	if($specialty) {
		$specialty = "AND UPPER(specialty) LIKE UPPER('%$specialty%')";
	}
  $sql = "SELECT id, lname, fname, mname, specialty";
	if($display_extra) { $sql .= ", $display_extra"; }
	$sql .= " FROM users WHERE active=1 AND username='' $specialty ".
			"ORDER BY lname";
  $rlist= sqlStatementNoLog($sql);
	if($allow_empty) {
  	echo "<option value=''";
  	if(!$thisField) echo " selected='selected'";
  	echo ">&nbsp;</option>";
	}
	if($special_title) {
  	echo "<option value='-1'";
  	if($thisField == -1) echo " selected='selected'";
  	echo ">$special_title</option>";
	}
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['id'] . "'";
    if($thisField == $rrow['id']) echo " selected='selected'";
    echo ">" . $rrow['lname'].', '.$rrow['fname'].' '.$rrow['mname'];
		if($display_extra) {
			$keys = explode(',',$display_extra);
			foreach($keys as $extra) {
				$extra = trim($extra);
				if($extra) { echo ' - '.$rrow{$extra}; }
			}
		}
    echo "</option>";
  }
}

function AddressSelect($thisField, $organization='', $specialty='', $type='', $display_extra = '', $order='organization', $allow_empty=true, $special_title='') {
	if($organization) {
		$organization = "AND UPPER(organization) LIKE UPPER('%$organization%') ";
	}
	if($specialty) {
		$specialty = "AND UPPER(specialty) LIKE UPPER('%$specialty%') ";
	}
	if($type) {
		$type = "AND UPPER(abook_type) LIKE UPPER('%$type%') ";
	}
  $sql = "SELECT id, lname, fname, mname, organization, specialty, ".
		"street, streetb, city, state, zip, fax, phonew1, phonew2";
	if($display_extra) { $sql .= ", $display_extra"; }
	$sql .= " FROM users WHERE active=1 AND username='' ";
	if($organization) { $sql .= $organization.' '; }
	if($specialty) { $sql .= $specialty.' '; }
	if($type) { $sql .= $type.' '; }
	$sql .= "ORDER BY $order";
  $rlist= sqlStatementNoLog($sql);
	if($allow_empty) {
  	echo "<option value=''";
  	if(!$thisField) echo " selected='selected'";
  	echo ">&nbsp;</option>";
	}
	if($special_title) {
  	echo "<option value='-1'";
  	if($thisField == -1) echo " selected='selected'";
  	echo ">$special_title</option>";
	}
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['id'] . "'";
    if($thisField == $rrow['id']) echo " selected='selected'";
		if($rrow['organization']) {
    	echo ">" . $rrow['organization'];
		} else {
    	echo ">" . $rrow['lname'].', '.$rrow['fname'].' '.$rrow['mname'];
		}
		if($display_extra) {
			$keys = explode(',',$display_extra);
			foreach($keys as $extra) {
				$extra = trim($extra);
				if($extra) { echo ' - '.$rrow{$extra}; }
			}
		}
    echo "</option>";
  }
}

function ProviderSelect($thisField) {
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE " .
      "active=1 AND username != '' AND (UPPER(specialty) LIKE '%PROVIDER%' ".
			"|| UPPER(specialty) LIKE '%SUPERVISOR%') ".
					"ORDER BY lname");
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['id'] . "'";
    if($thisField == $rrow['id']) echo " selected='selected'";
    echo ">" . $rrow['lname'].', '.$rrow['fname'].' '.$rrow['mname'];
    echo "</option>";
  }
}

function SupervisorSelect($thisField) {
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE active=1 AND ".
		"username != '' AND UPPER(specialty) LIKE '%SUPERVISOR%' ORDER BY lname");
  echo "<option value=''";
  if(!$thisField) echo " selected='selected'";
  echo ">&nbsp;</option>";
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['id'] . "'";
    if($thisField == $rrow['id']) echo " selected='selected'";
    echo ">" . $rrow['lname'].', '.$rrow['fname'].' '.$rrow['mname'];
    echo "</option>";
  }
}

function UserIdLook($thisField) {
  if(!$thisField) return '';
  $ret = '';
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE id=?",array($thisField));
  $rrow= sqlFetchArray($rlist);
  if($rrow) {
    $ret = $rrow{'lname'}.', '.$rrow{'fname'}.' '.$rrow{'mname'};
  }
  return $ret;
}

function UserNameFromID($thisField) {
  if(!$thisField) return '';
  $ret = '';
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE id=?",array($thisField));
  $rrow= sqlFetchArray($rlist);
  if($rrow) {
    $ret = $rrow{'lname'}.', '.$rrow{'fname'}.' '.$rrow{'mname'};
  }
  return $ret;
}

function UserNameFromName($thisField) {
  if(!$thisField) return '';
  $ret = '';
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE username=?",array($thisField));
  $rrow= sqlFetchArray($rlist);
  if($rrow) {
    $ret = $rrow{'lname'}.', '.$rrow{'fname'}.' '.$rrow{'mname'};
  }
  return $ret;
}

function UserDispNameFromID($thisField) {
  if(!$thisField) return '';
  $ret = '';
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE id=?", array($thisField));
  $rrow= sqlFetchArray($rlist);
  if($rrow) {
		$_mi = ' ';
		if(!empty($rrow{'mname'})) { $_mi = ' '.$rrow{'mname'}.' '; }
    $ret = $rrow{'fname'}.$_mi.$rrow{'lname'};
  }
  return $ret;
}

function UserLook($thisField) {
  if(!$thisField) return '';
  $ret = '';
  $rlist= sqlStatementNoLog("SELECT * FROM users WHERE username=?", array($thisField));
  $rrow= sqlFetchArray($rlist);
  if($rrow) {
    $ret = $rrow['lname'].', '.$rrow['fname'].' '.$rrow['mname'];
  }
  return $ret;
}

function FacilityLook($thisField) {
  if(!$thisField) return '';
  $flist= sqlStatementNoLog("SELECT name FROM facility WHERE id=?",array($thisField));
  $frow= sqlFetchArray($flist);
  return($frow{'name'});
}

function ImmLook($thisField) {
  if(!$thisField) return '';
  $fres=sqlStatementNoLog("SELECT ct_id FROM code_types WHERE ct_key='CVX'");
  $frow=sqlFetchArray($fres);
	$type=$frow{'ct_id'};
	if($type == '' || !$type) return '';
  $fres=sqlStatementNoLog("SELECT code_text, code_text_short FROM ".
		"codes WHERE code_type=? AND code=?",array($type, $thisField));
  $frow=sqlFetchArray($fres);
  return($frow{'code_text_short'});
}

function ImmDateCheck($thisPid='', $thisCode) {
	if(!$thisPid) { return ''; }
	if(is_array($thisCode)) {
		if(!count($thisCode)) return '';
	} else {
  	if(!$thisField) return '';
	}
	if(is_array($thisCode)) {
		$binds = array($thisPid);
  	$sql = "SELECT administered_date, cvx_code FROM immunizations WHERE ".
			"patient_id=? AND (";
		$cnt = 1;
		foreach($thisCode as $code) {
			if($cnt > 1) { $sql .= " OR "; }
			$sql .= "cvx_code=?";	
			$binds[] = $code;
			$cnt++;
		}
		$sql .= ") ORDER BY administered_date DESC LIMIT 1";
	} else {
  	$sql = "SELECT administered_date, cvx_code FROM ".
			"immunizations WHERE patient_id=? AND cvx_code=? ORDER BY ".
			"administered_date DESC LIMIT 1";
		$binds = array($thisPid, $thisCode);
	}
	// echo "Immunization Statement: $sql<br>\n";
	// echo print_r($binds),"<br>\n";
	$fres=sqlStatementNoLog($sql, $binds);
  $frow=sqlFetchArray($fres);
  return($frow{'administered_date'});
}

function AddVitalsTest($vrec,$ht,$wt,$bps='',$bpd='',$bmi='',$bmi_status='',$hr='') {
  // echo "Height: ".$ht."<br />\n";
  // echo "Weight: ".$wt."<br />\n";
  // echo "Bps: ".$bps."<br />\n";
  // echo "Bpd: ".$bpd."<br />\n";
  // echo "BMI: ".$bmi."<br />\n";
  $add=false;
  // If there is no vitals record, and we captured data =>  ADD
  if($vrec == '' || $vrec == '0') { $add=true; }
	// echo "Vrec: $vrec    Add: $add<br>\n";
  $vitals_entered = ($ht > 0);
  // echo "Test 1 -Vitals [".$vitals_entered."]  and Height(".$ht.")<br />\n";
  if(!$vitals_entered) { $vitals_entered= ($wt > 0); }
  // echo "Test 2 -Vitals [".$vitals_entered."]  and Weight(".$wt.")<br />\n";
  if(!$vitals_entered) { $vitals_entered= ($bps > 0); }
  if(!$vitals_entered) { $vitals_entered= ($bpd > 0); }
  if(!$vitals_entered) { $vitals_entered= ($bmi > 0); }
  if(!$vitals_entered) { $vitals_entered= ($bmi_status != ''); }
  // echo "Test 1 - Add [".$add."]  and Entered (".$vitals_entered.")<br />\n";
  if($add && $vitals_entered) { return true; }
  $add=false;
  if($vrec != '' && $vrec != '0' && $vitals_entered) {
    // echo "Checking for Vitals Record<br/>\n";
    $fres=sqlStatementNoLog("SELECT * FROM form_vitals WHERE id=?", array($vrec));
    $vitals=sqlFetchArray($fres);
    if($vitals) {
      // echo "Setting Vitals<br/>\n";
      if($ht && $vitals{'height'} && ($ht != $vitals{'height'})) { $add=true; }
  		// echo "Test 2 - Add [".$add."] Ht: $ht (".$vitals{'height'}.")<br />\n";
      if($wt && $vitals{'weight'} && ($wt != $vitals{'weight'})) { $add=true; }
      if($bps && $vitals{'bps'} && ($bps != $vitals{'bps'})) { $add=true; }
      if($bpd && $vitals{'bpd'} && ($bpd != $vitals{'bpd'})) { $add=true; }
      if($bmi && $vitals{'BMI'} && ($bmi != $vitals{'BMI'})) { $add=true; }
      if($bmi_status != $vitals{'BMI_status'}) { $add=true; }
      if($hr && $vitals{'pulse'} && ($hr != $vitals{'pulse'})) { $add=true; }
    }
  }
  return $add;
}

function UpdateDashboard($thisPid,$pap='',$mamm='',$bd='',$chol='',$colon='') {
  if(empty($thisPid)) { return false; }
  $update='';
  // echo "Add Dashboard Test, PID: ",$thisPid,"<br/>\n";
  // echo 'Updating dashboard entries....';
  $dates_entered = ($colon != 0 && $colon != '');
  if(!$dates_entered) { $dates_entered= ($bd != 0 && $bd != ''); }
  if(!$dates_entered) { $dates_entered= ($chol > 0 && $chol != ''); }
  if(!$dates_entered) { $dates_entered= ($pap > 0 && $pap != ''); }
  if(!$dates_entered) { $dates_entered= ($mamm > 0 && $mamm != ''); }
  if(!$dates_entered) { return true; }
  // echo '..';
  $fres=sqlStatementNoLog("SELECT * FROM form_dashboard WHERE pid=?",array($thisPid));
  // echo '..';
  $dash=sqlFetchArray($fres);
  // echo '..';
  if(!$dash{'id'}) {
    // echo "No dashboard was found..Creating";
		$binds=array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
				$_SESSION['userauthorized']);
    sqlStatement("INSERT INTO form_dashboard (date, pid, user, groupname, ".
				"authorized, activity) VALUES (NOW(), ?, ?, ?, ?, '1')", $binds);

  }
  if(!empty($colon) && $colon != $dash{'db_last_colon'}) { 
		$update.="db_last_colon='".$colon."', ";
  }
  if(!empty($bd) && $bd > $dash{'db_last_bone'}) {
		$update.="db_last_bone='".$bd."', ";
  }
  if(!empty($chol) && $chol > $dash{'db_last_chol'}) {
		$update.="db_last_chol='".$chol."', ";
  }
  if(!empty($pap) && $pap > $dash{'db_last_pap'}) {
		$update.="db_last_pap='".$pap."', ";
  }
  if(!empty($mamm) && $mamm > $dash{'db_last_mamm'}) {
		$update.="db_last_mamm='".$mamm."', ";
  }
	if(!empty($update)) {
		$form_dt=date('Y-m-d');
		$update.="db_form_dt='".$form_dt."'";
    $sql = "UPDATE form_dashboard SET date=NOW(), ".$update.
			", user='".$_SESSION['authUser']."', groupname='".
			$_SESSION['authProvider']."', authorized='".$_SESSION['userauthorized'].
			"', activity='1' WHERE pid='".$thisPid."'";
    // echo $sql."<br/>\n";
    sqlInsert($sql);
  }
  // echo '..';
  return true;
}

function checkSettingMode($thisSetting, $thisUser='', $thisSub='')
{
  $value=false;
	// First check for a sub setting if set 
	if($thisSub != '') {
		$subSetting = $thisSetting .'::'. $thisSub;
  	$sql= "SELECT * FROM user_settings WHERE setting_user='".
      	"0' AND setting_label=?";
  	$ures= sqlStatementNoLog($sql,array($subSetting));
  	$urow= sqlFetchArray($ures);
		if($urow{'setting_label'} == $subSetting) $value=$urow{'setting_value'};
		if(isset($_SESSION['authUserID'])) { 
  		$sql= "SELECT * FROM user_settings WHERE setting_user=? ".
     			"AND setting_label=?";
  		$ures= sqlStatementNoLog($sql,array($_SESSION['authUserID'],$subSetting));
  		$urow= sqlFetchArray($ures);
			if($urow{'setting_label'} == $subSetting) $value=$urow{'setting_value'};
		}
	}
  if($value !== false) return $value;
	// First check for a practice setting
  $sql= "SELECT * FROM user_settings WHERE setting_user='".
      "0' AND setting_label=?";
  $ures= sqlStatementNoLog($sql,array($thisSetting));
  $urow= sqlFetchArray($ures);
	if($urow{'setting_label'} == $thisSetting) { $value=$urow{'setting_value'}; }
	if(isset($_SESSION['authUserID'])) { 
  	$sql= "SELECT * FROM user_settings WHERE setting_user=? ".
     		"AND setting_label=?";
  	$ures= sqlStatementNoLog($sql,array($_SESSION['authUserID'],$thisSetting));
  	$urow= sqlFetchArray($ures);
		if($urow{'setting_label'} == $thisSetting) $value=$urow{'setting_value'};
	}
  return $value;
}

function saveSettingMode($thisLabel='', $thisSetting='', $thisUser='')
{
	if(!isset($_SESSION['authUserID']) && !$thisUser) { return true; }
	if(!$thisUser) { $thisUser = $_SESSION['authUserID']; }
	if($thisLabel == '' || $thisSetting == '') { return false; }
	if(!$thisUser) { $thisUser = 0; }
  $sql= "INSERT INTO user_settings (setting_user, setting_label, ".
		"setting_value) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE setting_value=?";
  $test= sqlInsert($sql,array($thisUser, $thisLabel, $thisSetting, $thisSetting));
  return $test;
}

function printFamHist($check=0, $note='', $who='', $title='')
{
	if($check || $note || $who ) {
  	echo "<tr>\n";
  	echo "  <td class='PrintLabel'>&nbsp;&nbsp;$title</td>\n";
  	echo "  <td class='PrintBody'>".MultPrintInline($who)."</td>\n";
  	echo "  <td class='PrintBody'>".$note."</td>\n";
		echo "</tr>\n";
		return true;
	} else {
 	  return false;
	}
}

function PrintChapter($title, $printed=false, $tstyle='', $bstyle='border-collapse: collapse;')
{
  if($printed) { return true; }
  echo "<div class='wmtPrnMainContainer'>\n";
  echo "	<div class='wmtPrnCollapseBar'>\n";
  echo "	<span class='wmtPrnChapter'>",xl($title,'e'),"</span>\n";
  echo "	</div>\n";
  echo "	<div class='wmtPrnCollapseBox' ";
	if($bstyle) { echo "style='$bstyle' "; }
	echo ">\n";
  echo "	<table width='100%' border='0' cellspacing='0' cellpadding='0'";
	if(!empty($tstyle)) { echo " style='$tstyle'"; }
	echo ">\n";
  if($title == 'Review of Systems') {
    echo "	<tr>\n";
    echo "		<td class='wmtPrnLabel' colspan='3'>",xl('The patient reports the current following problems','e'),":</td>\n";
    echo "	</tr>\n";
  }
  return true;
}

function PrintChapterStyle2($title, $printed, $tstyle='')
{
  if($printed) { return true; }
  echo "<fieldset style='border: solid 1px black; padding: 0px; padding-top: 4px; border-collapse: collapse;'><legend class='wmtPrnHeader'>&nbsp;$title&nbsp;</legend>\n";
  echo "	<table width='100%' border='0' cellspacing='0' cellpadding='0'";
	if(!empty($tstyle)) { echo " style='$tstyle'"; }
	echo ">\n";
  if($title == 'Review of Systems') {
    echo "	<tr>\n";
    echo "		<td class='wmtPrnLabel' colspan='3'>",xl('The patient reports the current following problems','e'),":</td>\n";
    echo "	</tr>\n";
  }
  return true;
}

function PrintChapterPlainStyle($title, $printed, $tstyle='')
{
  if($printed) { return true; }
  echo "<fieldset style='border: none; 1px black; padding: 0px; padding-top: 4px; border-collapse: collapse;'><legend class='wmtPrnHeader'>&nbsp;$title&nbsp;</legend>\n";
  echo "	<table width='100%' border='0' cellspacing='0' cellpadding='0'";
	if(!empty($tstyle)) { echo " style='$tstyle'"; }
	echo ">\n";
  if($title == 'Review of Systems') {
    echo "	<tr>\n";
    echo "		<td class='wmtPrnLabel' colspan='3'>",xl('The patient reports the current following problems','e'),":</td>\n";
    echo "	</tr>\n";
  }
  return true;
}

function CloseChapter()
{
	echo "	</table>\n";
	echo "	</div>\n";
	echo "</div>\n";
}

function CloseChapterStyle2()
{
	echo "	</table>\n";
	echo "</fieldset>\n";
	echo "<br>\n";
}

function CloseChapterPlainStyle()
{
	echo "	</table>\n";
	echo "</fieldset>\n";
	echo "<br>\n";
}

function PrintHeader($title, $printed, $bar=false)
{
  if($printed) { return true; }
	if($bar) {
		echo "<tr><td colspan='3'><div style='border-bottom: solid 1px gray; margin: 4px;'></div></td></tr>\n";
	}
  echo "<tr>\n";
  echo "<td class='wmtPrnLabel' colspan='3'>",xl($title,'e'),"&nbsp;</td>\n";
  echo "</tr>\n";
  return true;
}

function PrintBlockHeader($title, $printed)
{
  if($printed) { return true; }
  echo "<tr>\n";
  echo "<td class='wmtPrnHeadingBar' colspan='3'>",xl($title,'e'),"</td>\n";
  echo "</tr>\n";
  return true;
}

function PrintSubSection($title, $printed)
{
  if($printed) { return true; }
  echo "<tr>\n";
  echo "<td class='wmtPrnSubSection' colspan='3'>",xl($title,'e'),"</td>\n";
  echo "</tr>\n";
  return true;
}

function BuildPrintList($list)
{
	$ret='';
	if(!count($list)) return $ret;
	foreach($list as $k => $val) {
		//  echo "Key: ",$k,"  Value: ",$val,"<br/>\n";
		if(!empty($ret)) $ret.=', ';
		$val = ucwords(str_replace("_", " ", $val));
		$ret .= $val;	
	}
	return $ret;
}

function AppendItem($existing='',$new='', $comma=true, $sep='')
{
	if($new=='') { return($existing); }
	$existing=trim($existing);
	if(!empty($existing) && $comma) { 
		$existing.=', ';
	} else if(!empty($existing) && $sep != '') {
		$existing.=$sep;
	} else if(!empty($existing)) {
		$existing.=' ';
	}
	$existing .= $new;
	return($existing);
}

function PrintSingleLine($lbl='',$txt='',$span='1', $tstyle='')
{
	if(!empty($lbl) || !empty($txt)) {
		echo "		<tr>\n";
		echo "			<td colspan='$span'";
		if(!empty($tstyle)) { echo " style='$tstyle'"; }
		echo "><span class='wmtPrnLabel'>$lbl&nbsp;&nbsp</span><span class='wmtPrnBody'>$txt</span></td>\n";
		echo "		</tr>\n";
	}
}

function PrintTwoColumn($lbl1='',$txt1='',$lbl2='',$txt2='', $tstyle='')
{
	$_printed = false;
	if(!empty($lbl1) || !empty($txt1)) {
		echo "		<tr>\n";
		echo "			<td ";
		if(!empty($tstyle)) { echo " style='$tstyle'"; }
		echo "><span class='wmtPrnLabel'>$lbl1&nbsp;&nbsp</span><span class='wmtPrnBody'>$txt1</span></td>\n";
		$_printed = true;
	}
	if(!empty($lbl2) || !empty($txt2)) {
		if(!$_printed) {
			echo "		<tr>\n";
			echo "			<td";
			if(!empty($tstyle)) { echo " style='$tstyle'"; }
			echo ">&nbsp;</td>\n";
		}
		echo "			<td ";
		if(!empty($tstyle)) { echo " style='$tstyle'"; }
		echo "><span class='wmtPrnLabel'>$lbl2&nbsp;&nbsp</span><span class='wmtPrnBody'>$txt2</span></td>\n";
		$_printed = true;
	} else if($_printed) {
		echo "			<td";
		if(!empty($tstyle)) { echo " style='$tstyle'"; }
		echo ">&nbsp;</td>\n";
	}
	if($_printed) { echo "		</tr>\n";}
}

function PrintOverhead($lbl='',$txt='',$span=1,$tstyle='')
{
	if(!empty($lbl)) {
		echo "		<tr>\n";
		echo "			<td class='wmtPrnLabel'";
		if(!empty($tstyle)) { echo " style='$tstyle'"; }
		echo " colspan='$span'>$lbl</td>\n";
		echo "		</tr>\n";
	}
	if(!empty($txt)) {
		echo "		<tr>\n";
		echo "			<td class='wmtPrnIndentText'";
		if(!empty($tstyle)) { echo " style='$tstyle'"; }
		echo " colspan='$span'>$txt</td>\n";
		echo "		</tr>\n";
	}
}

function VerifyPatientID($testID='')
{
  if(!$testID || $testID == 0 || $testID =='') {
		echo "<h>Session Corrupt...Could NOT Access Patient ID!</h><br/>\n";
		echo "<h>ID Value of '",$testID,"' Was Submitted</h><br/>\n";
		echo "Aborting!!<br/>\n";
		return false;
	}
	// Could do other checks here, like retrieve that row of patient data
	return true;
}

function getPrescriptionbyPatient ($thisPid, $cols = "*")
{
  $sql = "SELECT * FROM prescriptions WHERE patient_id=? ".
				"AND active='1' ORDER BY active DESC, date_added DESC";
	$all=array();
  $res = sqlStatementNoLog($sql,array($thisPid));
  for($iter =0;$row = sqlFetchArray($res);$iter++)
  $all[$iter] = $row;
  return $all;
}

function getLinkedPrescriptionsByPatient($thisPid,$enc='',$active='=1')
{
	$all=array();
	if(!$enc) { return $all; }
  $sql = "SELECT form_wmt_ll.list_id, prescriptions.id, ".
			"prescriptions.date_added, prescriptions.drug, prescriptions.drug_id, ".
			"prescriptions.form, prescriptions.dosage, prescriptions.quantity, ".
			"prescriptions.size, prescriptions.unit, prescriptions.route, ".
			"prescriptions.interval, prescriptions.refills, prescriptions.note, ".
			"prescriptions.active FROM form_wmt_ll LEFT JOIN prescriptions ON ".
			"form_wmt_ll.list_id=prescriptions.id WHERE prescriptions.patient_id=? ".
			"AND form_wmt_ll.encounter_id=? AND form_wmt_ll.list_type=? ".
			"AND prescriptions.active$active ORDER BY date_added DESC";
	$binds=array($thisPid, $enc, 'prescriptions', $active);
  $res = sqlStatementNoLog($sql,$binds);
  for($iter =0;$row = sqlFetchArray($res);$iter++)
	$all[] = $row;
  return $all;
}

function getActiveRxByPatient($thisPid,$enc='')
{
  $sql = "SELECT * FROM prescriptions ".
			"WHERE patient_id=? AND active=1 ORDER BY date_added DESC";
	$binds=array($thisPid);
	if($enc != '') {
  	$sql = "SELECT prescriptions.id, ".
			"prescriptions.date_added, prescriptions.drug, prescriptions.drug_id, ".
			"prescriptions.form, prescriptions.dosage, prescriptions.quantity, ".
			"prescriptions.size, prescriptions.unit, prescriptions.route, ".
			"prescriptions.interval, prescriptions.refills, prescriptions.note, ".
			"prescriptions.active, form_wmt_ll.list_id FROM prescriptions ".
			"LEFT JOIN form_wmt_ll ON ".
			"(prescriptions.id=form_wmt_ll.list_id AND form_wmt_ll.encounter_id=? ".
			"AND form_wmt_ll.list_type='prescriptions') ".
			"WHERE prescriptions.patient_id=? AND ".
			"prescriptions.active=1 ORDER BY date_added DESC";
		$binds=array($enc, $thisPid);
	}
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
  for($iter =0;$row = sqlFetchArray($res);$iter++)
	$all[] = $row;
  return $all;
}

function getInactiveRxByPatient($thisPid,$enc='')
{
  $sql = "SELECT * FROM prescriptions ".
			"WHERE patient_id=? AND active<=0 ORDER BY date_added DESC";
	$binds=array($thisPid);
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, prescriptions.id, ".
			"prescriptions.start_date, ".
			"prescriptions.date_added, prescriptions.drug, prescriptions.drug_id, ".
			"prescriptions.form, prescriptions.dosage, prescriptions.quantity, ".
			"prescriptions.size, prescriptions.unit, prescriptions.route, ".
			"prescriptions.interval, prescriptions.refills, prescriptions.note, ".
			"prescriptions.active FROM prescriptions LEFT JOIN form_wmt_ll ON ".
			"(prescriptions.id=form_wmt_ll.list_id AND form_wmt_ll.encounter_id=? ".
			"AND form_wmt_ll.list_type='prescriptions') ".
			"WHERE prescriptions.patient_id=? AND ".
			"prescriptions.active<=0 ORDER BY date_added DESC";
		$binds=array($enc, $thisPid);
	}
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
  for($iter =0;$row = sqlFetchArray($res);$iter++)
	$all[] = $row;
  return $all;
}

function getActivePrescriptionsbyPatient($thisPid,$enc='')
{
  $sql = "SELECT * FROM prescriptions WHERE patient_id=? ".
			"AND active=1 ORDER BY date_added DESC";
	$binds=array($thisPid);
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, prescriptions.id, ".
			"prescriptions.date_added, prescriptions.drug, prescriptions.drug_id, ".
			"prescriptions.form, prescriptions.dosage, prescriptions.quantity, ".
			"prescriptions.size, prescriptions.unit, prescriptions.route, ".
			"prescriptions.interval, prescriptions.refills, prescriptions.note, ".
			"prescriptions.active FROM form_wmt_ll LEFT JOIN prescriptions on ".
			"form_wmt_ll.list_id=prescriptions.id WHERE form_wmt_ll.pid=? AND ".
			"form_wmt_ll.encounter_id=? AND form_wmt_ll.list_type='prescriptions' ".
			"AND prescriptions.active=1 ORDER BY date_added DESC";
		$binds=array($thisPid, $enc);
	}
	// if($max) { $sql .= " LIMIT $max"; }
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
  for($iter =0;$row = sqlFetchArray($res);$iter++)
	$all[] = $row;
  return $all;
}

function getInactivePrescriptionsbyPatient($thisPid,$enc='')
{
  $sql = "SELECT * FROM prescriptions WHERE patient_id=? ".
			"AND active<=0 ORDER BY start_date DESC";
	$binds=array($thisPid);
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, prescriptions.id, ".
			"prescriptions.start_date, ".
			"prescriptions.date_added, prescriptions.drug, prescriptions.drug_id, ".
			"prescriptions.form, prescriptions.dosage, prescriptions.quantity, ".
			"prescriptions.size, prescriptions.unit, prescriptions.route, ".
			"prescriptions.interval, prescriptions.refills, prescriptions.note, ".
			"prescriptions.active FROM form_wmt_ll LEFT JOIN prescriptions on ".
			"form_wmt_ll.list_id=prescriptions.id WHERE form_wmt_ll.pid=? AND ".
			"form_wmt_ll.encounter_id=? AND form_wmt_ll.list_type='prescriptions' ".
			"AND prescriptions.active<=0 ORDER BY start_date DESC";
		$binds=array($thisPid, $enc);
	}
	// if($max) { $sql.= " LIMIT $max"; }
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
  for($iter =0;$row = sqlFetchArray($res);$iter++)
	$all[] = $row;
  return $all;
}


function getAllPrescriptionsbyPatient ($thisPid,$cols="*",$active="*",$enc='')
{
  $sql = "SELECT * FROM prescriptions WHERE patient_id=? ".
			"AND active=? ORDER BY date_added DESC";
	$binds=array($thisPid, $active);
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, prescriptions.id, ".
			"prescriptions.date_added, prescriptions.drug, prescriptions.drug_id, ".
			"prescriptions.form, prescriptions.dosage, prescriptions.quantity, ".
			"prescriptions.size, prescriptions.unit, prescriptions.route, ".
			"prescriptions.interval, prescriptions.refills, prescriptions.note, ".
			"prescriptions.active FROM form_wmt_ll LEFT JOIN prescriptions on ".
			"form_wmt_ll.list_id=prescriptions.id WHERE form_wmt_ll.pid=? AND ".
			"form_wmt_ll.encounter_id=? AND form_wmt_ll.list_type='prescriptions' ".
			"AND prescriptions.active=? ORDER BY date_added DESC";
		$binds=array($thisPid, $enc, $active);
	}
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
  for($iter =0;$row = sqlFetchArray($res);$iter++)
	$all[] = $row;
  return $all;
}

function getFormsByType($type='pop_form', $type2='', $type3='')
{
  $sql = "SELECT wmt_pop_forms.*, registry.name, registry.nickname ".
				"FROM wmt_pop_forms ".
				"LEFT JOIN registry on wmt_pop_forms.form_name=registry.directory ".
				"WHERE $type=1 ";
	if($type2 != '') { $sql .= "OR $type2=1 "; }
	if($type3 != '') { $sql .= "OR $type3=1 "; }
	$sql .= "ORDER BY ".
				"IF((registry.nickname IS NOT NULL AND registry.nickname != ''),".
				"registry.nickname,registry.name)";
	$all=array();
	// echo "My Form Query: $sql<br>\n";
  $res = sqlStatementNoLog($sql);
  for($iter =0;$row = sqlFetchArray($res);$iter++) {
  	$row{'full_name'} = 'form_'.$row{'form_name'};
  	$all[$iter] = $row;
	}
  return $all;
}

function getAllMedicationsbyPatient ($thisPid, $cols = "*", $enc='')
{
  $sql = "SELECT * FROM medications WHERE patient_id=? ORDER BY date_added DESC";
	$all=array();
  $res = sqlStatementNoLog($sql,array($thisPid));
  for($iter =0;$row = sqlFetchArray($res);$iter++)
  $all[$iter] = $row;
  return $all;
}

function GetAllImmunizationsbyPatient ($thisPid, $enc='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
  $sql = "SELECT * FROM immunizations WHERE patient_id=? ORDER BY ".
				"administered_date DESC";
	$binds=array($thisPid);
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, immunizations.id, ".
				"immunizations.administered_date, ".
				"immunizations.cvx_code, immunizations.manufacturer, ".
				"immunizations.lot_number, immunizations.note ".
				"FROM form_wmt_ll LEFT JOIN immunizations on ".
				"form_wmt_ll.list_id=immunizations.id WHERE form_wmt_ll.pid=? ".
				"AND form_wmt_ll.encounter_id=? AND form_wmt_ll.list_type=? ".
				"ORDER BY immunizations.administered_date DESC";
		$binds=array($thisPid, $enc, 'immunizations');
	}
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
  for($iter =0;$row = sqlFetchArray($res);$iter++)
  $all[$iter] = $row;
  return $all;
}

function AddSurgery($thisPid,$sdate='',$title='',$comm='',$refer='',$hosp='',$src=1)
{
	$test=false;
	if($sdate == 'YYYY-MM-DD') { $sdate=''; }
	if(strlen($sdate) == 4) { $sdate .= '-00-00'; }
  if(!VerifyPatientID($thisPid)) { return $test; }
	if(!empty($sdate) || !empty($title) || !empty($comm) || !empty($refer)) {
  	$sql="INSERT INTO lists (date, pid, type, title, activity, ".
			"user, groupname, begdate, enddate, comments, referredby, extrainfo, classification) ".
			"VALUES (NOW(), ?, 'surgery', ?, '1', ?, ?, ?, ?, ?, ?, ?, ?)";
		// echo $sql,"<br/>\n";
		$binds=array($thisPid, $title, $_SESSION['authUser'], 
				$_SESSION['authProvider'], $sdate, $sdate, $comm, $refer, $hosp, $src);
  	$test=sqlInsert($sql,$binds);
		setListTouch($thisPid, 'surgery');
	}
	return $test;
}

function UpdateSurgery($thisPid,$item='',$sdate='',$title='',$comm='',$refer='',$hosp='',$src=1)
{
	if($sdate == 'YYYY-MM-DD') { $sdate=''; }
	if(strlen($sdate) == 4) { $sdate .= '-00-00'; }
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($sdate) || !empty($title) || !empty($comm) || !empty($refer)) {
  	$sql="UPDATE lists SET date=NOW(), begdate=?, title=?, comments=?, ".
				"referredby=?, extrainfo=?, classification=? WHERE pid=? AND id=?";
		$binds=array($sdate, $title, $comm, $refer, $hosp, $src, $thisPid, $item);
		sqlStatement($sql, $binds);
		setListTouch($thisPid, 'surgery');
	}
}

function DeleteSurgery($thisPid,$item='',$links=0)
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM lists WHERE pid=? AND id=? AND type=?",
		array($thisPid, $item, 'surgery'));
	setListTouch($thisPid, 'surgery');
	if($links) {
		DeleteAllListEntries($thisPid, $item, 'surgery');
	}
}

function AddHospitalization($thisPid,$sdate='',$why='',$type='',$note='')
{
	$test=false;
	if($sdate == 'YYYY-MM-DD') { $sdate=''; }
	if(strlen($sdate) == 4) { $sdate .= '-00-00'; }
  if(!VerifyPatientID($thisPid)) { return $test; }
	if(!empty($sdate) || !empty($why) || !empty($note) || !empty($type)) {
		$binds=array($thisPid, $why, $_SESSION['authUser'], 
				$_SESSION['authProvider'], $sdate, $sdate, $note, $type);
  	$test=sqlInsert("INSERT INTO lists (date, pid, type, title, activity, ".
			"user, groupname, begdate, enddate, comments, extrainfo) VALUES ".
			"(NOW(), ?, 'hospitalization', ?, '1', ?, ?, ?, ?, ?, ?)", $binds);
		setListTouch($thisPid, 'hospitalization');
	}
	return $test;
}

function UpdateHospitalization($thisPid,$item='',$sdate='',$why='',$type='',$note='')
{
	if($sdate == 'YYYY-MM-DD') { $sdate=''; }
	if(strlen($sdate) == 4) { $sdate .= '-00-00'; }
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($sdate) || !empty($note) || !empty($why)) {
		$binds= array($sdate, $why, $note, $type, $thisPid, $item);
  	sqlStatement("UPDATE lists SET date=NOW(), begdate=?, ".
			"title=?, comments=?, extrainfo=? WHERE pid=? AND id=?", $binds);
		setListTouch($thisPid, 'hospitalization');
	}
}

function DeleteHospitalization($thisPid,$item='',$links=0)
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM lists WHERE pid=? AND id=? AND ".
			"type='hospitalization'",array($thisPid, $item));
	setListTouch($thisPid, 'hospitalization');
	if($links) {
		DeleteAllListEntries($thisPid, $item, 'hospitalization');
	}
}

function GetMedicalHistory($thisPid, $enc='') {
  $sql = "SELECT id, injury_type as pmh_type, comments as pmh_nt, ".
			"extrainfo, classification FROM lists ".
			"WHERE pid=? AND type='wmt_med_history' ORDER BY id";
	$binds=array($thisPid);
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, lists.id, injury_type as pmh_type, ".
				"comments as pmh_nt, extrainfo, classification FROM form_wmt_ll ".
				"LEFT JOIN lists on ".
				"form_wmt_ll.list_id=lists.id WHERE form_wmt_ll.pid=? ".
				"AND form_wmt_ll.encounter_id=? AND form_wmt_ll.list_type=? ".
				"ORDER BY lists.id";
		$binds=array($thisPid, $enc, 'wmt_med_history');
	}
	$all=array();
  $res = sqlStatementNoLog($sql, $binds);
	$iter=0;
  while($row = sqlFetchArray($res)) {
		$all[$iter] = $row;
		$sql = "SELECT COUNT(*) FROM form_wmt_ll WHERE form_wmt_ll.list_type=? ".
				"AND form_wmt_ll.list_id=?";
		$chk = sqlStatementNoLog($sql, array('wmt_med_history', $all[$iter]['id']));
		$num = sqlFetchArray($chk);
		$all[$iter]['pmh_num_links']= $num['COUNT(*)'];
		$iter++;
	}
  return $all;
}

function AddMedicalHistory($thisPid,$type='',$sub='',$note='',$hosp='',$src=1)
{
	$test=false;
  if(!VerifyPatientID($thisPid)) { return $test; }
	$type = trim($type);
	$note = trim($note);
	$hosp = trim($hosp);
	if($type || $sub || $note || $hosp) {
		// Auto-create a title for this issue
		// echo "Somehow we got into the add history section<br>\n";
		$title=ListLook($type,'Medical_History_Problems');
		if($title == '') { $title='No Type of History Specified'; }
		$binds=array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
			$type, $sub, $note, $title, $hosp, $src);
  	$test=sqlInsert("INSERT INTO lists (date, pid, user, groupname, activity, ".
			"type, enddate, injury_type, injury_part, comments, title, ".
			"extrainfo, classification) VALUES (NOW(), ?, ?, ?, '1', ".
			"'wmt_med_history', '0000-00-00', ?, ?, ?, ?, ?, ?)", $binds);
		setListTouch($thisPid, 'wmt_med_history');
	}
	return $test;
}

function UpdateMedicalHistory($thisPid,$item='',$type='',$sub='',$note='',$hosp='',$src=1)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($type) || !empty($sub) || !empty($note) || !empty($hosp)) {
		// Auto-create a title for this issue
		$title=ListLook($type,'Medical_History_Problems');
		if($title == '') { $title='No Type of History Specified'; }
		$binds=array($type, $sub, $note, $title, $hosp, $src, $thisPid, $item);
  	sqlStatement("UPDATE lists SET date=NOW(), injury_type=?, ".
				"injury_part=?, comments=?, title=?, extrainfo=?, classification=? ".
				" WHERE pid=? AND id=?",$binds);
		setListTouch($thisPid, 'wmt_med_history');
	}
}

function DeleteMedicalHistory($thisPid,$item='',$links=0)
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM lists WHERE pid=? AND id=?", 
			array($thisPid, $item));
	setListTouch($thisPid, 'wmt_med_history');
	if($links) {
		DeleteAllListEntries($thisPid, $item, 'wmt_med_history');
	}
}

function AddSupplier($thisPid,$name='',$type='',$note='')
{
	$test=false;
  if(!VerifyPatientID($thisPid)) { return $test; }
	if(!empty($name) || !empty($type) || !empty($note)) {
		// Auto-create a title for this issue
		$binds=array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
			$name, $type, $note);
  	$test=sqlInsert("INSERT INTO lists (date, pid, user, groupname, activity, ".
			"type, enddate, referredby, title, comments) ".
			"VALUES (NOW(), ?, ?, ?, '1', 'wmt_supplier', ".
			"'0000-00-00', ?, ?, ?)", $binds);
		setListTouch($thisPid, 'wmt_supplier');
	}
	return $test;
}

function UpdateSupplier($thisPid,$item='',$name='',$type='',$note='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($type) || !empty($name) || !empty($note)) {
		// Auto-create a title for this issue
		$binds=array($name, $type, $note, $thisPid, $item);
  	sqlStatement("UPDATE lists SET date=NOW(), referredby=?, ".
				"title=?, comments=? WHERE pid=? AND id=?",$binds);
		setListTouch($thisPid, 'wmt_supplier');
	}
}

function DeleteSupplier($thisPid,$item='',$links=0)
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM lists WHERE pid=? AND id=?", 
			array($thisPid, $item));
	setListTouch($thisPid, 'wmt_supplier');
	if($links) {
		DeleteAllListEntries($thisPid, $item, 'wmt_supplier');
	}
}

function GetImageHistory($thisPid,$enc='') {
  $sql = "SELECT id, injury_type as img_type, comments as img_nt, ".
		"begdate as img_dt, classification  FROM lists WHERE pid=? AND ".
		"type=? ORDER BY begdate";
	$binds=array($thisPid, 'wmt_img_history');
	// Create a new sql statement to only get those included on the linked list
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, lists.id, injury_type as img_type, ".
				"comments as img_nt, begdate as img_dt, classification FROM ".
				"form_wmt_ll LEFT JOIN ".
				"lists on form_wmt_ll.list_id=lists.id WHERE form_wmt_ll.pid=? ".
				"AND form_wmt_ll.encounter_id=? AND form_wmt_ll.list_type=? ".
				"ORDER BY begdate";
		$binds=array($thisPid, $enc, 'wmt_img_history');
	}
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
	$iter = 0;
  while($row = sqlFetchArray($res)) {
  	$all[$iter] = $row;
		$sql = "SELECT COUNT(*) FROM form_wmt_ll WHERE form_wmt_ll.list_type=? ".
				"AND form_wmt_ll.list_id=?";
		$chk = sqlStatementNoLog($sql, array('wmt_img_history', $all[$iter]['id']));
		$num = sqlFetchArray($chk);
		$all[$iter]['img_num_links']= $num['COUNT(*)'];
		$iter++;
	}
  return $all;
}

function AddImageHistory($thisPid,$type='',$dt='',$note='', $src=1)
{
	$test=0;
  if(!VerifyPatientID($thisPid)) { return false; }
	if(strlen($dt) == 4) { $dt .= '-00-00'; }
	if(!empty($type) || !empty($dt) || !empty($note)) {
		// Auto-create a title for this issue
		$title=ListLook($type,'Image_Types');
		if($title == '') { $title='No Type of Image Specified'; }
		if($dt == 0 || $dt == 'YYYY-MM-DD' || $dt == '') { $dt='0000-00-00'; }
  	$sql="INSERT INTO lists (date, pid, user, groupname, activity, begdate, ".
			"enddate, type, injury_type, comments, title, classification) ".
			"VALUES (NOW(), ?, ?, ?, '1', ?, ?, ?, ?, ?, ?, ?)";
		$test=sqlInsert($sql, array($thisPid, $_SESSION['authUser'], 
			$_SESSION['authProvider'],$dt,$dt,'wmt_img_history',$type,$note,
			$title, $src));
		setListTouch($thisPid, 'wmt_img_history');
		// We could log with test if we want to add that functionality
		// echo "Image History Added - Return [$test]<br/>\n";
	}
	return $test;
}

function UpdateImageHistory($thisPid,$item='',$type='',$dt='',$note='',$src=1,$sub='')
{
	if(strlen($dt) == 4) { $dt .= '-00-00'; }
	if($dt == 0 || $dt == 'YYYY-MM-DD' || $dt == '0000-00-00') { $dt=''; }
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($type) || !empty($sub) || !empty($note)) {
		// Auto-create a title for this issue
		$title=ListLook($type,'Image_Types');
		if($title == '') { $title='No Type of Image Specified'; }
		$binds=array($type, $sub, $note, $title, $src, $thisPid, $item);
  	$sql="UPDATE lists SET date=NOW(), ";
		if(!empty($dt) && $dt != 0) { 
			$sql.="begdate=?, ";
			array_unshift($binds, $dt);
		}
		$sql.="injury_type=?, injury_part=?, comments=?, title=?, ".
				"classification=?  WHERE pid=? AND id=?";
		sqlStatement($sql,$binds);
		setListTouch($thisPid, 'wmt_img_history');
	}
}

function DeleteImageHistory($thisPid,$item='',$links=0)
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM lists WHERE pid=? AND id=?", 
			array($thisPid, $item));
	setListTouch($thisPid, 'wmt_img_history');
	if($links) {
		DeleteAllListEntries($thisPid, $item, 'wmt_img_history');
	}
}

function LinkListEntry($thisPid, $item='', $enc='', $type='', $report=false, $skip=false)
{
	if($item == '' || $enc == '') { return false; }
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("INSERT INTO form_wmt_ll (encounter_id, ".
			"list_type, list_id, pid) VALUES (?, ?, ?, ?) ".
			"ON DUPLICATE KEY UPDATE list_id=?",
			array($enc, $type, $item, $thisPid, $item));
	if($report) {
		echo "Linked $type (ID: $item) to Encounter [$enc] for Patient ID: $thisPid<br/>\n";
	}
	// If this was for an entry in lists, also update the issue_encounter table
	if($type != 'prescriptions' && $type != 'immunizations' && $type != 'pap' &&
		$type != 'past_pregnancy' && !$skip) {
		$sql="INSERT INTO issue_encounter (pid, list_id, encounter, resolved) ".
				"VALUES (?, ?, ?, 0) ON DUPLICATE KEY UPDATE encounter=?";
		$binds=array($thisPid, $item, $enc, $enc);
		$link=sqlInsert($sql,$binds);
	}
}

function UnlinkListEntry($thisPid, $item='',$enc='', $type='', $skip=false)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if($item == '' || $enc == '') { return false; }
 	sqlStatement("DELETE FROM form_wmt_ll WHERE pid=? AND encounter_id=? ".
		"AND list_id=? AND list_type=?", array($thisPid, $enc, $item, $type));
	// If this was for an entry in lists, also update the issue_encounter table
	if($type != 'prescriptions' && $type != 'immunizations' && $type != 'pap' &&
		$type != 'past_pregnancy' && !$skip) {
		$sql="DELETE FROM issue_encounter WHERE pid=? AND list_id=? AND ".
			"encounter=?";
		$binds=array($thisPid, $item, $enc);
		sqlStatement($sql,$binds);
	}
}

function DeleteAllListEntries($thisPid, $item='', $type='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if($item == '' || $type == '') { return false; }
 	sqlStatement("DELETE FROM form_wmt_ll WHERE pid=? AND ".
		"list_id=? AND list_type=?", array($thisPid, $item, $type));
	// If this was for an entry in lists, also update the issue_encounter table
	if($type != 'prescriptions' && $type != 'immunizations' && $type != 'pap' &&
		$type != 'past_pregnancy') {
		$sql="DELETE FROM issue_encounter WHERE pid=? AND list_id=?";
		$binds=array($thisPid, $item);
		sqlStatement($sql,$binds);
	}
}

function UnlinkTypeFromEncounter($thisPid, $enc='', $type='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if($enc== '' || $type == '') { return false; }
 	sqlStatement("DELETE FROM form_wmt_ll WHERE pid=? AND ".
		"encounter_id=? AND list_type=?", array($thisPid, $enc, $type));
	// If this was for an entry in lists, also update the issue_encounter table
	if($type != 'prescriptions' && $type != 'immunizations' && $type != 'pap' &&
		$type != 'past_pregnancy') {
		$sql="DELETE FROM issue_encounter WHERE pid=? AND encounter=?";
		$binds=array($thisPid, $enc);
		sqlStatement($sql,$binds);
	}
}

function AddAllergy($thisPid,$sdate='',$title='',$comm='',$react='',$occur='')
{
	$test=false;
	if($sdate == 'YYYY-MM-DD') { $sdate=''; }
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($sdate) || !empty($title) || !empty($comm) || 
			!empty($react) || !empty($occur)) {
		$binds=array($thisPid, $title, $_SESSION['authUser'], 
			$_SESSION['authProvider'], $sdate, $occur, $comm, $react);
  	$test = sqlInsert("INSERT INTO lists (date, pid, type, title, activity, ".
			"user, groupname, begdate, occurrence, comments, reaction) VALUES ".
			"(NOW(), ?, 'allergy', ?, '1', ?, ?, ?, ?, ?, ?)", $binds);
		setListTouch($thisPid, 'allergy');
	}
	return $test;
}

function UpdateAllergy($thisPid,$item='',$note='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($note)) {
  	sqlStatement("UPDATE lists SET date=NOW(), comments=? ".
			" WHERE pid=? AND id=?", array($note, $thisPid, $item));
		setListTouch($thisPid, 'allergy');
	}
}

function AddMedication($thisPid,$sdate='',$edate='',$title='',$comm='',$stat='')
{
	if($sdate == 'YYYY-MM-DD') { $sdate=''; }
	if($edate == 'YYYY-MM-DD') { $edate=''; }
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($sdate) || !empty($edate) || !empty($title) || !empty($comm) || 
			!empty($stat)) {
		if(empty($edate) || !$edate || $edate == '') {
  		sqlInsert("INSERT INTO lists (date, pid, type, title, activity, user, ".
     			"groupname, begdate, comments, extrainfo) VALUES (NOW(), ".
     			"'$thisPid', 'medication', '".$title."', '1', '".
     			$_SESSION['authUser']."', '".$_SESSION['authProvider']."', '".
     			$sdate."', '".$comm."', '".$stat."')");
		} else {
  		sqlInsert("INSERT INTO lists (date, pid, type, title, activity, user, ".
     			"groupname, begdate, enddate, comments, extrainfo) VALUES (NOW(), ".
     			"'$thisPid', 'medication', '".$title."', '1', '".
     			$_SESSION['authUser']."', '".$_SESSION['authProvider']."', '".
     			$sdate."', '".$edate."', '".$comm."', '".$stat."')");
		}
		setListTouch($thisPid, 'medication');
	}
}

function UpdatePrescription($thisPid,$item='',$note='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($note)) {
  	sqlStatement("UPDATE prescriptions SET date_modified=NOW(), note=? ".
			"WHERE patient_id=? AND id=?", array($note, $thisPid, $item));
		setListTouch($thisPid, 'prescription_erx');
	}
}

function UpdateImmunization($thisPid,$item='',$note='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($note)) {
		$binds=array($note, $_SESSION['authUserID'], $thisPid, $item);
  	sqlStatement("UPDATE immunizations SET update_date=NOW(), note=?, ".
			"updated_by=? WHERE patient_id=? AND id=?",$binds);
		setListTouch($thisPid, 'immunization');
	}
}

function AddProblem($thisPid, $pdate='', $pdiag='')
{
 	if(!empty($pdiag) && $pdiag != 0) {
		$desc=lookup_code_descriptions('ICD9:'.$pdiag);
		$pdiag='ICD9:'.$pdiag;
   	$title=$pdiag.' - '.$desc;
   	$comment='Auto-Add From Encounter: '.$pdate.' - Extended Exam (1)';
		$binds=array($thisPid, $title, $_SESSION['authUser'], 
			$_SESSION['authProvider'], $pdate, $pdiag, $comment);
   	sqlInsert("INSERT INTO lists (date, pid, type, title, activity, user, ".
      	"groupname, begdate, occurrence, referredby, diagnosis, comments ) ".
				"VALUES (NOW(), ?, 'medical_problem',  ?, '1', ?, ?, ?, '', '', ?, ?)",
				$binds);
		setListTouch($thisPid, 'medical_problem');
 	}
}

function AddFamilyHistory($thisPid,$who='',$type='',$note='',$dead='',$age='', $age_dead='',$src=1)
{
	$ret=false;
	if($age == 'YYYY-MM-DD') { $age=''; }
	if($age_dead == 'YYYY-MM-DD') { $age_dead=''; }
  if(!$thisPid || $thisPid == 0 || $thisPid=='') {
		echo "<h>Session Corrupt...Could NOT Access Patient ID!</h><br/>\n";
		echo "Aborting!!<br/>\n";
		exit;
	}
	if(!empty($who) && (!empty($type) || !empty($note))) { 
		// Auto-create a title for this issue
		$title='No Type of History';
		$tmp=ListLook($type,'Family_History_Problems');
		if($tmp != '') { $title=$tmp.' - '; }
		$tmp=ListLook($who,'Family_Relationships');
		if($tmp == '') { $tmp='No Family Member Specified'; }
		$title.=$tmp;
		
		$binds=array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
				$who, $dead, $age, $age_dead, $type, $note, $title, $src);
  	$ret=sqlInsert("INSERT INTO lists (date, type, pid, user, groupname, ".
     	"activity, begdate, enddate, injury_part, injury_grade, reaction, ".
			"destination, injury_type, comments, title, classification) VALUES ".
			"(NOW(), ".
			"'wmt_family_history', ?, ?, ?, '1', '0000-00-00', '0000-00-00', ?, ".
			"?, ?, ?, ?, ?, ?, ?)", $binds);
		setListTouch($thisPid, 'wmt_family_history');
	}
	if(!empty($who) && (!empty($dead) || !empty($age) || !empty($age_dead))) { 
		$sql="SELECT * FROM form_fh_misc WHERE pid=? AND fhm_who=?";
		$res=sqlStatementNoLog($sql,array($thisPid, $who));
		$row=sqlFetchArray($res);
		$binds=array();
		if(($row{'pid'} != '') && ($row{'fhm_who'} != '')) {
			$update=',';
			if(!empty($dead)) { 
				array_push($binds, $dead);
				$update.=" fhm_deceased=?,";
			}
			if(!empty($age)) { 
				array_push($binds, $age);
				$update.=" fhm_age=?,";
			}
			if(!empty($age_dead)) {
				array_push($binds, $age_dead);
				$update.=" fhm_age_dead=?,";
			}
			array_push($binds, $_SESSION['authUser'], $_SESSION['authProvider'], 
					$_SESSION['userauthorized'], $thisPid, $who);
    	$sql = "UPDATE form_fh_misc SET date=NOW() ".$update." user=?, ".
				"groupname=?, authorized=?, activity='1' WHERE pid=? AND fhm_who=?";
			sqlStatement($sql,$binds);
		} else {
			// echo "No result!<br/>\n";
			// echo $res,"<br/>\n";
			// echo "Making an entry for this person<br/>\n";
			$binds=array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
				$_SESSION['userauthorized'], $who, $dead, $age, $age_dead);
  		sqlInsert("INSERT INTO form_fh_misc (date, pid, user, groupname, ".
     		"authorized, activity, fhm_who, fhm_deceased, fhm_age, fhm_age_dead) ".
				"VALUES (NOW(), ?, ?, ?, ?, '1', ?, ?, ?, ?)",$binds);
		}
	}
	return $ret;
}

function UpdateFamilyHistory($thisPid,$item='',$who='',$type='',$note='',$dead='',$age='',$age_dead='',$src=1)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($who) && (!empty($type) || !empty($note))) { 
		// Auto-create a title for this issue
		$title='No Type of History';
		$tmp=ListLook($type,'Family_History_Problems');
		if($tmp != '') { $title=$tmp.' - '; }
		$tmp=ListLook($who,'Family_Relationships');
		if($tmp == '') { $tmp='No Family Member Specified'; }
		$title.=$tmp;
		$binds=array($_SESSION['authUser'], $_SESSION['authProvider'], $who,
					$dead, $age, $age_dead, $type, $note, $title, $src, $thisPid, $item);
    $sql = "UPDATE lists SET date=NOW(), user=?, groupname=?, ".
				"activity='1', injury_part=?, injury_grade=?, reaction=?, ".
				"destination=?, injury_type=?, comments=?, title=?, classification=? ".
				"WHERE pid=? AND id=?";
		sqlStatement($sql,$binds);
		setListTouch($thisPid, 'wmt_family_history');
	}

	if(!empty($who) && (!empty($dead) || !empty($age) || !empty($age_dead))) { 
		$sql="SELECT * FROM form_fh_misc WHERE pid=? AND fhm_who=?";
		$res=sqlStatementNoLog($sql, array($thisPid, $who));
		$row=sqlFetchArray($res);
		if(($row{'pid'} != '') && ($row{'fhm_who'} != '')) {
			$binds=array();
			$update=',';
			if(!empty($dead)) {
				array_push($binds, $dead);
				$update.=" fhm_deceased=?,";
			}
			if(!empty($age)) {
				array_push($binds, $age);
				$update.=" fhm_age=?,";
			}
			if(!empty($age_dead)) {
				array_push($binds, $age_dead);
				$update.=" fhm_age_dead=?,";
			}
			array_push($binds, $_SESSION['authUser'], $_SESSION['authProvider'],
				$_SESSION['userauthorized'], $thisPid, $who);
    	$sql = "UPDATE form_fh_misc SET date=NOW() ".$update." user=?, ".
				"groupname=?, authorized=?, activity='1' WHERE pid=? AND fhm_who=?";
			sqlStatement($sql,$binds);
		} else {
			$binds=array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
				$_SESSION['userauthorized'], $who, $dead, $age, $age_dead);
  		sqlInsert("INSERT INTO form_fh_misc (date, pid, user, groupname, ".
     		"authorized, activity, fhm_who, fhm_deceased, fhm_age, fhm_age_dead) ".
				"VALUES (NOW(), ?, ?, ?, ?, '1', ?, ?, ?, ?)", $binds);
		}
	}
}

function DeleteFamilyHistory($thisPid,$item='',$links=0)
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM lists WHERE pid=?  AND id=?", 
				array($thisPid, $item));
	setListTouch($thisPid, 'wmt_family_history');
	if($links) {
		DeleteAllListEntries($thisPid, $item, 'wmt_family_history');
	}
}

function GetFamilyHistory($thisPid,$enc='') {
  $sql = "SELECT id, injury_part as fh_who, injury_grade as fh_deceased, ".
			"reaction as fh_age, destination as fh_age_dead, classification, ".
			"injury_type as fh_type, comments as fh_nt FROM lists ".
			"WHERE pid=? AND type='wmt_family_history' ORDER BY id";
	$binds=array($thisPid);
	if($enc != '') {
  	$sql = "SELECT form_wmt_ll.list_id, lists.id, injury_grade as ".
				"fh_deceased, reaction as fh_age, destination as fh_age_dead, ".
				"injury_part as fh_who, classification, ".
				"injury_type as fh_type, comments as fh_nt FROM form_wmt_ll ".
				"LEFT JOIN lists on form_wmt_ll.list_id=lists.id WHERE ".
				"form_wmt_ll.pid=? AND form_wmt_ll.encounter_id=? AND ".
				"form_wmt_ll.list_type=? ORDER BY lists.id";
		$binds=array($thisPid, $enc, 'wmt_family_history');
	}
	$all=array();
  $res = sqlStatementNoLog($sql,$binds);
	$iter=0;
  while($row = sqlFetchArray($res)) {
  	$all[$iter] = $row;
		$sql= "SELECT COUNT(*) FROM form_wmt_ll WHERE form_wmt_ll.list_type=? ".
				"AND form_wmt_ll.list_id=?";
		$chk= sqlStatementNoLog($sql, array('wmt_family_history', $all[$iter]['id']));
		$num= sqlFetchArray($chk);
		$all[$iter]['fh_num_links'] = $num['COUNT(*)'];
		$iter++;
	}
  return $all;
}

function GetFamilyHistoryDefaults($thisPid) {
	$all=array();
	$fres=sqlStatementNoLog("SELECT option_id, title FROM list_options WHERE ".
       "list_id='Family_Relationships' ORDER BY seq");
  while($frow = sqlFetchArray($fres)) {
  	$sql = "SELECT fhm_who, fhm_deceased, fhm_age, fhm_age_dead FROM ".
				"form_fh_misc WHERE pid=? AND fhm_who=?";
		// echo "Query: ",$sql,"<br/>\n";
  	$res = sqlStatementNoLog($sql, array($thisPid, $frow{'option_id'}));
		$row = sqlFetchArray($res);

  	$all[$frow{'option_id'}] = $row;
	}
  return $all;
}

function AddDiagnosis($thisPid,$enc=0,$type='',$diag='',$title='',$note='',$bdt='',$edt='',$seq='')
{
	if($bdt == 'YYYY-MM-DD') { $bdt=''; }
	if($edt == 'YYYY-MM-DD') { $edt=''; }
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($diag) || !empty($note) || !empty($title)) {
		// The start date must be set
		if(empty($bdt) || !$bdt) { $bdt=date('Y-m-d'); }
		if(empty($title)) { 
			if(!empty($diag)) {
				$title=$diag.' - '.lookup_code_descriptions($type.':'.$diag);
			} else {
				$title='Problem added for visit on '.date('Y-m-d');
			}
		}
		if(!empty($type) && !empty($diag)) { $diag=$type.':'.$diag; }
  	$sql= "INSERT INTO lists (date, pid, user, groupname, type, title, ".
			"begdate, enddate, activity, diagnosis, comments) VALUES ".
			"(NOW(), ?, ?, ?, 'medical_problem', ?, ?, ?, '1', ?, ?)";
		$binds = array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
			$title, $bdt, $edt, $diag, $note);
		if(empty($edt) || $edt=='' || !$edt) {
  		$sql= "INSERT INTO lists (date, pid, user, groupname, type, title, ".
				"begdate, activity, diagnosis, comments) VALUES ".
				"(NOW(), ?, ?, ?, 'medical_problem', ?, ?, '1', ?, ?)";
			$binds = array($thisPid, $_SESSION['authUser'], $_SESSION['authProvider'],
				$title, $bdt, $diag, $note);
		}
		$test=sqlInsert($sql, $binds);
		setListTouch($thisPid, 'medical_problem');
		if(!$seq) $seq = GetDiagnosisSequence($thisPid, $enc);
		// Now add the link from this diagnosis to this encounter
		// echo "Diagnosis Insert returned ",$test,"<br/>\n";
		LinkDiagnosis($thisPid, $test, $enc, $seq);
	}
}

function GetDiagnosisSequence($thisPid,$thisEnc='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!$thisEnc) { return false; }
	$sql="SELECT pid, seq FROM issue_encounter WHERE pid=? AND encounter=? ".
			"ORDER BY seq * 1 DESC, seq DESC";
	$fres = sqlStatementNoLog($sql, array($thisPid, $thisEnc));
	$frow = sqlFetchArray($fres);
	$val = 1;
	if($frow{'seq'}) {
		// Could make some alpha sensitive code here
		$val = $frow{'seq'} + 1;
	}
	return $val;
}

function SequenceDiagnosis($thisPid,$thisId='',$thisEnc='', $seq='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!$thisId) { return false; }
	if(!$thisEnc) { return false; }
	// echo "Past the value checks<br>\n";
	// $sql="INSERT INTO issue_encounter (pid, list_id, encounter, resolved, seq) ".
			// "VALUES (?, ?, ?, 0, ?) ON DUPLICATE KEY UPDATE seq=VALUES(seq)";
	$sql = "SELECT * FROM issue_encounter WHERE pid=? AND list_id=? ".
		"AND encounter=?";
	$fres = sqlStatementNoLog($sql, array($thisPid, $thisId, $thisEnc));
	$frow = sqlFetchArray($fres);
	// We only update this if the diag is already linked to the encounter
	if($frow{'list_id'} == $thisId) {
		$sql="UPDATE issue_encounter SET seq=? WHERE pid=? AND list_id=? ".
			"AND encounter=?";
		sqlStatement($sql, array($seq, $thisPid, $thisId, $thisEnc));
	}
}

function LinkDiagnosis($thisPid,$thisId='',$thisEnc='', $seq='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!$thisId) { return false; }
	if(!$thisEnc) { return false; }
	$sql="INSERT INTO issue_encounter (pid, list_id, encounter, resolved, seq) ".
			"VALUES (?, ?, ?, 0, ?)";
	$test=sqlInsert($sql, array($thisPid, $thisId, $thisEnc, $seq));
}

function UnlinkDiagnosis($thisPid,$thisId='',$thisEnc='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!$thisId) { return false; }
	if(!$thisEnc) { return false; }
	$sql="DELETE FROM issue_encounter WHERE pid=? AND list_id=? AND encounter=?";
	// echo "My Patient: $thisPid  ID: $thisId and Enc: $thisEnc<br>\n";
	sqlStatement($sql, array($thisPid, $thisId, $thisEnc));
	// exit;
}

function UpdateDiagnosis($thisPid,$thisId='',$diag='',$title='',$note='',$bdt='',$edt='',$pre='',$suff='',$seq='', $thisEnc='')
{
	if(!empty($pre) && (substr($pre,-1) != ':')){ $pre.=':'; }
	$diag=$pre.$diag.$suff;
	if($bdt == 'YYYY-MM-DD') { $bdt=''; }
	if($edt == 'YYYY-MM-DD') { $edt=''; }
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($diag) || !empty($note) || !empty($title)) {
		$binds=array($diag, $bdt, $title, $note, $thisPid, $thisId);
  	$sql="UPDATE lists SET date=NOW(), diagnosis=?, begdate=?, ".
			"title=?, comments=? WHERE pid=? AND id=?";
		if(!empty($edt)) {
			$binds=array($diag, $bdt, $edt, $title, $note, $thisPid, $thisId);
  		$sql="UPDATE lists SET date=NOW(), diagnosis=?, begdate=?, ".
				"enddate=?, title=?, comments=? WHERE pid=? AND id=?";
		}
  	sqlStatement($sql, $binds);
		setListTouch($thisPid, 'medical_problem');
	}
	// echo "Trying to update $thisId -> $thisEnc -> $seq<br>\n";
	SequenceDiagnosis($thisPid, $thisId, $thisEnc, $seq);
}

function DeleteDiagnosis($thisPid,$item='')
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM lists WHERE pid=? AND id=?",
				array($thisPid, $item));
	setListTouch($thisPid, 'medical_problem');
	// echo "Test of Individual Delete: ",$test,"<br/>\n";
}

function GetFormFromRepository($thisPid,$thisEnc,$thisId,$thisName)
{
	$_ret='Could Not Locate Archived Form'; 
  if(!VerifyPatientID($thisPid)) { return false; }
	$binds=array($thisPid, $thisId, $thisName, $thisEnc);
  $sql="SELECT id, form_id, content FROM form_repository WHERE pid=? ".
		"AND form_id=? AND form_name=? AND encounter=?";
  $fres=sqlStatementNoLog($sql, $binds);
	if($fres) { 
		$frow=sqlFetchArray($fres);
		if($frow{'form_id'} == $thisId) {
			$_ret=$frow{'content'};
		}
	}
	return $_ret;
}

function FormInRepository($thisPid,$thisEnc,$thisId,$thisName)
{
	$_ret = false;
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($thisEnc) && !empty($thisId) && !empty($thisName)) {
		$binds=array($thisPid, $thisId, $thisName, $thisEnc);
  	$sql="SELECT id, pid FROM form_repository WHERE pid=? AND form_id=? ".
			"AND form_name=? AND encounter=?";
  	$fres=sqlStatementNoLog($sql, $binds);
		if($fres) { 
			$frow=sqlFetchArray($fres);
			if($frow{'id'} != '' && $frow{'id'} != 0) $_ret = true;
		}
	}
	return $_ret;
}

function AddFormToRepository($thisPid,$thisEnc,$thisId,$thisName,$thisContent)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($thisEnc) && !empty($thisId) && !empty($thisName)) {
		$binds=array($thisPid, $thisId, $thisName, $thisEnc, $thisContent);
  	$sql="INSERT INTO form_repository (pid, form_id, form_name, encounter, ".
			"content) VALUES (?, ?, ?, ?, ?)";
  	$test=sqlInsert($sql, $binds);
	}
}

function DeleteFromRepository($thisPid,$thisEnc,$thisId,$thisName)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!empty($thisEnc) && !empty($thisId) && !empty($thisName)) {
		$binds=array($thisPid, $thisId, $thisName, $thisEnc);
  	$sql="DELETE FROM form_repository WHERE pid=? AND form_id=? AND ".
				"form_name=? AND encounter=?";
  	sqlStatement($sql, $binds);
	}
}

function AddPP($thisPid,$dt='',$weeks='',$len='',$lb='',$oz='',$sex='',$delivery='',$anes='',$loc='',$pre='',$com='',$doc='',$src=1)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if($dt == '' && $weeks == '' && $len == '' && $lb == '' && $oz == '' &&
			$sex == '' && $delivery == '' && $anes == '' && $loc == '' &&
			$pre == '' && $com == '' && $doc == '') { return false; }
  $sql= "INSERT INTO form_whc_pp (pid, groupname, user, authorized, ".
     	"activity, date, pp_date_of_pregnancy, pp_ga_weeks, ".
			"pp_labor_length, pp_weight_lb, pp_weight_oz, pp_sex, pp_delivery, ".
			"pp_anes, pp_place, pp_preterm, pp_comment, pp_doc, pp_source) VALUES ".
			"(?, ?, ?, ?, '1', NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	$binds=array($thisPid, $_SESSION['authProvider'], $_SESSION['authUser'],
			$_SESSION['userauthorized'], $dt, $weeks, $len, $lb, $oz,
			$sex, $delivery, $anes, $loc, $pre, $com, $doc, $src);
  $ret=sqlInsert($sql, $binds);
	return $ret;
}

function UpdatePP($thisPid,$ppid=0,$dt='',$weeks='',$len='',$lb='',$oz='',$sex='',$delivery='',$anes='',$loc='',$pre='',$com='',$doc='',$src=1)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!$ppid) { return false; }
   	// Update an existing row
  $sql= "UPDATE form_whc_pp SET groupname=?, user=?, authorized=?, ".
   	"activity=1, date = NOW(), pp_date_of_pregnancy=?, pp_ga_weeks=?, ".
   	"pp_labor_length=?, pp_weight_lb=?, pp_weight_oz=?, pp_sex=?, ".
		"pp_delivery=?, pp_anes=?, pp_place=?, pp_preterm=?, pp_comment=?, ".
   	"pp_doc=?, pp_source=?  WHERE id=?";
	$binds=array($_SESSION['authProvider'], $_SESSION['authUser'],
		$_SESSION['userauthorized'], $dt, $weeks, $len, $lb, $oz,
		$sex, $delivery, $anes, $loc, $pre, $com, $doc, $src, $ppid);
  sqlInsert($sql, $binds);
}

function AddOrUpdatePP($thisPid,$ppid=0,$dt='',$weeks='',$len='',$lb='',$oz='',$sex='',$delivery='',$anes='',$loc='',$pre='',$com='',$doc='', $src=1)
{
  if(!VerifyPatientID($thisPid)) { return false; }
	if(!$ppid && empty($dt) && empty($weeks) && empty($len) && empty($lb) &&
			empty($oz) && empty($sex) && empty($delivery) && empty($anes) &&
			empty($loc) && empty($pre) && empty($com) && empty($doc)) { return true; }
  if($ppid) {
   	// Update an existing row
   	$sql= "UPDATE form_whc_pp SET groupname=?, user=?, authorized=?, ".
    	"activity=?,  pp_date_of_pregnancy=?, pp_ga_weeks=?, ".
     	"pp_labor_length=?, pp_weight_lb=?, pp_weight_oz=?, pp_sex=?, ".
			"pp_delivery=?, pp_anes=?, pp_place=?, pp_preterm=?, pp_comment=?, ".
			"pp_doc=?, pp_source=?, date = NOW() WHERE id=?";
   	$binds = array($_SESSION["authProvider"], $_SESSION["authUser"],
    		$_SESSION['userauthorized'], 1, $dt, $weeks, $len, $lb, $oz, $sex,
				$delivery, $anes, $loc, $pre, $com, $doc, $src, $ppid);
   	// echo "SQL Insert: ".$sql."<br />\n";
   	sqlInsert($sql, $binds);
  } else {
   	// Add a new row 
   	// Get the highest existing order number
   	$pp_order=getNextOrder($thisPid);
   	// echo "Next Order: ".$pp_order."<br />\n";
   	$sql= "INSERT INTO form_whc_pp (pid, groupname, user, authorized, ".
       	"activity, date, pp_date_of_pregnancy, pp_ga_weeks, ".
				"pp_labor_length, pp_weight_lb, pp_weight_oz, pp_sex, pp_delivery, ".
				"pp_anes, pp_place, pp_preterm, pp_comment, pp_order, pp_doc, ".
				"pp_source) VALUES ".
				"( ?, ?, ?, ?, '1', NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?. ?, ?)";
		$binds = array($thisPid, $_SESSION['authProvider'], $_SESSION['authUser'],
				$_SESSION['userauthorized'], $dt, $weeks, $len, $lb, $oz, $sex,
				$delivery, $anes, $loc, $pre, $com, $pp_order, $doc, $src);
   	// echo "SQL Insert: ".$sql."<br />\n";

   	sqlInsert($sql, $binds);
  }
}

function DeletePP($thisPid,$item='',$links=0)
{
  if(!VerifyPatientID($thisPid)) { return false; }
 	sqlStatement("DELETE FROM form_whc_pp WHERE pid=? AND id=?",
		array($thisPid, $item));
	if($links) {
		DeleteAllListEntries($thisPid, $item, 'past_pregnancy');
	}
}

function SearchMultiArray($needle, $haystack) {
	foreach($haystack as $key => $value) {
		$this_key = $key;
		if($needle === $value || 
				(is_array($value) && SearchMultiArray($needle, $value) !== false)) {
			return $this_key;
		}
	}
	return false;
}

function FacilitySelect($thisField, $allow_empty=false, $empty_title='', $allow_all=false) {
  $rlist= sqlStatementNoLog("SELECT id, name FROM facility WHERE 1 ORDER BY name");
	if($allow_all) {
  	echo "<option value='~ALL~'";
  	if(!$thisField == '~ALL~') echo " selected='selected'";
  	echo ">-- All Facilities --</option>";
	}
	if($allow_empty) {
  	echo "<option value=''";
  	if(!$thisField) echo " selected='selected'";
  	echo ">$empty_title&nbsp;</option>";
	}
  while ($rrow= sqlFetchArray($rlist)) {
    echo "<option value='" . $rrow['id'] . "'";
    if($thisField == $rrow['id']) echo " selected='selected'";
    echo ">" . $rrow['name'];
    echo "</option>";
  }
}

function GetDiagDescription($codes) {
	$code_types = array();
	$default_search_type = '';
	$ctres = sqlStatementNoLog("SELECT * FROM code_types WHERE ct_active=1 ORDER BY ct_seq, ct_key");
	while ($ctrow = sqlFetchArray($ctres)) {
  	$code_types[$ctrow['ct_key']] = array(
    	'active' => $ctrow['ct_active'  ],
    	'id'   => $ctrow['ct_id'  ],
    	'fee'  => $ctrow['ct_fee' ],
    	'mod'  => $ctrow['ct_mod' ],
    	'just' => $ctrow['ct_just'],
    	'rel'  => $ctrow['ct_rel' ],
    	'nofs' => $ctrow['ct_nofs'],
    	'diag' => $ctrow['ct_diag'],
    	'mask' => $ctrow['ct_mask'],
    	'label'=> ( (empty($ctrow['ct_label'])) ? $ctrow['ct_key'] : $ctrow['ct_label'] ),
    	'external'=> $ctrow['ct_external'],
    	'claim' => $ctrow['ct_claim'],
    	'proc' => $ctrow['ct_proc'],
  	);
  	if ($default_search_type === '') $default_search_type = $ctrow['ct_key'];
	}

	/**
 	* This array stores the external table options. 
 	* 'external' attribute  for explanation of the option listings.
 	* @var array
 	*/
	$cd_external_options = array(
  	'0' => xl('No'),
  	'4' => xl('ICD9 Diagnosis'),
  	'5' => xl('ICD9 Procedure/Service'),
  	'1' => xl('ICD10 Diagnosis'),
  	'6' => xl('ICD10 Procedure/Service'),
  	'2' => xl('SNOMED (RF1) Diagnosis'),
  	'3' => xl('SNOMED (RF2) Diagnosis'),
	);

  $code_text = '';
  if (!empty($codes)) {
    $relcodes = explode(';', $codes);
    foreach ($relcodes as $codestring) {
      if ($codestring === '') continue;
      list($codetype, $code) = explode(':', $codestring);
      if ( !($code_types[$codetype]['external']) ) { // Collect from default codes table
        $wheretype = "";
        $sqlArray = array();
        if (empty($code)) {
          $code = $codetype;
        } else {
          $wheretype = "code_type = ? AND ";
          array_push($sqlArray,$code_types[$codetype]['id']);
        }
        $sql = "SELECT code_text FROM codes WHERE " .
          "$wheretype code = ? ORDER BY id LIMIT 1";
        array_push($sqlArray,$code);
        $crow = sqlQuery($sql,$sqlArray);
        if (!empty($crow['code_text'])) {
          if ($code_text) $code_text .= '; ';
          $code_text .= $crow['code_text'];
        }
      }
      else if ($code_types[$codetype]['external'] == 1) { // Collect from ICD10 Diagnosis codeset tables
        // Ensure the icd10_dx_order_code sql table exists
        $check_table = sqlQuery("SHOW TABLES LIKE 'icd10_dx_order_code'");
        if ( !(empty($check_table)) ) {
          if ( !(empty($code)) ) {
            // Will grab from previous inactive revisions if unable to find in current revision
            $sql = "SELECT `long_desc` FROM `icd10_dx_order_code` " .
                   "WHERE `formatted_dx_code` = ? ORDER BY `revision` DESC LIMIT 1";
            $crow = sqlQuery($sql, array($code) );
            if (!empty($crow['long_desc'])) {
              if ($code_text) $code_text .= '; ';
              $code_text .= $crow['long_desc'];
            }
          }
        }
      }
      else if ($code_types[$codetype]['external'] == 2) { // Collect from SNOMED (RF1) Diagnosis codeset tables
        // Ensure the sct_concepts sql table exists
        $check_table = sqlQuery("SHOW TABLES LIKE 'sct_concepts'");
        if ( !(empty($check_table)) ) {
          if ( !(empty($code)) ) {
            $sql = "SELECT `FullySpecifiedName` FROM `sct_concepts` " .
                   "WHERE `ConceptId` = ? AND `ConceptStatus` = 0 LIMIT 1";
            $crow = sqlQuery($sql, array($code) );
            if (!empty($crow['FullySpecifiedName'])) {
              if ($code_text) $code_text .= '; ';
              $code_text .= $crow['FullySpecifiedName'];
            }
          }
        }
      }
      else if ($code_types[$codetype]['external'] == 3) { // Collect from SNOMED (RF2) Diagnosis codeset tables
        //placeholder
      }
      else if ($code_types[$codetype]['external'] == 4) { // Collect from ICD9 Diagnosis codeset tables
        // Ensure the icd9_dx_code sql table exists
        $check_table = sqlQuery("SHOW TABLES LIKE 'icd9_dx_code'");
        if ( !(empty($check_table)) ) {
          if ( !(empty($code)) ) {
            // Will grab from previous inactive revisions if unable to find in current revision
            $sql = "SELECT `long_desc` FROM `icd9_dx_code` " .
                   "WHERE `formatted_dx_code` = ? ORDER BY `revision` DESC LIMIT 1";
            $crow = sqlQuery($sql, array($code) );
            if (!empty($crow['long_desc'])) {
              if ($code_text) $code_text .= '; ';
              $code_text .= $crow['long_desc'];
            }
          }
        }
      }
      else if ($code_types[$codetype]['external'] == 5) { // Collect from ICD9 Procedure/Service codeset tables
        // Ensure the icd9_dx_code sql table exists
        $check_table = sqlQuery("SHOW TABLES LIKE 'icd9_sg_code'");
        if ( !(empty($check_table)) ) {
          if ( !(empty($code)) ) {
            // Will grab from previous inactive revisions if unable to find in current revision
            $sql = "SELECT `long_desc` FROM `icd9_sg_code` " .
                   "WHERE `formatted_sg_code` = ? ORDER BY `revision` DESC LIMIT 1";
            $crow = sqlQuery($sql, array($code) );
            if (!empty($crow['long_desc'])) {
              if ($code_text) $code_text .= '; ';
              $code_text .= $crow['long_desc'];
            }
          }
        }
      }
      else if ($code_types[$codetype]['external'] == 6) { // Collect from ICD10 PRocedure/Service codeset tables
        // Ensure the icd10_dx_order_code sql table exists
        $check_table = sqlQuery("SHOW TABLES LIKE 'icd10_pcs_order_code'");
        if ( !(empty($check_table)) ) {
          if ( !(empty($code)) ) {
            // Will grab from previous inactive revisions if unable to find in current revision
            $sql = "SELECT `long_desc` FROM `icd10_pcs_order_code` " .
                   "WHERE `pcs_code` = ? ORDER BY `revision` DESC LIMIT 1";
            $crow = sqlQuery($sql, array($code) );
            if (!empty($crow['long_desc'])) {
              if ($code_text) $code_text .= '; ';
              $code_text .= $crow['long_desc'];
            }
          }
        }
      }

      else {
        //using an external code that is not yet supported, so skip. 
      }
    }
  }
  return $code_text;
}

function PrintFormHeader($psr, $title, $include_phone=false, $include_email=false, $include_web=false) {
	echo "<html>\n";
	echo $title,"\n";
	echo "<head>\n";
	echo "<link rel='stylesheet' href='../../../library/wmt/wmtprint.bkk.css' type='text/css'>\n";
	echo "</head>\n";

	echo "<body style='background: transparent'>\n";
	echo "<table width='98%'  border='0' cellspacing='0' cellpadding='0'>\n";
	echo "	<tr>\n";
	echo "		<td class='bkkPrnHuge'>$psr->facility</td>\n";
	echo "	</tr>\n";
	echo "  <tr>\n";
	echo "    <td class='bkkPrnChapter'>$psr->addr</td>\n";
	echo "  </tr>\n";
	echo "  <tr>\n";
	echo "    <td class='bkkPrnChapter'>$psr->csz</td>\n";
	echo "  </tr>\n";
	if($include_phone) {
		echo "  <tr>\n";
		echo "    <td class='bkkPrnChapter'>$psr->phone</td>\n";
		echo "  </tr>\n";
	}
	if($include_email) {
		echo "  <tr>\n";
		echo "    <td class='bkkPrnChapter'>$psr->email</td>\n";
		echo "  </tr>\n";
	}
	if($include_web) {
		echo "  <tr>\n";
		echo "    <td class='bkkPrnChapter'>$psr->website</td>\n";
		echo "  </tr>\n";
	}
	echo "</table>\n";
	echo "<br/>\n";
	echo "</body>\n";
	echo "</html>\n";
}

function LooseDateCheck($thisDate) {
	if($thisDate === '000-00-00') return false;
	if($thisDate == '') return false;
	if(substr($thisDate,4,1) != '-') return false;
	return true;
}

function getAppointments($thisPid, $dt='current') {
  if(!VerifyPatientID($thisPid)) { return false; }
	$query = "SELECT e.pc_eid, e.pc_aid, e.pc_title, e.pc_eventDate, ".
	  "e.pc_startTime, e.pc_hometext, u.fname, u.lname, u.mname, c.pc_catname ".
	  "FROM openemr_postcalendar_events AS e, users AS u, ".
	  "openemr_postcalendar_categories AS c WHERE ".
	  "e.pc_pid = ? AND e.pc_eventDate >= ";
	$query .= ($dt == 'current') ? 'CURRENT_DATE ' : '? ';
	$query .= "AND u.id = e.pc_aid AND e.pc_catid = c.pc_catid " .
	  "ORDER BY e.pc_eventDate, e.pc_startTime";
	// echo $query,"<br>\n";
	$binds = array($thisPid);
	if($dt == 'current') { $binds[] = $dt; }
	$res = sqlStatementNoLog($query, $binds);
	$all = array();
	$iter=0;
  while($row = sqlFetchArray($res)) {
		$all[$iter] = $row;
		$iter++;
	}
  return $all;
}

function generateChapter($title='', $bar_id='', $toggle='block', $class='wmtCollapseBar', $collapsible=true, $bottom_bar=false) {
	$display_field = 'tmp_'.$bar_id.'_disp_mode';
	echo "<div class='$class' id='".$bar_id;
	echo ($bottom_bar == 2) ? "B" : "";
	echo "Bar' style='border-";
	echo ($bottom_bar == 2) ? 'top: ' : 'bottom: ';
	echo ($toggle == 'block')?'solid 1px black':'none'; 
	echo ";' onclick='togglePanel(\"".$bar_id."Box\",\"".$bar_id."ImageL\",\"".$bar_id."ImageR\",\"".$bar_id."Bar\",\"\",\"$display_field\"";
	if($bottom_bar) {
		echo ",\"".$bar_id."ImageBL\",\"".$bar_id."ImageBR\",\"".$bar_id."BBar\"";
	}
	echo ")'>\n";
	echo "	<table width='100%' border='0' cellspacing='0' cellpadding='0'>\n";
	echo "		<tr>\n";
	$img_source = '../../../library/wmt/fill-270.png';
	$alt = 'Maximize';
	if($toggle == 'block') {
		$img_source = '../../../library/wmt/fill-090.png';
		$alt = 'Minimize';
	}
	echo "			<td class='wmtL'><img id='".$bar_id."Image";
	echo ($bottom_bar == 2) ? "B" : "";
	echo "L' src='$img_source' border='0' alt='$alt' title='$alt' /></td>\n";
 	echo "<td class='wmtChapter'>$title</td>\n";
	echo "<td class='wmtR'><img id='".$bar_id."Image";
	echo ($bottom_bar == 2) ? "B" : "";
	echo "R' src='$img_source' border='0' alt='$alt' title='$alt' /></td>\n";
	echo "		</tr>\n";
	echo "	</table>\n";
	echo "</div>\n";
}

?>
