/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	import com.adobe.serialization.json.JSON;

	public class App42ResponseBuilder
	{
		/**
		 * @author Himanshu Sharma
		 */
		public function getServiceJSONObject(serviceName:String, json:String):Object {
			var jsonObj:Object = com.adobe.serialization.json.JSON.decode(json);
			var jsonObjApp42:Object = jsonObj["app42"];
			var jsonObjResponse:Object = jsonObjApp42["response"];
			var jsonObjService:Object = jsonObjResponse[serviceName];
			return jsonObjService;
		}
		public function isResponseSuccess(json:String):Boolean {
			var jsonObj:Object = com.adobe.serialization.json.JSON.decode(json);
			var jsonObjApp42:Object = jsonObj["app42"];
			var jsonObjResponse:Object = jsonObjApp42["response"];
			var jsonObjSuccess:Boolean = jsonObjResponse["success"];
			return jsonObjSuccess;
		}
		
		public function getTotalRecords(json:String):int {
			var totalRecords:int ;
			var jsonObj:Object = com.adobe.serialization.json.JSON.decode(json);
			var jsonObjApp42:Object = jsonObj["app42"];
			var jsonObjResponse:Object = jsonObjApp42["response"];
			totalRecords = jsonObjResponse["totalRecords"];
			return totalRecords;
		}
	}
}