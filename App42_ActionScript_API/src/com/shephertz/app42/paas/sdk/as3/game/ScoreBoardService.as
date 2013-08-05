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
	 * ScoreBoard allows storing, retrieving, querying and ranking scores for users
	 * and Games across Game Session. The Game service allows Game, User, Score and
	 * ScoreBoard Management on the Cloud. The service allows Game Developer to
	 * create a Game and then do in Game Scoring using the Score service. It also
	 * allows to maintain a Scoreboard across game sessions using the ScoreBoard
	 * service. One can query for average or highest score for user for a Game and
	 * highest and average score across users for a Game. It also gives ranking of
	 * the user against other users for a particular game. The Reward and
	 * RewardPoints allows the Game Developer to assign rewards to a user and redeem
	 * the rewards. E.g. One can give Swords or Energy etc. The services Game,
	 * Score, ScoreBoard, Reward, RewardPoints can be used in Conjunction for
	 * complete Game Scoring and Reward Management.
	 * 
	 * @author Himanshu Sharma
	 * 
	 */
	public class ScoreBoardService extends App42Service
	{
		private var version : String  = "1.0";
		private var resource :String  = "game/scoreboard";
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
		
		public function ScoreBoardService(apiKey : String , secretKey : String) {
			this.apiKey = apiKey;
			this.secretKey = secretKey;
			
		}
		/**
		 * Saves the User score for a game in async mode.
		 * @param gameName - Name of the game for which score has to be saved
		 * @param userName - The user for which score has to be saved
		 * @param gameScore - The sore that has to be saved
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function saveUserScore( gameName:String,  userName:String,
			 gameScore:int,callback:App42CallBack):void  {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			if(userName == null || Util.trim(userName) == "" || gameName == null || Util.trim(gameName) == "" )
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(gameName,"GameName",callback);
				
				return;
			}
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var gameJson:Object = new Object;
			var scoresJson:Object = new Object;
			var scoreJson:Object = new Object;
			scoreJson.value = gameScore;
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
			var resourceUrl:String = this.version + "/" + this.resource;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		/**
		 * Retrieves the highest game score for the specified user in async mode.
		 * @param gameName - Name of the game for which highest score has to be fetched
		 * @param userName - The user for which highest score has to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getHighestScoreByUser(gameName:String, userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName + "/highest";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the scores for a game for the specified name
		 * @param gameName - Name of the game for which score has to be fetched
		 * @param userName - The user for which score has to be fetched
		 * @param callback - Callback object for success/exception result
		 */
		
		public function getScoresByUser(gameName:String, userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the lowest game score for the specified user in async mode.
		 * @param gameName - Name of the game for which lowest score has to be fetched
		 * @param userName - The user for which lowest score has to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getLowestScoreByUser(gameName:String, userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName + "/lowest";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the average game score for the specified user in async mode.
		 * @param gameName - Name of the game for which average score has to be fetched
		 * @param userName - The user for which average score has to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getAverageScoreByUser(gameName:String, userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName + "/average";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
	   /**
		* Retrieves the Top Rankings for the specified game in async mode.
		* @param gameName - Name of the game for which ranks have to be fetched
		* @param callback - Callback object for success/exception result
		* 
		*/
		public function getTopRankings(gameName:String, callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/ranking";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the Top N Rankings for the specified game in async mode.
		 * @param gameName - Name of the game for which ranks have to be fetched
		 * @param max - Maximum number of records to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getTopNRankings(gameName:String, max:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["max"] = max; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName  + "/ranking" + "/" + max;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the Top Rankings for the specified game in async mode.
		 * @param gameName - Name of the game for which ranks have to be fetched
		 * @param startDate  -Start date from which the ranking have to be fetched
		 * @param endDate  - End date up to which the ranking have to be fetched 
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getTopRankingsByDate(gameName:String, startDate:Date , endDate:Date ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			var strStartDate:String = Util.getUTCFormattedTimestampWithUserInputDate(startDate);
			var strEndDate:String = Util.getUTCFormattedTimestampWithUserInputDate(endDate);
			paramsDics["name"] = gameName; 
			paramsDics["startDate"] = strStartDate; 
			paramsDics["endDate"] = strEndDate; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/"
				+ gameName + "/ranking" + "/" + strStartDate + "/"
				+ strEndDate;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * This function returns the specified number of top rankers in a specific
		 * game in async mode.
		 * @param gameName - Name of the game
		 * @param max - Maximum number of records to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getTopNRankers(gameName:String, max:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["max"] = max; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"
				+ gameName + "/rankers" + "/" + max;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the User Ranking for the specified game in async mode.
		 * @param gameName- Name of the game for which ranks have to be fetched
		 * @param userName - Name of the user for which ranks have to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getUserRanking(gameName:String, userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName   + "/" + userName+ "/ranking";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * This function returns the top score attained by the specified user in the game.
		 * @param gameName - Name of the game
		 * @param userName - Name of the user for which score has to retrieve
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getLastScoreByUser(gameName:String, userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"
				+ gameName + "/" + userName + "/lastscore";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * This function returns the score attained by the specified user in the
		 * last game session.
		 * @param userName - Name of the for which score has to retrieve.
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getLastGameScore(userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/"
				+ userName + "/lastgame";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}

		
		/**
		 * This function returns the top ranking based on user score
		 * @param gameName - Name of the game.
		 * @param userList - List of the user for which ranking has to retrieve
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getTopRankingsByGroup(gameName:String,userList:Array,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			paramsDics["userList"] = "["+userList+"]"; 
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/"
				+ gameName + "/group";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		
		/**
		 * This function returns the specified number of top rankers in a specific
		 * game in async mode.
		 * @param gameName - Name of the game
		 * @param startDate  -Start date from which the ranking have to be fetched
		 * @param endDate  - End date up to which the ranking have to be fetched 
		 * @param max - Maximum number of records to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getTopNRankersByDate(gameName:String ,startDate:Date , endDate:Date, max:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			var strStartDate:String = Util.getUTCFormattedTimestampWithUserInputDate(startDate);
			var strEndDate:String = Util.getUTCFormattedTimestampWithUserInputDate(endDate);
			paramsDics["name"] = gameName; 
			paramsDics["max"] = max; 
			paramsDics["startDate"] = strStartDate; 
			paramsDics["endDate"] = strEndDate; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/"
				+ gameName + "/rankers" + "/" + strStartDate + "/"
				+ strEndDate + "/" + max;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		
		/**
		 * Edit the game score by score id of the user in async mode.
		 * @param gameName - Name of the game for which score has to be edit
		 * @param gameScore - The score that has to be edit
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function editScoreValueById( scoreId:String,  gameScore:int ,callback:App42CallBack):void  {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			if(scoreId == null || Util.trim(scoreId) == "" )
			{
				Util.throwExceptionIfNullOrBlank(scoreId,"ScoreId",callback);
				
				return;
			}
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var gameJson:Object = new Object;
			var scoresJson:Object = new Object;
			var scoreJson:Object = new Object;
			scoreJson.value = gameScore;
			scoreJson.scoreId = scoreId;
			scoresJson.score = scoreJson;
			gameJson.scores = scoresJson;
			app42Json.game = gameJson;
			json.app42 = app42Json;
			
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource
				+ "/editscore";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback);
			
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