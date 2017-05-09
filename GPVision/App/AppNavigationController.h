//
//  RHCNavigationController.h
//  RenrenOfficial-iOS-Concept
//
//  Created by Will Lee on 8/29/13.
//  Copyright (c) 2013 renren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppNavigationController : UINavigationController <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIColor *navigationBarColor;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, assign) BOOL navPanGestureEnabled;

@end
