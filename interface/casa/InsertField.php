<?php
/**
 * Created by PhpStorm.
 * User: kchapple
 * Date: 5/24/18
 * Time: 3:21 PM
 */

class InsertField
{
    public $field_name = null;
    public $field_value = null;

    public function __construct( $field_name, $field_value )
    {
        $this->field_name = $field_name;
        $this->field_value = $field_value;
    }
}