/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	/**
	 * This exception maps to Http Error Code 413. It is thrown when any of the
	 * limits are crossed. E.g. No. Of calls to API or storage limits.
	 * 
	 * @author Himanshu Sharma
	 */
	public class App42LimitException extends App42Exception
	{
		public var httpErrorCode:int;
		public var appErrorCode:int;
		
		
		public function App42LimitException(message:String, httpErrorCode:int,appErrorCode:int)
		{
			App42Log.debug("Exception message " + message);
			super(message, httpErrorCode,appErrorCode);
			App42Log.debug("HttpErrorCode " + httpErrorCode);
			this.httpErrorCode = httpErrorCode;
			App42Log.debug("AppErrorCode " + appErrorCode);
			this.appErrorCode = appErrorCode;
		}
	}
}