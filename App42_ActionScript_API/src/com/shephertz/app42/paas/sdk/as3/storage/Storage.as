package com.shephertz.app42.paas.sdk.as3.storage
{
	import com.shephertz.app42.paas.sdk.as3.App42Response;
	
	public class Storage extends App42Response {
		
		public var dbName:String;
		public var docId:String;
		public var collectionName:String;
		public var recordCount:String;
		
		public var jsonDocList:Array = new Array(JSONDocument);
		
		/**
		 * Returns the name of the database.
		 * 
		 * @return the name of the database.
		 */
		
		public function getDbName():String {
			return dbName;
		}
		
		/**
		 * Sets the name of the database.
		 * 
		 * @param dbName
		 *            - Database name for storage json document
		 * 
		 */
		
		public function setDbName( dbName:String) {
			this.dbName = dbName;
		}
		
		/**
		 * Returns the collection name of the storage
		 * 
		 * @return collection name of storage
		 */
		
		public function getCollectionName():String {
			return collectionName;
		}
		
		/**
		 * Sets the collection name of storage.
		 * 
		 * @param collectionName
		 *            - Collection name of storage
		 * 
		 */
		
		public function setCollectionName(collectionName:String) {
			this.collectionName = collectionName;
		}
		/**
		 * Returns the count  of the jsonDoc
		 * 
		 * @return count name of jsonDoc
		 */
		
		public function getRecordCount():String {
			return recordCount;
		}
		
		/**
		 * Sets the count of jsonDoc.
		 * 
		 * @param count
		 *            - count  of jsonDoc
		 * 
		 */
		
		public function setRecordCount(recordCount:String) {
			this.recordCount = recordCount;
		}
		
		/**
		 * Returns the json document list of storage
		 * 
		 * @return json document list of storage
		 */
		
		public function getJsonDocList():Array {
			return jsonDocList;
		}
		
		/**
		 * Sets the Json doc list
		 * 
		 * @param jsonDocList
		 *            - json document list of the storage
		 * 
		 */
		
		public function setJsonDocList(jsonDocList:Array):void {
			this.jsonDocList = jsonDocList;
		}
		
	}
}
