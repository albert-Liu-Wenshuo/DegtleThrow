//
//  LWSJudgeLogin.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSJudgeLogin.h"

@implementation LWSJudgeLogin

+ (BOOL)isLogin{
    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    if (userName == nil) {
        return NO;
    }
    else if ([userName isEqualToString:@""]){
        return NO;
    }
    else
        return YES;
}

+ (NSString *)getLoginUserName{
    if ([LWSJudgeLogin isLogin]) {
        NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
        return userName;
    }
    else
        return nil;
}

@end
