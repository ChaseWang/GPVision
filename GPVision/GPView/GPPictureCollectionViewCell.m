//
//  GPPictureCollectionViewCell.m
//  GPVision
//
//  Created by wangtao on 2017/1/1.
//  Copyright © 2017年 wangtao. All rights reserved.
//

#import "GPPictureCollectionViewCell.h"

@implementation GPPictureCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.imageView setImage:nil];
}
@end
