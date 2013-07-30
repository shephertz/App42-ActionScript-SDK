import com.adobe.serialization.json.JSON;
import com.shephertz.app42.paas.sdk.as3.App42CallBack;
import com.shephertz.app42.paas.sdk.as3.App42Exception;
import com.shephertz.app42.paas.sdk.as3.ServiceAPI;
import com.shephertz.app42.paas.sdk.as3.game.GameService;
import com.shephertz.app42.paas.sdk.as3.game.RewardService;
import com.shephertz.app42.paas.sdk.as3.game.ScoreBoardService;
import com.shephertz.app42.paas.sdk.as3.game.ScoreService;
import com.shephertz.app42.paas.sdk.as3.storage.StorageService;
import com.shephertz.app42.paas.sdk.as3.user.UserService;
import com.shephertz.app42.paas.sdk.as3.util.Util;

import flash.text.TextField;

var outputField:TextField = new TextField();
var passTextField:TextField = new TextField();
var emailIdTextField:TextField = new TextField();
var userTextField:TextField = new TextField();
var authUserTextField:TextField = new TextField();
var authPassTextField:TextField = new TextField();
var getUserTextField:TextField = new TextField();
var gameNameTextField:TextField = new TextField();
var gameUserNameTextField:TextField = new TextField();
var gameScoreTextField:TextField = new TextField();

var rewGameTextField:TextField = new TextField();
var rewRewardTextField:TextField = new TextField();
var rewUserNameTextField:TextField = new TextField();
var rewPointsTextField:TextField = new TextField();

var postbtn:TextField = new TextField();
var clearbtn:TextField = new TextField();
var rewardbtn:TextField = new TextField();
var earnRewardbtn:TextField = new TextField();
var getUsersbtn:TextField = new TextField();
var saveUserScorebtn:TextField = new TextField();
var getTopRankbtn:TextField = new TextField();
var authBtn:TextField = new TextField();
var AUTHUser_Name:String = "Enter User Name";
var AUTHPassword:String =  "Enter Your Password";

var User_Name:String = "Enter User Name";
var Password:String =  "Enter Your Password";
var Email_id:String =  "Enter Your EmailId";

var Get_USER_NAME:String = "Enter User Name";

var GAME_NAME:String = "Enter Game Name";
var GAME_USER_NAME:String = "Enter Game User Name";
var GAME_SCORE:String = "Enter Game Score";


var rewGAME_NAME:String = "Enter Game Name";
var rewReward_NAME:String = "Enter Reward Name";
var rewGAME_USER_NAME:String = "Enter User Name";
var rew_Points:String = "Points";

var outputTextField:TextField = new TextField();
var GREY:uint = 0x999999;
var BLACK:uint = 0x000000;
var WHITE:uint = 0xFFFFFF;
var RED:uint = 0xDF0101;
var serviceAPI:ServiceAPI ;//= new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74") ;
var gameName:String =  "testGame";
var rewardName:String =  "rewardName";
var userName1:String =  "Himanshu";
var userName:String = "Nick";
var description:String =  "description";
var gameService:GameService;
var rewardService:RewardService;
var userService:UserService;
var storageService:StorageService;
var scoreBoardService:ScoreBoardService;
var scoreService:ScoreService;

class app42CallBack implements App42CallBack{
	
	serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
	serviceAPI.setBaseURL("http://","localhost",8082);
	public function onSuccess(res:Object):void
	{
			trace("On Success In TestCase " +  Util.toString(res));
			outputField.text += "\nDBName is  ..."+  Util.toString(res)	
		}
	public function onException(excption:App42Exception):void
	{
		trace("On Exception in Test Case " +excption);
		outputField.text += "" + excption;
	}
}

class reward42CallBack implements App42CallBack{
	
	public function onSuccess(res:Object):void
	{
		var rewardObject:Object  = res["app42"]["response"]["rewards"]["reward"]
		var userName:String  = rewardObject["userName"];
		var points:int  = rewardObject["points"];
		trace("On Success In TestCase " + Util.toString(res));
		outputField.text += "User by the Name"+  userName + "have total points = " + points 
	}
	public function onException(excption:App42Exception):void
	{
		trace("On Exception in Test Case " +excption);
		outputField.text += "" + excption;
	}
}

