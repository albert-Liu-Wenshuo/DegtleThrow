//
//  LWSModelDegtleThrow.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelDegtleThrow.h"

@implementation LWSModelDegtleThrow

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    [super setValuesForKeysWithDictionary:[keyedValues valueForKey:@"threadsort_data"]];
    [super setValuesForKeysWithDictionary:keyedValues];
}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"Ppic"]) {
        NSArray *array = [value componentsSeparatedByString:@"\""];
        for (NSString *url in array) {
            if ([url hasPrefix:@"http"]) {
                self.Ppic = url;
                break;
            }
        }
    }
    else
        [super setValue:value forKey:key];
}

@end
