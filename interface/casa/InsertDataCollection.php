<?php
/**
 * Created by PhpStorm.
 * User: kchapple
 * Date: 5/24/18
 * Time: 2:11 PM
 */
require_once __DIR__ . "/InsertRecord.php";
require_once __DIR__ . "/InsertField.php";

class InsertDataCollection
{
    public $insert_data = array();

    public function add( InsertData $insert_data )
    {
        $this->insert_data[]= $insert_data;
    }

    public function fetchByTable( $table )
    {
        $fetched = [];
        foreach( $this->insert_data as $insert_datum ) {
            if ( $insert_datum->table == $table ) {
                $fetched[$insert_datum->field_name] = $insert_datum->field_value;
            }
        }

        return $fetched;
    }

    public function hasField( $table, $field_name )
    {
        $found = false;
        foreach( $this->insert_data as $insert_datum ) {
            if ( $insert_datum->table == $table &&
                $insert_datum->field_name == $field_name ) {
                $found = true;
                break;
            }
        }

        return $found;
    }
}