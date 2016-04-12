//
//  LWSModelMine.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelMine.h"

@implementation LWSModelMine

- (instancetype)initWithTitle:(NSString *)title Icon:(UIImage *)icon NeedLogin:(BOOL)needLogin{
    self = [super init];
    if (self) {
        self.title = title;
        self.icon = icon;
        self.needLogin = needLogin;
    }
    return self;
}

+ (instancetype)modelWithTitle:(NSString *)title Icon:(UIImage *)icon NeedLogin:(BOOL)needLogin{
    return [[super alloc]initWithTitle:title Icon:icon NeedLogin:needLogin];
}

@end
