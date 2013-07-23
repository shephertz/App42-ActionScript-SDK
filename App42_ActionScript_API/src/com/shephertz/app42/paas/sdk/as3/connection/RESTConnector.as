package com.shephertz.app42.paas.sdk.as3.connection
{
	import com.shephertz.app42.paas.sdk.as3.Config;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;

	public class RESTConnector
	{
		
		private var baseURL : String  = null;
		private var customCodeURL : String  = null;
		private var callback:Function;
		
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
									params : Dictionary, func:Function) : String {
			/*
			var response:String ;
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
			}*/
			
			var uri:String  = "http://control.appwarp.shephertz.com/newzonelocation?plan=default";
			var request:URLRequest = new URLRequest(uri);
			request.method = URLRequestMethod.GET;
//			request.requestHeaders.push(new URLRequestHeader("Content-Type",Config.getInstance().getContentType()));
//			request.requestHeaders.push(new URLRequestHeader("Accept",Config.getInstance().getAccept()));
//			request.requestHeaders.push(new URLRequestHeader("apiKey",apiKey));
//			request.requestHeaders.push(new URLRequestHeader("signature",signature));
//			request.requestHeaders.push(new URLRequestHeader("timeStamp",Util.getUTCFormattedTimestamp()));
//			trace("---------resource url is ---------- "+ uri);
//			trace("---------resource url is ---------- "+ apiKey);trace("---------resource url is ---------- "+ signature);
			var httpLoader:URLLoader = new URLLoader;
			httpLoader.addEventListener(Event.COMPLETE,completeHandler);
			httpLoader.addEventListener(IOErrorEvent.IO_ERROR,error);
			httpLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,statusEvent);
			httpLoader.load(request); 
			//callback = func;
			return "responsefromseerver";	
		}
		public  function executePost(signature : String , url : String ,
									params : Dictionary, bodyPayLoad:String,func:Function) : String {
			var response:String ;
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
			
			var uri:String  = this.baseURL +url+ queryString;
			var request:URLRequest = new URLRequest(uri);
			request.method = URLRequestMethod.GET;
			request.requestHeaders.push(new URLRequestHeader("Content-Type",Config.getInstance().getContentType()));
			request.requestHeaders.push(new URLRequestHeader("Accept",Config.getInstance().getAccept()));
			request.requestHeaders.push(new URLRequestHeader("apiKey",apiKey));
			request.requestHeaders.push(new URLRequestHeader("signature",signature));
			request.requestHeaders.push(new URLRequestHeader("timeStamp",Util.getUTCFormattedTimestamp()));
			trace("---------resource url is ---------- "+ uri);
			trace("---------resource url is ---------- "+ apiKey);trace("---------resource url is ---------- "+ signature);
			var httpLoader:URLLoader = new URLLoader;
			httpLoader.addEventListener(Event.COMPLETE,completeHandler);
			httpLoader.addEventListener(IOErrorEvent.IO_ERROR,error);
			httpLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,statusEvent);
			httpLoader.load(request); 
			callback = func;
			return "responsefromseerver";	
		}
		private function completeHandler(e:Event):void
		{
			trace("  -------------------------- trace ----------------------" );
			trace("[HTTP]Recieved : "+e.target.data);	
			if(e.target.data){
				callback(e.target.data);	
			}
		}
		private function statusEvent(status:HTTPStatusEvent):void
		{
			trace("I m Status Event");
			trace("Success : "+status.toString());	
			
		}
		private function error(e:IOErrorEvent):void
		{
			trace("I m error Event" + e.text);
			trace("Error : "+e.target.data);
		}
	}
}