/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	public class App42Exception extends Error
	{
		/**
 		 * @author Himanshu Sharma
		 */
		private var httpErrorCode:int;
		private var appErrorCode:int;
		
		public function App42Exception(message : String , httpErrorCode:int, appErrorCode:int)
		{
			App42Log.debug("Exception message " + message);
			super(message, httpErrorCode);
			App42Log.debug("App42Exception HttpErrorCode " + httpErrorCode);
			this.httpErrorCode = httpErrorCode;
			App42Log.debug("App42Exception AppErrorCode " + appErrorCode);
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