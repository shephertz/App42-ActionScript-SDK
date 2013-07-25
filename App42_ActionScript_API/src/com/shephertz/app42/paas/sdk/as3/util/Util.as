package com.shephertz.app42.paas.sdk.as3.util
{
	import com.hurlant.crypto.hash.HMAC;
	import com.hurlant.crypto.hash.SHA1;
	
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
			trace("in hmac "+ message);
			// HMAC also support RIPEMD algorithm which is not provided
			var messageBytes:ByteArray = new ByteArray();
			
			messageBytes.writeMultiByte(message,"utf-8");
			
			var secretBytes:ByteArray = new ByteArray();
			
			secretBytes.writeMultiByte(key,"utf-8");
			
			var hmac : HMAC = new HMAC(new SHA1());
			var encryptedArray : ByteArray = hmac.compute(secretBytes, messageBytes)
			
			var encoder : Base64Encoder = new Base64Encoder();
			encoder.encodeBytes(encryptedArray);
			return encoder.toString();
		}
		public static function getUTCFormattedTimestamp():String {
			var currentDate:Date = new Date();
			var timeStamp : String = new String();
			var month : String  =	new String();
			if(currentDate.getUTCMonth() < 10)
				month  = "-0" + currentDate.getUTCMonth();
			else
				month  = "-"+currentDate.getUTCMonth();
			timeStamp = currentDate.getUTCFullYear() + month + "-" + currentDate.getDate() +"T"+currentDate.getUTCHours()+":"+currentDate.getUTCMinutes()+":" +currentDate.getUTCMinutes()+":"+currentDate.getUTCMilliseconds()+"Z";
			return "2013-07-24T14:06:00.848Z";
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
			
			for(var key:* in parmasDics) {
				trace("keys is " + key);
				var keysParams:String = parmasDics[key];
				var signature:String = computeHmac(keysParams,secretKey);
				
			}return escape(signature); 
		}
		public static function sortDictionaryByValue(d:Dictionary):Array
		{
			var a:Array = new Array();
			for (var dictionaryKey:Object in d)
			{
				a.push({key:dictionaryKey,value:d[dictionaryKey]});
			}
			a.sortOn("value",[Array.NUMERIC|Array.DESCENDING]);
			return a;
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
		
	}
}
