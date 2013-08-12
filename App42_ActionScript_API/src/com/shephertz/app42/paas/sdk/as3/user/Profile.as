package com.shephertz.app42.paas.sdk.as3.user
{
	public class Profile extends User {
		
		public var firstName:String;
		public var lastName:String;
		public var sex:String;
		public var mobile:String;
		public var line1:String;
		public var line2:String;
		public var city:String;
		public var state:String;
		public var country:String;
		public var pincode:String;
		public var homeLandLine:String;
		public var officeLandLine:String;
		public var dateOfBirth:Date;
		
		public function Profile(user:User){
			user = this;
		}
		/**
		 * Returns the first name of the User.
		 * 
		 * @return the first name of the User.
		 */
		
		public function getFirstName():String {
			return firstName;
		}
		
		/**
		 * Sets the first name of the User.
		 * 
		 * @param firstName
		 *            - FirstName of the User
		 * 
		 */
		
		public function setFirstName(firstName:String):void {
			this.firstName = firstName;
		}
		
		/**
		 * Returns the last name of the User.
		 * 
		 * @return the last name of the User.
		 */
		
		public function getLastName():String {
			return lastName;
		}
		
		/**
		 * Sets the last name of the User.
		 * 
		 * @param lastName
		 *            - LastName of the User
		 * 
		 */
		
		public function setLastName(lastName:String):void {
			this.lastName = lastName;
		}
		
		/**
		 * Returns the gender of the User.
		 * 
		 * @return the gender of the User.
		 */
		
		public function getSex():String {
			return sex;
		}
		
//		/**
//		 * Sets the gender of the User.
//		 * 
//		 * @param sex
//		 *            - Gender of the User
//		 * 
//		 */
//		
//		public function setSex(userGender:UserGender):void {
//			this.sex = userGender;
//		}
		
		/**
		 * Returns the mobile number of the User.
		 * 
		 * @return the mobile of the User.
		 */
		
		public function getMobile():String {
			return mobile;
		}
		
		/**
		 * Sets the mobile number for the User.
		 * 
		 * @param mobile
		 *            - Mobile of the User
		 * 
		 */
		
		public function setMobile(mobile:String):void {
			this.mobile = mobile;
		}
		
		/**
		 * Returns the address line1 of the User.
		 * 
		 * @return the address line1 of the User.
		 */
		
		public function getLine1():String {
			return line1;
		}
		
		/**
		 * Sets the address line1 of the User.
		 * 
		 * @param line1
		 *            - Address line1 of the User
		 * 
		 */
		
		public function setLine1(line1:String):void {
			this.line1 = line1;
		}
		
		/**
		 * Returns the address line2 of the User.
		 * 
		 * @return the address line2 of the User.
		 */
		
		public function getLine2():String {
			return line2;
		}
		
		/**
		 * Sets the address line2 of the User.
		 * 
		 * @param line2
		 *            - Address line2 of the User
		 * 
		 */
		
		public function setLine2(line2:String):void {
			this.line2 = line2;
		}
		
		/**
		 * Returns the city of the User.
		 * 
		 * @return the city of the User.
		 */
		
		public function getCity():String {
			return city;
		}
		
		/**
		 * Sets the city of the User.
		 * 
		 * @param city
		 *            - City of the User
		 * 
		 */
		
		public function setCity(city:String):void {
			this.city = city;
		}
		
		/**
		 * Returns the state of the User.
		 * 
		 * @return the state of the User.
		 */
		
		public function getState():String {
			return state;
		}
		
		/**
		 * Sets the state of the User.
		 * 
		 * @param state
		 *            State of the User
		 * 
		 */
		
		public function setState( state:String):void {
			this.state = state;
		}
		
		/**
		 * Returns the country of the User.
		 * 
		 * @return the country of the User.
		 */
		
		public function getCountry():String {
			return country;
		}
		
		/**
		 * Sets the country of the User.
		 * 
		 * @param country
		 *            - Country of the User
		 * 
		 */
		
		public function setCountry(country:String):void {
			this.country = country;
		}
		
		/**
		 * Returns the pincode of the User.
		 * 
		 * @return the pincode of the User.
		 */
		
		public function getPincode():String {
			return pincode;
		}
		
		/**
		 * Sets the pincode of the User.
		 * 
		 * @param pincode
		 *            - Pincode of the User
		 * 
		 */
		
		public function setPincode(pincode:String) :void {
			this.pincode = pincode;
		}
		
		/**
		 * Returns the home land line of the User.
		 * 
		 * @return the home land line of the User.
		 */
		
		public function getHomeLandLine():String {
			return homeLandLine;
		}
		
		/**
		 * Sets the home land line of the User.
		 * 
		 * @param homeLandLine
		 *            - Home land line of the User
		 * 
		 */
		
		public function setHomeLandLine(homeLandLine:String):void {
			this.homeLandLine = homeLandLine;
		}
		
		/**
		 * Returns the office land line of the User.
		 * 
		 * @return the office land line of the User.
		 */
		
		public function getOfficeLandLine():String {
			return officeLandLine;
		}
		
		/**
		 * Sets the office land line of the User.
		 * 
		 * @param officeLandLine
		 *            - Office land line of the User
		 * 
		 */
		
		public function setOfficeLandLine(officeLandLine:String):void {
			this.officeLandLine = officeLandLine;
		}
		
		/**
		 * Returns the date of birth of the User.
		 * 
		 * @return the data of birth of the User.
		 */
		
		public function getDateOfBirth():Date {
			return dateOfBirth;
		}
		
		/**
		 * Sets the data of birth of the User.
		 * 
		 * @param dateOfBirth
		 *            Date of birth of the User
		 * 
		 */
		
		public function setDateOfBirth( dateOfBirth:Date):void {
			this.dateOfBirth = dateOfBirth;
		}
	}
}