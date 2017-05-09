//
//  QTTabBarController.m
//  GPVision
//
//  Created by wangtao on 2017/1/2.
//  Copyright © 2017年 wangtao. All rights reserved.
//

#import "GPTabBarController.h"
#import "GPRankViewController.h"
#import "GPGalleryViewController.h"

@interface GPTabBarController ()

@end

@implementation GPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //b.创建子控制器
    GPRankViewController *rkvc=[[GPRankViewController alloc]init];
    rkvc.tabBarItem.title=@"排行";
    rkvc.tabBarItem.image=[UIImage imageNamed:@"tab_recent_nor"];

    GPGalleryViewController *glrvc=[[GPGalleryViewController alloc]init];
    glrvc.tabBarItem.title=@"广场";
    glrvc.tabBarItem.image=[UIImage imageNamed:@"tab_recent_nor"];

    [self addChildViewController:rkvc];
    [self addChildViewController:glrvc];

    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
