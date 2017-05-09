//
//  AppUser.m
//  finder
//
//  Created by jianjie Wu on 4/1/13.
//  Copyright (c) 2013 jianjie Wu. All rights reserved.
//

#import "AppUser.h"

#define kAppUserInfoPath        @"user.archiver"
#define kCommonDir              @"common"
#define kEmotionDir             @"emotion"

@implementation AppUser
+ (AppUser *)makeAppUser:(NSDictionary *)dict
{
    AppUser *user = [[AppUser alloc]init];
    user.weiboId = [dict objectForKey:@"weibo_id"];
    user.userId = [dict objectForKey:@"user_id"];
    user.secretKey = [dict objectForKey:@"secret_key"];
    user.sessionKey = [dict objectForKey:@"session_key"];
    user.username = [dict objectForKey:@"user_name"];
    user.headUrl = [dict objectForKey:@"user_head_img"];
    user.imName = [dict objectForKey:@"im_name"];
    user.imSecret = [dict objectForKey:@"im_secret"];
    user.introduction = [dict objectForKey:@"introduction"];
    BOOL save = [user persistence];
    NSLog(@"save:%d",save);
    return user;
}

+ (AppUser *)wakeUpUser
{
    AppUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:[self userArchiverPath]];
    return user;
}

// App Document 路径
+ (NSString *)documentPath
{
    NSArray  *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [searchPath objectAtIndex:0];

    return path;
}

+ (NSString *)userArchiverPath
{
    NSString *path = [[self documentPath] stringByAppendingPathComponent:kAppUserInfoPath];
    return path;
}

// 公共文件夹路径
+ (NSString *)commonPath
{
    NSString *path = [[AppUser documentPath] stringByAppendingPathComponent:kCommonDir];
    [self createFilePath:path];
    return path;
}

// 表情文件夹路径
+ (NSString *)emotionPath
{
    NSString *path = [[AppUser commonPath] stringByAppendingPathComponent:kEmotionDir];

    NSFileManager *fileMgr = [NSFileManager defaultManager];

    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error = nil;
        [fileMgr  createDirectoryAtPath:path
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:&error];

        if (error) {
            NSLog(@"创建 commonPath 失败 %@", error);
        }
    }

    return path;
}

#pragma mark - NSCoding methods
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.sessionKey forKey:@"sessionKey"];
    [aCoder encodeObject:self.secretKey forKey:@"secretKey"];
    [aCoder encodeObject:self.weiboId forKey:@"weiboId"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.headUrl forKey:@"headUrl"];
    [aCoder encodeObject:self.imName forKey:@"imName"];
    [aCoder encodeObject:self.imSecret forKey:@"imSecret"];
    [aCoder encodeObject:self.introduction forKey:@"introduction"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [self init])
    {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.sessionKey = [aDecoder decodeObjectForKey:@"sessionKey"];
        self.secretKey = [aDecoder decodeObjectForKey:@"secretKey"];
        self.weiboId = [aDecoder decodeObjectForKey:@"weiboId"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.headUrl = [aDecoder decodeObjectForKey:@"headUrl"];
        self.imName = [aDecoder decodeObjectForKey:@"imName"];
        self.imSecret = [aDecoder decodeObjectForKey:@"imSecret"];
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
    }
	return self;
}

- (BOOL)persistence
{
    return [NSKeyedArchiver archiveRootObject:self toFile:[AppUser userArchiverPath]];
}

- (NSString *)userVideoPath
{
    NSString *path = [[self userDocumentPath] stringByAppendingPathComponent:@"shortVideo"];
    [AppUser createFilePath:path];
    return path;
}

// 用户路径
- (NSString *)userDocumentPath
{
    NSString *path = [[AppUser documentPath] stringByAppendingPathComponent:[self.userId stringValue]];
    [AppUser createFilePath:path];
    return path;
}

- (NSString *)videoSavePath
{
    NSString *path = [self.userDocumentPath stringByAppendingPathComponent:@"video"];
    [AppUser createFilePath:path];
    return path;
}

+ (BOOL)createFilePath:(NSString *)path
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];

    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error = nil;
        [fileMgr  createDirectoryAtPath:path
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:&error];

        if (error) {
            return NO;
        }
    }
    return YES;
}

// 是否登录
- (BOOL)isLogin{
    if (self.sessionKey.length && self.secretKey.length > 0) {
        return YES;
    }
    return NO;
}

- (void)registerCookie
{
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *keys = [NSArray arrayWithObjects:NSHTTPCookieDomain, NSHTTPCookieName, NSHTTPCookieValue, NSHTTPCookiePath, nil];
//    NSArray *objects = [NSArray arrayWithObjects:@".renren.com", @"mt", [NSString stringWithFormat:@"%@", APPCONTEXT.currentUser.ticket], @"/", nil];
//    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dict];
//    [storage setCookie:cookie];
//
//    objects = [NSArray arrayWithObjects:@".renren.com", @"t", [NSString stringWithFormat:@"%@", APPCONTEXT.currentUser.web_ticket], @"/", nil];
//    dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//    cookie = [NSHTTPCookie cookieWithProperties:dict];
//    [storage setCookie:cookie];
    NSLog(@"Cookies :%@", [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
}

// 主用户注销 Cookie
- (void)clearCookie{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieJar deleteCookie:cookie];
    }
}

- (void)logout
{
    self.weiboId = @"";
    self.userId = @(0);
    self.secretKey = @"";
    self.sessionKey = @"";
    [self persistence];
}
@end
