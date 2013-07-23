package com.shephertz.app42.paas.sdk.as3
{
	

	public class Config {
		
		private static var config : Config;
		private var protocol:String = "http://";
		private var baseURL:String ;
		private var serverName:String  = "/App42_API_SERVER/cloud/";
		private var contentType:String  = "application/json";
		private var accept:String  = "application/json";
	
		private var  customCodeURL:String =  null;
		
		public function Config()  {
			this.baseURL = "https://api.shephertz.com/cloud/";
			this.customCodeURL = "https://customcode.shephertz.com/";
			App42Log.debug("Configuration Properties " + this.baseURL);
		}
		
		public static function   getInstance():Config {
			if (config == null) {
				
					config = new Config();
				
			}
			return config;
		}
		
		
		
		public function setProtocol(protocol:String ):void {
			this.protocol = protocol;
		}
		
		public function getProtocol():String {
			return this.protocol;
		}
		
		public  function setServerName(serverName:String ) : void{
			this.serverName = serverName;
		}
		
		public function getServerName() : String {
			return this.serverName;
		}
		
		public function setBaseURL(protocol : String , host : String , port: int ) : void {
			this.baseURL = protocol + host + ":" + port + serverName;
		}
		
		public function  getBaseURL() : String {
			return this.baseURL;
		}
		
		public function  setContentType(contentType : String ): void {
			this.contentType = contentType;
		}
		
		public function getContentType() : String{
			return this.contentType;
		}
		
		public function setAccept(accept : String ) : void{
			this.accept = accept;
		}
		
		public function getAccept() : String {
			return this.accept;
		}
		
		public function  getCustomCodeURL()  : String{
			return customCodeURL;
		}
		
		public function setCustomCodeURL(customCodeURL:String ) :void{
			this.customCodeURL = customCodeURL;
		}
	}
}