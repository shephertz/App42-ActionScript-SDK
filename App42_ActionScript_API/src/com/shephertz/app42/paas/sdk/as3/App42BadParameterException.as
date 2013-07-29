package com.shephertz.app42.paas.sdk.as3
{
	public class App42BadParameterException extends App42Exception
	{
		public var httpErrorCode:int;
		public var appErrorCode:int;
		
		
		public function App42BadParameterException(message:String, httpErrorCode:int,appErrorCode:int)
		{
			super(message, httpErrorCode,appErrorCode);
			this.httpErrorCode = httpErrorCode;
			this.appErrorCode = appErrorCode;
		}
	}
}


