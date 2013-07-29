package com.shephertz.app42.paas.sdk.as3
{
	public class App42Log
	{
		private static var debugFlag:Boolean = false;
		
		public static function isDebug():Boolean
		{
			return debugFlag;
		}
		
		public static function setDebug(debugFlag:Boolean):void
		{
			App42Log.debugFlag = debugFlag;
		}
		
		public static function info( msg:String):void {
			trace(msg);
		}
		
		public static function debug(msg:String):void {
			if (debugFlag)
				trace(msg);
		}
		
		public static function error(msg:String):void {
			trace(msg);
		}
		
		public static function fatal(msg:String):void {
			trace(msg);
		}	
	}	
}