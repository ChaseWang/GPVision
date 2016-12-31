//
//  GPCollectionViewController.h
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPBaseDataSource.h"

@interface GPCollectionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (atomic, strong)NSMutableArray *source;
@property (nonatomic, assign)int page;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)GPBaseDataSource *dataSource;

- (void)loadNewData;
- (void)loadMoreData;
@end
