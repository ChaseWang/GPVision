//
//  GPRankTableViewCell.h
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRankDataSource.h"

@interface GPRankTableViewCell : UICollectionViewCell
@property (nonatomic, strong)GPRankItem *object;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *rankLabel;
@end
