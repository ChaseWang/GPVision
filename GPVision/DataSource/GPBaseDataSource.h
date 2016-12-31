//
//  GPBaseDataSource.h
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPBaseDataSource : NSObject
@property (nonatomic, readonly) NSString *path;

- (id)initWithPath:(NSString *)path;
- (void)loadData:(NSString *)index
         success:(void (^)(NSString *index, NSArray *info))success
         failure:(void (^)( NSError *error))failure;
@end
