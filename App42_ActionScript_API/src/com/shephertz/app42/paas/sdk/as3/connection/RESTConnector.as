/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */

package com.shephertz.app42.paas.sdk.as3.connection
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42BadParameterException;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	import com.shephertz.app42.paas.sdk.as3.App42LimitException;
	import com.shephertz.app42.paas.sdk.as3.App42Log;
	import com.shephertz.app42.paas.sdk.as3.App42NotFoundException;
	import com.shephertz.app42.paas.sdk.as3.App42SecurityException;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.Config;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.system.Security;
	import flash.utils.Dictionary;
	
	/**
	 * @author Himanshu Sharma
	 */
	
	public class RESTConnector
	{
		
		private var baseURL : String  = null;
		private var customCodeURL : String  = null;
		private var callback:App42CallBack;
		private var service:App42Service;
		
		private static var restCon: RESTConnector  = null;
		
		public function RESTConnector()
		{
			this.baseURL = Config.getInstance().getBaseURL();
			this.customCodeURL  = Config.getInstance().getCustomCodeURL();
		}
		
		/**
		 * @return
		 * @throws ConfigurationException
		 */
		public static function  getInstance() : RESTConnector {
			
			if (restCon == null)
				return new RESTConnector();
			return restCon;
			
		}
		
		
		public  function executeGet(signature : String , url : String ,
									params : Dictionary,serviceNew:App42Service ,call:App42CallBack) : void {
			
			var response:String ;
			
			var queryParams : Dictionary = com.shephertz.app42.paas.sdk.as3.util.Util.clone(params);
			queryParams["signature"] = signature;
			var apiKey : String = queryParams["apiKey"]
			var httpLoader:URLLoader = new URLLoader;
			var timeStamp : String = queryParams["timeStamp"]
			var queryString:String = "?";
			var data:Object = queryParams;
			// Get all Request parameter and set here
			var value:String;
			for ( var keys:String in data ) {
				value  = data[keys];
				queryString += keys + "=" + value + "&";
				
				App42Log.debug(" Setting value :" + keys + " : " + value);
			}
			App42Log.debug(" QueryString is " + queryString);
			var uri:String  = this.baseURL + url + queryString;
			App42Log.debug(" Requested URL is " + uri);
			var request:URLRequest = new URLRequest(uri);
			request.method = URLRequestMethod.GET;
			request.contentType  = Config.getInstance().getContentType();
			httpLoader.addEventListener(Event.COMPLETE,completeHandler);
			httpLoader.addEventListener(IOErrorEvent.IO_ERROR,app42Exception);
			httpLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,app42Exception);
			httpLoader.load(request);
			service  = serviceNew;
			callback = call;
			
		}
		
		public  function executePost(signature : String , url : String ,
									 params : Dictionary, bodyPayLoad:String,serviceNew:App42Service ,call:App42CallBack) : void {
			var response:String ;
			var queryParams : Dictionary = com.shephertz.app42.paas.sdk.as3.util.Util.clone(params);
			var apiKey : String = queryParams["apiKey"]
			var httpLoader:URLLoader = new URLLoader;
			var timeStamp : String = queryParams["timeStamp"]
			delete queryParams["apiKey"]
			delete queryParams["timeStamp"]
			var queryString:String = "?";
			var data:Object = queryParams;
			// Get all Request parameter and set here
			var value:String;
			for ( var keys:String in data ) {
				value  = data[keys];
				queryString += keys + "=" + value + "&";
				App42Log.debug("Setting value :" + keys + " : " + value);
			}
			App42Log.debug("QueryString is " + queryString);
			var uri:String  = this.baseURL + url + queryString;
			App42Log.debug("Requested URL is " + uri);
			flash.system.Security.loadPolicyFile("http://localhost:8082/App42_API_SERVER/crossdomain.xml");
			var request:URLRequest = new URLRequest(uri);
			request.method = URLRequestMethod.POST;
			request.data = bodyPayLoad;
			request.requestHeaders.push(new URLRequestHeader("Content-Type",Config.getInstance().getContentType()));
			request.requestHeaders.push(new URLRequestHeader("Accept",Config.getInstance().getAccept()));
			request.requestHeaders.push(new URLRequestHeader("apiKey",apiKey));
			request.requestHeaders.push(new URLRequestHeader("signature",signature));
			request.requestHeaders.push(new URLRequestHeader("timeStamp",timeStamp));
			httpLoader.load(request);
			httpLoader.addEventListener(Event.COMPLETE,completeHandler);
			httpLoader.addEventListener(IOErrorEvent.IO_ERROR,app42Exception);
			httpLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,app42Exception);
			service  = serviceNew;
			callback = call;
		}
		
		
		private function completeHandler(e:Event):void
		{
			service.onSuccess(e.target.data,callback,true);
		}
		
		private function app42Exception(event:Event):void
		{
			var app42Fault:Object = new Object;
			try {
				app42Fault = com.adobe.serialization.json.JSON.decode(event.target.data)["app42Fault"];
				var appErrorCode:int = app42Fault["appErrorCode"];
				var httpErrorCode:int = app42Fault["httpErrorCode"];
				var detailMessage:String =event.target.data;
				if(httpErrorCode == 400){
					service.onException(new App42BadParameterException(detailMessage,httpErrorCode,appErrorCode),callback);
				}
				else if(httpErrorCode == 401){
					service.onException(new App42SecurityException(detailMessage,httpErrorCode,appErrorCode),callback);
				}
				else if(httpErrorCode == 404){
					service.onException(new App42NotFoundException(detailMessage,httpErrorCode,appErrorCode),callback);
				}
				else if(httpErrorCode == 413){
					service.onException(new App42LimitException(detailMessage,httpErrorCode,appErrorCode),callback);
				}
				else if(httpErrorCode == 500){
					service.onException(new App42Exception(detailMessage,httpErrorCode,appErrorCode),callback);
				}
				else{
					service.onException(new App42Exception(detailMessage,httpErrorCode,appErrorCode),callback);
				}
			}
			catch(error:Error){
				trace("Parsing Exception : " + error.getStackTrace());
			}
		}
	}
}