class user42CallBack implements App42CallBack{
	
	public function onSuccess(res:Object):void
	{
		var userObject:Object = res["app42"]["response"]["users"]["user"];
		var uName:String = userObject["userName"];
		outputField.text += "User with the "+ uName + "and" + userObject["email"] + " is successfully registered with App42";
		userTextField.text = User_Name;
		passTextField.text = Password;emailIdTextField.text = Email_id;
	}
	public function onException(excption:App42Exception):void
	{
		outputField.text += "" + excption;
		userTextField.text = User_Name;
		passTextField.text = Password;emailIdTextField.text = Email_id;
	}
}


class auth42CallBack implements App42CallBack{
	serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
	serviceAPI.setBaseURL("http://","localhost",8082);
	public function onSuccess(res:Object):void
	{
		var userObject:Object = res["app42"]["response"];
		var uName:String = userObject["users"]["user"]["userName"];
		outputField.text += uName + " is successfully authenticated";
	}
	public function onException(exception:App42Exception):void
	{
		var details:Object = com.adobe.serialization.json.JSON.decode(exception.message);
		outputField.text += "Your " + details["app42Fault"]["details"];
	}
}

class storage42CallBack implements App42CallBack{
	serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
	serviceAPI.setBaseURL("http://","localhost",8082);
	public function onSuccess(res:Object):void
	{
		var userObject:Object = res["app42"]["response"]["users"]["user"];
		var uName:String = userObject["userName"];
		trace("On Success In TestCase " + res);
		outputField.text += "User with the "+ uName + "and" + userObject["email"] + " is successfully registered";
	}
	public function onException(excption:App42Exception):void
	{
		trace("On Exception in Test Case " +excption);
		outputField.text += "" + excption;
	}
}

class game42CallBack implements App42CallBack{
	serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
	serviceAPI.setBaseURL("http://","localhost",8082);
	public function onSuccess(res:Object):void
	{
		var userObject:Object = res["app42"]["response"]["users"]["user"];
		var uName:String = userObject["userName"];
		trace("On Success In TestCase " + res);
		outputField.text += "User with the "+ uName + "and" + userObject["email"] + " is successfully registered";
	}
	public function onException(excption:App42Exception):void
	{
		trace("On Exception in Test Case " +excption);
		outputField.text += "" + excption;
	}
}

