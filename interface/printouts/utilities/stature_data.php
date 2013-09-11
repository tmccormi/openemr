<?php
require_once($include_root."/stats/calculations.php");
require_once($include_root."/stats/cdc_growth_stats.php");
function stature_info($pid,&$patient_info,$DOB,$sex)
{
    $sqlVitals = "SELECT height,weight,BMI,form_vitals.date,DATE_FORMAT(form_vitals.date,'%m-%d-%Y') as date_string FROM form_vitals,forms WHERE form_vitals.pid=? "
                ." AND forms.form_id=form_vitals.id AND forms.deleted=0"
                ." ORDER BY form_vitals.date desc LIMIT 1";
    $vitals_data = sqlQuery($sqlVitals,array($pid));
    if($vitals_data!==false)
    {
        $patient_info['height']=$vitals_data['height'];
        $pounds_int=floor($vitals_data['weight']);
        $ounces_int=floor(($vitals_data['weight']-$pounds_int)*16);
        $patient_info['weight']=$vitals_data['weight'];
        $patient_info['weight_lbs']=$pounds_int;
        $patient_info['weight_ozs']=$ounces_int;
        $patient_info['stature_date']=$vitals_data['date_string'];
        if($vitals_data['BMI']>0)
        {
            $patient_info['BMI']=$vitals_data['BMI'];
            $age_info=getPatientAgeYMD($DOB,$vitals_data['date']);
            $age_in_months=$age_info['age_in_months'];
            if($age_in_months>=23.5)
            {
                $patient_info['bmi_pct']=number_format(cdc_age_percentile($vitals_data['BMI'],$age_in_months,$sex,'bmi'),1);
            }
        }
    }
}
?>
