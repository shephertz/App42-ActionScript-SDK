package com.shephertz.app42.paas.sdk.as3.game
{
	import com.shephertz.app42.paas.sdk.as3.App42Response;
	
	public class Reward extends App42Response {
		
		public var gameName:String;
		public var userName:String;
		public var name:String;
		public var description:String;
		public var points:int;
		public var rank:int;
		
		/**
		 * Returns the name of the game.
		 * 
		 * @return the name of the game.
		 */
		public function getGameName():String {
			return gameName;
		}
		
		/**
		 * Sets the name of the Game which has to be created.
		 * 
		 * @param gameName
		 *            - Name of the Game that has to be created
		 * 
		 */
		public function setGameName(	gameName:String):void {
			this.gameName = gameName;
		}
		
		/**
		 * Returns the user name of the game.
		 * 
		 * @return the user name of the game.
		 */
		public function getUserName():String {
			return userName;
		}
		
		/**
		 * Sets the user name of the Game.
		 * 
		 * @param userName
		 *            - User Name of the Game
		 * 
		 */
		public function setUserName(userName:String):void {
			this.userName = userName;
		}
		
		/**
		 * Returns the name of the reward.
		 * 
		 * @return the name of the reward.
		 */
		public function getName():String {
			return name;
		}
		
		/**
		 * Sets the name of the reward which has to be created.
		 * 
		 * @param name
		 *            - Name of the reward that has to be created
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
		public function setDescription(description:String):void {
			this.description = description;
		}
		
		/**
		 * Returns the points to the Reward.
		 * 
		 * @return the points to the Reward.
		 */
		public function getPoints():int {
			return points;
		}
		
		/**
		 * Sets the points to the Reward.
		 * 
		 * @param points
		 *            - points to the reward
		 * 
		 */
		public function setPoints(points:int):void {
			this.points = points;
		}
		public function getRank():int {
			return rank;
		}
		public function setRank(rank:int):void {
			this.rank = rank;
		}
	}
}
