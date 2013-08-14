package com.shephertz.app42.paas.sdk.as3.storage
{
	public class JSONDocument {
		
		public var jsonDoc:String;
		
		public var createdAt:String;
		
		public var updatedAt:String;
		
		public var docId:String;
		public var loc:GeoTag ;
		
		//	public  var aclList:Array = new Array(ACL);
		
		
		
		/**
		 * Returns the json doc for Storage.
		 * 
		 * @return json doc for storage
		 */
		
		public function getJsonDoc():String {
			trace("trace is " + jsonDoc);
			return jsonDoc;
		}
		
		/**
		 * Sets the json document for Storage
		 * 
		 * @param jsonDoc
		 *            - json document for storage
		 * 
		 */
		
		public function setJsonDoc(jsonDoc:String):void {
			this.jsonDoc = jsonDoc;
		}
		
		/**
		 * Returns the document Id.
		 * 
		 * @return docId
		 */
		
		public function getDocId():String {
			return docId;
		}
		
		/**
		 * Sets the document Id for the Storage
		 * 
		 * @param docId
		 *            - document Id for the storage
		 * 
		 */
		
		public function setDocId(docId:String):void {
			this.docId = docId;
		}
		
		public function getCreatedAt():String {
			return createdAt;
		}
		
		
		public function setCreatedAt(createdAt:String):void {
			this.createdAt = createdAt;
		}
		
		
		public function setUpdatedAt(updatedAt:String):void {
			this.updatedAt = updatedAt;
		}
		
		public function getUpdatedAt():String {
			return updatedAt;
		}
		public function getLocation():GeoTag{
			return loc;
		}
		public function setLocation(loc:GeoTag):void{
			this.loc = loc;
		}
	}
}


