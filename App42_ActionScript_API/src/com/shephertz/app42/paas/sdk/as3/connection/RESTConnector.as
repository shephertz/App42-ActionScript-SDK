package com.shephertz.app42.paas.sdk.as3.connection
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.Config;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;
	
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
		
		
		/**
		 * @param signature
		 * @param url
		 * @param params
		 * @return
		 * @throws Exception
		 */
		
		public  function executeGet(signature : String , url : String ,
									params : Dictionary,serviceNew:App42Service ,call:App42CallBack) : void {
			
			var response:String ;
			var httpLoader:URLLoader = new URLLoader;
			var queryParams : Dictionary = com.shephertz.app42.paas.sdk.as3.util.Util.clone(params);
			var apiKey : String = queryParams["apiKey"]
			
			var timeStamp : String = queryParams["timeStamp"]
			delete queryParams["apiKey"]
			delete queryParams["timeStamp"]
			var queryString:String = "?";
			var data:Object = queryParams;
			// Get all Request parameter and set here
			for ( var keys:String in data ) {
				queryString += keys + "=" + data[keys] + "&";
			}
			
			var uri:String  = this.baseURL + url + queryString;
			var request:URLRequest = new URLRequest(uri);
			request.method = URLRequestMethod.GET;
			request.requestHeaders.push(new URLRequestHeader("Content-Type",Config.getInstance().getContentType()));
			request.requestHeaders.push(new URLRequestHeader("Accept",Config.getInstance().getAccept()));
			request.requestHeaders.push(new URLRequestHeader("apiKey",apiKey));
			request.requestHeaders.push(new URLRequestHeader("signature",signature));
			request.requestHeaders.push(new URLRequestHeader("timeStamp",timeStamp));
			httpLoader.addEventListener(Event.COMPLETE,completeHandler);
			httpLoader.addEventListener(IOErrorEvent.IO_ERROR,gotIOError);
			httpLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,statusEvent);
			httpLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,gotIOError);
			httpLoader.load(request);
			service  = serviceNew;
			callback = call;
			
		}
		private function completeHandler(e:Event):void
		{
			var json:Object  = com.adobe.serialization.json.JSON.decode(e.target.data);
			if(json["app42"] != undefined){
				trace("Success Called");
			 	service.onSuccess(e.target.data,callback,true);
			}
			else{
				
				trace("Exception Called" + e);
//				service.onException(e,callback);
			}
		}
		private function statusEvent(status:HTTPStatusEvent):void
		{
			if(status.status == 200)
				trace("Status if called" + status);
			else{
				trace("Status Else called " + status.status);
			}
		}
		private function gotIOError(event:Event):void
		{
			trace("[HTTP]Error : "+event.target.data);
		}
		
		public  function executePost(signature : String , url : String ,
									 params : Dictionary, bodyPayLoad:String,serviceNew:App42Service ,call:App42CallBack) : void {
			var response:String ;
			var httpLoader:URLLoader = new URLLoader;
			var queryParams : Dictionary = com.shephertz.app42.paas.sdk.as3.util.Util.clone(params);
			var apiKey : String = queryParams["apiKey"]
			
			var timeStamp : String = queryParams["timeStamp"]
			delete queryParams["apiKey"]
			delete queryParams["timeStamp"]
			var queryString:String = "?";
			var data:Object = queryParams;
			// Get all Request parameter and set here
			for ( var keys:String in data ) {
				queryString += keys + "=" + data[keys] + "&";
			}
			
			var uri:String  = this.baseURL + url + queryString;
			var request:URLRequest = new URLRequest(uri);
			request.method = URLRequestMethod.POST;
			request.data = bodyPayLoad;
			request.requestHeaders.push(new URLRequestHeader("Content-Type",Config.getInstance().getContentType()));
			request.requestHeaders.push(new URLRequestHeader("Accept",Config.getInstance().getAccept()));
			request.requestHeaders.push(new URLRequestHeader("apiKey",apiKey));
			request.requestHeaders.push(new URLRequestHeader("signature",signature));
			request.requestHeaders.push(new URLRequestHeader("timeStamp",timeStamp));
	
			httpLoader.addEventListener(Event.COMPLETE,completeHandler);
			httpLoader.addEventListener(IOErrorEvent.IO_ERROR,gotIOError);
			httpLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,statusEvent);
			httpLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,gotIOError);
			httpLoader.load(request);
			service  = serviceNew;
			callback = call;
		}
	}
}