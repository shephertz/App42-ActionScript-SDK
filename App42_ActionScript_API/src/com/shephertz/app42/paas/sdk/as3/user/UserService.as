package com.shephertz.app42.paas.sdk.as3.user
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;

	public class UserService extends App42Service
	{
		private var version : String  = "1.0";
		private var resource :String  = "user";
		private var apiKey : String ;
		private var secretKey : String ;
		private var baseURL : String ;
		
		/**
		 * this is a constructor that takes
		 * 
		 * @param apiKey
		 * @param secretKey
		 * @param baseURL
		 * 
		 */
		
		public function UserService(apiKey : String , secretKey : String) {
			this.apiKey = apiKey;
			this.secretKey = secretKey;
			
		}
		/**
		 * Create a User with userName, password & emailAddress in async mode
		 * @param userName - Name of the User
		 * @param password - Password for the User
		 * @param emailId - Email address of the user
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function createUser(userName:String, password:String, emailId:String ,callback:App42CallBack) : void {
			var response:String = null;
			Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
			Util.throwExceptionIfNullOrBlank(password,"password",callback);
			Util.throwExceptionIfNullOrBlank(emailId,"emailId",callback);
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var userJson:Object = new Object;
			userJson.email = emailId;
			userJson.password = password;
			userJson.userName = userName;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource;
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		/**
		 * Gets the User details based on userName
		 * @param userName - Name of the User to retrieve
		 * @param calback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getUser(userName:String, callback:App42CallBack) : void {
			var response:String = null;
			Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource + "/"+ userName;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		/**
		 * Gets the details of all users
		 * @param calback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getAllUsers(callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource ;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
		/**
		 * Gets user details based on emailId
		 * @param emailId - EmailId of the user to be retrieved
		 * @param calback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getUserByEmailId(emailId:String, callback:App42CallBack) : void {
			var response:String = null;
			Util.throwExceptionIfNullOrBlank(emailId,"emailId",callback);
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			paramsDics["emailId"]= emailId;
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"+ "email" + "/" + emailId;
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback);
			
		}
	}
}