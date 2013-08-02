/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3.util
{
	import com.adobe.serialization.json.JSON;
	import com.hurlant.crypto.hash.HMAC;
	import com.hurlant.crypto.hash.SHA1;
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.utils.Base64Encoder;
	
	
	public class Util
	{
		public function Util()
		{
			
		}
		
		public static function computeHmac(message:String, key:String):String
		{
			// HMAC also support RIPEMD algorithm which is not provided
			var messageBytes:ByteArray = new ByteArray();
			
			messageBytes.writeMultiByte(message,"utf-8");
			
			var secretBytes:ByteArray = new ByteArray();
			
			secretBytes.writeMultiByte(key,"utf-8");
			
			var hmac : HMAC = new HMAC(new SHA1());
			var encryptedArray : ByteArray = hmac.compute(secretBytes, messageBytes)
			
			var encoder : Base64Encoder = new Base64Encoder();
			encoder.encodeBytes(encryptedArray);
			return urlEncode(encoder.toString());
		}
		
		public static function getUTCFormattedTimestamp():String {
			var date:Date = new Date();
			var month:String;
			var monthString:String = (date.getUTCMonth()+1).toString();
			if (monthString.length == 1) { month = "0" + monthString; }
			else{  month = monthString;  }
			var dateString:String;
			var rawDate:String = date.getUTCDate().toString();
			if (rawDate.length == 1) { dateString = "0" + rawDate; }
			else { dateString = rawDate; }			
			var timeStamp:String = "";
			timeStamp += date.getUTCFullYear() + "-";
			timeStamp += month + "-";
			timeStamp += dateString;
			timeStamp += "T" + date.getUTCHours() + ":";
			timeStamp += date.getUTCMinutes() + ":";
			timeStamp += date.getUTCSeconds() + ".";
			timeStamp += date.getUTCMilliseconds();
			timeStamp += "Z";
			return timeStamp;
		}
		
		
		public static function countKeys(myDictionary:flash.utils.Dictionary):int 
		{
			var n:int = 0;
			for (var key:* in myDictionary) {
				n++;
			}
			return n;
		}
		
		
		public static function clone(original:Dictionary):Dictionary {
			var cloned:Dictionary = new Dictionary();
			for(var key:Object in original) {
				if( original[key]  is Dictionary)
					cloned[key] = clone(original[key]);
				else
					cloned[key] = original[key];
			}
			return cloned;
		}
		public static function sign(secretKey:String, parmasDics:Dictionary):String {
			var sign:String = "";
			var sortArray:Array = sortDictionaryByValue(parmasDics);
				for(var keySorted:* in sortArray)
				{
					sign= sign.concat(sortArray[keySorted],parmasDics[sortArray[keySorted]]);
				}	
				var signature:String = computeHmac(sign,secretKey);
			return signature; 
		}
		
		public static function sortDictionaryByValue(parmasDics:Dictionary):Array
		{
			var arraySort:Array = new Array();
			for (var dictionaryKey:* in parmasDics)	{ arraySort.push(dictionaryKey);}
			return arraySort.sort();
		}  
		
		public static function urlEncode(string:String):String {
			var urlString:String = '';
			
			for (var i:int = 0 ; i < string.length ; i++)
			{
				var chr:Number = string.charCodeAt(i);
				
				if ((chr >= 48 && chr <= 57) || // 09
					(chr >= 65 && chr <= 90) || // AZ
					(chr >= 97 && chr <= 122) || // az
					chr == 45 || // -
					chr == 95 || // _
					chr == 46 || // .
					chr == 126) // ~
				{
					urlString += String.fromCharCode(chr);
				}
				else
				{
					urlString += '%' + chr.toString(16).toUpperCase();
				}
			}
			
			return urlString;
		}
		/**
		 * An exception to check whether the object is null or blank.
		 * @param obj
		 * @param name
		 * 
		 */
		
		public static function throwExceptionIfNullOrBlank(obj:Object, name:String,callback:App42CallBack):void {
			if (obj == null) {
				callback.onException(new App42Exception(name +" parameter can not be null" ,null,null));
				return ;
			}
			if (obj is String) {
			var trimObj:String = obj.toString();
				if(Util.trim(trimObj) == "") {
					callback.onException(new App42Exception(name + " parameter can not be blank",null,null));
					return ;
				}
			}
		}
		
		/**
		 * An exception to check whether the email entered is valid or not.
		 * @param obj
		 * @param name
		 */
		
		public static function throwExceptionIfEmailNotValid(obj:Object, name:String,callback:App42CallBack):void {
			if (obj == null) {
				callback.onException(new App42Exception(name +" parameter can not be null" ,null,null));
				return ;
			}
			var pattern:RegExp = /"^[\\w\\-]([\\.\\w])+[\\w]+@([\\w\\-]+\\.)+[A-Z]{2,4}$"/;
			var match:Boolean = pattern.exec(obj.toString());
			if (match != true)
				callback.onException(new App42Exception(name +" id is not valid" ,null,null));
			return ;
		}
		
		public static function trim(str:String):String
		{
			if (str == null) return '';
			
			var startIndex:int = 0;
			while (isWhitespace(str.charAt(startIndex)))
				++startIndex;
			
			var endIndex:int = str.length - 1;
			while (isWhitespace(str.charAt(endIndex)))
				--endIndex;
			
			if (endIndex >= startIndex)
				return str.slice(startIndex, endIndex + 1);
			else
				return "";
		}
		public static function isWhitespace(character:String):Boolean
		{
			switch (character)
			{
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
					
				default:
					return false;
			}
		}
		public static function toString(object:Object):String
		{
			var toString:String  = com.adobe.serialization.json.JSON.encode(object);
			return toString;
		}
	}
}
