//
//  GPAlbumDataSource.h
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPBaseDataSource.h"

@interface GPAlbumItem : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *path;
- (id)initWithTFHppleElement:(TFHppleElement *)element;
@end

@interface GPAlbumDataSource : GPBaseDataSource

@end
