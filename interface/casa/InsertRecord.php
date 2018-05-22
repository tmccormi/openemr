<?php
/**
 * Created by PhpStorm.
 * User: kchapple
 * Date: 5/24/18
 * Time: 2:11 PM
 */

class InsertRecord
{
    public $table = null;
    public $field = null;

    public function __construct( $table, InsertField $field )
    {
        $this->table = $table;
        $this->field = $field;
    }
}