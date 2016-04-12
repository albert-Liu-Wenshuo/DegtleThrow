//
//  LWSMineCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSMineCell.h"

@interface LWSMineCell ()

@property (nonatomic , retain)UIImageView *iconImage;
@property (nonatomic , retain)UILabel *titleLabel;
@property (nonatomic , retain)UIImageView *btnImgView;

@end

@implementation LWSMineCell

- (void)setModel:(LWSModelMine *)model{
    _model = model;
    self.iconImage.image = [self.model.icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.btnImgView.image = [[UIImage imageNamed:@"forward_icon@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.titleLabel.text = self.model.title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.btnImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.iconImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.btnImgView];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.userInteractionEnabled = YES;
        self.iconImage.userInteractionEnabled = YES;
        self.btnImgView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    frame.origin = CGPointMake(20, 10);
    frame.size = CGSizeMake(frame.size.height - 20, frame.size.height - 20);
    self.iconImage.frame = frame;
    
    
    frame.origin = CGPointMake(frame.origin.x + frame.size.width + 20, frame.origin.y);
    frame.size.height = self.contentView.frame.size.height - 20;
    frame.size.width = 200;
    self.titleLabel.frame = frame;
//    center.y = self.contentView.center.y;
//    self.titleLabel.center = center;
    
    CGFloat height = self.contentView.frame.size.height - 30;
    frame.origin = CGPointMake(self.contentView.frame.size.width - 20 - height, 15);
    frame.size = CGSizeMake(height, height);
    self.btnImgView.frame = frame;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
