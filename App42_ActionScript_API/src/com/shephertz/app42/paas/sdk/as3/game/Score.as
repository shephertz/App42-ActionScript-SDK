package com.shephertz.app42.paas.sdk.as3.game
{
	public class Score  {
		
		public var userName:String;
		public var rank:String;
		public var value:int;
		public var createdOn:Date;
		public var scoreId:String;
		public function getRank():String {
			return rank;
		}
		public function setRank( rank:String):void {
			this.rank = rank;
		}
		
		public function getScoreId():String {
			return scoreId;
		}
		public function setScoreId(scoreId:String):void {
			this.scoreId = scoreId;
		}
		/**
		 * Returns the game user name.
		 * 
		 * @return the game user name.
		 */
		public function getUserName():String {
			return userName;
		}
		
		/**
		 * Sets the game user name for which scores have to be added
		 * 
		 * @param scoreList
		 *            - List of score for the game
		 * 
		 */
		public function setUserName(userName:String) :void{
			this.userName = userName;
		}
		
		/**
		 * Returns the game value.
		 * 
		 * @return the game value.
		 */
		public function getValue():int {
			return value;
		}
		
		/**
		 * Sets the value for the game.
		 * 
		 * @param value
		 *            - value for the game.
		 * 
		 */
		public function setValue( value:int):void {
			this.value = value;
		}
		
		/**
		 * Returns the time when the game was created.
		 * 
		 * @return the time when the game was created.
		 */
		public function getCreatedOn():Date{
			return createdOn;
		}
		
		/**
		 * Sets the time when the game was created..
		 * 
		 * @param createdOn
		 *            - time when the game was created.
		 * 
		 */
		public function setCreatedOn(createdOn:Date):void {
			this.createdOn = createdOn;
		}
	}
}