//
//  LWSIrcCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSIrcCell.h"

@interface LWSIrcCell ()

@property (nonatomic , retain)UILabel *labelIrc;

@end

@implementation LWSIrcCell

- (void)setIrc:(NSString *)irc{
    _irc = irc;
    self.labelIrc.text = _irc;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelIrc = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.labelIrc];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    frame.origin = CGPointMake(0, 0);
    self.labelIrc.numberOfLines = 0;
    self.labelIrc.font = [UIFont systemFontOfSize:15.0];
    self.labelIrc.textAlignment = NSTextAlignmentCenter;
    self.labelIrc.frame = frame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
