package com.shephertz.app42.paas.sdk.as3.game
{
	import com.shephertz.app42.paas.sdk.as3.App42ResponseBuilder;
	
	public class GameResponseBuilder extends App42ResponseBuilder
	{
		public function buildResponse(json:String) :Game {
			var gamesJSONObj :Object = getServiceJSONObject("games", json);
			var gameJSONObj:Object = gamesJSONObj["game"];
			
			var game:Game = new Game();
			buildObjectFromJSONTree(game, gameJSONObj);
			game.setResponseSuccess(isResponseSuccess(json));
			game.setStrResponse(json);
			return game;
		}
		public function buildArrayResponse(json:String) :Game {
			var gamesJSONObj :Object = getServiceJSONObject("games", json);
			var gameJSONObj:Object = gamesJSONObj["game"];
			trace("Here in Root")
			if(gameJSONObj as Array){
			for (var i:int = 0; i < gameJSONObj.length; i++) 
				var game:Game = buildGameObject(gameJSONObj);
				game.setStrResponse(json);
				game.setResponseSuccess(isResponseSuccess(json));
				trace("here in " + game)
			}
			return game;
		}
		public function buildGameObject(json:Object) :Game {
			var game:Game = new Game();
			buildObjectFromJSONTree(game,json);
			return game;
		}
		public function buildObjectFromJSONTree(obj:Object, json:Object):void {
			var game:Game = Game(obj);
			trace("Herre in build")
//			if(obj is Game){
//				if(json as Array) {
//					trace(json.length)
//					for (var i:int = 0; i < json.length; i++) 
//					{
//						trace('Name: ' + json[i].name);
//						trace('');
//					}
//				}
				 if(json["name"] != null || json["description"] != null){
					 trace("here");
						game.setName(json["name"]);
						game.setDescription(json["description"]);
					
//				}
			}
		}
	}
}