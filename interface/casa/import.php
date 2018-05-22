<?php
/**
 * Created by PhpStorm.
 * User: kchapple
 * Date: 5/22/18
 * Time: 10:04 AM
 */

require_once __DIR__."/PracticeFusionImporter.php";
require_once __DIR__."/../globals.php";

$import_directory = "/opt/conversion-data/PF";  //PRODUCTION
//$import_directory = "/Users/kchapple/Downloads/2018Apr-PF-ccdxml";
//$import_directory = "/home/tony/workspace/casa-de-salud/PracticeFusion/CCDTests";
$update_count = 0;
$create_count = 0;
$total_count = 0;
foreach ( glob( "$import_directory/*.xml" ) as $filename ) {

    print "$total_count: Processing: $filename... ";

    $log = PracticeFusionImporter::import( $filename );
    if ( $log['insert_type'] == "UPDATE" ) {
        $update_count++;
    } else if ( $log['insert_type'] == "CREATE" ) {
        $create_count++;
    }

    if ( $log['patient_matching'] ) {
        print $log[ 'patient_matching' ];
    }

    print "done (patient {$log['insert_type']})</br />";
    ob_flush();
    $total_count++;
}

print "$update_count Updated</br />";
print "$create_count Created</br />";
