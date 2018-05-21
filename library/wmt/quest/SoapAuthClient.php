<?php
/** **************************************************************************
 *	SoapAuthClient.PHP
 *
 *	Copyright (c)2014 - Williams Medical Technology, Inc.
 *
 *	This program is free software: you can redistribute it and/or modify it 
 *	under the terms of the GNU General Public License as published by the Free 
 *	Software Foundation, either version 3 of the License, or (at your option) 
 *	any later version.
 *
 *	This program is distributed in the hope that it will be useful, but WITHOUT 
 *	ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
 *	FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for 
 *	more details.
 *
 *	You should have received a copy of the GNU General Public License along with 
 *	this program.  If not, see <http://www.gnu.org/licenses/>.	This program is 
 *	free software; you can redistribute it and/or modify it under the terms of 
 *	the GNU Library General Public License as published by the Free Software 
 *	Foundation; either version 2 of the License, or (at your option) any 
 *	later version.
 *
 *  @package laboratory
 *  @subpackage quest
 *  @version 2.0
 *  @copyright Williams Medical Technologies, Inc.
 *  @author Ron Criswell <ron.criswell@MDTechSvcs.com>
 * 
 *************************************************************************** */
class SoapAuthClient extends SoapClient {
	/**
	 * Since the PHP SOAP package does not support basic authentication
	 * this class downloads the WDSL file using the cURL package and
	 * creates a local copy of the wsdl on the server.
	 * 
	 * Make sure you provide the following additional parameter in the
	 * $options Array: wsdl_local_copy => true
	 */

	function SoapAuthClient($wsdl, $options) {
//		echo "\n" . $wsdl;
		if (isset($options['wsdl_local_copy']) &&
				isset($options['login']) &&
				isset($options['password']) &&
				isset($options['wsdl_path'])) {
			 
			$file = "/" . $options['wsdl_local_copy'].'.xml'; 
			
			$path = $options['wsdl_path'];
			if (!file_exists($path)) {
				if (!mkdir($path,0700)) {
					throw new Exception('Unable to create directory for WSDL file ('.$path.')');
				}
			}

			$path .= "/wsdl"; // subdirectory
			if (!file_exists($path)) {
				if (!mkdir($path,0700)) {
					throw new Exception('Unable to create subdirectory for WSDL file ('.$path.')');
				}
			}
				
			if (($fp = fopen($path.$file, "w+")) == false) {
				throw new Exception('Could not create local WSDL file ('.$path.$file.')');
			}
				 
			$ch = curl_init();
			$credit = ($options['login'].':'.$options['password']);
			curl_setopt($ch, CURLOPT_URL, $wsdl);
			curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
			curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
			curl_setopt($ch, CURLOPT_USERPWD, $credit);
			curl_setopt($ch, CURLOPT_TIMEOUT, 15);
//			curl_setopt($ch, CURLOPT_FILE, $fp);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			
			// testing only!!
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
					
			if (($xml = curl_exec($ch)) === false) {
				curl_close($ch);
				fclose($fp);
				unlink($path.$file);
				 
				$ch = curl_init();
				$credit = ($options['login'].':'.$options['password']);
				curl_setopt($ch, CURLOPT_URL, $wsdl);
				curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
				curl_setopt($ch, CURLOPT_USERPWD, $credit);
				curl_setopt($ch, CURLOPT_TIMEOUT, 15);
				curl_setopt($ch, CURLOPT_FILE, $fp);
				curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
				
				if (($xml = curl_exec($ch)) === false) {
					curl_close($ch);
					fclose($fp);
					unlink($path.$file);
				}
				 
				throw new Exception(curl_error($ch));
			}
				 
			curl_close($ch);
			fwrite($fp, $xml);
			fclose($fp);
			$wsdl = "file:///".$path.$file;
		}
		 
		unset($options['wsdl_local_copy']);
		unset($options['wsdl_force_local_copy']);
		 
//		echo "\n" . $wsdl;
		parent::__construct($wsdl, $options);
	}
}
?>