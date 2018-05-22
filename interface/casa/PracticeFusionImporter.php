<?php
/**
 * Created by PhpStorm.
 * User: kchapple
 * Date: 5/22/18
 * Time: 10:04 AM
 */

require_once __DIR__."/PracticeFusionParser.php";
require_once __DIR__."/PatientMatching.php";
require_once __DIR__."/InsertDataCollection.php";
require_once __DIR__."/mapping_functions.php";
include_once(__DIR__."/../globals.php");
include_once("$srcdir/patient.inc");
require_once("$srcdir/classes/Document.class.php");

class PracticeFusionImporter
{
    public static function import( $filename )
    {
        $content = file_get_contents( $filename );
        $mapping = include __DIR__ . "/mapping.php";
        $mapping_meta = include __DIR__ . "/mapping_meta.php";

        // Parse the XML file and get the field/value mappings
        $field_value_mappings = PracticeFusionParser::parse( $content, $mapping );

        // if there's a mapping function (formatting, etc) associated with this
        // field in the mapping_meta array, try to call the function on the data
        foreach ( $mapping_meta as $table => $field_function ) {
            foreach ( $field_function as $field => $function ) {
                if ( function_exists( $function ) ) {
                    $field_value_mappings[ $table ][ $field ] = $function( $field_value_mappings[ $table ][ $field ] );
                }
            }
        }

        $pid = null;
        $insert_type = "";
        // If there is exactly one match, update the patient, otherwise create a new patient
        $matches = PatientMatching::fetchMatches( $field_value_mappings['patient_data'] );
        if ( count( $matches ) === 1 ) {
            $pid = self::updatePatient( $field_value_mappings, $matches[0] );
            $insert_type = "UPDATE";
        } else {
            $pid = self::createPatient( $field_value_mappings );
            $insert_type = "CREATE";
        }

        $log = [];
        $log['patient_matching']= PatientMatching::getLog();
        $log['insert_type'] = $insert_type;

        // Attach CCD (category 12) document
        $document = new Document();
        $document->createDocument( $pid, 12, basename( $filename ), 'text/xml', $content );

        return $log;
    }

    public static function updatePatient( $field_value_mappings, $existing_data )
    {
        $pid = $existing_data['pid'];
        foreach ( $existing_data as $key => $value ) {
            if ( empty( $field_value_mappings['patient_data'][$key] ) ) {
                $field_value_mappings['patient_data'][$key] = $value;
            }
        }

        return self::insertData( $field_value_mappings, $pid, false );
    }

    public static function createPatient( $field_value_mappings )
    {
        $prow = sqlQuery("SELECT IFNULL(MAX(pid)+1,1) AS pid FROM patient_data");
        $pid = $prow['pid'];
        $field_value_mappings['patient_data']['pubpid'] = $pid;
        return self::insertData( $field_value_mappings, $pid, true );
    }

    public static function aec( $data, $index = null )
    {
        $ret = "";
        if ( is_array( $data ) &&
            $index !== null ) {
            if ( isset( $data[ $index ] ) ) {
                $ret = add_escape_custom( $data[ $index ] );
            }
        } else {
            $ret = add_escape_custom( $data );
        }

        return $ret;
    }

    public static function insertData( $field_value_mappings, $pid, $create = false )
    {

        foreach ( $field_value_mappings as $table => $insert_data_row ) {

            if ( $table == 'patient_data' ) {
                updatePatientData( $pid, $insert_data_row, $create );
            } else if ( $table == 'allergies' || $table == 'medications' ) {
                foreach ( $insert_data_row as $list ) {
                    sqlInsert( "INSERT INTO lists(" .
                        "pid,date,type,title,begdate,enddate,diagnosis,activity,comments,reaction" .
                        ") VALUES (" .
                        "'" . self::aec( $pid ) . "'," .
                        "'" . self::aec( $list, 'date' ) . "'," .
                        "'" . self::aec( $list, 'type' ) . "'," .
                        "'" . self::aec( $list, 'title' ) . "'," .
                        "'" . self::aec( $list, 'begdate' ) . "'," .
                        "'" . self::aec( $list, 'enddate' ) . "'," .
                        "'" . self::aec( $list, 'diagnosis' ) . "'," .
                        "'" . self::aec( $list, 'activity' ) . "'," .
                        "'" . self::aec( $list, 'comments' ) . "'," .
                        "'" . self::aec( $list, 'reaction' ) . "')" );
                }
            }
        }

        return $pid;
    }
}

