package com.shephertz.app42.paas.sdk.as3.game
{
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;
	
	public class GameService 
	{
		private var version : String  = "1.0";
		private var resource :String  = "game";
		private var apiKey : String ;
		private var secretKey : String ;
		private var baseURL : String ;
		
		/**
		 * this is a constructor that takes
		 * 
		 * @param apiKey
		 * @param secretKey
		 * @param baseURL
		 * 
		 */
		
		public function GameService(apiKey : String , secretKey : String) {
			this.apiKey = apiKey;
			this.secretKey = secretKey;
			this.baseURL = "sjjdbkjsdbksb";
			
		}
		
		public function getGameByName(gameName:String, callback:Function) : String {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]=Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource + "/"+ gameName;
			response = RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,callback);
			trace("----response----------------" + response);
			return response;
		}
		
		public function createGame(gameName:String,description:String, callback:Function) : String {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]=Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
//			var 
			var jsonBody:String  =  "{\"app42\":{\"game\":{\"name\":"+gameName+",\description\":"+description+"}}}";
			trace("jsonBody is " + jsonBody);
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource + "/"+ gameName;
			response = RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams,jsonBody,callback);
			trace("----response----------------" + response);
			return response;	
		}
		
		private function onGetData(msg:String):void
		{
			trace("Result : "+msg);
		}
	}
}