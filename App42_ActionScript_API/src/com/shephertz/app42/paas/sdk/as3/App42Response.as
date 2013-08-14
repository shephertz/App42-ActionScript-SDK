/**
 * -----------------------------------------------------------------------
 *     Copyright © 2012 ShepHertz Technologies Pvt Ltd. All rights reserved.
 * -----------------------------------------------------------------------
 */
package com.shephertz.app42.paas.sdk.as3
{
	public class App42Response
	{
		/**
		 * @author Himanshu Sharma
		 */
		public var isResponse:Boolean;
		
		public var strResponse:String;
		
		public var totalRecords:int;
		
		public function getTotalRecords():int {
			return totalRecords;
		}
		
		public function setTotalRecords(totalRecords:int):void {
			this.totalRecords = totalRecords;
		}
		
		public function getStrResponse():String {
			return strResponse;
		}
		
		public function setStrResponse(strResponse:String):void {
			this.strResponse = strResponse;
		}
		
		public function isResponseSuccess():Boolean {
			return isResponse;
		}
		public function setResponseSuccess(isResponseSuccess:Boolean):void {
			this.isResponse = isResponseSuccess;
		}
		
		public function toString():String {
			return strResponse;
		}
	}
}