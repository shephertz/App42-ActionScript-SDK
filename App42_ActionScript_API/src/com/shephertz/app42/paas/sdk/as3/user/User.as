 package com.shephertz.app42.paas.sdk.as3.user
{
	import com.shephertz.app42.paas.sdk.as3.App42Response;

	public class User extends App42Response {
		
		public var userName:String;
		public var password:String;
		public var email:String;
		public var sessionId:String;
		private var profile:Profile;
		public var accountLocked:Boolean = new Boolean(false);
		public var roleList :Array = new Array;
		
		/**
		 * Returns the User's account status.
		 * 
		 * @return true if account is locked, false if account is unlocked.
		 */
		
		public function isAccountLocked():Boolean {
			return accountLocked;
		}
		
		/**
		 * Sets the value of account to either true or false.
		 * 
		 * @param accountLocked
		 *            - true or false
		 * 
		 */
		
		public function setAccountLocked(accountLocked:Boolean):void {
			this.accountLocked = accountLocked;
		}
		
		/**
		 * Returns the name of the User.
		 * 
		 * @return the name of the User.
		 */
		
		public function getUserName():String {
			return userName;
		}
		
		/**
		 * Sets the name of the User.
		 * 
		 * @param userName
		 *            - Name of the User
		 * 
		 */
		
		public function setUserName(userName:String):void {
			this.userName = userName;
		}
		
		
		/**
		 * Returns the email of the User.
		 * 
		 * @return the email of the User.
		 * 
		 */
		
		public function getEmail():String {
			return email;
		}
		
		/**
		 * Sets the Email of the User.
		 * 
		 * @param email
		 *            - Email of the User
		 * 
		 */
		
		public function setEmail(email:String):void {
			this.email = email;
		}
		/**
		 * Returns the User.Profile object for the User.
		 * 
		 * @return Profile of the User
		 * 
		 */
		
		public function getProfile():Profile {
			return this.profile;
		}
		
		/**
		 * Sets the User. Profile object for the User.
		 * 
		 * @param profile
		 *            - Profile of the User
		 * 
		 */
		
		public function setProfile( profile:Profile):void {
			this.profile = profile;
		}
		
		/**
		 * Returns the roles assigned to the User
		 * 
		 * @return List of the roles assigned to the User
		 * 
		 */
		
		public function getRoleList():Array {
			return roleList;
		}
		
		/**
		 * Assigns the list of roles to the User
		 * 
		 * @param roleList
		 *            - List of roles to be assigned to User
		 * 
		 */
		
		public function setRoleList( roleList:Array):void {
			this.roleList = roleList;
		}
		
		/**
		 * Session Id of User if authenticated
		 * 
		 * @return
		 */
		public function getSessionId() :String {
			return sessionId;
		}
		
		/**
		 * Set Session Id of User
		 * 
		 * @param sessionId
		 */
		public function setSessionId(sessionId:String):void {
			this.sessionId = sessionId;
		}
	}
 }