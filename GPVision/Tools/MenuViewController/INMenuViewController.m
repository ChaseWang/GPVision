//
//  INMenuViewController.m
//  Insight
//
//  Created by wangtao on 14/11/11.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "INMenuViewController.h"
#import "INMenuCell.h"
#import "AppNavigationController.h"
#import "GPRankViewController.h"
#import "GPGalleryViewController.h"
#import "INSlideViewManager.h"
#import "GPWebViewController.h"

@interface INMenuViewController ()
@property (nonatomic, strong) NSDictionary *viewControllerForKey;
@property (nonatomic, strong) UIView *tableViewHeaderView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *keys;
@end

@implementation INMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kAppBgCommonColor;
    [self.tableView setBackgroundColor:kAppBgCommonColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.tableHeaderView = self.tableViewHeaderView;
    self.tableView.height -= self.bottomView.height;

    [self.view addSubview:self.bottomView];
    self.dataSource = [NSMutableArray arrayWithObjects:@"排行榜", @"新人", @"WEB",nil];
    self.keys = [NSMutableArray arrayWithObjects:kGPRANK, kGPGELLARY, kGPWEBVIEW,nil];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    }
    return _tableView;
}

- (UIView *)tableViewHeaderView
{
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 97)];
        UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"insight"]];
        logoView.left = 15;
        logoView.top = 52;
        [_tableViewHeaderView addSubview:logoView];
    }
    return _tableViewHeaderView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - 70, self.view.width, 70)];
        [_bottomView setBackgroundColor:[UIColor clearColor]];
        UIButton *settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width - 39, 24, 22, 22)];
        [settingBtn setImage:[UIImage imageNamed:@"setting"]];
        [settingBtn addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
        [lineView setBackgroundColor:RGBCOLOR(0x33, 0x2e, 0x2e)];
        [_bottomView addSubview:lineView];

        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 0, 200, 18)];
        nameLabel.top = (_bottomView.height - nameLabel.height)/2.0;
        [nameLabel setTextColor:RGBCOLOR(0xa3, 0xa3, 0xa3)];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [nameLabel setText:@"黑瞳君"];
        [nameLabel setText:APPCONTEXT.currentUser.username];
        [_bottomView addSubview:nameLabel];

        UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 40, 40)];
        headView.top = (_bottomView.height - headView.height)/2.0;
        [headView.layer setCornerRadius:20];
        [headView.layer setBorderWidth:2.0];
        [headView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [headView setImageWithURL:[NSURL URLWithString:APPCONTEXT.currentUser.headUrl]];
        headView.clipsToBounds = YES;
        [_bottomView addSubview:headView];

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBottomView:)];
        [tapGesture setNumberOfTapsRequired:1];
        [_bottomView addGestureRecognizer:tapGesture];
        tapGesture.delegate = self;

        [_bottomView addSubview:settingBtn];
    }
    return _bottomView;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (void)tapBottomView:(UIGestureRecognizer *)gesture
{
    //INUserInfoViewController *userInfoVC = [[INUserInfoViewController alloc]init];
    //[AppNavigator showModalNavigationController:userInfoVC animated:YES];
}

- (void)settingButtonClick:(id)sender
{
}


#pragma mark-tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.keys objectAtIndex:indexPath.row];
    NSString *vcName = [self.viewControllerForKey objectForKey:key];
    AppNavigationController *navi = [self.viewControllers objectForKey:key];
    if (!navi) {
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        navi = [[AppNavigationController alloc]initWithRootViewController:vc];
    }
    [self.viewControllers setObject:navi forKey:key];
    [[INSlideViewManager shareInstance].slideViewController setContentViewController:navi];
    [[INSlideViewManager shareInstance].slideViewController hideMenuViewController];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *activityMenuCell = @"activityMeunCell";

    INMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:activityMenuCell];
    if (cell == nil) {
        cell = [[INMenuCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:activityMenuCell];
    }

    cell.textLabel.text =[self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 49.0f;
    }
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = 65;
    if (section == 0) {
        headerHeight = 49;
    }

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width - 20, headerHeight)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, tableView.width, 49)];
    titleLabel.top = headerView.height - titleLabel.height;
    titleLabel.text = @"";
    [titleLabel setTextColor:RGBCOLOR(0xa3, 0xa3, 0xa3)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
    [headerView addSubview:titleLabel];
    return headerView;
}


- (NSDictionary *)viewControllerForKey
{
    if (!_viewControllerForKey) {
        _viewControllerForKey = @{kGPRANK:@"GPRankViewController",
                                  kGPGELLARY:@"GPGalleryViewController",
                                  kGPWEBVIEW:@"GPWebViewController"
                                  };
    }
    return _viewControllerForKey;
}

- (NSMutableDictionary *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [NSMutableDictionary dictionary];
    }
    return _viewControllers;
}

@end
