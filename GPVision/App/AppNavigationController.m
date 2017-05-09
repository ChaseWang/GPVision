//
//  RHCNavigationController.m
//  RenrenOfficial-iOS-Concept
//
//  Created by Will Lee on 8/29/13.
//  Copyright (c) 2013 renren. All rights reserved.
//

#import "AppNavigationController.h"

#define KEY_WINDOW [[UIApplication sharedApplication] keyWindow]
@interface AppNavigationController () {
    CGPoint startTouch;
    
    UIView *lastScreenShotView;
    UIView *blackMask;
}

@property (nonatomic, assign) BOOL isMoving;

@end

@implementation AppNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithNavigationBarClass:[UINavigationBar class] toolbarClass:[UIToolbar class]]) {
        [self pushViewController:rootViewController animated:YES];
//        UIFont *font = [UIFont fontWithName:APP_FONT_Medium size:17];
//        NSDictionary *titleTextAttributes = @{NSFontAttributeName:font,
//                                              NSForegroundColorAttributeName:UIColorFromRGB(0xffffff)};
//        self.navigationBar.titleTextAttributes = titleTextAttributes;
        self.delegate = self;
        self.navPanGestureEnabled = YES;
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIDevice isHigherIOS7] && [self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }

    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setNavigationBarColor:(UIColor *)navigationBarColor
{
    _navigationBarColor = navigationBarColor;
    UIImage *colorImage = [UIImage imageWithColor:_navigationBarColor];
    // 重新构造navigationBar的纯色图片
    [self.navigationBar setNavigationBarWithImage:colorImage];
}

#pragma mark PKResChangeStyleDelegate
- (void)changeSkinStyle:(id)sender
{
}

@end
