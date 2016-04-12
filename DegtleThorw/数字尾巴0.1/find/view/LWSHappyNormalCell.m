//
//  LWSHappyNormalCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHappyNormalCell.h"
#import "UIImageView+WebCache.h"
#import "LWSLabelSize.h"

@interface LWSHappyNormalCell ()

@property (nonatomic , retain)UIImageView *iconView;
@property (nonatomic , retain)UILabel *labelTitle;
@property (nonatomic , retain)UILabel *labelSummary;
@property (nonatomic , retain)UILabel *labelReplaies;
@property (nonatomic , retain)UILabel *labelTags;

@end

@implementation LWSHappyNormalCell

- (void)setModel:(LWSModelHappy *)model{
    _model = model;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc] placeholderImage:[UIImage imageNamed:@"Deg_HappyNormalPic.jpg"]];
    _labelTitle.text = _model.title;
    _labelTags.text = _model.TAGS;
    _labelSummary.text = _model.digest;
    if (_model.replyCount) {
        _labelReplaies.text = [NSString stringWithFormat:@"%@跟帖",_model.replyCount];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelSummary = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelReplaies = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelTags = [[UILabel alloc]initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelSummary];
        [self.contentView addSubview:self.labelReplaies];
        [self.contentView addSubview:self.labelTags];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.contentView.frame.size.height - 20;
    UIImage *test = [UIImage imageNamed:@"Deg_HappyNormalPic.jpg"];
    CGFloat width = (height / test.size.height) * test.size.width;
    self.iconView.frame = CGRectMake(10, 10, width, height);
    
    UIFont *font = [UIFont systemFontOfSize:16.0];
    height = 20;
    self.labelTitle.frame = CGRectMake(20 + width, 10, self.contentView.frame.size.width - 30 - width, 20);
    self.labelTitle.font = font;
    
    font = [UIFont systemFontOfSize:14.0];
    //这个尺寸可能不对
    height = 40;
    width = self.contentView.frame.size.width - self.labelTitle.frame.origin.x - 20;
    self.labelSummary.frame = CGRectMake(self.labelTitle.frame.origin.x, self.contentView.frame.size.height - 50, width, 40);
    self.labelSummary.textColor = [UIColor darkGrayColor];
    self.labelSummary.font = font;
    self.labelSummary.numberOfLines = 2;
    
    /** 
     怎么设置label的边框即颜色
     */
    
    height = 15;
    //先做tag的标签，左边就是跟帖的标签
    width = [LWSLabelSize getLabelWidthByLabelFont:font LabelText:self.labelTags.text];
    if (width > 10) {
        width += 5;
    }
    CGFloat oriY = self.contentView.frame.size.height - 25;
    CGFloat oriX = self.contentView.frame.size.width - width - 10;
    self.labelTags.frame = CGRectMake(oriX, oriY, width, 15);
    self.labelTags.textColor = [UIColor blueColor];
    self.labelTags.layer.borderColor =[UIColor blackColor].CGColor;
    self.labelTags.layer.borderWidth = 1;
    self.labelTags.layer.cornerRadius = 5;
    self.labelTags.font = font;
    self.labelTags.textAlignment = NSTextAlignmentCenter;
    
    width = [LWSLabelSize getLabelWidthByLabelFont:font LabelText:self.labelReplaies.text];
    if (width > 10) {
        width += 10;
    }
    oriX -= 10 + width;
    self.labelReplaies.frame = CGRectMake(oriX, oriY, width, 15);
    self.labelReplaies.textColor = [UIColor darkGrayColor];
    self.labelReplaies.font = font;
    /**圆角设置的可能不对*/
    self.labelReplaies.layer.cornerRadius = 7;
    self.labelReplaies.layer.borderColor = [UIColor blackColor].CGColor;
    self.labelReplaies.layer.borderWidth = 1;
    self.labelReplaies.textAlignment = NSTextAlignmentCenter;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
