//
//  INSlideViewManager.h
//  Insight
//
//  Created by wangtao on 14/11/11.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RESideMenu.h"

@interface INSlideViewManager : NSObject <RESideMenuDelegate>
+ (INSlideViewManager *)shareInstance;
@property (nonatomic, strong) RESideMenu *slideViewController;
@end
