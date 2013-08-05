package com.shephertz.app42.paas.sdk.as3
{
	public class Enum
	{
		private var _value:String;
		
		public function get value():String
		{
			return _value;
		}
		
		public function Enum(value:String)
		{
			_value = value;
		}
		
		public function toString():String
		{
			return _value;
		}
	}
}