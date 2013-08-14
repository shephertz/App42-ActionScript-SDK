package com.shephertz.app42.paas.sdk.as3.game
{
	import com.shephertz.app42.paas.sdk.as3.App42ResponseBuilder;
	
	public class RewardResponseBuilder extends App42ResponseBuilder
	{
		/**
		 * 
		 */
		public function buildResponse(json:String) :Reward {
			var rewardsJSONObj :Object = getServiceJSONObject("rewards", json);
			if(rewardsJSONObj == null){
				var rewardObjec:Reward = new Reward();
				rewardObjec.setStrResponse(json);
				rewardObjec.setResponseSuccess(isResponseSuccess(json));
				rewardObjec.setTotalRecords(new RewardResponseBuilder().getTotalRecords(json));
				return rewardObjec;
			}
			var reward:Reward = buildRewardObject(rewardsJSONObj["reward"]);
			reward.setStrResponse(json);
			reward.setResponseSuccess(isResponseSuccess(json));
			return reward;
		}
		/**
		 * 
		 */
		public function buildArrayResponse(json:String) :Array {
			var rewardsJSONObj :Object = getServiceJSONObject("rewards", json);
			var rewardList:Array = new Array();
			if(rewardsJSONObj["reward"] is Array) {
				var rewardJSONObj:Object = rewardsJSONObj["reward"];
				for (var i:int = 0; i < rewardJSONObj.length; i++) { 
					var jsonObj:Object = rewardJSONObj[i];
					var reward:Reward = buildRewardObject(jsonObj);
					reward.setStrResponse(json);
					reward.setResponseSuccess(isResponseSuccess(json));	
					rewardList.push(reward);
				}
			}
			else 
			{
				var rewards:Reward = buildRewardObject(rewardsJSONObj["reward"]);
				rewards.setStrResponse(json);
				rewards.setResponseSuccess(isResponseSuccess(json));
				rewardList.push(rewards);
			}
			return rewardList;
		}
		
		/**
		 * 
		 */
		public function buildRewardObject(json:Object) :Reward {
			var reward:Reward = new Reward();
			buildObjectFromJSONTree(reward,json);
			return reward;
		}
		/**
		 * 
		 */
		public function buildObjectFromJSONTree(obj:Object, json:Object):void {
			
			if(obj is Reward){ 
				var reward:Reward = Reward(obj);
				if(json["name"] != null){
					reward.setName(json["name"]);
				}
				if(json["gameName"] != null){
					reward.setGameName(json["gameName"]);	
				}
				if(json["userName"] != null){
					reward.setUserName(json["userName"]);
				}
				if(json["description"] != null){
					reward.setDescription(json["description"]);	
				}
				if(json["points"] != null){
					reward.setPoints(json["points"]);
				}
				if(json["rank"] != null){
					reward.setRank(json["rank"]);
				}
				if(json["description"] != null){
					reward.setDescription(json["description"]);	
				}
			}
		}
	}
}
