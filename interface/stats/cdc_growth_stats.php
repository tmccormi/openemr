<?php
define('COL_AGE_MOS','agemos');
define('COL_SEX','sex');
define('COL_HEIGHT','height');

function string_sex_number($sex)
{
    if($sex==='Male')
    {
        $sex=1;
    }
    if($sex==='Female')
    {
        $sex=2;
    }
    return $sex;
}

$GLOBALS['cdc_data_tables']=array(
  "bmi"=>"cdc_bmi_age",
  "weight"=>"cdc_weight_age",
   "height"=>"cdc_stature_age"
);

function cdc_age_percentile($x,$age,$sex,$stat)
{

    $sex=string_sex_number($sex);
    if(isset($GLOBALS['cdc_data_tables'][$stat]))
    {
        $table=$GLOBALS['cdc_data_tables'][$stat];
        
    }
    else
    {
        return "Unknown Stat";
    }
    $difference="(?-".COL_AGE_MOS.")";
    $delta="ABS".$difference;
    $parameters=array();
    $sql_get_lms="SELECT ".COL_AGE_MOS.",L,M,S,".$delta." as delta";        array_push($parameters,$age);
    $sql_get_lms.=" FROM ".$table;
    $sql_get_lms.=" WHERE IF(".COL_AGE_MOS."=0,?=0,-0.5<=".$difference." AND ".$difference. "<0.5)";  array_push($parameters,$age,$age,$age); // Only use 0 value if it is AT birth 
    $sql_get_lms.=" AND ".COL_SEX."=? ";array_push($parameters,$sex);
    $sql_get_lms.=" ORDER BY ".$delta." ASC LIMIT 1"; array_push($parameters,$age);

    $lms=sqlQuery($sql_get_lms,$parameters); 
    if($lms===false) // If we can't lookup the proper parameters to use, return null
    {
        return 0;
    }
//    echo $lms['L'].":".$lms['M'].":".$lms['S'];

    $z=x_to_z_lms($x,$lms['L'],$lms['M'],$lms['S']);   
    return 100*(cdf($z));
    
}


function cdc_weight_height($weight,$height,$sex)
{
    $sex=string_sex_number($sex);
    $table="cdc_weight_height";
    $difference="(?-".COL_HEIGHT.")";
    $delta="ABS".$difference;
    $parameters=array();
    $sql_get_lms="SELECT ".COL_HEIGHT.",L,M,S,".$delta." as delta";        array_push($parameters,$height);
    $sql_get_lms.=" FROM ".$table;
    $sql_get_lms.=" WHERE -0.5<=".$difference." AND ".$difference. "<0.5 ";  array_push($parameters,$height,$height); // Only use 0 value if it is AT birth 
    $sql_get_lms.=" AND ".COL_SEX."=? ";array_push($parameters,$sex);
    $sql_get_lms.=" ORDER BY ".$delta." ASC LIMIT 1"; array_push($parameters,$height);

    $lms=sqlQuery($sql_get_lms,$parameters); 
    if($lms===false) // If we can't lookup the proper parameters to use, return null
    {
        return 0;
    }
    
    $z=x_to_z_lms($weight,$lms['L'],$lms['M'],$lms['S']);   
    return 100*(cdf($z));
        
}
function bmi_pct_to_status($pct)
{
        if($pct<5)
        {
            return "Underweight";
        }
        else if($pct<85)
        {
            return "Healthy weight";
        }
        else if($pct<95)
        {
            return "Overweight";
        }
        else if($pct>=95)
        {
            return  "Obese";
        }
}
?>
