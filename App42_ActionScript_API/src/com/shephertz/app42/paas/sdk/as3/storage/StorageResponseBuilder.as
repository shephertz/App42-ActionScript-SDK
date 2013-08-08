package com.shephertz.app42.paas.sdk.as3.storage
{
	import com.shephertz.app42.paas.sdk.as3.App42ResponseBuilder;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	public class StorageResponseBuilder extends App42ResponseBuilder
	{
		/**
		 * 
		 */
		public function buildResponse(json:String) :Storage {
			var storagesJSONObj :Object = getServiceJSONObject("storage", json);
			var storage:Storage = buildStorageObject(storagesJSONObj);
			storage.setStrResponse(json);
			storage.setResponseSuccess(isResponseSuccess(json));
			return storage;
		}
		
		/**
		 * 
		 */
		public function buildStorageObject(json:Object) :Storage {
			var storage:Storage = new Storage();
			var array:Array = new Array();
			buildObjectFromJSONTree(storage,json);
			if (json["jsonDoc"] == null)
				return storage;
			
			if (json["jsonDoc"] != null)
			{
				var jsonDocObj:Object = json["jsonDoc"];
				if(jsonDocObj is Array){
					trace(jsonDocObj.length)
					for (var i:int = 0; i < jsonDocObj.length; i++) { 
						var jsonsObjDoc:Object = jsonDocObj[i];
						var document:JSONDocument= new JSONDocument;
						buildJsonDocument(document, jsonsObjDoc);
						array.push(document);
						trace(document[0]);
						storage.setJsonDocList(array);
					}
				}
			}
			//			else
			//			{
			//				JArray jsonObjDocArray = (JArray)jsonObjStorage["jsonDoc"];
			//				for (int i = 0; i < jsonObjDocArray.Count(); i++)
			//				{
			//					App42Log.debug("jsonObjDocArray" + jsonObjDocArray);
			//					JObject jsonObjDoc = (JObject)jsonObjDocArray[i];
			//					Storage.JSONDocument document = new Storage.JSONDocument(storageObj);
			//					BuildJsonDocument(document, jsonObjDoc);
			//				}
			//			}
			//			App42Log.debug(storageObj.GetDbName() + " : " + storageObj.GetCollectionName() + " : " + storageObj.GetJsonDocList());
			
			return storage;
		}
		
		
		public function buildJsonDocument(obj:Object, json:Object):void {
			if(obj is JSONDocument){
				var document:JSONDocument = new JSONDocument;
				if(json["_id"] != null){
					var idObj:Object = json["_id"];
					var oIdObj:String = idObj["$oid"];
					document.setDocId(oIdObj);
					delete json["_id"];
					document.setJsonDoc(json["jsonDoc"]);
				}
			}
		}
		
		/**
		 * 
		 */
		public function buildObjectFromJSONTree(obj:Object, json:Object):void {
			if(obj is Storage){
				trace(obj);
				var storage:Storage = Storage(obj);
				if(json["dbName"] != null || json["collectionName"] != null){
					storage.setDbName(json["dbName"]);
					storage.setCollectionName(json["collectionName"]);	
				}
				
			}
		}
	}
}


