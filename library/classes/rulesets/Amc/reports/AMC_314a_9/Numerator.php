<?php
// Copyright (C) 2014 Ensoftek
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//


class AMC_314a_9_Numerator implements AmcFilterIF
{
    public function getTitle()
    {
        return "AMC_314a_9 Numerator";
    }
    
    public function test( AmcPatient $patient, $beginDate, $endDate ) 
    {
		$beginDate = date("Y-m-d", strtotime($beginDate));
		$endDate = date("Y-m-d", strtotime($endDate));
		$check = sqlQuery("SELECT * FROM `form_encounter` WHERE `pid`=? AND (DATE(`date`)>=? AND DATE(`date`)<=?)", array($patient->id,$beginDate,$endDate) );
		if (!(empty($check))){
			return true;
		}else{
			return false;
		}
    }
}
?>
