//
//  GPAlbumDataSource.m
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPAlbumDataSource.h"
@implementation GPAlbumItem
- (id)initWithTFHppleElement:(TFHppleElement *)element {
    self = [super init];
    if (self) {
        TFHppleElement *pathE = [[element childrenWithClassNameRecursion:@"ck-link ck-link-mask"] firstObject];
        self.path = [pathE objectForKey:@"href"];

        TFHppleElement *headUrlE = [[element childrenWithClassNameRecursion:@"ck-icon"] firstObject];
        TFHppleElement *imageE = [[headUrlE childrenWithTagName:@"img"] firstObject];
        self.imageUrl = [imageE objectForKey:@"src"];

        TFHppleElement *rankE = [[element childrenWithClassNameRecursion:@"ck-gallery-title"] firstObject];
        self.title = [rankE text];
    }
    return self;
}

@end

@implementation GPAlbumDataSource
- (void)loadData:(NSString *)index
         success:(void (^)(NSString *index, NSArray *info))success
         failure:(void (^)( NSError *error))failure {

    NSString *URLString = [NSString stringWithFormat:@"%@%@%@/",PATH,index,self.path];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//div"];
        NSMutableArray *result = [NSMutableArray array];

        for (TFHppleElement *httpElement in dataArray) {
            if ([[httpElement objectForKey:@"class"] isEqualToString:@"ck-item clickable ck-fleft"]) {
                GPAlbumItem *item = [[GPAlbumItem alloc]initWithTFHppleElement:httpElement];
                [result addObject:item];
            }
        }

        success(index, result);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
