<?php


function pf_map_allergies( $x_path )
{
    // These map to the <td> columns in the xml file
    $column_index_map = [
        0 => 'title',
        1 => '',
        2 => 'reaction',
        3 => 'severity_al'
    ];

    $res = pf_map_lists( 'allergy', $column_index_map, $x_path );

    return $res;
}

function pf_map_medications( $x_path )
{
    // These map to the <td> columns in the xml file
    $column_index_map = [
        0 => 'title',
        1 => '',
        2 => 'reaction',
        3 => 'severity_al',
        4 => 'begdate',
        5 => 'enddate',
        6 => 'comments'
    ];

    $res = pf_map_lists( 'medication', $column_index_map, $x_path );

    return $res;
}

function pf_map_lists( $type, $map, $x_path )
{
    $record = array();

    foreach( $x_path as $tr ) {
        $td_index = 0;
        $res = array();
        $res["type"] = $type;
        $res["date"] = date( 'Y-m-d h:i:s' );
        foreach ( $tr->childNodes as $td ) {
            $field_index = $map[$td_index];
            $res[$field_index] = $td->nodeValue;
            $td_index++;
        }

        $record[]= $res;
    }

    return $record;
}

function pf_fill_usertext1_with_PF()
{
    return "PF";
}

function pf_map_sex( $value )
{
    if ( $value == 'M' ) {
        return "Male";
    } else {
        return "Female";
    }
}

function pf_map_dob( $value )
{
    $date = DateTime::createFromFormat('Ymd', $value);
    $formatted = "";
    if ( $date ) {
        $formatted = date( 'Y-m-d',$date->getTimestamp() );
    }
    return $formatted;
}

function pf_map_phone( $value )
{
    $formatted = substr($value, 4); // skips "tel:" in string
    $formatted = str_replace( "(", "", $formatted );
    $formatted = str_replace( ")", "-", $formatted );
    return $formatted;
}