//
//  GPPicturesDataSource.m
//  GPVision
//
//  Created by wangtao on 2017/1/1.
//  Copyright © 2017年 wangtao. All rights reserved.
//

#import "GPPicturesDataSource.h"

@implementation GPPicturesDataSource
- (void)loadData:(NSString *)index
         success:(void (^)(NSString *index, NSArray *info))success
         failure:(void (^)( NSError *error))failure {

    NSString *URLString = [NSString stringWithFormat:@"%@%@%@.html",PATH,self.path,index];
    if (index.integerValue == 0 || index.integerValue == 1) {
        URLString = [NSString stringWithFormat:@"%@%@",PATH,self.path];
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//div"];
        NSMutableArray *result = [NSMutableArray array];

        for (TFHppleElement *httpElement in dataArray) {
            if ([[httpElement objectForKey:@"class"] isEqualToString:@"ck-parent-div"]) {
                TFHppleElement *imageE = [[httpElement childrenWithTagName:@"img"] firstObject];
                [result addObject:[imageE objectForKey:@"src"]];
            }
        }

        success(index, result);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
