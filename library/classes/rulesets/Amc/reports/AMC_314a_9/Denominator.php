<?php
// Copyright (C) 2014 Ensoftek
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

class AMC_314a_9_Denominator implements AmcFilterIF
{
    public function getTitle()
    {
        return "AMC_314a_9 Denominator";
    }
    
    public function test( AmcPatient $patient, $beginDate, $endDate ) 
    {
		$beginDate = date("Y-m-d", strtotime($beginDate));
		$endDate = date("Y-m-d", strtotime($endDate));
		
		$check = sqlQuery("SELECT * FROM `openemr_postcalendar_events` WHERE pc_pid = ? AND  ( (pc_eventDate BETWEEN ?  AND ?) OR (pc_endDate BETWEEN  ?  AND ?) )", array($patient->id,$beginDate,$endDate,$beginDate,$endDate) );

		if (!(empty($check))){
			return true;
		}else{
			return false;
		}
    }
}
