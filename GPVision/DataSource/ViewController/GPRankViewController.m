//
//  GPRankViewController.m
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPRankViewController.h"
#import "GPRankDataSource.h"
#import "GPRankTableViewCell.h"
#import "GPAlbumViewController.h"

@interface GPRankViewController ()
@end

@implementation GPRankViewController
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"排行榜";

    [self.collectionView registerClass:[GPRankTableViewCell class] forCellWithReuseIdentifier:@"GPRankTableViewCell"];
}

- (GPBaseDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[GPRankDataSource alloc]initWithPath:@"rank"];
    }
    return _dataSource;
}

- (void)loadNewData{
    __weak GPCollectionViewController *wself = self;
    [self.dataSource loadData:[NSString stringWithFormat:@"%d",self.page] success:^(NSString *index, NSArray *info) {
        [self.collectionView.pullToRefreshView stopAnimating];
        self.collectionView.showsInfiniteScrolling = YES;

        if (info.count == 0) {
            self.collectionView.showsInfiniteScrolling = NO;
            return;
        }

        [wself.source removeAllObjects];
        [wself.source addObjectsFromArray:info];
        wself.page++;
        [wself.collectionView reloadData];
    } failure:^(NSError *error) {

    }];
}


- (void)loadMoreData{
    __weak GPCollectionViewController *wself = self;
    [self.dataSource loadData:[NSString stringWithFormat:@"%d",self.page] success:^(NSString *index, NSArray *info) {
        [self.collectionView.infiniteScrollingView stopAnimating];

        if (info.count == 0) {
            self.collectionView.showsInfiniteScrolling = NO;
            return;
        }

        [wself.source addObjectsFromArray:info];
        wself.page++;
        [wself.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GPRankItem* item = [self.source objectAtIndex:indexPath.row];
    GPAlbumViewController *alubmVC = [[GPAlbumViewController alloc]init];
    alubmVC.path = item.path;
    [self.navigationController pushViewController:alubmVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/3 - 20, SCREEN_WIDTH/3 * 1.38);
}

#pragma mark - UICollectionViewDatasourceDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.source.count == 0) {

    }
    GPRankTableViewCell *applicantCell = (GPRankTableViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:@"GPRankTableViewCell" forIndexPath:indexPath];
    GPRankItem *item = [self.source objectAtIndex:indexPath.row];

    [applicantCell setObject:item];
    return applicantCell;
}
@end
