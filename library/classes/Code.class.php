<?php
//require_once(dirname(__FILE__) . "/../../interface/globals.php");
//require_once("$srcdir/library/sql.inc");
require_once("$srcdir/options.inc.php");
 // $Id$
 // $Author$
 //
 // $Log$
 //

if (!defined('__CLASS_CODE_PHP__')) {
define('__CLASS_CODE_PHP__', true);

  class Code {
    public static function get_codes_from_type($type) {
      $codeset = Code::get_codeset($type);
      return Code::get_codes($codeset);
    }

    public static function get_codeset($type) {
      return $GLOBALS[$type];
    }

    public static function get_codes($codeset) {
      $sqlQuery = "SELECT codes.* FROM code_types INNER JOIN codes ON ct_id = code_type WHERE ct_key = ?";
      $bindArray = array(substr($codeset, 0, 15));
      $results = sqlQ($sqlQuery, $bindArray);
      $codes = array();
      while ($row = sqlFetchArray($results)) {
        $codes[] = $row;
      }
      return $codes;
    }

    public static function get_codes_from_short_text($code_name) {
      $sqlQuery = "SELECT codes.* FROM codes WHERE code_text_short = ?";
      $bindArray = array(trim($code_name));
      $results = sqlQ($sqlQuery, $bindArray);
      $codes = array();
      while ($row = sqlFetchArray($results)) {
        $codes[] = $row;
      }
      return $codes;
    }
  }

}

?>
