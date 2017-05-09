//
//  GPGalleryViewController.m
//  GPVision
//
//  Created by wangtao on 2017/1/2.
//  Copyright © 2017年 wangtao. All rights reserved.
//

#import "GPGalleryViewController.h"

@interface GPGalleryViewController ()

@end

@implementation GPGalleryViewController

@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"广场";

    [self.collectionView registerClass:[GPAlbumCollectionViewCell class] forCellWithReuseIdentifier:@"GPAlbumCollectionViewCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (GPBaseDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[GPAlbumDataSource  alloc]initWithPath:@"/gallery/"];
    }
    return _dataSource;
}

- (void)loadNewData{
    __weak GPCollectionViewController *wself = self;
    [self.dataSource loadData:self.path success:^(NSString *index, NSArray *info) {
        [self.collectionView.pullToRefreshView stopAnimating];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GPAlbumItem* item = [self.source objectAtIndex:indexPath.row];
    GPPicturesViewController *picVC = [[GPPicturesViewController alloc]init];
    picVC.path = item.path;
    picVC.name = item.title;
    [self.navigationController pushViewController:picVC animated:YES];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.source.count == 0) {

    }
    GPAlbumCollectionViewCell *applicantCell = (GPAlbumCollectionViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:@"GPAlbumCollectionViewCell" forIndexPath:indexPath];
    GPAlbumItem *item = [self.source objectAtIndex:indexPath.row];

    [applicantCell setObject:item];
    return applicantCell;
}

@end
