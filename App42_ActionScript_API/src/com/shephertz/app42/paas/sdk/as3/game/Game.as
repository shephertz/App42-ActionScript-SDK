package com.shephertz.app42.paas.sdk.as3.game
{
	import com.shephertz.app42.paas.sdk.as3.App42Response;

	public class Game extends App42Response
	{
		public var name:String;
		public var description:String;
		
		public function getGameName():String{
			return this.name;
		}
		public function setGameName(name:String):void {
			trace("name is " + name);
			this.name = name;
		}
	}
}