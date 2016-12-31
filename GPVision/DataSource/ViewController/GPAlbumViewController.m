//
//  GPAlbumViewController.m
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPAlbumViewController.h"
#import "GPAlbumCollectionViewCell.h"
#import "GPAlbumDataSource.h"
#import "GPPicturesViewController.h"

@interface GPAlbumViewController ()

@end

@implementation GPAlbumViewController
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"相册";

    [self.collectionView registerClass:[GPAlbumCollectionViewCell class] forCellWithReuseIdentifier:@"GPAlbumCollectionViewCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.collectionView.showsInfiniteScrolling = NO;
}

- (GPBaseDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[GPAlbumDataSource  alloc]initWithPath:@"album"];
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
