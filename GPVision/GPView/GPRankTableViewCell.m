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
    }
    return self;
}

- (void)setObject:(GPRankItem *)object {
    _object = object;
    [self.imageView setImageWithURL:[NSURL URLWithString:object.headUrl]];
}
@end
