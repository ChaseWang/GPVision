//
//  GPRankTableViewCell.m
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#import "GPRankTableViewCell.h"

@implementation GPRankTableViewCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
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

- (void)setObject:(GPRankItem *)object {
    _object = object;
    [self.imageView setImageWithURL:[NSURL URLWithString:object.headUrl]];
    self.nameLabel.text = object.gname;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.imageView setImage:nil];
}
@end
