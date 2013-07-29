package com.shephertz.app42.paas.sdk.as3.game
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;

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
		 * @throws App42Exception
		 * 
		 */
		public function saveUserScore( gameName:String,  userName:String,
			 gameScore:int,callback:App42CallBack):void  {
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
				scoreJson.value = gameScore;
				scoreJson.userName = userName;
				scoresJson.score = scoreJson;
				gameJson.name = gameName;
				gameJson.scores = scoresJson;
				app42Json.game = gameJson;
				json.app42 = app42Json;
				
				var jsonStr:String  = com.adobe.serialization.json.JSON.encode(json);
				trace("body is " + jsonStr.toString());
				paramsDics["body"] = jsonStr.toString();
				var signature:String = Util.sign(this.secretKey,paramsDics);
				var resourceUrl:String = this.version + "/" + this.resource;
				RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonStr,this,callback);
		}
		/**
		 * Retrieves the highest game score for the specified user in async mode.
		 * @param gameName - Name of the game for which highest score has to be fetched
		 * @param userName - The user for which highest score has to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
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
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName + "/highest";;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the scores for a game for the specified name
		 * @param gameName - Name of the game for which score has to be fetched
		 * @param userName - The user for which score has to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
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
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the lowest game score for the specified user in async mode.
		 * @param gameName - Name of the game for which lowest score has to be fetched
		 * @param userName - The user for which lowest score has to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
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
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName + "/lowest";;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the average game score for the specified user in async mode.
		 * @param gameName - Name of the game for which average score has to be fetched
		 * @param userName - The user for which average score has to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
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
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/" + userName + "/average";;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
	   /**
		* Retrieves the Top Rankings for the specified game in async mode.
		* @param gameName - Name of the game for which ranks have to be fetched
		* @param callback - Callback object for success/exception result
		* @throws App42Exception
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
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName + "/ranking";
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the Top N Rankings for the specified game in async mode.
		 * @param gameName - Name of the game for which ranks have to be fetched
		 * @param max - Maximum number of records to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
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
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName  + "/ranking" + "/" + max;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * Retrieves the Top N Rankings for the specified game in async mode.
		 * @param gameName - Name of the game for which ranks have to be fetched
		 * @param max - Maximum number of records to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
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
			var resourceUrl:String = this.version + "/" + this.resource + "/" + gameName   + "/" + userName+ "/ranking";
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		
		/**
		 * This function returns the top ranking based on user score in async mode.
		 * @param gameName - Name of the game
		 * @param userList - List of the user for which ranking has to retrieve
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getTopRankingsByGroup(gameName:String, userList:Array,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["name"] = gameName; 
			trace("userList is " + userList);
			paramsDics["userList"] = userList; 
			trace("userList is " + userList);
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource  +  "/"
				+ gameName + "/group";
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
	}
}