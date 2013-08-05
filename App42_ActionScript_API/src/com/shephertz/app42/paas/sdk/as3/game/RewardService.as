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
	
	import mx.collections.ArrayList;
	
	/**
	 * Define a Reward e.g. Sword, Energy etc. Is needed for Reward Points
	 * 
	 * The Game service allows Game, User, Score and ScoreBoard Management on the
	 * Cloud. The service allows Game Developer to create a Game and then do in Game
	 * Scoring using the Score service. It also allows to maintain a Scoreboard
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
	public class RewardService extends App42Service
	{
		private var version : String  = "1.0";
		private var resource :String  = "game/reward";
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
		
		public function RewardService(apiKey : String , secretKey : String) {
			this.apiKey = apiKey;
			this.secretKey = secretKey;
			
		}
		
		/**
		 * Creates Reward. Reward can be Sword, Energy etc. When Reward Points have
		 * to be added the Reward name created using this method has to be
		 * specified.
		 * @param rewardName  - The reward that has to be created
		 * @param description - The description of the reward to be created
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function createReward(rewardName:String, description:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var rewardsJson:Object = new Object;
			var rewardJson:Object = new Object;
			rewardJson.name = rewardName;
			rewardJson.description = description;
			json.app42 = app42Json;
			app42Json.rewards = rewardsJson;
			rewardsJson.reward = rewardJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			App42Log.debug("Json String : " + jsonBody.toString());
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Fetches the count of all the Rewards
		 * @param callback - Callback object for success/exception result
		 */
		public function getAllRewardsCount(callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/count";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		/**
		 * Fetches all the Rewards
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getAllRewards(callback:App42CallBack) : void {
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
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		/**
		 * Fetches all the Rewards by paging.
		 * @param max - Maximum number of records to be fetched
		 * @param offset - From where the records are to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		public function getAllRewardsByPaging(max:int, offset:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			paramsDics["max"]=max;
			paramsDics["offset"]=offset;
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/paging"
				+ "/" + max + "/" + offset;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		/**
		 * Retrieves the reward for the specified name
		 * @param rewardName - Name of the reward that has to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		public function getRewardByName(rewardName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			paramsDics["name"]=rewardName; 	
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/"
				+ rewardName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		
		
		/**
		 * Adds the reward points to an users account. Reward Points can be earned
		 * by the user which can be redeemed later.
		 * @param gameName - Name of the game for which reward points have to be added
		 * @param gameUserName - The user for whom reward points have to be added
		 * @param rewardName - The rewards for which reward points have to be added
		 * @param rewardPoints - The points that have to be added
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function earnRewards(gameName:String, userName:String ,rewardName:String, rewardPoints:int ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var rewardsJson:Object = new Object;
			var rewardJson:Object = new Object;
			rewardJson.gameName = gameName;
			rewardJson.userName = userName;
			rewardJson.name = rewardName;
			rewardJson.points = rewardPoints;
			json.app42 = app42Json;
			app42Json.rewards = rewardsJson;
			rewardsJson.reward = rewardJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			App42Log.debug("Json String : " + jsonBody.toString());
			paramsDics["body"] = jsonBody.toString();
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/earn";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Deducts the reward points from the earned rewards by a user.
		 * @param gameName - Name of the game for which reward points have to be deducted
		 * @param userName - The user for whom reward points have to be deducted
		 * @param rewardName - The rewards for which reward points have to be deducted
		 * @param rewardPoints - The points that have to be deducted
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function redeemRewards(gameName:String, userName:String ,rewardName:String, rewardPoints:int ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var rewardsJson:Object = new Object;
			var rewardJson:Object = new Object;
			rewardJson.gameName = gameName;
			rewardJson.userName = userName;
			rewardJson.name = rewardName;
			rewardJson.points = rewardPoints;
			json.app42 = app42Json;
			app42Json.rewards = rewardsJson;
			rewardsJson.reward = rewardJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			App42Log.debug("Json String : " + jsonBody.toString());
			paramsDics["body"] = jsonBody.toString();
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/redeem";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Fetches the reward points for a particular user
		 * @param gameName - Name of the game for which reward points have to be fetched
		 * @param userName - The user for whom reward points have to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		public function getGameRewardPointsForUser(gameName:String,userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			paramsDics["gameName"]=gameName; 	
			paramsDics["userName"]=userName; 	
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"
				+ gameName + "/" + userName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		
		
		/**
		 * This function provides a list of specified number of top reward earners
		 * for a specific game.
		 * @param gameName - Name of the game for which reward earners are to be fetched
		 * @param rewardName - Name of the reward for which list of earners is to be fetched
		 * @param max - Specifies the number of top earners to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		public function getTopNRewardEarners(gameName:String,rewardName:String ,max:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			paramsDics["gameName"]=gameName; 	
			paramsDics["rewardName"]=rewardName; 	
			paramsDics["max"]=max; 	
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"
				+ gameName + "/" + rewardName + "/" + max;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * This function returns you the details of all the specific rewards earned
		 * by the specified user.
		 * @param userName - Name of the user whose rewards are to be fetched
		 * @param rewardName - Name of the reward for which details are to be fetched
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		public function getAllRewardsByUser(userName:String,rewardName:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			paramsDics["userName"]=userName; 	
			paramsDics["rewardName"]=rewardName; 	
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/"
				+ userName + "/points/" + rewardName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		
		/**
		 * Fetches the reward rank for a particular user
		 * @param gameName - Name of the game for which user rank have to be fetched
		 * @param rewardName - Name of the reward for which user rank have to be fetched
		 * @param userName - Name of the user for which rank have to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 * 
		 */
		
		public function getUserRankingOnReward(gameName:String,rewardName:String ,userName:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			paramsDics["gameName"]=gameName; 	
			paramsDics["rewardName"]=rewardName; 	
			paramsDics["userName"]=userName; 	
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"	+ gameName + "/" + rewardName + "/" + "rank" + "/"
				+ userName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
		}
		/**
		 * This function returns you a list of group wise users who earned the top
		 * rewards in the specified game .
		 * @param gameName - Name of the game for which top reward earners are to be fetched
		 * @param rewardName - Name of the reward for which top earners are to be listed
		 * @param userList - List of group wise users earning specified rewards
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function getTopNRewardEarnersByGroup(gameName:String,rewardName:String ,userList:Array,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			paramsDics["userList"]="[" + userList + "]"; 	
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["gameName"]=gameName; 	
			paramsDics["rewardName"]=rewardName; 	
			paramsDics["userList"]="[" + userList + "]"; 	
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource + "/"
				+ gameName + "/" + rewardName + "/group/points";
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
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