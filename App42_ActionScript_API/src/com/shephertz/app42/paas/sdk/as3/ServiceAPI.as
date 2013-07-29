package com.shephertz.app42.paas.sdk.as3
{
	import com.shephertz.app42.paas.sdk.as3.game.GameService;
	import com.shephertz.app42.paas.sdk.as3.game.RewardService;
	import com.shephertz.app42.paas.sdk.as3.game.ScoreBoardService;
	import com.shephertz.app42.paas.sdk.as3.game.ScoreService;
	import com.shephertz.app42.paas.sdk.as3.storage.StorageService;
	import com.shephertz.app42.paas.sdk.as3.user.UserService;
	

	public  class ServiceAPI
	{
		
		private var config : Config ;
		private var apiKey: String ;
		private var secretKey: String ;
		private var baseURL: String ;
		public function  ServiceAPI(apiKey:String,secretKey:String)
		{
			this.apiKey = apiKey;
			this.secretKey = secretKey;
			this.config = Config.getInstance();
		}
		
		
		/** 
		 * Retrieve the value of config object.
		 * @return Config object  
		 */ 
		public function  getConfig() : Config {
			return config;
		}
		
		/**
		 * Sets the value of config object
		 * @param config - Config object
		 * @see	Config
		 */
		public function  setConfig(config :Config ) : void{
			this.config = config;
		}
		
		/** 
		 * Retrieve the value of apiKey.
		 * @return apiKey - A variable of String type  
		 */ 
		public function  getApiKey(): String {
			return apiKey;
		}
		
		/**
		 * Sets the value of apiKey
		 * @param apiKey - A variable of String type
		 * 
		 */	
		public function  setApiKey(apiKey : String ) : void {
			this.apiKey = apiKey;
		}
		
		/** 
		 * Retrieve the value of secretKey.
		 * @return secretKey - A variable of String type  
		 */ 
		public function  getSecretKey() : String{
			return secretKey;
		}
		
		/**
		 * Sets the value of secretKey
		 * @param secretKey - A variable of String type
		 * 
		 */	
		public function  setSecretKey(secretKey : String ) : void{
			this.secretKey = secretKey;
		}
		
		/** 
		 * Retrieve the value of baseURL.
		 * @return Config.baseURL - A variable of String type  
		 */ 
		public function  getBaseURL() : String {
			return config.getBaseURL();
		}
		
		/**
		 * Sets the value of Config.baseURL
		 * @param protocol - A variable of String type
		 * @param host - A variable of String type
		 * @param port - A variable of Integer type
		 */	
		public function  setBaseURL(protocol : String , host : String ,port: int ) : void {
			config.setBaseURL(protocol, host, port);
			this.baseURL = config.getBaseURL();
		}
		
		/**
		 * Sets the value of Config.customcode
		 * @param url - server url
		 */
		public function  setCustomCodeURL(url : String ) : void {
			config.setCustomCodeURL(url);
		}
		
		/** 
		 * Builds the instance of GameService.
		 * @return gameService - GameService Object  
		 * @see	GameService
		 */ 
		public function  buildGameService() : GameService {
			var gameService : GameService  = new GameService(apiKey, secretKey);
			return gameService;
		}
		/** 
		 * Builds the instance of ScoreBoardService.
		 * @return scoreBoardService - ScoreBoardService Object  
		 * @see	ScoreBoardService
		 */ 
		public function  buildScoreBoardService() : ScoreBoardService {
			var scoreboardService : ScoreBoardService  = new ScoreBoardService(apiKey, secretKey);
			return scoreboardService;
		}
		
		/** 
		 * Builds the instance of ScoreService.
		 * @return scoreService - ScoreService Object  
		 * @see	ScoreService
		 */ 
		public function  buildScoreService() : ScoreService {
			var scoreService : ScoreService  = new ScoreService(apiKey, secretKey);
			return scoreService;
		}
		/** 
		 * Builds the instance of RewardService.
		 * @return rewardService - RewardService Object  
		 * @see	RewardService
		 */ 
		public function  buildRewardService() : RewardService {
			var rewardService : RewardService  = new RewardService(apiKey, secretKey);
			return rewardService;
		}
		/** 
		 * Builds the instance of StorageService.
		 * @return storageService - StorageService Object  
		 * @see	StorageService
		 */ 
		public function  buildStorageServicee() : StorageService {
			var storageService : StorageService  = new StorageService(apiKey, secretKey);
			return storageService;
		}
		/** 
		 * Builds the instance of UserService.
		 * @return userService - UserService Object  
		 * @see	UserService
		 */ 
		public function  buildUserService() : UserService {
			var userService : UserService  = new UserService(apiKey, secretKey);
			return userService;
		}
		
	}
}