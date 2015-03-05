[![Overview](https://github-camo.global.ssl.fastly.net/f703c82720fddccaf01b29e8cfb7ad950fbe9efe/687474703a2f2f777777696d616765732e61646f62652e636f6d2f7777772e61646f62652e636f6d2f646f776e6c6f616463656e7465722f696d616765732f666c6173682f666c6173685f3132382e6a7067)](https://github.com/shephertz/App42-ActionScript-SDK/wiki/AS3-Home)

App42 ActionScript library for Flash and Flex applications.
===========================================================

1. [Register] (https://apphq.shephertz.com/register) with App42 platform.
2. Create an app once you are on Quick start page after registration.
3. If you are already registered, login to [AppHQ] (http://apphq.shephertz.com/register/app42Login) console and create an app from App Manager Tab.

__Download And Set Up SDK :-__

1). [Download] (https://github.com/shephertz/App42-ActionScript-SDK/archive/master.zip) ActionScript SDK

2). Unzip downloaded Zip file. Unzip folder contains version folder of swc and sample folder.

3). Version folder will contain App42_ActionScript_SDK_x.x.x.swc.

4).Add the reference of App42_ActionScript_SDK_x.x.x.swc in your project properties **(Project Properties -> Build Path -> Add swc File)**.

__Initializing SDK :-__
You have to instantiate App42API by putting your ApiKey/SecretKey to initialize the SDK.

```
App42API.initialize("YOUR_API_KEY","YOUR_SECRET_KEY"); 
```

__Using App42 Services :-__
 you have to build target service that you want to use in your app. For example, User Service can be build with following snippet. Similarly you can build other service also with same notation.
 
```
var userService:UserService = App42API.buildUserService();
//Similarly you can build other services like App42API.buildXXXXService()
```

__Documentation :__
Gift Service and File Upload API's Only for Desktop and mobile application

__SDK Structure:__
Gift Service and File Upload API's Only for Desktop and mobile application you can find the SWC file inside the (App42-ActionScript-SDK-Mobile)
For Web you can find the SWC file inside the (App42-ActionScript-SDK-Web)

