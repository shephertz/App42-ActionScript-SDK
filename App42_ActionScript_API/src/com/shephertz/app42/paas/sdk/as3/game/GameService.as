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
		/**
		 * Creates a game on the cloud in async mode.
		 * @param gameName - Name of the game that has to be created
		 * @param gameDescription - Description of the game to be created
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 * 
		 */
		public function createGame(gameName:String, description:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var gameJson:Object = new Object;
			gameJson.name = gameName;
			gameJson.description = description;
			json.app42 = app42Json;
			app42Json.game = gameJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource;
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		
		/**
		 * Retrieves the game by the specified name in async mode.
		 * @param gameName - Name of the game that has to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getGameByName(gameName:String, callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource + "/"+ gameName;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		
		/**
		 * Fetches all games for the App
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 * 
		 */
		public function getAllGames(callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		
		
	 override public function onSuccess(response:String, requestCall:App42CallBack,isArray:Boolean):void
		{
		 	var object:Object;
			object = com.adobe.serialization.json.JSON.decode(response);
			trace("response is " + response);
//			object = new GameResponseBuilder().buildResponse(response);
			requestCall.onSuccess(object);
			
		}
	 override public function onException(exception:App42Exception, requestCall:App42CallBack):void
		{
		 	trace("I m here in Service" + exception);
		 	requestCall.onException(exception);
		}
	}
}