//
//  INSlideViewManager.m
//  Insight
//
//  Created by wangtao on 14/11/11.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "INSlideViewManager.h"
#import "AppNavigationController.h"
#import "INMenuViewController.h"
#import "GPRankViewController.h"

@implementation INSlideViewManager

- (UIViewController *)slideViewController
{
    if (!_slideViewController) {
        AppNavigationController *navigationController = [[AppNavigationController alloc] initWithRootViewController:[[GPRankViewController alloc] init]];
        INMenuViewController *leftMenuViewController = [[INMenuViewController alloc] init];
        [leftMenuViewController.viewControllers setObject:navigationController forKey:kGPRANK];

        RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                        leftMenuViewController:leftMenuViewController
                                                                       rightMenuViewController:nil];
        sideMenuViewController.menuPreferredStatusBarStyle = 1;
        sideMenuViewController.delegate = self;
        sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
        sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
        sideMenuViewController.contentViewShadowOpacity = 0.6;
        sideMenuViewController.contentViewShadowRadius = 12;
        sideMenuViewController.contentViewShadowEnabled = YES;
        sideMenuViewController.scaleMenuView = NO;
        sideMenuViewController.scaleContentView = YES;
        sideMenuViewController.scaleBackgroundImageView = NO;
        sideMenuViewController.view.backgroundColor = [UIColor blackColor];
        _slideViewController = sideMenuViewController;
    }
    return _slideViewController;
}

+ (INSlideViewManager *)shareInstance
{
    static INSlideViewManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[INSlideViewManager alloc]init];
    });
    return instance;
}

#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

@end
