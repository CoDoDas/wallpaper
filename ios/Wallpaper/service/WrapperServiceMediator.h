//
//  WrapperServiceMediator.h
//  WallWrapper ( https://github.com/kysonzhu/wallpaper.git )
//
//  Created by zhujinhui on 14-12-27.
//  Copyright (c) 2014年 zhujinhui( http://kyson.cn ). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MGNetworkServiceMediator.h>

#define HOST_PICSHOW @"http://app.zol.com.cn/bizhi"

#define SERVICENAME_RECOMMENDEDDETAIL   @"corp/bizhiClient/getGroupPic.php"

#define SERVICENAME_CATEGORYLIST        @"corp/bizhiClient/getCateInfo.php"
//category
#define SERVICENAME_CATEGORYRECOMMENDEDLIST         @"corp/bizhiClient/getGroupInfo.php"
#define SERVICENAME_CATEGORYHOTESTLIST              @"SERVICENAME_CATEGORYHOTESTLIST"
#define SERVICENAME_CATEGORYLATESTLIST              @"SERVICENAME_CATEGORYLATESTLIST"
//second category
#define SERVICENAME_CATEGORYSECONDARY           @"SERVICENAME_CATEGORYSECONDARY"

#define SERVICENAME_SECONDARYCATEGORYRECOMMENDEDLIST         @"SERVICENAME_SECONDARYCATEGORYRECOMMENDEDLIST"
#define SERVICENAME_SECONDARYCATEGORYHOTESTLIST              @"SERVICENAME_SECONDARYCATEGORYHOTESTLIST"
#define SERVICENAME_SECONDARYCATEGORYLATESTLIST              @"SERVICENAME_SECONDARYCATEGORYLATESTLIST"


#define SERVICENAME_SEARCHGETSEARCHRESULTLIST              @"SERVICENAME_SEARCHGETSEARCHRESULTLIST"

#define SERVICENAME_APPCONFIG              @"appConfig"




@interface WrapperServiceMediator : MGNetworkServiceMediator

@end
