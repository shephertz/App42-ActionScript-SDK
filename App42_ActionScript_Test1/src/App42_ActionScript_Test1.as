import com.adobe.serialization.json.JSON;
import com.shephertz.app42.paas.sdk.as3.App42CallBack;
import com.shephertz.app42.paas.sdk.as3.App42Exception;
import com.shephertz.app42.paas.sdk.as3.ServiceAPI;
import com.shephertz.app42.paas.sdk.as3.game.GameService;
import com.shephertz.app42.paas.sdk.as3.game.ScoreBoardService;
import com.shephertz.app42.paas.sdk.as3.storage.StorageService;
import com.shephertz.app42.paas.sdk.as3.user.UserService;
import com.shephertz.app42.paas.sdk.as3.util.Util;

import flash.text.TextField;

var outputField:TextField = new TextField();
var passTextField:TextField = new TextField();
var userTextField:TextField = new TextField();
var roomID:String = "1799555827";

var postbtn:TextField = new TextField();
var User_Name:String = "Enter UserName";
var Password:String =  "Enter Your Password";
var Email_id:String =  "Enter Your EmailId";
var outputTextField:TextField = new TextField();
var GREY:uint = 0x999999;
var BLACK:uint = 0x000000;
var WHITE:uint = 0xFFFFFF;
var RED:uint = 0xDF0101;
var serviceAPI:ServiceAPI ;
var gameName:String =  "testGame";
var userName:String =  "himanshu11";
var description:String =  "description";
var gameService:GameService;
var userService:UserService;
var storageService:StorageService;
var scoreBoardService:ScoreBoardService;

class app42CallBack implements App42CallBack{
	
	serviceAPI = new ServiceAPI("fb91bf00ca1c16af549b2608a8ecc779bf47d858ada8f95e85759c003b0585d3",
		"5e4ce8138bf151aefeff8d55e1648553a5a384a9b3e1936aa101424e6eb72b73");
		serviceAPI.setBaseURL("http://","localhost",8082);
	public function onSuccess(res:Object):void
	{
			trace("On Success In TestCase " +  Util.toString(res));
			outputField.text += "\nDBName is  ..."+  Util.toString(res)	
		}
	public function onException(excption:App42Exception):void
	{
		trace("On Exception in Test Case " +excption);
		outputField.text += "\nException is   ..." + excption;
	}
}
package
{
	import flash.display.Sprite;
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
			headerLine1.text = "App42 FLASH API";
			addChild(headerLine1);           
			headerLine1.wordWrap = true;
			headerLine1.width = 250;
			headerLine1.height = 30;
			headerLine1.textColor = BLACK;
			headerLine1.x = 0;
			headerLine1.y = 0;           
			
			
			var headerLine2:TextField = new TextField();
			headerLine2.defaultTextFormat = headerFormat;
			headerLine2.text = "User Module";
			addChild(headerLine2);           
			headerLine2.wordWrap = true;
			headerLine2.width = 200;
			headerLine2.height = 25;
			headerLine2.textColor = BLACK;
			headerLine2.x = 0;
			headerLine2.y = 30;  
			
			
			outputField.width = 600;
			outputField.height = 900;
			outputField.y = 55;
			addChild(outputField);
			
			userTextField.width = 265;
			userTextField.height = 30;
			userTextField.x = 220;
			userTextField.text = User_Name;
			userTextField.textColor = BLACK;
			userTextField.border = true;
			userTextField.type = "input";
			addChild(userTextField);
			
			
			passTextField.width = 265;
			passTextField.height = 30;
			passTextField.x = 220;
			passTextField.y = 40;
			passTextField.text = Password;
			passTextField.textColor = BLACK;
			passTextField.border = true;
			passTextField.type = "input";
			addChild(passTextField);
			
			
			postbtn.y = passTextField.height + passTextField.y + 10;
			postbtn.x = 220;
			postbtn.selectable = false;
			postbtn.width = 60;
			postbtn.height = 25;
			postbtn.background = true;
			postbtn.backgroundColor = GREY;
			postbtn.textColor = WHITE;
			postbtn.text = "Post API";
			postbtn.addEventListener(MouseEvent.CLICK,connect_click);
			addChild(postbtn);
//			connect_click(null);
			
		}

		private function connect_click(e:MouseEvent):void
		{ 

//				App42Log.setDebug(true);
				/********************Game , ScoreBoard Service ************************/
				gameService = serviceAPI.buildGameService();
				scoreBoardService = serviceAPI.buildScoreBoardService();
				
//				scoreBoardService.getTopRankingsByGroup(gameName,jsonArray,new app42CallBack());
//				gameService.createGame(gameName,description,new app42CallBack());
//				gameService.getGameByName(gameName,new app42CallBack());
//				gameService.getAllGames(new app42CallBack());
				
				/********************StorageService************************/
				var jsonObject:Object = new Object;
				jsonObject.name = "himanshu";
				jsonObject.Age = 23;
				storageService = serviceAPI.buildStorageServicee();
//				storageService.insertJSONDocument("test","foo",jsonObject,new app42CallBack());
				
				
				
				/********************UserService************************/
				userService = serviceAPI.buildUserService();
//				userService.createUser(userName,"password",userName+"@gmail.com",new app42CallBack());
				userService.getUser(userName,new app42CallBack());
		}
	}
}