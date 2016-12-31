//
//  GPRankDataSource.m
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPRankDataSource.h"
@implementation GPRankItem
- (id)initWithTFHppleElement:(TFHppleElement *)element {
    self = [super init];
    if (self) {
        TFHppleElement *headUrlE = [[element childrenWithClassNameRecursion:@"ck-icon-left"] firstObject];
        TFHppleElement *imageE = [[headUrlE childrenWithTagName:@"img"] firstObject];
        self.headUrl = [imageE objectForKey:@"src"];

        TFHppleElement *nameE = [[element childrenWithClassNameRecursion:@"ck-title"] firstObject];
        self.gname = nameE.firstChild.content;

        TFHppleElement *pathE = [[element childrenWithClassNameRecursion:@"ck-link ck-link-mask"] firstObject];
        self.path = [pathE objectForKey:@"href"];

        TFHppleElement *rankE = [[element childrenWithClassNameRecursion:@"ck-rank-num"] firstObject];
        TFHppleElement *spanE = [[rankE childrenWithTagName:@"span"] firstObject];
        self.rank = [spanE text];
    }
    return self;
}
@end

@implementation GPRankDataSource
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
    NSString *indexPath = @"";
    if (index.integerValue != 0) {
        indexPath = [index stringByAppendingString:@".html"];
    }
    
    NSString *URLString = [[PATH stringByAppendingPathComponent:self.path] stringByAppendingPathComponent:indexPath];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//div"];
        NSMutableArray *result = [NSMutableArray array];

        for (TFHppleElement *httpElement in dataArray) {
            if ([[httpElement objectForKey:@"class"] isEqualToString:@"ck-initem"]) {
                GPRankItem *item = [[GPRankItem alloc]initWithTFHppleElement:httpElement];
                [result addObject:item];
            }
        }

        success(index, result);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
@end
