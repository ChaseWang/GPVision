//
//  INMenuCell.m
//  Insight
//
//  Created by wangtao on 14/12/10.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "INMenuCell.h"

@implementation INMenuCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setFont:[UIFont boldSystemFontOfSize:19]];
        [self.textLabel setTextAlignment:NSTextAlignmentLeft];
        [self.textLabel setTextColor:kAppCommonTextColor];
        self.backgroundColor = kAppBgCommonColor;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.width = SCREEN_WIDTH;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setSelectedColor:selected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self setSelectedColor:selected];
}

- (void)setSelectedColor:(BOOL)selected
{
    if (selected) {
        [self.textLabel setTextColor:kAppCommonColor];
    }else{
        [self.textLabel setTextColor:kAppCommonTextColor];
    }
}
@end
