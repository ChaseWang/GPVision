//uto-merging RenrenOfficial-iOS-Concept.xcodeproj/project.pbxproj

//  AppConfig.m
//  finder
//
//  Created by jianjie Wu on 4/1/13.
//  Copyright (c) 2013 jianjie Wu. All rights reserved.
//

#import "AppConfig.h"
#import "AppKeyChain.h"

#define APPSTORE_DISTRIBUTION_BUNDLE_ID @"com.newmsg.QuickTalk"
#define INHOUSE_DISTRIBUTION_BUNDLE_ID @"com.newmsg.QuickTalk"

@implementation AppConfig

- (id)init {
    self = [super init];
    if (self != nil) {
        [self initEnv];
    }
    return self;
}


-(void)initEnv
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    // 客户端信息
    self.opApiKey = @"51a02dd4b352b33f197bac8c0075d705";
    self.opSecretKey = @"dc84da4fe8ae5d98728c285d1c831f16";
    self.clientCode = @"1.0.0";
    self.clientName = @"Insight";
    
    //应用在appStore的ID
    self.appStoreId = @"963638196";
    // 应用版本
    self.version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    //服务版本
    self.serverVersion = @"1.0.0";

    // 渠道标识
    self.fromID = @"2000505"; // 正式版 fromID
    // 发布日期
    self.pubdate = @"20120712";
    // Path for cache database file
    self.databasePath = [docDir stringByAppendingPathComponent:@"cachedb.sql"];
    // 数据版本
    self.dataVersion = 1;
    self.httpTimeout = 45;
  
    // 设备型号
    self.deviceModel = [UIDevice machineModelName];
    
    // 线上环境参数
    self.mApiUrl = @"http://online.1sight.cn/api";

    self.mTestUrl = @"http://test.api.plus.1sight.cn/api";

    self.mApiUrl = self.mTestUrl;

    self.clientType = @"iOS";

    self.clientUser = @"plus";

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSString *DeviceScreenBounds = [NSString stringWithFormat:@"%dx%d", (int)screenBounds.size.width, (int)screenBounds.size.height];
    self.deviceScreenBoundsRecord = DeviceScreenBounds;

    self.helpURL = @"http://online.1sight.cn/html/faq.html";
    self.serviceUrl = @"http://online.1sight.cn/html/term.html";
    self.appStoreUrl = @"https://itunes.apple.com/us/app/jia-zi-pai/id963638196";

    NSString *bundleID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    if ([bundleID isEqualToString:APPSTORE_DISTRIBUTION_BUNDLE_ID]) {
        self.pushID = 11;
    }
    else if ([bundleID isEqualToString:INHOUSE_DISTRIBUTION_BUNDLE_ID]){
        self.pushID = 911;
    }
    else{
        self.pushID = 911;
    }
}

- (NSString *)pushSettingEnable
{
    NSString * retString = @"false";
    
    UIRemoteNotificationType notificationType = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if ( (UIRemoteNotificationTypeBadge & notificationType)
        || (UIRemoteNotificationTypeAlert & notificationType)) {
        retString = @"true";
    }
    
    return  retString;
}

- (NSString *)udid {
    NSString * udid = [AppKeyChain sharedUUIDString];
    if (!udid) {
        udid = @"";
    }
    return udid;
}
@end
