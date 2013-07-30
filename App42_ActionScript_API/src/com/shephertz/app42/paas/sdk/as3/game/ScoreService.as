/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3.game
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	import com.shephertz.app42.paas.sdk.as3.App42Log;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;
	
	/**
	 * Allows game scoring. It has to be used for scoring for a particular Game
	 * Session. If scores have to be stored across Game sessions then the service
	 * ScoreBoard has to be used. It is especially useful for Multiplayer online or
	 * mobile games. The Game service allows Game, User, Score and ScoreBoard
	 * Management on the Cloud. The service allows Game Developer to create a Game
	 * and then do in Game Scoring using the Score service. It also allows to
	 * maintain a Scoreboard across game sessions using the ScoreBoard service. One
	 * can query for average or highest score for user for a Game and highest and
	 * average score across users for a Game. It also gives ranking of the user
	 * against other users for a particular game. The Reward and RewardPoints allows
	 * the Game Developer to assign rewards to a user and redeem the rewards. E.g.
	 * One can give Swords or Energy etc. The services Game, Score, ScoreBoard,
	 * Reward, RewardPoints can be used in Conjunction for complete Game Scoring and
	 * Reward Management.
	 */
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
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/add";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		/**
		 * Deducts the score from users account for a particular Game
		 * @param gameName - Name of the game for which scores have to be deducted
		 * @param userName - The user for whom scores have to be deducted
		 * @param score - The scores that have to be deducted
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function deductScore(gameName:String, userName:String, score:int ,callback:App42CallBack) : void {
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
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/deduct";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		override public function onSuccess(response:String, requestCall:App42CallBack,isArray:Boolean):void
		{
			App42Log.debug("Response From Server : " + response);
			var object:Object;
			object = com.adobe.serialization.json.JSON.decode(response);
			requestCall.onSuccess(object);
			
		}
		override public function onException(exception:App42Exception, requestCall:App42CallBack):void
		{
			requestCall.onException(exception);
		}
	}
}