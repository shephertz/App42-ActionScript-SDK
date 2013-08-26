### Leaderboard in Snake War Sample



# Steps to use sample : 

1. [Register] (https://apphq.shephertz.com/register) with App42 platform
2. Create an app once you are on Quick start page after registration.
3. If you are already registered, login to [AppHQ] (http://apphq.shephertz.com/register/app42Login) console and create an app from App Manager Tab
4. [Download](https://github.com/shephertz/App42-ActionScript-SDK/archive/master.zip) the action script sdk .
5. Open the Sample project as flash builder project.
6. Open the App42Leaderboard.as file from your src folder.
7. Pass your apiKey and secretKey which you have receive after the success of app creation.
8. Create a game from appHq by clicking __Business service -> Game Service -> Game -> Add Game__.
9. Pass your game name and user name for which you have to score.
9. Save and run.

In App42Leaderboard.as file we have used SaveUserScore and GetTopNRankings which is explained below in design details :-

## Design Details:

## Initialize Services

```
var serviceAPI:ServiceAPI = new ServiceAPI("YOUR_API_KEY", "YOUR_SECRET_KEY");
var scoreBoardService:ScoreBoardService = serviceAPI.buildScoreBoardService();
```


## Save User Score 
Saves the User score for a game.Required Parameters

**Required Parameters**

``
gameName - Name of the game for which score has to be saved.
``
``
userName - The user for which score has to be saved
``
``
gameScore - The sore that has to be saved
``

```
var gameName:String = "gameName";	
var userName:String = "userName";
var gameScore:int = 40000;		
scoreBoardService.saveUserScore(gameName,userName,gameScore, new callback());  
public class callback implements App42Callback  
{  
	public function onException(excption:App42Exception):void  
	{  
		trace("Exception Message");  
	}  
	public function onSuccess(response:Object):void  
	{  
		var game:Game = Game(response);  
		trace("response is : " + game);
	}  
}  
```

## Get Top N Rankings
Retrieves the Top N Rankings for the specified game.Required Parameters

**Required Parameters**

``
gameName - Name of the game for which ranks have to be fetched.
``
``
max - Maximum number of records to be fetched
``

```
var gameName:String = "gameName";	
var max:int = 5;
scoreBoardService.getTopNRankings(gameName,max, new callback());  
public class callback implements App42Callback  
{  
	public function onException(excption:App42Exception):void  
	{  
		trace("Exception Message");  
	}  
	public function onSuccess(response:Object):void  
	{  
		var game:Game = Game(response);  
		trace("response is : " + game);
	}  
}  
```
