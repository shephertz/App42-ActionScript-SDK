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
			
			var jsonDocObj:Object = json["jsonDoc"];
				if(jsonDocObj is Array){
					for (var i:int = 0; i < jsonDocObj.length; i++) { 
						var jsonsObjDoc:Object = jsonDocObj[i];
						var document:JSONDocument= new JSONDocument;
						buildJsonDocument(document, jsonsObjDoc);
						array.push(document);
						storage.setJsonDocList(array);
						trace("doc is " + Util.toString(document));
						trace("jsons Obj Doc is " + Util.toString(jsonsObjDoc));
					}
				}
				else{
					var docObj:JSONDocument= new JSONDocument;
					buildJsonDocument(docObj, jsonDocObj);
					array.push(docObj);
					storage.setJsonDocList(array);
					trace("jsonsObj Doc is " + Util.toString(jsonDocObj));
				}
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
				}
				if(json["_updatedAt"] != null){
					var updatedObj:String = json["_$updatedAt"];
					document.setUpdatedAt(updatedObj);
					delete json["_$updatedAt"];
				}
				if(json["_createdAt"] != null){
					trace("json is " + json["_$createdAt"]);
					var createdObj:String = json["_$createdAt"];
					document.setCreatedAt(createdObj);
					delete json["_$createdAt"];
				}
				document.setJsonDoc(Util.toString(json));
				trace("doc is " + document.getJsonDoc());
			}
		}
		
		/**
		 * 
		 */
		public function buildObjectFromJSONTree(obj:Object, json:Object):void {
			if(obj is Storage){
				var storage:Storage = Storage(obj);
				if(json["dbName"] != null || json["collectionName"] != null){
					storage.setDbName(json["dbName"]);
					storage.setCollectionName(json["collectionName"]);	
				}
			}
		}
	}
}


