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
			// HMAC also support RIPEMD algorithm which is not provided
			var messageBytes:ByteArray = new ByteArray();
			
			messageBytes.writeMultiByte(message,"utf-8");
			
			var secretBytes:ByteArray = new ByteArray();
			
			secretBytes.writeMultiByte(key,"utf-8");
			
			var hmac : HMAC = new HMAC(new SHA1());
			var encryptedArray : ByteArray = hmac.compute(secretBytes, messageBytes)
			
			var encoder : Base64Encoder = new Base64Encoder();
			encoder.encodeBytes(encryptedArray);
			var urlcode:String = urlEncode(encoder.toString());
			return urlcode;
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
		
		public static function getUTCFormattedTimestamp():String {
			var currentDate:Date = new Date();
			var timeStamp : String = new String();
			timeStamp = currentDate.getUTCFullYear() + "-" + currentDate.getUTCMonth() + "-" + currentDate.getUTCDate() +"T"+currentDate.getUTCHours()+":"+currentDate.getUTCMinutes()+":" +currentDate.getUTCMinutes()+":"+currentDate.getUTCMilliseconds()+"Z";
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
			for(var key:String in parmasDics) 
			var signature:String = computeHmac(secretKey,key);
			return escape(signature); 
		}
		
	}
}
