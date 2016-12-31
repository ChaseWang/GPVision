//
//  GPAlbumCollectionViewCell.h
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPAlbumDataSource.h"

@interface GPAlbumCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)GPAlbumItem *object;
@end
