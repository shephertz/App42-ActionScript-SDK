* [Release Version 2.3](https://github.com/shephertz/App42-ActionScript-SDK/blob/master/Change_Log.md#version-23)
* [Release Version 2.2](https://github.com/shephertz/App42-ActionScript-SDK/blob/master/Change_Log.md#version-22)
* [Release Version 2.1](https://github.com/shephertz/App42-ActionScript-SDK/blob/master/Change_Log.md#version-21)
* [Release Version 2.0](https://github.com/shephertz/App42-ActionScript-SDK/blob/master/Change_Log.md#version-20)
* [Release Version 1.9](https://github.com/shephertz/App42-ActionScript-SDK/blob/master/Change_Log.md#version-19)
* [Release Version 1.8](https://github.com/shephertz/App42-ActionScript-SDK/blob/master/Change_Log.md#version-18)
* [Release Version 1.2](https://github.com/shephertz/App42-ActionScript-SDK/blob/master/Change_Log.md#version-12)


## Version 2.3

**Release Date:** 21-05-2014 

**Release Version:** 2.3

**The following features have been changed :**


```
If you are upgrading from previous version of App42_ActionScript_SDK and have used getRecordCount() method on storage service, you have to change its return type as Number instead of string, because the return type of this method is changed.

**OlD Code Snippet:
var  recordCount:String =storageResponse.getRecordCount();

**New Code Snippet :
var  recordCount:Number = storageResponse.getRecordCount();
```


**The following features have been pushed to the services :**


**PUSH NOTIFICATION SERVICE**


```
updatePushBadgeforDevice
updatePushBadgeforUser
clearAllBadgeCount
```
**SCOREBOARD SERVICE**

```
getUsersWithScoreRange
```


**This release contains the following bug fix:**

```
None
```

## Version 2.2

**Release Date:** 14-04-2014 

**Release Version:** 2.2

**The following features have been pushed :**

```
New NokiaX enum added in push DeviceType.
```

**The following features have been pushed to the services :**

**REVIEW SERVICE**

```
getAllReviewsByUser
```

**User SERVICE**

```
getUsersByProfileData
getUsersByGroup
createUserWithProfile
```

**PUSH SERVICE**

```
unsubscribeDevice
resubscribeDevice
deleteAllDevices
sendPushMessageToDevice
```


**This release contains the following bug fix:**

```
None
```



## Version 2.1

**Release Date:** 21-03-2014 

**Release Version:** 2.1

**The following features have been pushed :**

```
Meta info in UserService (getUser,getUsersByRole,getUserByEmailId) and ScoreBoardService(getTopNRankers,getTopNTargetRankers).
```


**The following features have been pushed to the services :**

**STORAGE SERVICE**

```
addOrUpdateKeys
```

**User SERVICE**

```
addJSONObject(Add Extra Information while creating user)
```

**SCOREBOARD SERVICE**

```
addJSONObject(Add Extra Information of user while saves score)
```


**This release contains the following bug fix:**

```
None
```

## Version 2.0

**Release Date:** 19-02-2014 

**Release Version:** 2.0


**The following Services have been pushed to the latest :**

```
PUSH NOTIFICATION SERVICE
```

**The following feature has been deleted to the service :**

**USER SERVICE**

```
resetUserPassword
```

**This release contains the following bug fix:**

```
None
```

## Version 1.9

**Release Date:** 06-02-2014 

**Release Version:** 1.9


**The following features have been pushed to the services :**

**USER SERVICE**

```
resetAppUserPassword
```

**STORAGE SERVICE**

```
updateDocumentByQuery
```

**REVIEW SERVICE**

```
deleteReviewByReviewId
deleteCommentByCommentId
```

**BUDDY SERVICE**

```
unFriend
deleteMessageById
deleteMessageByIds
```

**SCOREBOARD SERVICE**

```
getTopNTargetRankers
```

**This release contains the following bug fix:**

```
None
```

## Version 1.8

**Release Date:** 31-10-2013

**Release Version:** 1.8

**The following Services have been pushed to the latest :**

```
AB Testing Service
```

**This release contains the following bug fix:**

```
None
```


## Version 1.2

**Release Date:** 17-09-2013

**Release Version:** 1.2

**The following Services have been pushed to the latest :**

```
 Avatar Service
 Custom Code Service
 Message Service
 Logging Service
 Email Service
 Geo Service
 Buddy Service
 Social Service
 Session Service
 Review Service
```

**This release contains the following bug fix:**

```
None
```
