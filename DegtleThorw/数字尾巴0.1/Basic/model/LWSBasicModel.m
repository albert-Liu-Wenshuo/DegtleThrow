//
//  LWSBasicModel.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@implementation LWSBasicModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic{
    return [[super alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _nId = [NSString stringWithString:value];
    }
//    else
//        NSLog(@"UndefinedKey = %@", key);
}

@end
