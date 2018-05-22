<?php
/**
 * Created by PhpStorm.
 * User: kchapple
 * Date: 5/22/18
 * Time: 10:02 AM
 */

class PracticeFusionParser
{
    public static $prefix = 'x';

    public static function parse( $content, $field_mapping )
    {
        $xml = new DOMDocument;
        $xml->preserveWhiteSpace = false;
        $xml->loadXML($content);
        $xpath = new DOMXpath($xml);
        $rootNamespace = $xml->lookupNamespaceUri($xml->namespaceURI);
        $xpath->registerNamespace(self::$prefix, $rootNamespace);
        $record = array();
        foreach ( $field_mapping as $section_name => $section_mapping ) {

            foreach ( $section_mapping as $xpath_path => $database_field ) {

                // Check to see if we have a function
                $function = false;
                if ( strpos( $database_field, "()" ) !== false ) {
                    $function = str_replace( "()", "", $database_field );
                    if ( !function_exists( $function ) ) {
                        $function = false;
                    }
                }
                $p = self::$prefix;
                $xpath_full = preg_replace( "/\/([a-zA-Z])/", "/$p:$1", $xpath_path );
                $xpath_full = str_replace( "title/$p:text()", "$p:title/text()", $xpath_full );
                $x_entries = $xpath->query( $xpath_full );
                if ( $x_entries == false ) {
                    error_log( "Error: No entry found for: $xpath_full" );
                }

                if ( $function ) {
                    // If we have a mapping function, call the function with our
                    $x_value = $function( $x_entries );
                    $record[ $section_name ] = $x_value;

                } else {
                    $x_value = '';
                    if ( $x_entries->length > 0 ) {
                        $x_value = $x_entries[ 0 ]->nodeValue;
                        if ( empty( $x_value ) ) {
                            error_log( "Warning: Empty value for: $xpath_full" );
                        }
                    }

                    $record[ $section_name ][ $database_field ] = $x_value;
                }

            }
        }

        return $record;
    }

}