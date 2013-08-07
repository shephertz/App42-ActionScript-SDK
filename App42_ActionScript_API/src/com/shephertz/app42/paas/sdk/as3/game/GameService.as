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
	 * The Game service allows Game, User, Score and ScoreBoard Management on the
	 * Cloud. The service allows Game Developer to create a Game and then do in Game
	 * Scoring using the Score service. It also allows to maintain a Score board
	 * across game sessions using the ScoreBoard service. One can query for average
	 * or highest score for user for a Game and highest and average score across
	 * users for a Game. It also gives ranking of the user against other users for a
	 * particular game. The Reward and RewardPoints allows the Game Developer to
	 * assign rewards to a user and redeem the rewards. E.g. One can give Swords or
	 * Energy etc. The services Game, Score, ScoreBoard, Reward, RewardPoints can be
	 * used in Conjunction for complete Game Scoring and Reward Management.
	 * 
	 * @author Himanshu Sharma
	 */
	
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
		 * @param description - Description of the game to be created
		 * @param callback - Callback object for success/exception result
		 * 
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
			App42Log.debug("Json String : " + jsonBody.toString());
			paramsDics["body"] = jsonBody.toString();
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback,false);
		}
		
		
		/**
		 * Retrieves the game by the specified name in async mode.
		 * @param gameName - Name of the game that has to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
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
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/"+ gameName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,false);
			
		}
		/**
		 * Fetches all games for the App in async mode.
		 * @param callback - Callback object for success/exception result
		 * 
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
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		
		/**
		 * Fetches the count of all games for the App in async mode.
		 * @param callback - Callback object for success/exception result
		 * 
		 * 
		 */
		public function getAllGamesCount(callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/count";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Fetches all games for the App by paging in async mode.
		 * @param max - Maximum number of records to be fetched
		 * @param offset - From where the records are to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 * 
		 */
		public function getAllGamesByPaging(max:int,offset:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["max"]=max;
			paramsDics["offset"]=offset;
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/paging"
				+ "/" + max + "/" + offset;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		
	 override public function onSuccess(response:String, requestCall:App42CallBack,isArray:Boolean):void
		{
		 	var object:Object;
			if(isArray){
				App42Log.debug("Array Response " + response);
				object = new GameResponseBuilder().buildArrayResponse(response);
			} 
			else {
				App42Log.debug("Response : " + response);
				object = new GameResponseBuilder().buildResponse(response);
			}
			requestCall.onSuccess(object);
			
		}
	 override public function onException(exception:App42Exception, requestCall:App42CallBack):void
		{
		 	requestCall.onException(exception);
		}
	}
}