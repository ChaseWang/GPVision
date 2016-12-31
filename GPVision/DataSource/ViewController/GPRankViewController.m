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

@interface GPRankViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)GPRankDataSource *dataSource;
@property (nonatomic, strong)NSMutableArray *source;
@property (nonatomic, assign)int page;
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation GPRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"排行榜";

    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:fl];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[GPRankTableViewCell class] forCellWithReuseIdentifier:@"GPRankTableViewCell"];
    [self.view addSubview:self.collectionView];

    self.source = [NSMutableArray array];
    self.dataSource = [[GPRankDataSource alloc]initWithPath:@"rank"];
    [self.dataSource loadData:[NSString stringWithFormat:@"%d",self.page] success:^(NSString *index, NSArray *info) {
        [self.source addObjectsFromArray:info];
        self.page++;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {

    }];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GPRankItem* item = [self.source objectAtIndex:indexPath.row];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/3 - 20, SCREEN_WIDTH/3 * 1.38);
}

#pragma mark - UICollectionViewDatasourceDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.source.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPRankTableViewCell *applicantCell = (GPRankTableViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:@"GPRankTableViewCell" forIndexPath:indexPath];
    GPRankItem *item = [self.source objectAtIndex:indexPath.row];

    [applicantCell setObject:item];
    return applicantCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
