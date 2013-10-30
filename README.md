App42_BPaaS_ActionScript_SDK
==============

App42 BPaaS Cloud API Client SDK for ACTIONSCRIPT

- Download the App42 BPaaS ACTIONSCRIPT SDK
- Unzip the file and open **App42 ACTIONSCRIPT Sample** project.
- Add the **App42_BPaaS_ActionScript_SDK_x.x.x.swc** into library path. **Properties -> ActionScript Build Path -> Liabrary Path -> Add SWC**
- Initialize the library using :-

```
var api:ServiceAPI = new ServiceAPI("<YOUR_API_KEY>","<YOUR_SECRET_KEY>");
api.setBaseURL("<YOUR_API_SERVER_URL>");
```

- Instantiate the service that one wants to use in the App, e.g. using LeaderBoard service one has to do the following :-

```
var scoreBoardService:ScoreBoardService = api.buildScoreBoardService(); 
```

- Now one can call associated method of that service e.g. saving the score of the user can be done with the following snipped :-

```
var gameName:String = "<Enter_your_game_name>";	
var userName:String = "userName";
var gameScore:int = 40000;		
scoreBoardService.saveUserScore(gameName,userName,gameScore, new callback());  
public class callback implements App42CallBack  
{  
	public function onException(excption:App42Exception):void  
	{  
		trace("Exception : " + excption);  
	}  
	public function onSuccess(response:Object):void  
	{  
		var scoreClass:Score = new Score();
		var game:Game   = Game(res);
		trace("gameName is : " + game.getName());
		for(var i:int=0;i<game.getScoreList().length;i++)
		{
			trace("username is :  " + Score(game.getScoreList()[i]).getUserName());
			trace("value is : " + Score(game.getScoreList()[i]).getValue());
			trace("scoreId is :  " + Score(game.getScoreList()[i]).getScoreId());
		}
	}  
}  
```

- Build the project and run.
