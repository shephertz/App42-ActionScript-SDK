package com.shephertz.app42.paas.sdk.as3.game
{
	import com.shephertz.app42.paas.sdk.as3.App42Response;
	
	/**
	 * 
	 * This Game object is the value object which contains the properties of Game
	 * along with the setter & getter for those properties.
	 * 
	 */
	
	public class Game extends App42Response {
		public var name:String;
		public var description:String ;
		public var scoreList:Array =new Array(Score);
		/**
		 * Returns the name of the game.
		 * 
		 * @return the name of the game.
		 */
		public function getName():String {
			return name;
		}
		
		/**
		 * Sets the name of the Game which has to be created.
		 * 
		 * @param name
		 *            - Name of the Game that has to be created
		 * 
		 */
		public function setName(name:String):void {
			this.name = name;
		}
		
		/**
		 * Returns the description of the game.
		 * 
		 * @return the description of the game.
		 */
		public function getDescription():String {
			return description;
		}
		
		/**
		 * Sets the description of the Game.
		 * 
		 * @param description
		 *            - Description of the game to be created
		 * 
		 */
		public function setDescription( description:String):void {
			this.description = description;
		}
		/**
		 * Returns the score list for the Game.
		 * 
		 * @return the score list for the Game.
		 */
		public function getScoreList():Array {
			return scoreList;
		}
		
		/**
		 * Sets the Score list for the Game.
		 * @param scoreList
		 *            - List of score for the game
		 * 
		 */
		public function setScoreList(scoreList:Array):void {
			this.scoreList = scoreList;
		}
	}
}