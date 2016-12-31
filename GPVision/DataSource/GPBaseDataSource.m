//
//  GPBaseDataSource.m
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPBaseDataSource.h"

@implementation GPBaseDataSource
- (id)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        _path = path;
    }
    return self;
}

- (void)loadData:(NSString *)index
         success:(void (^)(NSString *index, NSArray *info))success
         failure:(void (^)( NSError *error))failure {
}
@end
