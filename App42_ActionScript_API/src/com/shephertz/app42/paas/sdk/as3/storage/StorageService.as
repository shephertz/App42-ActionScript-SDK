/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3.storage
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	import com.shephertz.app42.paas.sdk.as3.App42Log;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.game.GameResponseBuilder;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;
	
	/**
	 * Storage service on cloud provides the way to store the JSON document in NoSQL
	 * database running on cloud. One can store the JSON document, update it ,
	 * search it and can apply the map-reduce search on stored documents. Example :
	 * If one will store JSON doc {"employeeName":"Nick"} it will be stored with unique
	 * Object Id and stored JSON object will look like {"employeeName":"Nick", "_id" : {
	 * "$oid" : "4f423dcce1603b3f0bd560cf"}}. This oid can further be used to
	 * access/search the document.
	 * @see Storage
	 * 
	 * @author Himanshu Sharma
	 */
	
	public class StorageService extends App42Service
	{
		private var version : String  = "1.0";
		private var resource :String  = "storage";
		private var apiKey : String ;
		private var secretKey : String ;
		private var baseURL : String ;
		
		/**
		 * this is a constructor that takes
		 * 
		 * @param apiKey
		 * @param secretKey
		 * 
		 */
		
		public function StorageService(apiKey : String , secretKey : String) {
			this.apiKey = apiKey;
			this.secretKey = secretKey;
			
		}
		
		/**
		 * Save the JSON document in given database name and collection name.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc has to be saved
		 * @param json - Target JSON document to be saved
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		public function insertJSONDocument( dbName:String,  collectionName:String,
									   jsonObject:Object,callback:App42CallBack):void  {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"DbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"CollectionName",callback);
				return ;
			}
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			paramsDics["dbName"] = dbName;
			paramsDics["collectionName"] = collectionName;
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var storageJson:Object = new Object;
			storageJson.jsonDoc = jsonObject;
			app42Json.storage = storageJson;
			json.app42 = app42Json;
			
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/insert/dbName/" + dbName + "/collectionName/"
				+ collectionName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback,false);
		}
		
		/**
		 * Find all documents stored in given database and collection.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param calback - Callback object for success/exception result
		 * 
		 */
		public function findAllDocuments(dbName:String,collectionName:String, callback:App42CallBack) : void {
			var response:String = null;
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
			}
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["dbName"] = dbName; 
			paramsDics["collectionName"] = collectionName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/findAll/dbName/" + dbName + "/collectionName/"
				+ collectionName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Find all documents stored in given database and collection.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param max - Maximum number of records to be fetched
		 * @param offset - From where the records are to be fetched
		 * @param calback - Callback object for success/exception result
		 * 
		 */
		public function findAllDocumentsByPaging(dbName:String,collectionName:String,max:int,offset:int ,callback:App42CallBack) : void {
			var response:String = null;
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
			}
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["dbName"] = dbName; 
			paramsDics["collectionName"] = collectionName; 
			paramsDics["max"] = max; 
			paramsDics["offset"] = offset; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/findAll/dbName/" + dbName + "/collectionName/"
				+ collectionName + "/" + max + "/" + offset;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		* Find all collections stored in given database.
		* @param dbName - Unique handler for storage name
		* @param collectionName - Name of collection under which JSON doc needs to be searched
		* @param calback - Callback object for success/exception result
		* 
		*/
		public function findAllCollections(dbName:String, callback:App42CallBack) : void {
			var response:String = null;
			if(dbName == null || Util.trim(dbName) == "" )
			{
				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
			}
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["dbName"] = dbName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	
				+ "/findCollections/dbName/" + dbName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Gets the count of all documents stored in given database and collection.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param calback - Callback object for success/exception result
		 * 
		 */
		public function findAllDocumentsCount(dbName:String,collectionName:String, callback:App42CallBack) : void {
			var response:String = null;
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
			}
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["dbName"] = dbName; 
			paramsDics["collectionName"] = collectionName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	
				+ "/findAll/count/dbName/" + dbName + "/collectionName/"
				+ collectionName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Find all documents stored in given database and collection.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param docId  - Unique Object Id handler
		 * @param calback - Callback object for success/exception result
		 * 
		 */
		public function findDocumentById(dbName:String,collectionName:String,docId:String,callback:App42CallBack) : void {
			var response:String = null;
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "" || docId == null || Util.trim(docId) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
				Util.throwExceptionIfNullOrBlank(docId,"DocId",callback);
			}
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["dbName"] = dbName; 
			paramsDics["collectionName"] = collectionName; 
			paramsDics["docId"] = docId; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/findDocById/dbName/" + dbName + "/collectionName/"
				+ collectionName + "/docId/" + docId;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Find target document using key value search parameter. This key value
		 * pair will be searched in the JSON doc stored on the cloud and matching
		 * Doc will be returned as a result of this method.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param key - Key to be searched for target JSON doc
		 * @param value - Value to be searched for target JSON doc
		 * @param calback - Callback object for success/exception result
		 * 
		 */
		
		public function findDocumentByKeyValue(dbName:String,collectionName:String,key:String,value:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "" || key == null || Util.trim(key) == "" || value == null || Util.trim(value) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
				Util.throwExceptionIfNullOrBlank(key,"Key",callback);
				Util.throwExceptionIfNullOrBlank(value,"Value",callback);
			}
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["dbName"] = dbName; 
			paramsDics["collectionName"] = collectionName; 
			paramsDics["key"] = key; 
			paramsDics["value"] = value; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/findDocByKV/dbName/" + dbName + "/collectionName/"
				+ collectionName + "/" + key + "/"	+ Util.urlEncode(value);
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Find target document using Custom Query in async mode.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param Query - Query Object containing custom query for searching docs
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 * 
		 */
		
//		public function findDocumentsByQuery(dbName:String,collectionName:String,key:String,value:String,callback:App42CallBack) : void {
//			var response:String = null;
//			var paramsDics:Dictionary = new Dictionary();
//			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "" || key == null || Util.trim(key) == "" || value == null || Util.trim(value) == "")
//			{
//				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
//				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
//				Util.throwExceptionIfNullOrBlank(key,"Key",callback);
//				Util.throwExceptionIfNullOrBlank(value,"Value",callback);
//			}
//			paramsDics["apiKey"]= apiKey;
//			paramsDics["version"]= version;
//			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
//			
//			var queryParams:Dictionary = Util.clone(paramsDics);
//			paramsDics["dbName"] = dbName; 
//			paramsDics["collectionName"] = collectionName; 
//			paramsDics["key"] = key; 
//			paramsDics["value"] = value; 
//			
//			var signature:String = Util.sign(this.secretKey,paramsDics);
//			App42Log.debug("Signature : " + signature);
//			var resourceUrl:String = this.version + "/" + this.resource	+ "/findDocByKV/dbName/" + dbName + "/collectionName/"
//				+ collectionName + "/" + key + "/"	+ Util.urlEncode(value);
//			App42Log.debug("Http url : " + resourceUrl);
//			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
//			
//		}
		
		/**
		 * Find target document using Custom Query with paging.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param Query - Query Object containing custom query for searching docs
		 * @param max  - max result parameter
		 * @param offset - offset result parameter
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		//		public function findDocumentsByQueryWithPaging(dbName:String,collectionName:String,key:String,value:String,callback:App42CallBack) : void {
		//			var response:String = null;
		//			var paramsDics:Dictionary = new Dictionary();
		//			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "" || key == null || Util.trim(key) == "" || value == null || Util.trim(value) == "")
		//			{
		//				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
		//				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
		//				Util.throwExceptionIfNullOrBlank(key,"Key",callback);
		//				Util.throwExceptionIfNullOrBlank(value,"Value",callback);
		//			}
		//			paramsDics["apiKey"]= apiKey;
		//			paramsDics["version"]= version;
		//			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
		//			
		//			var queryParams:Dictionary = Util.clone(paramsDics);
		//			paramsDics["dbName"] = dbName; 
		//			paramsDics["collectionName"] = collectionName; 
		//			paramsDics["key"] = key; 
		//			paramsDics["value"] = value; 
		//			
		//			var signature:String = Util.sign(this.secretKey,paramsDics);
		//			App42Log.debug("Signature : " + signature);
		//			var resourceUrl:String = this.version + "/" + this.resource	+ "/findDocByKV/dbName/" + dbName + "/collectionName/"
		//				+ collectionName + "/" + key + "/"	+ Util.urlEncode(value);
		//			App42Log.debug("Http url : " + resourceUrl);
		//			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
		//			
		//		}
		
		/**
		 * Find target document using Custom Query with paging and orderby in async mode.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param Query  - Query Object containing custom query for searching docs
		 * @param max - max result parameter
		 * @param offset - offset result parameter
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		//		public function findDocsWithQueryPagingOrderBy(dbName:String,collectionName:String,key:String,value:String,callback:App42CallBack) : void {
		//			var response:String = null;
		//			var paramsDics:Dictionary = new Dictionary();
		//			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "" || key == null || Util.trim(key) == "" || value == null || Util.trim(value) == "")
		//			{
		//				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
		//				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
		//				Util.throwExceptionIfNullOrBlank(key,"Key",callback);
		//				Util.throwExceptionIfNullOrBlank(value,"Value",callback);
		//			}
		//			paramsDics["apiKey"]= apiKey;
		//			paramsDics["version"]= version;
		//			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
		//			
		//			var queryParams:Dictionary = Util.clone(paramsDics);
		//			paramsDics["dbName"] = dbName; 
		//			paramsDics["collectionName"] = collectionName; 
		//			paramsDics["key"] = key; 
		//			paramsDics["value"] = value; 
		//			
		//			var signature:String = Util.sign(this.secretKey,paramsDics);
		//			App42Log.debug("Signature : " + signature);
		//			var resourceUrl:String = this.version + "/" + this.resource	+ "/findDocByKV/dbName/" + dbName + "/collectionName/"
		//				+ collectionName + "/" + key + "/"	+ Util.urlEncode(value);
		//			App42Log.debug("Http url : " + resourceUrl);
		//			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
		//			
		//		}
		
		
		/**
		 * Update target document using key value search parameter. This key value
		 * pair will be searched in the JSON doc stored in the cloud and matching
		 * Doc will be updated with new value passed. 
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param key - Key to be searched for target JSON doc
		 * @param value - Value to be searched for target JSON doc
		 * @param newJsonDoc - New Json document to be added
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		
		public function updateDocumentByKeyValue( dbName:String,  collectionName:String,
											key:String,value:Object,newJsonDoc:Object,callback:App42CallBack):void  {
			var response:String = null;
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"DbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"CollectionName",callback);
				return ;
			}
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			paramsDics["dbName"] = dbName;
			paramsDics["collectionName"] = collectionName;
			paramsDics["key"] = key;
			paramsDics["value"] = value;
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var storageJson:Object = new Object;
			storageJson.jsonDoc = newJsonDoc;
			app42Json.storage = storageJson;
			json.app42 = app42Json;
			
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/update/dbName/" + dbName + "/collectionName/"
				+ collectionName + "/" + key + "/" + value;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback,false);
		}
		/**
		 * Update target document using the document id.
		 * 
		 * @param dbName
		 *            - Unique handler for storage name
		 * @param collectionName
		 *            - Name of collection under which JSON doc needs to be searched
		 * @param docId
		 *            - Id of the document to be searched for target JSON doc
		 * @param newJsonDoc
		 *            - New Json document to be added
		 * @param callback - Callback object for success/exception result
		 * 
		 */
			
			public function updateDocumentByDocId( dbName:String,  collectionName:String,
													  docId:String,newJsonDoc:Object,callback:App42CallBack):void  {
				var response:String = null;
				if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "")
				{
					Util.throwExceptionIfNullOrBlank(dbName,"DbName",callback);
					Util.throwExceptionIfNullOrBlank(collectionName,"CollectionName",callback);
					return ;
				}
				var paramsDics:Dictionary = new Dictionary();
				paramsDics["apiKey"]=apiKey;
				paramsDics["version"]=version;
				paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
				var queryParams:Dictionary = Util.clone(paramsDics);
				
				paramsDics["dbName"] = dbName;
				paramsDics["collectionName"] = collectionName;
				paramsDics["docId"] = docId;
				var json:Object = new Object;
				var app42Json:Object = new Object;
				var storageJson:Object = new Object;
				storageJson.jsonDoc = newJsonDoc;
				app42Json.storage = storageJson;
				json.app42 = app42Json;
				
				var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
				paramsDics["body"] = jsonBody.toString();
				App42Log.debug("Json String : " + jsonBody.toString());
				var signature:String = Util.sign(this.secretKey,paramsDics);
				App42Log.debug("Signature : " + signature);
				var resourceUrl:String = this.version + "/" + this.resource	+ "/updateByDocId/dbName/" + dbName + "/collectionName/"
					+ collectionName + "/docId/" + docId;
				App42Log.debug("Http url : " + resourceUrl);
				RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback,false);
			}
			
			/**
			 * Delete target document using Object Id from given db and collection. The
			 * Object Id will be searched in the JSON doc stored on the cloud and
			 * matching Doc will be deleted.
			 * @param dbName - Unique handler for storage name
			 * @param collectionName - Name of collection under which JSON doc needs to be searched
			 * @param docId - Unique Object Id handler
			 * @param calback - Callback object for success/exception result
			 * 
			 */
			public function deleteDocumentById(dbName:String,collectionName:String,docId:String,callback:App42CallBack) : void {
				var response:String = null;
				if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "" || docId == null || Util.trim(docId) == "")
				{
					Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
					Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
					Util.throwExceptionIfNullOrBlank(docId,"DocId",callback);
				}
				var paramsDics:Dictionary = new Dictionary();
				
				paramsDics["apiKey"]= apiKey;
				paramsDics["version"]= version;
				paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
				
				var queryParams:Dictionary = Util.clone(paramsDics);
				paramsDics["dbName"] = dbName; 
				paramsDics["collectionName"] = collectionName; 
				paramsDics["docId"] = docId; 
				
				var signature:String = Util.sign(this.secretKey,paramsDics);
				App42Log.debug("Signature : " + signature);
				var resourceUrl:String = this.version + "/" + this.resource + "/deleteDocById/dbName/" + dbName + "/collectionName/"
					+ collectionName + "/docId/" + docId;
				App42Log.debug("Http url : " + resourceUrl);
				RESTConnector.getInstance().executeDelete(signature,resourceUrl,queryParams,this,callback,false);
				
			}

			public function deleteAllDocuments(dbName:String,collectionName:String, callback:App42CallBack) : void {
				var response:String = null;
				if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "")
				{
					Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
					Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
				}
				var paramsDics:Dictionary = new Dictionary();
				
				paramsDics["apiKey"]= apiKey;
				paramsDics["version"]= version;
				paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
				
				var queryParams:Dictionary = Util.clone(paramsDics);
				paramsDics["dbName"] = dbName; 
				paramsDics["collectionName"] = collectionName; 
				
				var signature:String = Util.sign(this.secretKey,paramsDics);
				App42Log.debug("Signature : " + signature);
				var resourceUrl:String = this.version + "/" + this.resource	+ "/deleteAll/dbName/" + dbName + "/collectionName/"
					+ collectionName;
				App42Log.debug("Http url : " + resourceUrl);
				RESTConnector.getInstance().executeDelete(signature,resourceUrl,queryParams,this,callback,false);
				
			}
			
