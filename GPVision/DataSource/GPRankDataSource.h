//
//  GPRankDataSource.h
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPBaseDataSource.h"

@interface GPRankItem : NSObject
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *gname;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSArray *introduce;
- (id)initWithTFHppleElement:(TFHppleElement *)element;
@end

@interface GPRankDataSource : GPBaseDataSource
@end
