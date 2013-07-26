package com.shephertz.app42.paas.sdk.as3
{
	public class App42Exception extends Error
	{
		private var httpErrorCode:int;
		private var appErrorCode:int;
		public function App42Exception(message : String , httpErrorCode:int,appErrorCode:int)
		{
			super(message, appErrorCode);
			this.httpErrorCode = httpErrorCode;
			this.appErrorCode = appErrorCode;
		}
		
		public function setHttpErrorCode(httpErrorCode:int):void
		{
			this.httpErrorCode = httpErrorCode;
		}
		
		public function getHttpErrorCode():int
		{
			return this.httpErrorCode;
		}
		
		public function setAppErrorCode(appErrorCode:int):void
		{
			this.appErrorCode = appErrorCode;
		}
		
		public function getAppErrorCode():int
		{
			return this.appErrorCode;
		}
	}
}