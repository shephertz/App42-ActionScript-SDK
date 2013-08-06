/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3.user
{
	import com.adobe.serialization.json.JSON;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	import com.shephertz.app42.paas.sdk.as3.App42Log;
	import com.shephertz.app42.paas.sdk.as3.App42Service;
	import com.shephertz.app42.paas.sdk.as3.connection.RESTConnector;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	import flash.utils.Dictionary;
	
	/**
	 * Creates User for the App. App42 Cloud API's provides a complete User
	 * Management for any mobile or web app. It supports User registration,
	 * retrieval, state management e.g. user creation and Authentication.
	 * 
	 * @author Himanshu Sharma
	 */
	
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
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" || password == null || Util.trim(password) == "" || emailId == null || Util.trim(emailId) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(password,"Password",callback);
				Util.throwExceptionIfNullOrBlank(emailId,"EmailId",callback);
				
				return;
			}
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var match:Boolean = pattern.exec(emailId.toString());
			if(match == true){
				
			}
			else {
				
				Util.throwExceptionIfEmailNotValid(emailId,"EmailId",callback);
				return ;
			}
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
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Create a User with userName, password & emailAddress in async mode
		 * @param userName - Name of the User
		 * @param password - Password for the User
		 * @param emailId - Email address of the user
		 * @param roleList - List of roles to be assigned to User
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function createUserWithRole(userName:String, password:String, emailId:String ,roleList:Array ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" || password == null || Util.trim(password) == "" || emailId == null || Util.trim(emailId) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(password,"Password",callback);
				Util.throwExceptionIfNullOrBlank(emailId,"EmailId",callback);
				
				return;
			}
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var match:Boolean = pattern.exec(emailId.toString());
			if(match == true){
				
			}
			else {
				
				Util.throwExceptionIfEmailNotValid(emailId,"EmailId",callback);
				return ;
			}
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var roleObj:Object = new Object;
			var userJson:Object = new Object;
			roleObj.role = "[" + roleList+"]";
			userJson.email = emailId;
			userJson.password = password;
			userJson.userName = userName;
			userJson.roles = roleObj;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		/**
		 * Creates or Updates User Profile. First time the Profile for the user is
		 * created and in future calls user profile will be updated. This will
		 * always update the profile with new value passed in profile object. Call
		 * to this method should have all the values you want to retain in user
		 * profile object, otherwise old values of profile will get updated with
		 * null. Method only updates the profile of user, passing email/password in
		 * user object does not have any significance for this method call.
		 * @param user - User for which profile has to be updated, this should
		 * 				 contain the userName and profile object in it.
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function createOrUpdateProfile(user:User,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var obj:Object = new Object();
			var json:Object = new Object();
			var app42Json:Object = new Object();
			var profile:Profile  = user.getProfile();
			var profileObj:Object = new Object();
			profileObj.put("firstName", profile.getFirstName());
			profileObj.put("lastName", profile.getLastName());
			profileObj.put("sex", profile.getSex());
			profileObj.put("mobile", profile.getMobile());
			profileObj.put("line1", profile.getLine1());
			profileObj.put("line2", profile.getLine2());
			profileObj.put("city", profile.getCity());
			profileObj.put("state", profile.getState());
			profileObj.put("country", profile.getCountry());
			profileObj.put("pincode", profile.getPincode());
			profileObj.put("homeLandLine", profile.getHomeLandLine());
			profileObj.put("officeLandLine", profile.getOfficeLandLine());
			if (profile.getDateOfBirth() != null) {
				profileObj.put("dateOfBirth", Util.getUTCFormattedTimestampWithUserInputDate(profile
					.getDateOfBirth()));
			}
			obj.put("profileData", profileObj);
			obj.put("userName", user.getUserName());
			
			json.app42 = app42Json;
			app42Json.profileData = profileObj;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/assignrole";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		/**
		 * Assign Roles to the existing User 
		 * @param uName - Name of the User to whom the roles have to be assigned
		 * @param roleList - List of roles to be assigned to User
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function assignRoles(userName:String,roleList:Array ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" )
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				
				return;
			}
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var roleObj:Object = new Object;
			var userJson:Object = new Object;
			roleObj.role = "[" + roleList+"]";
			userJson.userName = userName;
			userJson.roles = roleObj;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/assignrole";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Updates the User's Email Address based on userName. Note: Only email can
		 * be updated. User name cannot be updated.
		 * @param userName - UserName which should be unique for the App
		 * @param emailId - Email address of the user
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function updateEmail(userName:String, emailId:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" || emailId == null || Util.trim(emailId) == "" )
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(emailId,"EmailId",callback);
				
				return;
			}
			
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var match:Boolean = pattern.exec(emailId.toString());
			if(match == true){
				
			}
			else {
				
				Util.throwExceptionIfEmailNotValid(emailId,"EmailId",callback);
				return ;
			}
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object
			var userJson:Object = new Object;
			
			userJson.userName = userName;
			userJson.email = emailId;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Updates the User password based on userName. Username cannot be updated.
		 * @param userName - UserName which should be unique for the App
		 * @param password - Password to be reset
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function resetUserPassword(userName:String, password:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" || password == null || Util.trim(password) == "" )
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(password,"Password",callback);
				
				return;
			}
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object
			var userJson:Object = new Object;
			
			userJson.userName = userName;
			userJson.password = password;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/resetUserPassword";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Changes the password for user based on the userName.
		 * 
		 * @param uName
		 *            - UserName which should be unique for the App
		 * @param oldPassword
		 *            - Old Password for the user for authentication
		 * @param newPassword
		 *            - New Password for the user to change
		 * @param callback - Callback object for success/exception result
		 * 
		 * @throws App42Exception
		 */
		public function changeUserPassword(userName:String, oldPassword:String ,newPassword:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" || oldPassword == null || Util.trim(oldPassword) == "" || newPassword == null || Util.trim(newPassword) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(oldPassword,"OldPassword",callback);
				Util.throwExceptionIfNullOrBlank(newPassword,"newPassword",callback);
				
				return;
			}
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object
			var userJson:Object = new Object;
			
			userJson.userName = userName;
			userJson.oldPassword = oldPassword;
			userJson.newPassword = newPassword;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource	+ "/changeUserPassword";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		public function logout(sessioId:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(sessioId == null || Util.trim(sessioId) == "" )
			{
				Util.throwExceptionIfNullOrBlank(sessioId,"SessioId",callback);
				
				return;
			}
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object
			var sessionJson:Object = new Object;
			sessionJson.id = sessioId;
			json.app42 = app42Json;
			app42Json.session = sessionJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version  + "/" + "session";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		/**
		 * Locks the user based on the userName. Apps can use these feature to lock
		 * a user because of reasons specific to their user case e.g. If payment not
		 * received and the App wants the user to be inactive
		 * @param userName - UserName which should be unique for the App
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function lockUser(userName:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" )
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				
				return;
			}
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object
			var userJson:Object = new Object;
			userJson.userName = userName;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/lock";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		
		
		/**
		 * Unlocks the user based on the userName. App developers can use this
		 * feature to unlock a user because of reasons specific to their usercase
		 * e.g. When payment received, the App developer wants the user to be
		 * active.
		 * @param userName - UserName which should be unique for the App
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function unlockUser(userName:String ,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" )
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				
				return;
			}
			
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var json:Object = new Object;
			var app42Json:Object = new Object
			var userJson:Object = new Object;
			userJson.userName = userName;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/unlock";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePut(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		/**
		 * Authenticate user based on userName and password
		 * @param userName - UserName which should be unique for the App
		 * @param password - Password for the User
		 * @param callback - Callback object for success/exception result
		 * 
		 */
		public function authenticate(userName:String, password:String, callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			if(userName == null || Util.trim(userName) == "" || password == null || Util.trim(password) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(password,"Password",callback);
				
				return ;
			}
			paramsDics["apiKey"]=apiKey;
			paramsDics["version"]=version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			var json:Object = new Object;
			var app42Json:Object = new Object;
			var userJson:Object = new Object;
			userJson.password = password;
			userJson.userName = userName;
			json.app42 = app42Json;
			app42Json.user = userJson;
			var jsonBody:String  = com.adobe.serialization.json.JSON.encode(json);
			paramsDics["body"] = jsonBody.toString();
			App42Log.debug("Json String : " + jsonBody.toString());
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource
				+ "/authenticateAndCreateSession";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executePost(signature,resourceUrl,queryParams ,jsonBody,this,callback);
		}
		/**
		 * Gets the User details based on userName
		 * @param userName - Name of the User to retrieve
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getUser(userName:String, callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			if(userName == null || Util.trim(userName) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				return;
			}
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["userName"] = userName; 
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/"+ userName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Gets the details of all users
		 * @param callback - Callback object for success/exception result
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
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource ;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Gets the count of all the users
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getAllUsersCount(callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/count/all";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Gets all users by Paging
		 * @param max - Maximum number of records to be fetched
		 * @param offset - From where the records are to be fetched
		 * @param callback - Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getAllUsersByPaging(max:int,offset:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["max"]= max;
			paramsDics["offset"]= offset;
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/paging"	+ "/" + max + "/" + offset;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Gets user details based on emailId
		 * @param emailId - EmailId of the user to be retrieved
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getUserByEmailId(emailId:String, callback:App42CallBack) : void {
			var response:String = null;
			Util.throwExceptionIfNullOrBlank(emailId,"emailId",callback);
			var paramsDics:Dictionary = new Dictionary();
			
			if(emailId == null || Util.trim(emailId) == "")
			{
				Util.throwExceptionIfNullOrBlank(emailId,"EmailId",callback);
				return;
			}
			
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var match:Boolean = pattern.exec(emailId.toString());
			if(match == true){
				
			}
			else {
				
				Util.throwExceptionIfEmailNotValid(emailId,"EmailId",callback);
				return ;
			}
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			paramsDics["emailId"]= emailId;
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"+ "email" + "/" + emailId;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		/**
		 * Gets the details of all the locked users
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getLockedUsers(callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"	+ "locked";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Gets the count of all the locked users
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getLockedUsersCount(callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/count/locked";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Gets the details of all the locked users
		 * @param max - Maximum number of records to be fetched
		 * @param offset - From where the records are to be fetched
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getLockedUsersByPaging(max:int,offset:int,callback:App42CallBack) : void {
			var response:String = null;
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["max"]= max;
			paramsDics["offset"]= offset;
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"	+ "locked" + "/" + max + "/" + offset;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Get the assigned roles to the specified User
		 * @param userName - UserName from whom the role have to be retrieved
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getRolesByUser(userName:String, callback:App42CallBack) : void {
			var response:String = null;
			if(userName == null || Util.trim(userName) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				return;
			}
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			
			paramsDics["userName"]= userName;
			
			var queryParams:Dictionary = Util.clone(paramsDics);
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + userName + "/roles";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Get all the Users who have the specified role assigned
		 * @param role - Role for which Users needs to be retrieved
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function getUsersByRole(role:String, callback:App42CallBack) : void {
			var response:String = null;
			if(role == null || Util.trim(role) == "")
			{
				Util.throwExceptionIfNullOrBlank(role,"Role",callback);
				return;
			}
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["role"]= role;
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/role"	+ "/" + role;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeGet(signature,resourceUrl,queryParams,this,callback,true);
			
		}
		
		/**
		 * Revokes the specified role from the user.
		 * @param userName - UserName from whom the role has to be revoked
		 * @param role - Role that has to be revoked
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function revokeRole(userName:String, role:String,callback:App42CallBack) : void {
			var response:String = null;
			if(userName == null || Util.trim(userName) == "" || role == null || Util.trim(role) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				Util.throwExceptionIfNullOrBlank(role,"Role",callback);
				return;
			}
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["userName"]= userName;
			paramsDics["role"]= role;
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource  + "/"+ userName + "/revoke/" + role;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeDelete(signature,resourceUrl,queryParams,this,callback);
			
		}
		
		/**
		 * Revokes all the roles from the user.
		 * @param userName - UserName from whom the role has to be revoked
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function revokeAllRoles(userName:String, callback:App42CallBack) : void {
			var response:String = null;
			if(userName == null || Util.trim(userName) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				return;
			}
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["userName"]= userName;
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource+ "/" + userName + "/revoke";
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeDelete(signature,resourceUrl,queryParams,this,callback);
			
		}
		/**
		 * Deletes a particular user based on userName.
		 * @param userName - UserName which should be unique for the App
		 * @param callback- Callback object for success/exception result
		 * @throws App42Exception
		 */
		public function deleteUser(userName:String, callback:App42CallBack) : void {
			var response:String = null;
			if(userName == null || Util.trim(userName) == "")
			{
				Util.throwExceptionIfNullOrBlank(userName,"UserName",callback);
				return;
			}
			var paramsDics:Dictionary = new Dictionary();
			paramsDics["apiKey"]= apiKey;
			paramsDics["version"]= version;
			paramsDics["timeStamp"]= Util.getUTCFormattedTimestamp();
			var queryParams:Dictionary = Util.clone(paramsDics);
			paramsDics["userName"]= userName;
			
			var signature:String = Util.sign(this.secretKey,paramsDics);
			App42Log.debug("Signature : " + signature);
			var resourceUrl:String = this.version + "/" + this.resource + "/" + userName;
			App42Log.debug("Http url : " + resourceUrl);
			RESTConnector.getInstance().executeDelete(signature,resourceUrl,queryParams,this,callback);
			
		}
		
		
		/**
		 * Builds a Parameter string for the profileData.
		 * @param profileData - User.Profile object that contains profile information
		 * 
		 */
		
		private function fillParamsWithProfileData(profileData:Profile):String {
			
			var profileDataCond:String = "";
			if (profileData.getCity() != null && !profileData.getCity() == "") {
				profileDataCond += "city:" + profileData.getCity() + "!";
			}
			if (profileData.getCountry() != null && !profileData.getCountry() == "") {
				profileDataCond += "country:" + profileData.getCountry() + "!";
			}
			if (profileData.getDateOfBirth() != null && !profileData.getDateOfBirth() == "") {
				profileDataCond += "date_of_birth:" + profileData.getDateOfBirth()
					+ "!";
			}
			if (profileData.getFirstName() != null	&& !profileData.getFirstName() == "") {
				profileDataCond += "first_name:" + profileData.getFirstName() + "!";
			}
			if (profileData.getLastName() != null && !profileData.getLastName() == "") {
				profileDataCond += "last_name:" + profileData.getLastName() + "!";
			}
			if (profileData.getHomeLandLine() != null && !profileData.getHomeLandLine() == "") {
				profileDataCond += "home_land_line:" + profileData.getHomeLandLine() + "!";
			}
			if (profileData.getLine1() != null && !profileData.getLine1() == "") {
				profileDataCond += "line1:" + profileData.getLine1() + "!";
			}
			if (profileData.getLine2() != null && !profileData.getLine2() == "") {
				profileDataCond += "line2:" + profileData.getLine2() + "!";
			}
			if (profileData.getMobile() != null && !profileData.getMobile() == "") {
				profileDataCond += "mobile:" + profileData.getMobile() + "!";
			}
			if (profileData.getOfficeLandLine() != null && !profileData.getOfficeLandLine() == "") {
				profileDataCond += "office_land_line:" + profileData.getOfficeLandLine() + "!";
			}
			if (profileData.getPincode() != null && !profileData.getPincode() == "") {
				profileDataCond += "pincode:" + profileData.getPincode() + "!";
			}
			if (profileData.getSex() != null && !profileData.getSex() == "") {
				profileDataCond += "sex:" + profileData.getSex() + "!";
			}
			if (profileData.getState() != null && !profileData.getState() == "") {
				profileDataCond += "state:" + profileData.getState() + "!";
			}
			return profileDataCond;
			
		}
		override public function onSuccess(response:String, requestCall:App42CallBack,isArray:Boolean):void
		{
			App42Log.debug("Response From Server : " + response);
			var object:Object;
			object = com.adobe.serialization.json.JSON.decode(response);
			requestCall.onSuccess(object);
			
		}
		override public function onException(exception:App42Exception, requestCall:App42CallBack):void
		{
			requestCall.onException(exception);
		}
	}
}