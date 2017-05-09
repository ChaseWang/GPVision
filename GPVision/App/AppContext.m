
//
//  AppContext.m
//  finder
//
//  Created by jianjie Wu on 4/1/13.
//  Copyright (c) 2013 jianjie Wu. All rights reserved.
//

#import "AppContext.h"
#import "AppKeyChain.h"

static AppContext *_appContext = nil;

@implementation AppContext
@synthesize currentUser = _user;
@synthesize config = _config;
@synthesize hudHelper = _hudHelper;
@synthesize uniqueKeyChain = _uniqueKeyChain;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (AppContext *)getInstance {
    @synchronized (self) {
        
        if (!_appContext) {
            _appContext = [[self alloc] init];
        }
        return _appContext;
        
    }
}

- (id)init {
    self = [super init];
    if (self){
    }
    return self;
}


- (AppConfig *)config
{
    if (!_config) {
        _config = [[AppConfig alloc]init];
    }
    return _config;
}

- (HudHelper *)hudHelper
{
    if (!_hudHelper) {
        _hudHelper = [HudHelper getInstance];
    }
    return _hudHelper;
}


- (void)resetForUserLogIn{
    if (self.currentUser && [self.currentUser.userId integerValue] > 0) {
    }
}

- (void)logout{

}

- (void)userLogin{
    [self loginChat];
}

- (void)loginChat{
}

- (NSString *)uniqueKeyChain{
    if (!_uniqueKeyChain) {
        _uniqueKeyChain = [AppKeyChain sharedUUIDString];
    }
    return _uniqueKeyChain;
}
@end
