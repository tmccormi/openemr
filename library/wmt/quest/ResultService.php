<?php
/** **************************************************************************
 *	ResultService.php
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
require_once 'SoapAuthClient.php';

if (!class_exists("AcknowledgedResult")) {
/**
 * AcknowledgedResult
 */
class AcknowledgedResult {
	/**
	 * @access public
	 * @var string
	 */
	public $ackCode;
	/**
	 * @access public
	 * @var string[]
	 */
	public $documentIds;
	/**
	 * @access public
	 * @var string
	 */
	public $rejectionReason;
	/**
	 * @access public
	 * @var string
	 */
	public $resultId;
}}

if (!class_exists("Acknowledgment")) {
/**
 * Acknowledgment
 */
class Acknowledgment {
	/**
	 * @access public
	 * @var AcknowledgedResult[]
	 */
	public $acknowledgedResults;
	/**
	 * @access public
	 * @var string
	 */
	public $requestId;
}}

if (!class_exists("ObservationResult")) {
/**
 * ObservationResult
 */
class ObservationResult {
	/**
	 * @access public
	 * @var base64Binary
	 */
	public $HL7Message;
	/**
	 * @access public
	 * @var ObservationResultDocument[]
	 */
	public $documents;
	/**
	 * @access public
	 * @var string
	 */
	public $observationResultType;
	/**
	 * @access public
	 * @var string
	 */
	public $resultId;
}}

if (!class_exists("ObservationResultDocument")) {
/**
 * ObservationResultDocument
 */
class ObservationResultDocument {
	/**
	 * @access public
	 * @var base64Binary
	 */
	public $documentData;
	/**
	 * @access public
	 * @var string
	 */
	public $documentId;
	/**
	 * @access public
	 * @var string
	 */
	public $fileMimeType;
	/**
	 * @access public
	 * @var string
	 */
	public $fileName;
}}

if (!class_exists("ObservationResultRequest")) {
/**
 * ObservationResultRequest
 */
class ObservationResultRequest {
	/**
	 * @access public
	 * @var string
	 */
	public $endDate;
	/**
	 * @access public
	 * @var integer
	 */
	public $maxMessages;
	/**
	 * @access public
	 * @var ProviderAccount[]
	 */
	public $providerAccounts;
	/**
	 * @access public
	 * @var boolean
	 */
	public $retrieveFinalsOnly;
	/**
	 * @access public
	 * @var string
	 */
	public $startDate;
}}

if (!class_exists("ObservationResultResponse")) {
/**
 * ObservationResultResponse
 */
class ObservationResultResponse {
	/**
	 * @access public
	 * @var boolean
	 */
	public $isMore;
	/**
	 * @access public
	 * @var ObservationResult[]
	 */
	public $observationResults;
	/**
	 * @access public
	 * @var string
	 */
	public $requestId;
}}

if (!class_exists("ProviderAccount")) {
/**
 * ProviderAccount
 */
class ProviderAccount {
	/**
	 * @access public
	 * @var string
	 */
	public $providerAccountName;
	/**
	 * @access public
	 * @var string
	 */
	public $providerName;
}}

if (!class_exists("ServiceException")) {
/**
 * ServiceException
 */
class ServiceException {
}}

if (!class_exists("SOAPException")) {
/**
 * SOAPException
 */
class SOAPException {
	/**
	 * @access public
	 * @var string
	 */
	public $message;
}}

if (!class_exists("ObservationResultService")) {
/**
 * ObservationResultService
 * @author WSDLInterpreter
 */
class ObservationResultService extends SoapAuthClient {
	/**
	 * Default class map for wsdl=>php
	 * @access private
	 * @var array
	 */
	private static $classmap = array(
		"AcknowledgedResult" => "AcknowledgedResult",
		"Acknowledgment" => "Acknowledgment",
		"ObservationResult" => "ObservationResult",
		"ObservationResultDocument" => "ObservationResultDocument",
		"ObservationResultRequest" => "ObservationResultRequest",
		"ObservationResultResponse" => "ObservationResultResponse",
		"ProviderAccount" => "ProviderAccount",
		"ServiceException" => "ServiceException",
		"SOAPException" => "SOAPException",
	);

	/**
	 * Constructor using wsdl location and options array
	 * @param string $wsdl WSDL location for this service
	 * @param array $options Options for the SoapClient
	 */
	public function __construct($wsdl, $options=array()) {
		foreach(self::$classmap as $wsdlClassName => $phpClassName) {
		    if(!isset($options['classmap'][$wsdlClassName])) {
		        $options['classmap'][$wsdlClassName] = $phpClassName;
		    }
		}
		parent::__construct($wsdl, $options);
	}

	/**
	 * Checks if an argument list matches against a valid argument type list
	 * @param array $arguments The argument list to check
	 * @param array $validParameters A list of valid argument types
	 * @return boolean true if arguments match against validParameters
	 * @throws Exception invalid function signature message
	 */
	public function _checkArguments($arguments, $validParameters) {
		if (!$arguments || count($arguments) == 0) return true;
		
		$variables = "";
		foreach ($arguments as $arg) {
		    $type = gettype($arg);
		    if ($type == "object") {
		        $type = get_class($arg);
		    }
		    $variables .= "(".$type.")";
		}
		if (!in_array($variables, $validParameters)) {
		    throw new Exception("Invalid parameter types: ".str_replace(")(", ", ", $variables));
		}
		return true;
	}

	/**
	 * Service Call: getResults
	 * Parameter options:
	 * (ObservationResultRequest) resultRequest
	 * @param mixed,... See function description for parameter options
	 * @return ObservationResultResponse
	 * @throws Exception invalid function signature message
	 */
	public function getResults($mixed = null) {
		$validParameters = array(
			"(ObservationResultRequest)",
		);
		$args = func_get_args();
		$this->_checkArguments($args, $validParameters);
		return $this->__soapCall("getResults", $args);
	}


	/**
	 * Service Call: getMoreResults
	 * Parameter options:
	 * (partnsstring) requestId
	 * @param mixed,... See function description for parameter options
	 * @return ObservationResultResponse
	 * @throws Exception invalid function signature message
	 */
	public function getMoreResults($mixed = null) {
		$validParameters = array(
			"(partnsstring)",
		);
		$args = func_get_args();
		$this->_checkArguments($args, $validParameters);
		return $this->__soapCall("getMoreResults", $args);
	}


	/**
	 * Service Call: acknowledgeResults
	 * Parameter options:
	 * (Acknowledgment) ack
	 * @param mixed,... See function description for parameter options
	 * @return 
	 * @throws Exception invalid function signature message
	 */
	public function acknowledgeResults($mixed = null) {
		$validParameters = array(
			"(Acknowledgment)",
		);
		$args = func_get_args();
		$this->_checkArguments($args, $validParameters);
		return $this->__soapCall("acknowledgeResults", $args);
	}


	/**
	 * Service Call: getProviderAccounts
	 * Parameter options:

	 * @param mixed,... See function description for parameter options
	 * @return ProviderAccount[]
	 * @throws Exception invalid function signature message
	 */
	public function getProviderAccounts($mixed = null) {
		$validParameters = array(
		);
		$args = func_get_args();
		$this->_checkArguments($args, $validParameters);
		return $this->__soapCall("getProviderAccounts", $args);
	}


}}

?>