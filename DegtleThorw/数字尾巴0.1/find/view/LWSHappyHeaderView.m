//
//  LWSHapptHeaderView.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHappyHeaderView.h"
#import "UIImageView+WebCache.h"

@interface LWSHappyHeaderView ()

@property (nonatomic , retain)UIImageView *headerPic;
@property (nonatomic , retain)UILabel *label;

@end

@implementation LWSHappyHeaderView

- (void)setModel:(LWSModelHappyHeader *)model{
    _model = model;
    [_headerPic sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc] placeholderImage:[UIImage imageNamed:@"Deg_happyHeaderPic.jpg"]];
//    _headerPic.image = [UIImage imageNamed:@"Deg_happyHeaderPic.jpg"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerPic = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.label = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.headerPic];
        self.headerPic.contentMode = UIViewContentModeCenter;
        self.headerPic.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.contentView.frame.size.height;
    CGFloat width = self.contentView.frame.size.width / 3.0 * 2;
    self.headerPic.frame = CGRectMake(10, 0, width, height);
    
//    self.label.frame = CGRectMake(width + 15, self.contentView.center.x, self.contentView.frame.size.width - width - 25, 1);
//    self.label.backgroundColor = [UIColor darkGrayColor];
}

@end

