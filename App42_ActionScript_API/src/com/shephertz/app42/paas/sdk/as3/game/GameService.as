package com.shephertz.app42.paas.sdk.as3.game
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;
	
	public class GameService extends App42Service
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
			
		}
		
		public function getGameByName(gameName:String, callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource + "/"+ gameName;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		
		
	 override public function onSuccess(response:String, requestCall:App42CallBack,isArray:Boolean):void
		{
		 	var object:Object;
			object = com.adobe.serialization.json.JSON.decode(response);
//			object = new GameResponseBuilder().buildResponse(response);
			trace("response from service is " + response);
			trace("object from service is " + object);
			requestCall.onSuccess(object);
			
		}
	 override public function onException(exception:App42Exception, requestCall:App42CallBack):void
		{
		 	requestCall.onException(exception);
		}
	}
}