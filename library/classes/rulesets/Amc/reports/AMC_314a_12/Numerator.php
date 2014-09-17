<?php
// Copyright (C) 2014 Ensoftek
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//


class AMC_314a_12_Numerator implements AmcFilterIF{
    public function getTitle(){
        return "AMC_314a_12 Numerator";
    }
    
    public function test( AmcPatient $patient, $beginDate, $endDate ){
		$docLabQry = "SELECT count(*) as cnt FROM documents d ".
					 "INNER JOIN categories_to_documents cd ON d.id = cd.document_id ".
					 "INNER JOIN categories dlc ON cd.category_id = dlc.id AND dlc.name = 'Lab Report' ".
					 "INNER JOIN patient_data pd ON pd.pid = d.foreign_id ".
					 "WHERE d.foreign_id = ? AND (d.date BETWEEN ? AND ?) ";
        $check = sqlQuery( $docLabQry, array($patient->id, $beginDate, $endDate) );   
		if ($check['cnt'] > 0){
			return true;
		}else{
			return false;
		}
    }
}
?>
