<?php
/** **************************************************************************
 *	PRINTPAT.CLASS.PHP
 *	This file contains a print class for use with any print form
 *
 *  NOTES:
 *  1) __CONSTRUCT - always uses the ID to retrieve data 
 *  2) GET - uses alternate selectors to find and return associated object
 * 
 *  @version 1.0
 *  @copyright Williams Medical Technologies, Inc.
 *  @author Rich Genandt <rgenandt@gmail.com>
 * 
 *************************************************************************** */

/** 
 * Provides a partial representation of the patient data record This object
 * does NOT include all of the fields associated with the core patient data
 * record and should NOT be used for database updates.  It is intended only
 * for retrieval of partial patient information primarily for display 
 * purposes (reports for example).
 *
 */

class wmtPrintPat{
	public $id;
	public $pid;
	public $lname;
	public $fname;
	public $mi;
	public $addr;
	public $city;
	public $state;
	public $zip;
	public $full_name;
	public $last_first;
	public $csz;
	public $dob;
	public $age;
	public $sex;
	public $ssn;
	public $hphone;
	public $wphone;
	public $primary;
	public $primary_id;
	public $primary_group;
	public $secondary;
	public $secondary_id;
	public $secondary_group;
	public $referring;
	
	/**
	 * Constructor for the 'patient print' class which retrieves the requested 
	 * dashboard information from the database or errors.
	 * 
	 * @param int $id patient record id identifier
	 * @return object instance of patient print class
	 */
	public function __construct($id = false, $ageWhen='') {
		if(!$id) return false;

		$query = "SELECT * FROM patient_data WHERE id =?";
		$results = sqlStatementNoLog($query, array($id));
	
		if ($data = sqlFetchArray($results)) {
			$this->id = $data['id'];
			$this->pid = $data['pid'];
			$this->lname = $data['lname'];
			$this->fname = $data['fname'];
			$this->mi= $data['mname'];
			$this->addr = $data['street'];
			$this->sex= ucfirst($data['sex']);
			$this->city = $data['city'];
			$this->state = $data['state'];
			$this->zip = $data['postal_code'];
			$this->dob = $data['DOB'];
			$this->ssn = $data['ss'];
			$this->hphone = $data['phone_home'];
			$this->wphone = $data['phone_biz'];
			// preformat commonly used data elements	
			$this->full_name = $data['fname'].' '.$data['lname'];
			if($data['mname']) {
				$this->full_name = $data['fname'].' '.$data['mname'].' '.$data['lname'];
			}
			$this->last_first= $data['lname'].', '.$data['fname'].' '.$data['mname'];
			if($data['city'] || $data['state'] || $data['postal_code']) {
				$this->csz= $data['city'].', '.$data['state'].' '.$data['postal_code'];
			}
			if($data['DOB'] && $data['DOB'] != '0000-00-00') {
				$this->age = getPatientAge($data['DOB'], $ageWhen);
			}
			$query = "SELECT insurance_data.*, insurance_companies.* FROM ".
				"insurance_data LEFT JOIN insurance_companies ON ".
				"insurance_data.provider = insurance_companies.id ".
				"WHERE insurance_data.type=? AND insurance_data.pid=? ".
				"ORDER BY insurance_data.date DESC LIMIT 1";
			$results = sqlStatementNoLog($query, array('primary', $this->pid));
			if($data = sqlFetchArray($results)) {
				$this->primary = $data['name'];
				$this->primary_id = $data['policy_number'];
				$this->primary_group = $data['group_number'];
			}
			$results = sqlStatementNoLog($query, array('secondary', $this->pid));
			if($data = sqlFetchArray($results)) {
				$this->secondary = $data['name'];
				$this->secondary_id = $data['policy_number'];
				$this->secondary_group = $data['group_number'];
			}
		}
		else {
			throw new Exception('wmtPrintPat::_construct - no patient record with id ('.$this->id.').');
		}
		
		
	}	

	/**
	 * Retrieve a patient print object by PID value. Uses the base constructor 
   * for the 'patient print' class to create and return the object.
	 * 
	 * @static
	 * @param int $pid patient record pid
	 * @return object instance of patient print class
	 */
	public static function getPatient($pid, $ageWhen='') {
		if(!$pid) {
			throw new Exception('wmtPrintPat::getPidPatient - no patient identifier provided.');
		}
		
		$results = sqlStatementNoLog("SELECT id FROM patient_data WHERE pid =?",
			 array($pid));
		$data = sqlFetchArray($results);
		return new wmtPrintPat($data['id'], $ageWhen);
	}
	
}
                                            
?>
