package com.shephertz.app42.paas.sdk.as3.storage
{
	public class JSONDocument {
		
		public var jsonDoc:String;
		
		public var createdAt:String;
		
		public var updatedAt:String;
		
		public var docId:String;
		//	public var loc:GeoTag ;
		private var owner:String;
		
		//	public  var aclList:Array = new Array(ACL);
		
		
		
		/**
		 * Returns the json doc for Storage.
		 * 
		 * @return json doc for storage
		 */
		
		public function getJsonDoc():String {
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
		
		
		
		/**
		 * Returns the Storage Response in JSON format.
		 * 
		 * @return the response in JSON format.
		 * 
		 */
		
		public function toString() {
			if (this.docId != null && this.jsonDoc != null)
				return this.docId + " : " + this.jsonDoc;
			else
				return super.toString();
		}
		//	public function getLocation():GeoTag{
		//		return loc;
		//	}
		//	public function setLocation(loc:GeoTag):void{
		//		this.loc = loc;
		//	}
		/**
		 * Get the ACL List on the document object
		 * @return
		 */
//		public function getAclList():Array {
//			return aclList;
//		}
//		
//		/**
//		 * Sets the ACL list on document object
//		 * @param aclList
//		 */
//		public function setAclList(aclSet:Array):void {
//			this.aclList = aclSet;
//		}
		
		public function getOwner():String {
			return owner;
		}
		
		public function setOwner(owner:String) {
			this.owner = owner;
		}
	}
}
import com.shephertz.app42.paas.sdk.as3.storage.JSONDocument;

