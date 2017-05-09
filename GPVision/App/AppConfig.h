//
//  AppConfig.h
//  finder
//
//  Created by jianjie Wu on 4/1/13.
//  Copyright (c) 2013 jianjie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

- (NSString *)pushSettingEnable;
- (NSString *)udid;


// copy property
//获取设备操作系统版本号
@property (nonatomic, copy) NSString *deviceScreenBoundsRecord;
// 本应用在appStore的ID
@property (nonatomic, copy) NSString* appStoreId;
// Open Platform API Key
@property (nonatomic, copy) NSString *pubdate;
// Open Platform API Key
@property (nonatomic, copy) NSString *opApiKey;
// 3G API URL
@property (nonatomic, copy) NSString *mApiUrl;

@property (nonatomic, copy) NSString *mTestUrl;
// Open Platform Secret Key
@property (nonatomic, copy) NSString *opSecretKey;
// 客户端代码，用在UA中
@property (nonatomic, copy) NSString *clientCode;
// 客户端名称，用在关于中体现
@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, copy) NSString *clientType;

@property (nonatomic, copy) NSString *clientUser;

@property (nonatomic, copy) NSString *version;

// 服务版本号
@property (nonatomic, copy) NSString *serverVersion;

// Client fromType.
@property (nonatomic, copy) NSString *fromType;
// Client fromID.
@property (nonatomic, copy) NSString *fromID;
// 设备型号
@property (nonatomic, copy) NSString *deviceModel;
// 数据库路径
@property (nonatomic, copy) NSString *databasePath;
// Client Info.
@property (nonatomic, strong) NSDictionary *clientInfo;
@property (nonatomic, copy) NSString *clientInfoJSONString;
@property (nonatomic, copy) NSString *clientInfoUniqkey;
//
@property (nonatomic, strong) NSString *misc;
// PushID
@property (nonatomic, assign) NSInteger pushID;
@property (nonatomic, assign) NSInteger dataVersion;
@property (nonatomic, assign) NSUInteger httpTimeout;

@property (nonatomic, copy) NSString *helpURL;
@property (nonatomic, strong) NSString *appStoreUrl;
@property (nonatomic, strong)NSString *serviceUrl;
@end
