<?php
/**
 * Created by PhpStorm.
 * User: kchapple
 * Date: 5/23/18
 * Time: 10:40 AM
 */

class PatientMatching
{
    protected static $log = "";

    public static function getLog()
    {
        return self::$log;
    }

    public static function fetchMatches( array $patient_data_row )
    {
        self::$log = "";
        $firstName = $patient_data_row['fname'];
        $lastName = $patient_data_row['lname'];
        $dob = $patient_data_row['DOB'];
        $phone_cell = $patient_data_row['phone_cell'];
        $phone_home = $patient_data_row['phone_home'];  

        $matches = array();
        $do_query = true;

        // In order to have a match, we have to have first name, last name, DOB and
        // at least one phone number
        if ( empty( $firstName ) ||
            empty( $lastName ) ||
            empty( $dob ) ) {
            $do_query = false;
        }

        if ( $do_query ) {
            // Use a case-insensitive search
            $query = "SELECT * 
              FROM patient_data 
              WHERE UPPER(fname) = ? AND UPPER(lname) = ? AND DOB = ?";

            $matches = [];
            $resultSet = sqlStatement( $query, [ strtoupper($firstName), strtoupper($lastName), $dob ] );
            while ( $row = sqlFetchArray( $resultSet ) ) {
                $matches[]= $row;
                self::$log = "Match found: pid={$row['pid']} $firstName $lastName ($dob)";
            }

            if ( count( $matches ) > 1 ) {

                $matches = [];
                $query = "SELECT * 
                  FROM patient_data 
                  WHERE UPPER(fname) = ? AND UPPER(lname) = ? AND DOB = ? AND ( phone_cell = ? OR phone_home = ? )";
                    $resultSet = sqlStatement( $query, [ strtoupper($firstName), strtoupper($lastName), $dob, $phone_cell, $phone_home ] );
                while ( $row = sqlFetchArray( $resultSet ) ) {
                    $matches[]= $row;
                    self::$log = "Double found: pid={$row['pid']} $firstName $lastName ($dob) $phone_cell $phone_home";
                }
            }
        }

        return $matches;
    }
}