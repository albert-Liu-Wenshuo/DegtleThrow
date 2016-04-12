//
//  LWSCollectionViewCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface LWSCollectionViewCell ()

@property (nonatomic , retain)UIImageView *imageViewPic;
@property (nonatomic , retain)UILabel *labelSummary;
@property (nonatomic , retain)UILabel *labelPhone;
@property (nonatomic , retain)UILabel *labelDataLine;
@property (nonatomic , retain)UILabel *labelPrice;

@end

@implementation LWSCollectionViewCell

- (void)setModel:(LWSModelDegtleThrow *)model{
    _model = model;
    [self.imageViewPic sd_setImageWithURL:[NSURL URLWithString:self.model.Ppic] placeholderImage:[UIImage imageNamed:@"showlistPic"]];
    CGRect frame = self.labelSummary.frame;
    frame.size.width = self.contentView.frame.size.height - 20;
    self.labelSummary.frame = frame;
    self.labelSummary.text = self.model.subject;
    self.labelDataLine.text = self.model.PTime;
    self.labelPrice.text = [NSString stringWithFormat:@"￥%@",self.model.price];
    self.labelPhone.text = self.model.PContact;

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createDetialView];
        [self changeFontAndColor];
    }
    return self;
}

- (void)createDetialView{
    CGRect rect = self.contentView.frame;
    CGRect frame = CGRectMake(10, 5, rect.size.width - 20, rect.size.height / 3.0 * 2 - 10);
    self.imageViewPic = [[UIImageView alloc]initWithFrame:frame];
    [self.contentView addSubview:self.imageViewPic];
    
    
    CGFloat height = rect.size.height / 9.0;
    CGFloat width = rect.size.width / 5.0 * 3;
    frame = CGRectMake(10, 5 + height * 6, width - 20, height - 10);
    self.labelSummary = [[UILabel alloc]initWithFrame:frame];
    [self.contentView addSubview:self.labelSummary];
    
    frame.origin.y += height;
    self.labelPhone = [[UILabel alloc]initWithFrame:frame];
    [self.contentView addSubview:self.labelPhone];
    
    frame.origin.y += height;
    self.labelDataLine = [[UILabel alloc]initWithFrame:frame];
    [self.contentView addSubview:self.labelDataLine];
    
    frame.origin.x = width + 10;
    frame.size.width = width / 3.0 * 2 - 20;
    self.labelPrice = [[UILabel alloc]initWithFrame:frame];
    [self.contentView addSubview:self.labelPrice];
}

- (void)changeFontAndColor{
    self.labelSummary.font = [UIFont boldSystemFontOfSize:14.0];
    self.labelPhone.font = [UIFont systemFontOfSize:13.0];
    self.labelDataLine.font = [UIFont systemFontOfSize:14.0];
    self.labelPrice.font = [UIFont systemFontOfSize:14.0];
    
    self.labelSummary.textColor = [UIColor darkGrayColor];
    self.labelPhone.textColor = [UIColor darkGrayColor];
    self.labelPrice.textColor = [UIColor redColor];
}



@end
