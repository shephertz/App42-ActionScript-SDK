/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	/**
	 * Exception throuwn when a particular resource is not found. e.g. User not
	 * found. This maps to the HTTP Error Code 404
	 * 
	 * @author Himanshu Sharma
	 */
	public class App42NotFoundException extends App42Exception
	{
		public var httpErrorCode:int;
		public var appErrorCode:int;
		
		
		public function App42NotFoundException(message:String, httpErrorCode:int,appErrorCode:int)
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