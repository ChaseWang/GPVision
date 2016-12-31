//
//  GPAlbumCollectionViewCell.m
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPAlbumCollectionViewCell.h"

@implementation GPAlbumCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];

        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 16)];
        self.nameLabel.bottom = self.imageView.bottom - 5;
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.layer.shadowColor = (__bridge CGColorRef _Nullable)(UIColorFromRGBA(0x000000, 0.6));
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}
- (void)setObject:(GPAlbumItem *)object {
    _object = object;
    [self.imageView setImageWithURL:[NSURL URLWithString:object.imageUrl]];
    self.nameLabel.text = object.title;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.imageView setImage:nil];
}
@end
