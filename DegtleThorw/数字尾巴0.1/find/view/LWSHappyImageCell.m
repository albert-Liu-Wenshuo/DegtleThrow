//
//  LWSHappyImageCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHappyImageCell.h"
#import "LWSLabelSize.h"
#import "UIImageView+WebCache.h"

@interface LWSHappyImageCell ()

@property (nonatomic , retain)UILabel *labelTitle;
@property (nonatomic , retain)UIImageView *imageShow;
@property (nonatomic , retain)UILabel *labelDigest;
@property (nonatomic , retain)UILabel *labelRepiies;
@property (nonatomic , retain)UILabel *labelTags;
@property (nonatomic , retain)UIView *showView;

@end

@implementation LWSHappyImageCell

- (void)setModel:(LWSModelHappy *)model{
    _model = model;
    _labelTitle.text = _model.title;
    [_imageShow sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc] placeholderImage:[UIImage imageNamed:@"Deg_HappyImageCell.jpg"]];
    _labelTags.text = [NSString stringWithFormat:@"%@",_model.TAGS];
    if (_model.user_count) {
        CGFloat number = _model.user_count / 10000;
        _labelRepiies.text = [NSString stringWithFormat:@"%.1f万参与",number];
    }
    _labelDigest.text = _model.digest;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelDigest = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelRepiies = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelTags = [[UILabel alloc]initWithFrame:CGRectZero];
        self.imageShow = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.showView = [[UIView alloc]initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.showView];
        [self.showView addSubview:self.labelDigest];
        [self.showView addSubview:self.labelRepiies];
        [self.showView addSubview:self.labelTags];
        [self.showView addSubview:self.labelTitle];
        [self.showView addSubview:self.imageShow];
        
        self.contentView.backgroundColor = [UIColor grayColor];
        self.showView.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    frame.size.height -= 10;
    self.showView.frame = frame;
    
    frame = self.showView.frame;
    self.labelTitle.frame = CGRectMake(10, 10, frame.size.width - 20, 20);
    
    UIImage *test = [UIImage imageNamed:@"Deg_HappyImageCell.jpg"];
    CGFloat height = (self.labelTitle.frame.size.width / test.size.width) * test.size.height;
    self.imageShow.frame = CGRectMake(10 , self.labelTitle.frame.size.height + 20, self.labelTitle.frame.size.width, height);
    
    UIFont *font = [UIFont systemFontOfSize:15.0];
    self.labelDigest.frame = CGRectMake(10, self.showView.frame.size.height - 50, self.labelTitle.frame.size.width, 40);
    self.labelDigest.numberOfLines = 2;
    self.labelDigest.textColor = [UIColor darkGrayColor];
    self.labelDigest.font = font;
    
    font = [UIFont systemFontOfSize:14.0];
    CGFloat width = [LWSLabelSize getLabelWidthByLabelFont:font LabelText:self.model.TAGS];
    if (width > 10) {
        width += 5;
    }
    CGFloat OriX = self.contentView.frame.size.width - 10 - width;
    CGFloat OriY = self.showView.frame.size.height - 25;
    self.labelTags.frame = CGRectMake(OriX, OriY, width, 20);
    self.labelTags.textColor = [UIColor blueColor];
    self.labelTags.layer.borderColor = [UIColor blackColor].CGColor;
    self.labelTags.layer.borderWidth = 1;
    self.labelTags.layer.cornerRadius = 5;
    self.labelTags.textAlignment = NSTextAlignmentCenter;
    self.labelTags.font = font;
    
    width = [LWSLabelSize getLabelWidthByLabelFont:font LabelText:self.labelRepiies.text];
    if (width > 10) {
        width += 10;
    }
    OriX -= width + 10;
    self.labelRepiies.frame = CGRectMake(OriX, OriY, width, 20);
    self.labelRepiies.layer.cornerRadius = 10;
    self.labelRepiies.layer.borderColor = [UIColor grayColor].CGColor;
    self.labelRepiies.layer.borderWidth = 1;
    self.labelRepiies.font = font;
    self.labelRepiies.textColor = [UIColor darkGrayColor];
    self.labelRepiies.textAlignment = NSTextAlignmentCenter;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
