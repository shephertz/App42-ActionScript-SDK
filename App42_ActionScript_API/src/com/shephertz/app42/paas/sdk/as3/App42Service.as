package com.shephertz.app42.paas.sdk.as3
{
	public class App42Service 
	{
		public function onSuccess(object:String,requestCall:App42CallBack,isArray:Boolean) : void {};
		public function onException(exception:App42Exception,requestCall:App42CallBack) : void {
		};
		
	}
}