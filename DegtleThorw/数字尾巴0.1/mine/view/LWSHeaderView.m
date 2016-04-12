//
//  LWSHeaderView.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHeaderView.h"
#import "LWSJudgeLogin.h"

@implementation LWSHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHeaderView];
    }
    return self;
}

- (void)createHeaderView{
    CGFloat height = self.frame.size.height - 20;
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, height, height)];
    [self addSubview:iconView];
    iconView.image = [UIImage imageNamed:@"Deg_Login"];
    iconView.layer.cornerRadius = height / 2;
    /**使iamgeView的形状跟随layer */
    iconView.layer.masksToBounds = YES;
    iconView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnIconImage)];
    [iconView addGestureRecognizer:tap];
    
    CGRect frame = iconView.frame;
    frame.origin = CGPointMake(frame.origin.x + frame.size.width + 10, (self.frame.size.height - 30) / 2.0);
    frame.size = CGSizeMake(60, 30);
    self.labelSign = [[UILabel alloc]initWithFrame:frame];
    self.labelSign.text = @"未登录";
    self.labelSign.textColor = [UIColor darkGrayColor];
    self.labelSign.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:self.labelSign];
    
    frame.origin = CGPointMake(self.frame.size.width - 80, (self.frame.size.height - 20) / 2.0);
    frame.size = CGSizeMake(60, 20);
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:frame];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    loginBtn.backgroundColor = [UIColor blueColor];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(clickOnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    frame.origin = CGPointMake(frame.origin.x - 80, frame.origin.y);
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:frame];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    registerBtn.backgroundColor = [UIColor whiteColor];
    [registerBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(clickOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerBtn];

}

- (void)clickOnButton:(UIButton *)sender{
    if ([LWSJudgeLogin isLogin]) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"登录提示" message:@"您已经登陆 , 是否还进行下列操作" preferredStyle:UIAlertControllerStyleAlert];
        if ([sender.titleLabel.text isEqualToString:@"登陆"]) {
            [alertView addAction:[UIAlertAction actionWithTitle:@"切换新用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"userName"];
                [self.delegate jumpToLoginPager];
            }]];
        }else if ([sender.titleLabel.text isEqualToString:@"注册"]){
            [alertView addAction:[UIAlertAction actionWithTitle:@"注册用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"userName"];
                [self.delegate jumpToRegisterPAger];
            }]];
        }
        [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self.delegate jumpByAlertView:alertView];
    }
    else{
        if ([sender.titleLabel.text isEqualToString:@"登陆"]) {
            [self.delegate jumpToLoginPager];
        }else if ([sender.titleLabel.text isEqualToString:@"注册"]){
            [self.delegate jumpToRegisterPAger];
        }
    }
}

- (void)tapOnIconImage{
    [self.delegate jumpToLoginPager];
}

@end
