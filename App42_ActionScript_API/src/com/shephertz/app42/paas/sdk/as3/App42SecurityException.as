/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	/**
	 * 
	 * Security Exception thrown when the API-KEY, SECRET-KEY, Signature is
	 * incorrect or the client is not authorized to make the call. This maps to the
	 * 401 Http error code
	 * 
	 * @author Himanshu Sharma
	 */

	public class App42SecurityException extends App42Exception
	{
		public var httpErrorCode:int;
		public var appErrorCode:int;
		
		
		public function App42SecurityException(message:String, httpErrorCode:int,appErrorCode:int)
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