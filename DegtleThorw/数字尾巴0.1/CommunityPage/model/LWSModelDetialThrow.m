//
//  LWSModelDetialThrow.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelDetialThrow.h"

@implementation LWSModelDetialThrow

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"message"]) {
        NSArray *results = [value componentsSeparatedByString:@"\""];
        NSArray *temp = [results[0] componentsSeparatedByString:@"<"];
        _message = temp[0];
        _message = [self getStr:_message BackWithWords:@"&nbsp;"];
    }
    else if ([key isEqualToString:@"dateline"]){
        NSArray *array = [value componentsSeparatedByString:@">"];
        NSArray *arr2 = [array[1] componentsSeparatedByString:@"<"];
        _dateline = arr2[0];
//        if ([_dateline containsString:@"&nbsp;"]) {
//            NSArray *result = [_dateline componentsSeparatedByString:@"&nbsp;"];
//            _dateline = [NSString stringWithFormat:@"%@%@",result[0],result[1]];
//        }
        _dateline = [self getStr:_dateline BackWithWords:@"&nbsp;"];
    }
    else{
        [super setValue:value forKey:key];
    }
}

- (NSString *)getStr:(NSString *)str
       BackWithWords:(NSString *)word{
    NSString *other = @"";
    while ([str containsString:word]) {
        NSArray *result = [_dateline componentsSeparatedByString:@"&nbsp;"];
        for (int i = 0; i < result.count; i++) {
            other = [NSString stringWithFormat:@"%@%@",other,result[i]];
        }
        str = other;
    }
    return str;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"attachments"]) {
        _pics = [NSMutableArray array];
        for (NSDictionary *temp in value) {
            NSString *strUrl = [NSString stringWithFormat:@"%@%@",[temp valueForKey:@"url"],[temp valueForKey:@"attachment"]];
            [_pics addObject:strUrl];
        }
    }
    else{
//        NSLog(@"UndefinedKey : %@" , key);
    }
}

@end
