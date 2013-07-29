package com.shephertz.app42.paas.sdk.as3.game
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;

	public class ScoreService extends App42Service
	{
		private var version : String  = "1.0";
		private var resource :String  = "game/score";
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
		
		public function ScoreService(apiKey : String , secretKey : String) {
			this.apiKey = apiKey;
			this.secretKey = secretKey;
			
		}
		
		/**
		 * Adds game score for the specified user.
		 * @param gameName - Name of the game for which scores have to be added
		 * @param userName - The user for whom scores have to be added
		 * @param score - The scores that have to be added
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function addScore(gameName:String, userName:String, score:int ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var gameJson:Object = new Object;
			var scoresJson:Object = new Object;
			var scoreJson:Object = new Object;
			scoreJson.value = score;
			scoreJson.userName = userName;
			scoresJson.score = scoreJson;
			gameJson.name = gameName;
			gameJson.scores = scoresJson;
			app42Json.game = gameJson;
			json.app42 = app42Json;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource;
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
	}
}