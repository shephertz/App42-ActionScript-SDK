import flash.text.TextField;

var outputField:TextField = new TextField();
var passTextField:TextField = new TextField();
var userTextField:TextField = new TextField();
var roomID:String = "1799555827";

var postbtn:TextField = new TextField();
var User_Name:String = "Enter Your UserName";
var Password:String =  "Enter Your Password";
var Email_id:String =  "Enter Your EmailId";
var GREY:uint = 0x999999;
var BLACK:uint = 0x000000;
var WHITE:uint = 0xFFFFFF;
var RED:uint = 0xDF0101;

package
{
	import com.shephertz.app42.paas.sdk.as3.ServiceAPI;
	import com.shephertz.app42.paas.sdk.as3.game.GameService;
	
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
//			userTextField.text = Email_id;
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
			
			
			
		}
		private function connect_click(e:MouseEvent):void
		{ 
			var functio:Function;
			
			var serviceAPI:ServiceAPI = new ServiceAPI("5122309e3580653903aa6750df2087c709ca61481d877c1b98cf07f1926707cf",
				"a18daafa2437afc8dbc59873a5d39a66ebe71554fee9639aaae13c86c179b1ed");
			serviceAPI.setBaseURL("http://","localhost",8082);
			
			var gameService:GameService= serviceAPI.buildGameService();
			var game:String = gameService.getGameByName("test",functio);
			
			//var game:String = gameService.createGame("test","himansbj",functio);
			trace("response from test-------------" + game);
			outputField.text += "\nResponse is------------ "+ game;
		}
	}
}