//
//  LWSHappyFirstCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHappyFirstCell.h"
#import "UIImageView+WebCache.h"
#import "LWSLabelSize.h"

@interface LWSHappyFirstCell ()

@property (nonatomic , retain)UIImageView *picView;
@property (nonatomic , retain)UILabel *labelSign;
@property (nonatomic , retain)UILabel *labelTitle;

@end

@implementation LWSHappyFirstCell

/** 
 执行顺序是：先初始化，然后setmodel中为属性赋值最后在layoutSubview中修改尺寸（调用调高的协议方法就一定会调用layoutSubview）
 */
- (void)setModel:(LWSModelHappy *)model{
    _model = model;
    _labelTitle.text = model.title;
    _labelSign.text = model.TAGS;
    [_picView sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc] placeholderImage:[UIImage imageNamed:@"Deg_HappyFirstPic.jpg"]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelSign = [[UILabel alloc]initWithFrame:CGRectZero];
        _picView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_picView addSubview:_labelSign];
        [_picView addSubview:_labelTitle];
        [self.contentView addSubview:_picView];
    }
    return self;
}

- (void)layoutSubviews{
    /**
     设置pic的尺寸铺满屏幕。可能不对
     */
    [super layoutSubviews];
    CGRect frame = self.picView.frame;
    frame = self.contentView.frame;
    self.picView.frame = frame;
    
    //设置tag的位置(尺寸是15)
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CGFloat width = 5 + [LWSLabelSize getLabelWidthByLabelFont:font LabelText:self.labelSign.text];
    self.labelSign.textAlignment = NSTextAlignmentCenter;
    self.labelSign.frame = CGRectMake(20, frame.size.height - 25, width, 15);
    self.labelSign.layer.borderColor = [UIColor whiteColor].CGColor;
    self.labelSign.layer.borderWidth = 1;
    self.labelSign.textColor = [UIColor whiteColor];
    self.labelSign.layer.cornerRadius = 5;
    self.labelSign.font = font;
    
    //设置标题的尺寸
    frame = self.labelSign.frame;
    frame.origin.x += frame.size.width + 10;
    frame.size.width = 5 + [LWSLabelSize getLabelWidthByLabelFont:font LabelText:self.labelTitle.text];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.frame = frame;
    self.labelTitle.font = font;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
