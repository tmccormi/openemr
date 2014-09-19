<?php
// Copyright (C) 2014 Ensoftek
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

class AMC_314g_1_2_20_Denominator implements AmcFilterIF
{
	public $patArr = array();
    public function getTitle()
    {
        return "AMC_314g_1_2_20 Denominator";
    }
    
    public function test( AmcPatient $patient, $beginDate, $endDate ) 
    {
		if(!in_array($patient->id, $this->patArr)){
			$this->patArr[] = $patient->id;
			$procSqlQry = "SELECT procedure_result.result FROM " .
						  "procedure_order, " .
						  "procedure_report, " .
						  "procedure_result " .
						  "WHERE " .
						  "procedure_order.patient_id = ? AND " .
						  "procedure_order.procedure_order_id = procedure_report.procedure_order_id AND " .
						  "procedure_report.procedure_report_id = procedure_result.procedure_report_id AND " .
						  "procedure_report.date_collected >= ? AND procedure_report.date_collected <= ?";
			$check = sqlQuery( $procSqlQry, array($patient->id, $beginDate, $endDate) );   
			if (!(empty($check))){
				return true;
			}else{
				return false;
			}
		}
		else
			return false;
    }
}
