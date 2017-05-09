//
//  AppUser.h
//  finder
//
//  Created by jianjie Wu on 4/1/13.
//  Copyright (c) 2013 jianjie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AppUserTypeUnlogin,
    AppUserTypePhotographer,
    AppUserTypeCommonUser,
}AppUserType;

@interface AppUser : NSObject <NSCoding>
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *sessionKey;
@property (nonatomic, copy) NSString *secretKey;
@property (nonatomic, copy) NSString *weiboId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, strong) NSString *imName;
@property (nonatomic, strong) NSString *imSecret;
@property (nonatomic, assign) AppUserType identity;
@property (nonatomic, assign) CGFloat userCache;
@property (nonatomic, strong)NSString *introduction;

+ (NSString *)documentPath;
+ (NSString *)commonPath;
+ (NSString *)emotionPath;

- (BOOL)persistence;
- (BOOL)isLogin;

- (NSString *)userDocumentPath;
- (NSString *)videoSavePath;
- (void)registerCookie;
- (void)clearCookie;
- (void)logout;

+ (AppUser *)wakeUpUser;
+ (AppUser *)makeAppUser:(NSDictionary *)dict;
@end
