package com.shephertz.app42.paas.sdk.as3
{
	public class App42NotFoundException extends App42Exception
	{
		public var httpErrorCode:int;
		public var appErrorCode:int;
		
		
		public function App42NotFoundException(message:String, httpErrorCode:int,appErrorCode:int)
		{
			super(message, httpErrorCode,appErrorCode);
			this.httpErrorCode = httpErrorCode;
			this.appErrorCode = appErrorCode;
		}
		
		
		override public function setHttpErrorCode(httpErrorCode:int):void
		{
			this.httpErrorCode = httpErrorCode;
		}
		
		override public function getHttpErrorCode():int
		{
			return this.httpErrorCode;
		}
		
		override public function setAppErrorCode(appErrorCode:int):void
		{
			this.appErrorCode = appErrorCode;
		}
		
		override public function getAppErrorCode():int
		{
			return this.appErrorCode;
		}
	}
}