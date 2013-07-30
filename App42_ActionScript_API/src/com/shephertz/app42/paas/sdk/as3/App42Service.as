/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	public class App42Service 
	{
		/**
		 * @author Himanshu Sharma
		 */
		public function onSuccess(object:String,requestCall:App42CallBack,isArray:Boolean) : void {};
		public function onException(exception:App42Exception,requestCall:App42CallBack) : void {
		};
		
	}
}