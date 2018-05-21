<?php
/** **************************************************************************
 *	OrderService.PHP
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

if (!class_exists("BaseHubServiceResponse")) {
/**
 * BaseHubServiceResponse
 */
class BaseHubServiceResponse {
	/**
	 * @access public
	 * @var string
	 */
	public $responseCode;
	/**
	 * @access public
	 * @var string
	 */
	public $responseMsg;
	/**
	 * @access public
	 * @var ResponseProperty[]
	 */
	public $responseProperties;
	/**
	 * @access public
	 * @var string
	 */
	public $status;
}}

if (!class_exists("ResponseProperty")) {
/**
 * ResponseProperty
 */
class ResponseProperty {
	/**
	 * @access public
	 * @var string
	 */
	public $propertyName;
	/**
	 * @access public
	 * @var string
	 */
	public $propertyValue;
}}

if (!class_exists("OrderSupportDocument")) {
/**
 * OrderSupportDocument
 */
class OrderSupportDocument {
	/**
	 * @access public
	 * @var base64Binary
	 */
	public $documentData;
	/**
	 * @access public
	 * @var string
	 */
	public $documentType;
	/**
	 * @access public
	 * @var string
	 */
	public $requestStatus;
	/**
	 * @access public
	 * @var string
	 */
	public $responseMessage;
	/**
	 * @access public
	 * @var boolean
	 */
	public $success;
}}

if (!class_exists("Order")) {
/**
 * Order
 */
class Order {
	/**
	 * @access public
	 * @var base64Binary
	 */
	public $hl7Order;
}}

if (!class_exists("OrderResponse")) {
/**
 * OrderResponse
 */
class OrderResponse extends BaseHubServiceResponse {
	/**
	 * @access public
	 * @var string
	 */
	public $messageControlId;
	/**
	 * @access public
	 * @var string
	 */
	public $orderTransactionUid;
	/**
	 * @access public
	 * @var string[]
	 */
	public $validationErrors;
}}

if (!class_exists("OrderSupportServiceRequest")) {
/**
 * OrderSupportServiceRequest
 */
class OrderSupportServiceRequest extends Order {
	/**
	 * @access public
	 * @var string[]
	 */
	public $orderSupportRequests;
}}

if (!class_exists("OrderSupportServiceResponse")) {
/**
 * OrderSupportServiceResponse
 */
class OrderSupportServiceResponse extends OrderResponse {
	/**
	 * @access public
	 * @var OrderSupportDocument[]
	 */
	public $orderSupportDocuments;
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

if (!class_exists("OrderService")) {
/**
 * OrderService
 * @author WSDLInterpreter
 */
class OrderService extends SoapAuthClient {
	/**
	 * Default class map for wsdl=>php
	 * @access private
	 * @var array
	 */
	private static $classmap = array(
		"BaseHubServiceResponse" => "BaseHubServiceResponse",
		"ResponseProperty" => "ResponseProperty",
		"OrderSupportDocument" => "OrderSupportDocument",
		"Order" => "Order",
		"OrderResponse" => "OrderResponse",
		"OrderSupportServiceRequest" => "OrderSupportServiceRequest",
		"OrderSupportServiceResponse" => "OrderSupportServiceResponse",
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
	 * Service Call: submitOrder
	 * Parameter options:
	 * (Order) order
	 * @param mixed,... See function description for parameter options
	 * @return OrderResponse
	 * @throws Exception invalid function signature message
	 */
	public function submitOrder($mixed = null) {
		$validParameters = array(
			"(OrderSupportServiceRequest)",
		);
		$args = func_get_args();
		$this->_checkArguments($args, $validParameters);
		return $this->__soapCall("submitOrder", $args);
	}


	/**
	 * Service Call: validateOrder
	 * Parameter options:
	 * (Order) order
	 * @param mixed,... See function description for parameter options
	 * @return OrderResponse
	 * @throws Exception invalid function signature message
	 */
	public function validateOrder($mixed = null) {
		$validParameters = array(
			"(OrderSupportServiceRequest)",
		);
		$args = func_get_args();
		$this->_checkArguments($args, $validParameters);
		return $this->__soapCall("validateOrder", $args);
	}


	/**
	 * Service Call: getOrderDocuments
	 * Parameter options:
	 * (OrderSupportServiceRequest) request
	 * @param mixed,... See function description for parameter options
	 * @return OrderSupportServiceResponse
	 * @throws Exception invalid function signature message
	 */
	public function getOrderDocuments($mixed = null) {
		$validParameters = array(
			"(OrderSupportServiceRequest)",
		);
		$args = func_get_args();
		$this->_checkArguments($args, $validParameters);
		return $this->__soapCall("getOrderDocuments", $args);
	}


}}

?>