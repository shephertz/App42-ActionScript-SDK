package com.shephertz.app42.paas.sdk.as3
{
	public class App42Response
	{
		public var isResponseSuccess:Boolean;
		
		private var strResponse:String;
		
		private var totalRecords:int = -1;
		
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
		
		
		public function setResponseSuccess(isResponseSuccess:Boolean):void {
			this.isResponseSuccess = isResponseSuccess;
		}
		
		public function toString():String {
			return strResponse;
		}
	}
}