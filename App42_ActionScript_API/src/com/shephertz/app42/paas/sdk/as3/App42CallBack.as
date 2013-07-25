package com.shephertz.app42.paas.sdk.as3
{
	public interface App42CallBack
	{
		function onSuccess(object:Object):void;
		function onException(exception:App42Exception):void;
	}
}