//			/**
//			 * Find target document using Custom Query.
//			 * 
//			 * @param dbName
//			 *            - Unique handler for storage name
//			 * @param collectionName
//			 *            - Name of collection under which JSON doc needs to be searched
//			 * @param Query
//			 *            - Query Object containing custom query for searching docs
//			 * 
//			 * @return Storage object
//			 * 
//			 * @throws App42Exception
//			 * 
//			 */
//			
//			public Storage findDocumentsByLocation(String dbName,
//				String collectionName, GeoQuery query) throws App42Exception {
//					String response = null;
//					Storage storage = null;
//					Util.throwExceptionIfNullOrBlank(dbName, "DbName");
//					Util.throwExceptionIfNullOrBlank(collectionName, "CollectionName");
//					Util.throwExceptionIfNullOrBlank(query, "Query");
//					try {
//						Hashtable<String, String> queryParams = new Hashtable<String, String>();
//						Hashtable<String, String> headerParams = new Hashtable<String, String>();
//						Hashtable<String, String> signParams = populateSignParams();
//						Hashtable<String, String> metaHeaders = populateMetaHeaderParams();
//						headerParams.putAll(signParams);
//						headerParams.putAll(metaHeaders);
//						signParams.put("dbName", dbName);
//						signParams.put("collectionName", collectionName);
//						signParams.put("jsonQuery", query.getStr());
//						
//						queryParams.put("jsonQuery", query.getStr());
//						String signature = Util.sign(this.secretKey, signParams);
//						headerParams.put("signature", signature);
//						String resourceURL = this.version + "/" + this.resource
//							+ "/findDocsBylocation/dbName/" + dbName
//							+ "/collectionName/" + collectionName;
//						response = RESTConnectorAsync.getInstance().executeGet(resourceURL,
//							queryParams, headerParams);
//						storage = new StorageResponseBuilder().buildResponse(response);
//					} catch (App42Exception e) {
//						throw e;
//					} catch (Exception e) {
//						throw new App42Exception(e);
//					}
//					return storage;
//				}
			
		/**
		 * Delete target document using key and value from given db and collection.
		 * The key value will be searched in the JSON doc stored on the cloud and
		 * matching value will be deleted.
		 * @param dbName - Unique handler for storage name
		 * @param collectionName - Name of collection under which JSON doc needs to be searched
		 * @param key - Unique key handler
		 * @param value - Unique value handler
		 * @param calback - Callback object for success/exception result
		 * 
		 */
		
		public function deleteDocumentsByKeyValue(dbName:String,collectionName:String,key:String,value:String,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			if(dbName == null || Util.trim(dbName) == "" || collectionName == null || Util.trim(collectionName) == "" || key == null || Util.trim(key) == "" || value == null || Util.trim(value) == "")
			{
				Util.throwExceptionIfNullOrBlank(dbName,"dbName",callback);
				Util.throwExceptionIfNullOrBlank(collectionName,"collectionName",callback);
				Util.throwExceptionIfNullOrBlank(key,"Key",callback);
				Util.throwExceptionIfNullOrBlank(value,"Value",callback);
			}
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var object:Object = new Object();
			object.key = value;
			var getKey:Object = object;
			paramsDics["value"] = getKey; 
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["dbName"] = dbName; 
			paramsDics["collectionName"] = collectionName; 
			paramsDics["key"] = key; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/deletebykey/dbName/" + dbName + "/collectionName/"
				+ collectionName + "/" + key;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeDelete(signature,resourceUrl,queryParams,this,callback,false);
			
		}

		override public function onSuccess(response:String, requestCall:App42CallBack,isArray:Boolean):void
		{
			var object:Object;
			if(isArray){
				App42Log.debug("Array Response " + response);
				object = new StorageResponseBuilder().buildResponse(response);
			} 
			else {
				App42Log.debug("Response : " + response);
				object = new StorageResponseBuilder().buildResponse(response);
			}
			requestCall.onSuccess(object);
			
		}
		override public function onException(exception:App42Exception, requestCall:App42CallBack):void
		{
			requestCall.onException(exception);
		}
	}
}