/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	
	/**
	 * This exception is thrown when the arguments are invalid. For e.g. Already
	 * exits * This maps to the HTTP Error Code 408
	 * 
	 * @author Himanshu Sharma
	 */
	public class App42BadParameterException extends App42Exception
	{
		public var httpErrorCode:int;
		public var appErrorCode:int;
		
		
		public function App42BadParameterException(message:String, httpErrorCode:int,appErrorCode:int)
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


