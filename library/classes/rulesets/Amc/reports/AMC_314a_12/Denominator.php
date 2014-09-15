<?php
// Copyright (C) 2014 Ensoftek
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

class AMC_314a_12_Denominator implements AmcFilterIF
{
    public function getTitle()
    {
        return "AMC_314a_12 Denominator";
    }
    
    public function test( AmcPatient $patient, $beginDate, $endDate ) 
    {
		$beginDate = date("Y-m-d", strtotime($beginDate));
		$endDate = date("Y-m-d", strtotime($endDate));
		
		$prcFormsCheck = sqlStatement("SHOW TABLES LIKE 'procedure_order'");
		$procRows = sqlNumRows($prcFormsCheck);
		if($procRows > 0 ){
			$formQry =  " SELECT * FROM forms f ".
						" LEFT JOIN procedure_order po ON  f.encounter = po.encounter_id AND f.form_id = po.procedure_order_id ".
						" WHERE  f.formdir = 'procedure_order' AND f.deleted = 0 AND f.pid = ? AND (po.date_ordered BETWEEN ? AND ?) ";
			$check = sqlQuery( $formQry, array($patient->id,$beginDate,$endDate) );
			if (!(empty($check))){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
    }
}
