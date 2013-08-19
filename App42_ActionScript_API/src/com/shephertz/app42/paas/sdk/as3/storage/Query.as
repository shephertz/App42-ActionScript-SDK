package com.shephertz.app42.paas.sdk.as3.storage
{
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	public class Query
	{
		public var jsonArray:Array;
		public var jsonObject:Object;
		
		public function Query(jsonQuery:Array) {
			this.jsonArray = jsonQuery;
		}		
		public function getStr():String {
			return Util.toString(jsonArray);
		}	
		
		public function getType():Object {
			return jsonArray;
		}
	}
}