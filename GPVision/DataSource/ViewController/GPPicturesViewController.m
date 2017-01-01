//
//  GPPicturesViewController.m
//  GPVision
//
//  Created by wangtao on 2017/1/1.
//  Copyright © 2017年 wangtao. All rights reserved.
//

#import "GPPicturesViewController.h"
#import "GPPictureCollectionViewCell.h"
#import "GPPicturesDataSource.h"
#import <FSBasicImage.h>
#import <FSBasicImageSource.h>

@interface GPPicturesViewController ()
@end

@implementation GPPicturesViewController

@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.name;

    [self.collectionView registerClass:[GPPictureCollectionViewCell class] forCellWithReuseIdentifier:@"GPPictureCollectionViewCell"];
}

- (GPBaseDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[GPPicturesDataSource  alloc]initWithPath:self.path];
    }
    return _dataSource;
}

- (void)loadNewData{
    __weak GPCollectionViewController *wself = self;
    [self.dataSource loadData:[NSString stringWithFormat:@"%d",self.page] success:^(NSString *index, NSArray *info) {
        [self.collectionView.pullToRefreshView stopAnimating];
        self.collectionView.showsPullToRefresh = YES;
        if (info.count == 0) {
            self.collectionView.showsInfiniteScrolling = NO;
            return;
        }

        [wself.source removeAllObjects];
        [wself.source addObjectsFromArray:info];
        wself.page++;
        [wself.collectionView reloadData];
        [wself loadMoreData];
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
        [wself loadMoreData];
    } failure:^(NSError *error) {

    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *images = [NSMutableArray array];
    [self.source enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *sUrl = obj;
        NSRange range = [sUrl rangeOfString:@"/s"];
        NSMutableString *ms = [NSMutableString stringWithString:sUrl];
        [ms deleteCharactersInRange:range];

        FSBasicImage *firstPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:ms] name:[NSString stringWithFormat:@"%ld",idx]];
        [images addObject:firstPhoto];
    }];


    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:images];
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    imageViewController.showNumberOfItemsInTitle = YES;
    [imageViewController moveToImageAtIndex:indexPath.row animated:NO];
    [self.navigationController pushViewController:imageViewController animated:YES];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/2 - 5, SCREEN_WIDTH/2 - 5);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.source.count == 0) {

    }
    GPPictureCollectionViewCell *applicantCell = (GPPictureCollectionViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:@"GPPictureCollectionViewCell" forIndexPath:indexPath];
    applicantCell.imageUrl = [self.source objectAtIndex:indexPath.row];
    return applicantCell;
}

@end
