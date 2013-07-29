package com.shephertz.app42.paas.sdk.as3
{
	public class App42SecurityException extends App42Exception
	{
		public var httpErrorCode:int;
		public var appErrorCode:int;
		
		
		public function App42SecurityException(message:String, httpErrorCode:int,appErrorCode:int)
		{
			super(message, httpErrorCode,appErrorCode);
			this.httpErrorCode = httpErrorCode;
			this.appErrorCode = appErrorCode;
		}
	}
}