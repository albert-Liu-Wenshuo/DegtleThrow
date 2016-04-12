//
//  LWSHappyerFooterView.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHappyerFooterView.h"
#import "UIImageView+WebCache.h"

@interface LWSHappyerFooterView ()

@property (nonatomic , retain)UIButton *button;

@end

@implementation LWSHappyerFooterView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.button = [[UIButton alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.button];
        [self.button addTarget:self action:@selector(clickOnMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.button.frame = CGRectMake(0, 0, 200, 20);
    self.button.center = self.contentView.center;
    /**不知道这样的话点击按钮之后会不会因为中心点的变化而不响应 */
}

- (void)clickOnMoreBtn:(UIButton *)sender{
    /** 将跳转的对应界面的网址通过协议传过去*/
    [self.delegate jumpToAidWebView:self.model.url];
}

@end
