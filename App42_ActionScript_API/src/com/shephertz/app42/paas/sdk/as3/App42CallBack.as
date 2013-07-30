/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	public interface App42CallBack 
	{
		/**
		* @author Himanshu Sharma
		*/
		function onSuccess(object:Object):void;
		function onException(exception:App42Exception):void;
	}
}