package
{
	import com.shephertz.app42.paas.sdk.as3.ServiceAPI;
	
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	
	public class App42_ActionScript_Test1 extends Sprite 
	{
		public function App42_ActionScript_Test1()
		{
			
			var headerFormat:TextFormat = new TextFormat();
			headerFormat.size = 20;
			headerFormat.bold = true;
			headerFormat.align = TextFormatAlign.LEFT;
			
			var headerLine1:TextField = new TextField();
			headerLine1.defaultTextFormat = headerFormat;
			headerLine1.text = "App42 Flash LeaderBoard";
			addChild(headerLine1);           
			headerLine1.wordWrap = true;
			headerLine1.width = 300;
			headerLine1.height = 30;
			headerLine1.textColor = BLACK;
			headerLine1.x = 150;
			headerLine1.y = 0;           
						
			outputField.width = 600;
			outputField.height = 900;
			outputField.y = 250;
			addChild(outputField);
			
			
			userTextField.width = 90;
			userTextField.height = 20;
			userTextField.x = 0;
			userTextField.y = 30;
			userTextField.text = User_Name;
			userTextField.textColor = BLACK;
			userTextField.border = true;
			userTextField.type = "input";
			userTextField.addEventListener(FocusEvent.FOCUS_IN, focusHandler);
			userTextField.addEventListener(FocusEvent.FOCUS_OUT, focusHandler);
			addChild(userTextField);
			
			
			passTextField.width = 110;
			passTextField.height = 20;
			passTextField.x = 100;
			passTextField.y = 30;
			passTextField.text = Password;
			passTextField.textColor = BLACK;
			passTextField.border = true;
			passTextField.type = "input";
			passTextField.addEventListener(FocusEvent.FOCUS_IN, focusHandler);
			passTextField.addEventListener(FocusEvent.FOCUS_OUT, focusHandler);
			addChild(passTextField);
			
			emailIdTextField.width = 90;
			emailIdTextField.height = 20;
			emailIdTextField.x = 220;
			emailIdTextField.y = 30;
			emailIdTextField.text = Email_id;
			emailIdTextField.textColor = BLACK;
			emailIdTextField.border = true;
			emailIdTextField.type = "input";
			emailIdTextField.addEventListener(FocusEvent.FOCUS_IN, focusHandler);
			emailIdTextField.addEventListener(FocusEvent.FOCUS_OUT, focusHandler);
			addChild(emailIdTextField);
			
			
			postbtn.y = 30 ;
			postbtn.x = 400;
			postbtn.selectable = false;
			postbtn.width = 70;
			postbtn.height = 20;
			postbtn.background = true;
			postbtn.backgroundColor = GREY;
			postbtn.textColor = WHITE;
			postbtn.text = "Create User";
			postbtn.addEventListener(MouseEvent.CLICK,connect_click);
			addChild(postbtn);
			
			
			clearbtn.y = 350 ;
			clearbtn.x = 0;
			clearbtn.selectable = false;
			clearbtn.width = 70;
			clearbtn.height = 20;
			clearbtn.background = true;
			clearbtn.backgroundColor = GREY;
			clearbtn.textColor = WHITE;
			clearbtn.text = "Clear Log";
			clearbtn.addEventListener(MouseEvent.CLICK,clear_click);
			
			addChild(clearbtn);
			
			authUserTextField.width = 90;
			authUserTextField.height = 20;
			authUserTextField.x = 0;
			authUserTextField.y = 60;
			authUserTextField.text = AUTHUser_Name;
			authUserTextField.textColor = BLACK;
			authUserTextField.border = true;
			authUserTextField.type = "input";
			authUserTextField.addEventListener(FocusEvent.FOCUS_IN, authFocusHandler);
			authUserTextField.addEventListener(FocusEvent.FOCUS_OUT, authFocusHandler);
			addChild(authUserTextField);
			
			
			authPassTextField.width = 110;
			authPassTextField.height = 20;
			authPassTextField.x = 100;
			authPassTextField.y = 60;
			authPassTextField.text = AUTHPassword;
			authPassTextField.textColor = BLACK;
			authPassTextField.border = true;
			authPassTextField.type = "input";
			authPassTextField.addEventListener(FocusEvent.FOCUS_IN, authFocusHandler);
			authPassTextField.addEventListener(FocusEvent.FOCUS_OUT, authFocusHandler);
			addChild(authPassTextField);
			
			
			authBtn.y = 60;
			authBtn.x = 400;
			authBtn.selectable = false;
			authBtn.width = 90;
			authBtn.height = 20;
			authBtn.background = true;
			authBtn.backgroundColor = GREY;
			authBtn.textColor = WHITE;
			authBtn.text = "Authenticate User";
			authBtn.addEventListener(MouseEvent.CLICK,auth_click);
			addChild(authBtn);
			
			rewGameTextField.width = 90;
			rewGameTextField.height = 20;
			rewGameTextField.x = 0;
			rewGameTextField.y = 90;
			rewGameTextField.text = rewGAME_NAME;
			rewGameTextField.textColor = BLACK;
			rewGameTextField.border = true;
			rewGameTextField.type = "input";
			rewGameTextField.addEventListener(FocusEvent.FOCUS_IN, rewfocusHandler);
			rewGameTextField.addEventListener(FocusEvent.FOCUS_OUT, rewfocusHandler);
			addChild(rewGameTextField);
			
			
			rewUserNameTextField.width = 90;
			rewUserNameTextField.height = 20;
			rewUserNameTextField.x = 100;
			rewUserNameTextField.y = 90;
			rewUserNameTextField.text = rewGAME_USER_NAME;
			rewUserNameTextField.textColor = BLACK;
			rewUserNameTextField.border = true;
			rewUserNameTextField.type = "input";
			rewUserNameTextField.addEventListener(FocusEvent.FOCUS_IN, rewfocusHandler);
			rewUserNameTextField.addEventListener(FocusEvent.FOCUS_OUT, rewfocusHandler);
			addChild(rewUserNameTextField);
			
			rewRewardTextField.width = 102;
			rewRewardTextField.height = 20;
			rewRewardTextField.x = 200;
			rewRewardTextField.y = 90;
			rewRewardTextField.text = rewReward_NAME;
			rewRewardTextField.textColor = BLACK;
			rewRewardTextField.border = true;
			rewRewardTextField.type = "input";
			rewRewardTextField.addEventListener(FocusEvent.FOCUS_IN, rewfocusHandler);
			rewRewardTextField.addEventListener(FocusEvent.FOCUS_OUT, rewfocusHandler);
			addChild(rewRewardTextField);
			
			rewPointsTextField.width = 50;
			rewPointsTextField.height = 20;
			rewPointsTextField.x = 310;
			rewPointsTextField.y = 90;
			rewPointsTextField.text = rew_Points;
			rewPointsTextField.textColor = BLACK;
			rewPointsTextField.border = true;
			rewPointsTextField.type = "input";
			rewPointsTextField.addEventListener(FocusEvent.FOCUS_IN, rewfocusHandler);
			rewPointsTextField.addEventListener(FocusEvent.FOCUS_OUT, rewfocusHandler);
			addChild(rewPointsTextField);
			
			
			earnRewardbtn.y = 90 ;
			earnRewardbtn.x = 400;
			earnRewardbtn.selectable = false;
			earnRewardbtn.width = 90;
			earnRewardbtn.height = 20;
			earnRewardbtn.background = true;
			earnRewardbtn.backgroundColor = GREY;
			earnRewardbtn.textColor = WHITE;
			earnRewardbtn.text = "Earn Rewards";
			earnRewardbtn.addEventListener(MouseEvent.CLICK,earnReward_click);
			addChild(earnRewardbtn);
			
			
			rewardbtn.y = 350 ;
			rewardbtn.x = 200;
			rewardbtn.selectable = false;
			rewardbtn.width = 130;
			rewardbtn.height = 20;
			rewardbtn.background = true;
			rewardbtn.backgroundColor = GREY;
			rewardbtn.textColor = WHITE;
			rewardbtn.text = "Get Top Reward Earners";
			rewardbtn.addEventListener(MouseEvent.CLICK,getTopReward_click);
			addChild(rewardbtn);
			
		}
		
		private function connect_click(e:MouseEvent):void
		{ 
			serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
			serviceAPI.setBaseURL("http://","localhost",8082);
//				App42Log.setDebug(true);
			
				/********************Game , ScoreBoard, Score, Reward Service ************************/
			
				gameService = serviceAPI.buildGameService();
				scoreBoardService = serviceAPI.buildScoreBoardService();
				rewardService = serviceAPI.buildRewardService();
				scoreService = serviceAPI.buildScoreService();
				var jsonArray:Array = new Array;
//				rewardService.createReward(rewardName,userName,new reward42CallBack());
//				gameService.createGame(gameName,description,new app42CallBack());
//				scoreBoardService.saveUserScore(gameName,userName1,1200,new app42CallBack());
//				scoreBoardService.saveUserScore(gameName,userName,1200,new app42CallBack());
//				scoreService.addScore(gameName,userName,12000,new app42CallBack());
//				scoreService.deductScore(gameName,userName,1000,new app42CallBack());
				
				/********************StorageService************************/
				var jsonObject:Object = new Object;
				jsonObject.name = "himanshu";
				jsonObject.Age = 23;
				storageService = serviceAPI.buildStorageServicee();
//				storageService.insertJSONDocument("test","foo23",jsonObject,new app42CallBack());
				
				/********************UserService************************/
				
				userService = serviceAPI.buildUserService();
				userService.createUser(userTextField.text,passTextField.text,emailIdTextField.text,new user42CallBack());
//				userService.authenticate(userName,"password",new app42CallBack());
		}
		
		private function reward_click(e:MouseEvent):void
		{ 
			serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
			serviceAPI.setBaseURL("http://","localhost",8082);
//			App42Log.setDebug(true);
			rewardService = serviceAPI.buildRewardService();
//			rewardService.createReward(rewardName,userName,new reward42CallBack());
//			rewardService.earnRewards(gameName,userName1,rewardName,1200,new reward42CallBack());
//			rewardService.redeemRewards(gameName,userName,rewardName,100,new reward42CallBack());
		}
		private function get_click(e:MouseEvent):void
		{ 
			serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
			serviceAPI.setBaseURL("http://","localhost",8082);
//			App42Log.setDebug(true);
			
			/********************Game , ScoreBoard, Score, Reward Service ************************/
			gameService = serviceAPI.buildGameService();
			scoreBoardService = serviceAPI.buildScoreBoardService();
			rewardService = serviceAPI.buildRewardService();
			scoreService = serviceAPI.buildScoreService();
			var userArray:Array = new Array;
			userArray.push("Nick");
			userArray.push("John");
//			gameService.getGameByName(gameName,new app42CallBack());
//			gameService.getAllGames(new app42CallBack());
//			scoreBoardService.getHighestScoreByUser(gameName,userName,new app42CallBack());
//			scoreBoardService.getLowestScoreByUser(gameName,userName,new app42CallBack());
//			scoreBoardService.getAverageScoreByUser(gameName,userName,new app42CallBack());
//			scoreBoardService.getScoresByUser(gameName,userName,new app42CallBack());
//			scoreBoardService.getTopRankings(gameName,new app42CallBack());
//			scoreBoardService.getTopNRankings(gameName,3,new app42CallBack());
//			scoreBoardService.getUserRanking(gameName,userName,new app42CallBack());
//			scoreBoardService.getLastScoreByUser(gameName,userName,new app42CallBack());
//			scoreBoardService.getTopNRankers(gameName,3,new app42CallBack());
//			scoreBoardService.getLastGameScore(userName,new app42CallBack());
			
			
			
//			rewardService.getAllRewardsCount(new reward42CallBack());
//			rewardService.getAllRewards(new reward42CallBack());
//			rewardService.getAllRewardsByPaging(1,0,new reward42CallBack());
//			rewardService.getRewardByName(rewardName,new reward42CallBack());
//			rewardService.getGameRewardPointsForUser(gameName,userName1,new reward42CallBack());
//			rewardService.getTopNRewardEarners(gameName,rewardName,3,new reward42CallBack());
//			rewardService.getAllRewardsByUser(userName,rewardName,new reward42CallBack());
//			rewardService.getUserRankingOnReward(gameName,rewardName,userName,new reward42CallBack());
			/********************StorageService************************/
			var jsonObject:Object = new Object;
			jsonObject.name = "himanshu";
			jsonObject.Age = 23;
			storageService = serviceAPI.buildStorageServicee();
//			storageService.findAllDocuments("test","foo",new app42CallBack());
//			storageService.findAllDocumentsByPaging("test","foo",3,0,new app42CallBack());
//			storageService.findAllCollections("test",new app42CallBack());
//			storageService.findAllDocumentsCount("test","foo",new app42CallBack());
//			storageService.findDocumentById("test","foo","51f76a86b1e7cf5bc75dc6a9",new app42CallBack());
//			storageService.findDocumentByKeyValue("test","foo","name","himanshu",new app42CallBack());
			
			/********************UserService************************/
			
			userService = serviceAPI.buildUserService();
//			userService.getUser(userTextField.text,new app42CallBack());
//			userService.getAllUsers(new app42CallBack());
		}
		
		private function auth_click(e:MouseEvent):void
		{
			
			serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
			serviceAPI.setBaseURL("http://","localhost",8082);
						
			userService = serviceAPI.buildUserService();
			userService.authenticate(authUserTextField.text,authPassTextField.text,new auth42CallBack());
		}

		
		private function earnReward_click(e:MouseEvent):void
		{
			
			serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
			serviceAPI.setBaseURL("http://","localhost",8082);
			rewardService = serviceAPI.buildRewardService();
			rewardService.earnRewards(rewGameTextField.text,rewUserNameTextField.text,rewRewardTextField.text,rewPointsTextField.alpha,new reward42CallBack());
		}
		
		private function getTopReward_click(e:MouseEvent):void
		{
			
			serviceAPI = new ServiceAPI("02a75a1d13c1c7963d37d57f2ae0b572295653a8d41dd7e7c782e61224f9e5a1","6a4e1d048dc5396666e1b292ee1967aac7b24d6181699f3851867d0b98fa9c74"); ;
			serviceAPI.setBaseURL("http://","localhost",8082);
			rewardService = serviceAPI.buildRewardService();
			rewardService.getTopNRewardEarners(rewGameTextField.text,rewRewardTextField.text,rewPointsTextField.alpha,new reward42CallBack());
		}
		private function clear_click(e:MouseEvent):void
		{
			outputField.text=""; //To Clear the Text Box
		}
		
		
		private  function focusHandler(event:FocusEvent):void
		{
			switch (event.type) 
			{
				case FocusEvent.FOCUS_IN:
					if (userTextField.text == User_Name || passTextField.text == Password || emailIdTextField.text == Email_id )
						{
							userTextField.text = "";userTextField.textColor = BLACK; passTextField.text = ""; passTextField.textColor = BLACK;	emailIdTextField.text = "";	emailIdTextField.textColor = BLACK;
						}					 
				break;
				case FocusEvent.FOCUS_OUT:
					if (userTextField.text == "" && passTextField.text == "" && emailIdTextField.text == "")
						{
							userTextField.text = User_Name;passTextField.text = Password; emailIdTextField.text =Email_id;
						}
				break;
			}
		}
		private function authFocusHandler(event:FocusEvent):void
		{
			switch (event.type) 
			{
				case FocusEvent.FOCUS_IN:
					 if(authUserTextField.text == AUTHUser_Name || authPassTextField.text == AUTHPassword )
					 	{
							authUserTextField.text = "";authUserTextField.textColor = BLACK; authPassTextField.text = ""; authPassTextField.textColor = BLACK;
					 	}
				break;
				case FocusEvent.FOCUS_OUT:
					if (authUserTextField.text == "" && authPassTextField.text == "")
						{
							authUserTextField.text = AUTHUser_Name;
							authPassTextField.text = AUTHPassword;
						}
				break;
			}
		}	
		private function rewfocusHandler(event:FocusEvent):void
		{
			switch (event.type)
			{
				case FocusEvent.FOCUS_IN:
					if(rewGameTextField.text == rewGAME_NAME || rewUserNameTextField.text == rewGAME_USER_NAME || rewRewardTextField.text == rewReward_NAME || rewPointsTextField.text == "")
						{
							rewGameTextField.text = "";	rewGameTextField.textColor = BLACK; 
							rewUserNameTextField.text = ""; rewUserNameTextField.textColor = BLACK ;
							rewRewardTextField.text = "";rewRewardTextField.textColor = BLACK;
							rewPointsTextField.text = "";rewPointsTextField.textColor = BLACK;  
						}
					break;
				case FocusEvent.FOCUS_OUT:
					if (rewGameTextField.text == "" && rewUserNameTextField.text == "" && rewRewardTextField.text == "" && rewPointsTextField.text == "")
						{
							rewGameTextField.text = rewGAME_NAME; 
							rewUserNameTextField.text = rewGAME_USER_NAME;
							rewRewardTextField.text = rewReward_NAME;
							rewPointsTextField.text = rew_Points;
						}
				break;
			}
		}
	}
}