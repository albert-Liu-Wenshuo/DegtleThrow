//
//  LWSFailedAlert.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSFailedAlert.h"

@implementation LWSFailedAlert

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.alpha = 0.7;
        [self createDeyialView];
    }
    return self;
}

- (void)createDeyialView{
    CGRect rect = self.frame;
    CGRect frame = CGRectMake(0, 0, rect.size.width / 3.0 * 2, 30);
    self.label = [[UILabel alloc]initWithFrame:frame];
    self.label.center = self.center;
    self.label.font = [UIFont boldSystemFontOfSize:19.0];
    self.label.text = @"注册失败";
    [self addSubview:self.label];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor redColor];
}


@end
