//
//  LWSModelHappy.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelHappy.h"

@implementation LWSModelHappy


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"live_info"]) {
        _user_count = [[value valueForKey:@"user_count"] integerValue];
    }
    else
        [super setValue:value forUndefinedKey:key];
}

@end
