package com.shephertz.app42.paas.sdk.as3.storage
{
	public class GeoQuery
	{
		private var jsonObject:Object;
		private var jsonArray:Array;
		public function GeoQuery(jsonQuery:Object) {
			this.jsonObject = jsonQuery;
		}
		public function getStr():String {
			if (jsonObject != null) {
				return new "[" + jsonObject.toString() +("]").toString();
			} else {
				return jsonArray.toString();
			}
		}
		
		public function getType():Object {
			if (jsonObject != null) {
				return jsonObject;
			} else {
				return jsonArray;
			}
		}
		
	}
	
}