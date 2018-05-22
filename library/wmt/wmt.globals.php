<?php
/** **************************************************************************
 *	WMT.GLOBAL.PHP
 *
 *	Copyright (c)2017 - Medical Technology Services <MDTechSvcs.com>
 *
 *	This program is free software: you can redistribute it and/or modify it under the 
 *  terms of the GNU General Public License as published by the Free Software Foundation, 
 *  either version 3 of the License, or (at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful, but WITHOUT ANY
 *	WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 *  PARTICULAR PURPOSE. DISTRIBUTOR IS NOT LIABLE TO USER FOR ANY DAMAGES, INCLUDING 
 *  COMPENSATORY, SPECIAL, INCIDENTAL, EXEMPLARY, PUNITIVE, OR CONSEQUENTIAL DAMAGES, 
 *  CONNECTED WITH OR RESULTING FROM THIS AGREEMENT OR USE OF THIS SOFTWARE.
 *
 *	See the GNU General Public License <http://www.gnu.org/licenses/> for more details.
 *
 *  @package wmt
 *  @subpackage utilities
 *  @version 1.0.0
 *  @copyright Medical Technology Services
 *  @author Ron Criswell <ron.criswell@MDTechSvcs.com>
 *
 ******************************************************************************************** */

/**
 * All new functions are defined in the WMT namespace
 */
namespace wmt;

/**
 * Define constants used by the WMT applications;
 */
define('ACCESS',1);
define('CREATE',2);
define('UPDATE',3);
define('DELETE',4);
define('SUPER',9);

/**
 * Auto class loader function for all WMT applications. The class name passed to the
 * function must contain exactly two parts; a "prefix" such as "wmt" and a "name" which
 * must start with a capital letter. The "prefix" will be prepended to the "name" to 
 * create a file in the form of "prefixName.class.php". This class file will be loaded
 * from the "~/library/wmt/classes" directory.
 * 
 * @version 1.0.0
 * @since 2017-01-01
 * @author Ron Criswell <ron.criswell@MDTechSvcs.com>
 * 
 * @param 	String $class consisting of "prefix\name"
 * @throws 	Exception class file not found
 * 			Exception class not loadable
 */
if (!function_exists('wmt\ClassLoader')) {
	function ClassLoader($class) {
		$parts = explode('\\', $class); // break into components
		if (reset($parts) != 'wmt') return; // not a wmt class
		
		if (strpos(end($parts), 'Module') === false) { // loading a class
			
			// find the class file
			$class_file = $GLOBALS['srcdir']."/wmt-v3/classes/wmt". end($parts) .".class.php";
			if (!file_exists($class_file))
				$class_file = $GLOBALS['srcdir']."/wmt-v2/classes/wmt". end($parts) .".class.php";
			elseif (!file_exists($class_file))
				$class_file = $GLOBALS['srcdir']."/wmt/classes/wmt". end($parts) .".class.php";
			elseif (!file_exists($class_file))
				throw new \Exception("Class [$class] file not found in WMT class library");
				
			// load the class file				
			require_once($class_file);

			// verify the class exists
			if (!class_exists($class))
				throw new \Exception("Class [$class] could not be loaded");
			
		} else { // loading a module
			
			$file_name = str_replace('Module', '', end($parts));
			
			// find the module file
			$module_file = $GLOBALS['srcdir']."/wmt-v3/modules/wmt". end($parts) .".module.php";
			if (!file_exists($module_file))
				$module_file = $GLOBALS['srcdir']."/wmt-v2/modules/wmt". end($parts) .".module.php";
			elseif (!file_exists($module_file))
				$module_file = $GLOBALS['srcdir']."/wmt/modules/wmt". end($parts) .".module.php";
			elseif (!file_exists($module_file))
				throw new \Exception("Module [$class] file not found in WMT module library");
				
			// load the class file				
			require_once($module_file);

			// verify the class exists
			if (!class_exists($module))
				throw new \Exception("Module [$module] could not be loaded");
		}
	}

	// Make sure the class loader funtion is on the spl_autoload queue
	$splList = spl_autoload_functions();
	if (!$splList || !$splList['wmt\ClassLoader']) {
		spl_autoload_register('wmt\ClassLoader');
	}
};

/**
 * Auto class loader function for all WMT applications. The class name passed to the
 * function must contain exactly two parts; a "prefix" such as "wmt" and a "name" which
 * must start with a capital letter. The "prefix" will be prepended to the "name" to 
 * create a file in the form of "prefixName.class.php". This class file will be loaded
 * from the "~/library/wmt/classes" directory.
 * 
 * @version 1.0.0
 * @since 2017-01-01
 * @author Ron Criswell <ron.criswell@MDTechSvcs.com>
 * 
 * @param 	String $class consisting of "prefix\name"
 */
if (!function_exists('wmt\SecurityCheck')) {
	function SecurityCheck($realm) {
		$user_acl = false;
		
		if (!$_SESSION['authUser'] || $_SESSION['authUser'] == '')
			die ("FATAL ERROR: missing user credentials!!");
	
		// Security setup
		if (acl_check($realm, 'access')) $user_acl = ACCESS;
		if (acl_check($realm, 'enter')) $user_acl = CREATE;
		if (acl_check($realm, 'update')) $user_acl = UPDATE;
		if (acl_check($realm, 'delete')) $user_acl = DELETE;
		if (acl_check($realm, 'detail')) $user_acl = SUPER;
		$user_acl = SUPER; // ---- TESTING -----
		
		return $user_acl;
	}
}
?>