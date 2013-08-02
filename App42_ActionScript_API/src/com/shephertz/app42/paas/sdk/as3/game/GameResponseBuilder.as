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
	}
}