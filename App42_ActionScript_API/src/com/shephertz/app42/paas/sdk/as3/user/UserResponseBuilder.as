package com.shephertz.app42.paas.sdk.as3.user
{
	import com.shephertz.app42.paas.sdk.as3.App42ResponseBuilder;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	public class UserResponseBuilder extends App42ResponseBuilder {
		
		/**
		 * Converts the response in JSON format to the value object i.e User
		 * 
		 * @param json
		 *            - response in JSON format
		 * 
		 * @return User object filled with json data
		 * 
		 */
		
		public function buildResponse(json:String):User {
			var user:User;
			var usersJSONObj:Object = getServiceJSONObject("users", json);
			if(usersJSONObj == null){
				var userObjec:User = new User();
				userObjec.setStrResponse(json);
				userObjec.setResponseSuccess(isResponseSuccess(json));
				userObjec.setTotalRecords(new UserResponseBuilder().getTotalRecords(json));
				return userObjec;
			}
			var userJSOnObj:Object = usersJSONObj["user"];
			user =  buildUserObject(userJSOnObj);
			user.setStrResponse(json);
			user.setResponseSuccess(isResponseSuccess(json));
			return user;
		}
		
		/**
		 * Converts the User JSON object to the value object i.e User
		 * 
		 * @param userJSONObj
		 *            - user data as JSONObject
		 * 
		 * @return User object filled with json data
		 * 
		 */
		
		private function buildUserObject(userJSONObj:Object):User {
			var user:User = new User();
			buildObjectFromJSONTree(user, userJSONObj);
			if (userJSONObj["profile"] != null) {
				var profileJSONObj:Object = userJSONObj["profile"];
				var profile:Profile  = new Profile(user);
				buildObjectFromJSONTree(profile, profileJSONObj);
				trace("profile is : "+ Util.toString(profileJSONObj));
			}
			if (userJSONObj["role"] != null ) {
				var roleList:Array = new Array();
				if (userJSONObj["role"] is Array) {
					var roleArr:Array =  userJSONObj["role"];
					for (var i:int = 0; i < roleArr.length; i++) {
						roleList.push(roleArr[i].toString());
					}
				} else {
					roleList.push(userJSONObj["role"]);
				}
				user.setRoleList(roleList);
			}
			return user;
		}
		
		/**
		 * Converts the response in JSON format to the list of value objects i.e
		 * User
		 * 
		 * @param json
		 *            - response in JSON format
		 * 
		 * @return List of User object filled with json data
		 * 
		 */
		
		public function buildArrayResponse(json:String): Array {
			var usersJSONObj:Object = getServiceJSONObject("users", json);
			var userJSONObj:Object = usersJSONObj["user"];
			// Get JSON Array for user
			var userList:Array = new Array();
			if (userJSONObj is Array) {
				for (var i:int = 0; i < userJSONObj.length; i++) {
					var userJSONObject:Object = userJSONObj[i];
					var user:User = buildUserObject(userJSONObject);
					user.setStrResponse(json);
					user.setResponseSuccess(isResponseSuccess(json));
					userList.push(user);
				}
			}
			else {
				var useJSONObject:Object = usersJSONObj["user"];
				var userObj:User = buildUserObject(useJSONObject);
				userObj.setStrResponse(json);
				userObj.setResponseSuccess(isResponseSuccess(json));
				userList.push(userObj);	
			}
			return userList;
		}	
		public function buildObjectFromJSONTree(obj:Object, json:Object):void {
			
			var user:User ;
			if(obj is Profile) {
				var profile:Profile = new Profile(user);
				trace("object is 1 : " + json["profile"]);
			}
			else if(obj is User){
				user = User(obj);
				if(json["userName"] != null){
					user.setUserName(json["userName"]);
				}
				if(json["email"] != null){
					user.setEmail(json["email"]);
				}
				if(json["sessionId"] != null){
					user.setSessionId(json["sessionId"]);
				}
				if(json["accountLocked"] != null){
					user.setAccountLocked(json["accountLocked"]);
				}
			}
		}
	}
}