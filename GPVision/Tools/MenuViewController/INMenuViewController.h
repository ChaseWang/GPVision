//
//  INMenuViewController.h
//  Insight
//
//  Created by wangtao on 14/11/11.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

@interface INMenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableDictionary *viewControllers;
@end
