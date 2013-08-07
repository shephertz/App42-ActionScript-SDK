package com.shephertz.app42.paas.sdk.as3.storage
{
	import com.shephertz.app42.paas.sdk.as3.App42ResponseBuilder;

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
		public function buildArrayResponse(json:String) :Array {
			var storagesJSONObj :Object = getServiceJSONObject("storages", json);
			var storageJSONObj:Object = storagesJSONObj["storage"];
			var storageList:Array = new Array();
			if(storageJSONObj is Array) {
				for (var i:int = 0; i < storageJSONObj.length; i++) { 
					var jsonObj:Object = storageJSONObj[i];
					var storage:Storage = buildStorageObject(jsonObj);
					storage.setStrResponse(json);
					storage.setResponseSuccess(isResponseSuccess(json));
					storageList.push(storage);
					
				}
			}
			else 
			{
				var storages:Storage = buildStorageObject(storageJSONObj);
				storages.setStrResponse(json);
				storages.setResponseSuccess(isResponseSuccess(json));
				storageList.push(storages);
			}
			return storageList;
		}
		
		/**
		 * 
		 */
		public function buildStorageObject(json:Object) :Storage {
			var storage:Storage = new Storage();
			var array:Array = new Array();
			buildObjectFromJSONTree(storage,json);
//			if(json["jsonDocLists"] != null){
//				var jsonDocListsJSONObj:Object = json["jsonDocLists"];
//				if(jsonDocListsJSONObj["jsonDocList"] != null){
//					var jsonDocListJSONObj:Object = jsonDocListsJSONObj["jsonDocList"];
//					if(jsonDocListJSONObj is Array){
//						for (var i:int = 0; i < jsonDocListJSONObj.length; i++) { 
//							var jsonDocListsObj:Object = jsonDocListJSONObj[i];
//							
//							var jsonDocList:JSONDocument = new JSONDocument;
//							buildObjectFromJSONTree(jsonDocList, jsonDocListsObj);
//							array.push(jsonDocList);
//						}
//					}
//					else{
//						var sObj:Object = jsonDocListJSONObj[i];
//						var seObj:JSONDocument = new JSONDocument();
//						buildObjectFromJSONTree(seObj, jsonDocListsObj);
//					}
//				}
//			}
			return storage;
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
//			if(obj is JSONDocument) {
//				var jsonDocList:JSONDocument = JSONDocument(obj);
//				if(json["userName"] != null || json["value"] != null ||json["createdOn"] != null || json["jsonDocListId"] != null|| json["rank"] != null){
//					jsonDocList.setUserName(json["userName"]);
//					jsonDocList.setValue(json["value"]);	
//					jsonDocList.setJSONDocumentId(json["jsonDocListId"]);
//					jsonDocList.setRank(json["rank"]);
//					
//				}	
//			}
		}
	}
}


