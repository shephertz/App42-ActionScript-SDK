package com.shephertz.app42.paas.sdk.as3.game
{
	import com.shephertz.app42.paas.sdk.as3.App42ResponseBuilder;
	
	/**
	 * 
	 */
	public class GameResponseBuilder extends App42ResponseBuilder
	{
		/**
		 * 
		 */
		public function buildResponse(json:String) :Game {
			var gamesJSONObj :Object = getServiceJSONObject("games", json);
			if(gamesJSONObj == null){
				var gameObjec:Game = new Game();
				gameObjec.setStrResponse(json);
				gameObjec.setResponseSuccess(isResponseSuccess(json));
				gameObjec.setTotalRecords(new GameResponseBuilder().getTotalRecords(json));
				return gameObjec;
			}
			var game:Game = buildGameObject(gamesJSONObj["game"]);
			game.setStrResponse(json);
			game.setResponseSuccess(isResponseSuccess(json));
			return game;
		}
		/**
		 * 
		 */
		public function buildArrayResponse(json:String) :Array {
			var gamesJSONObj :Object = getServiceJSONObject("games", json);
			var gameJSONObj:Object = gamesJSONObj["game"];
			var gameList:Array = new Array();
			if(gameJSONObj is Array) {
				for (var i:int = 0; i < gameJSONObj.length; i++) { 
					var jsonObj:Object = gameJSONObj[i];
					var game:Game = buildGameObject(jsonObj);
					game.setStrResponse(json);
					game.setResponseSuccess(isResponseSuccess(json));
					gameList.push(game);
					
				}
			}
			else 
			{
				var games:Game = buildGameObject(gameJSONObj);
				games.setStrResponse(json);
				games.setResponseSuccess(isResponseSuccess(json));
				gameList.push(games);
			}
			return gameList;
		}
		
		/**
		 * 
		 */
		public function buildGameObject(json:Object) :Game {
			var game:Game = new Game();
			var array:Array = new Array();
			buildObjectFromJSONTree(game,json);
			if(json["scores"] != null){
				var scoresJSONObj:Object = json["scores"];
				if(scoresJSONObj["score"] != null){
					var scoreJSONObj:Object = scoresJSONObj["score"];
					if(scoreJSONObj is Array){
						for (var i:int = 0; i < scoreJSONObj.length; i++) { 
							var scoresObj:Object = scoreJSONObj[i];
							var score:Score = new Score;
							buildObjectFromJSONTree(score, scoresObj);
							array.push(score);
							game.setScoreList(array);
						}
					}
					else{
						var scoreJsonObj:Object = scoreJSONObj;
						var scoreObj:Score = new Score();
						buildObjectFromJSONTree(scoreObj, scoreJsonObj);		
						array.push(scoreObj);
						game.setScoreList(array);	
					}
				}
			}
			return game;
		}
		/**
		 * 
		 */
		public function buildObjectFromJSONTree(obj:Object, json:Object):void {
			
			var game:Game
			if(obj is Game){ 
				game = Game(obj);
				if(json["name"] != null || json["description"] != null){
					game.setName(json["name"]);
					game.setDescription(json["description"]);	
				}
			}
		if(obj is Score) {
				var score:Score = Score(obj);
				if(json["userName"] != null)
				{
					score.setUserName(json["userName"]);
				}
				if(json["value"] != null){
					score.setValue(json["value"]);	
				}
//				if(json["createdOn"] != null){
//					score.setCreatedOn(json["createdOn"]);
//				}
				if(json["scoreId"] != null){
					score.setScoreId(json["scoreId"]);
				}
				if(json["rank"] != null){
					score.setRank(json["rank"]);
				}
				
			}	
		}
	}
}
