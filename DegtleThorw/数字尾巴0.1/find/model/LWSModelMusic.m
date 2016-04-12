//
//  LWSModelMusic.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelMusic.h"

@implementation LWSModelMusic

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
    else
        NSLog(@"forUndefinedKey = %@" , key);
}

@end
