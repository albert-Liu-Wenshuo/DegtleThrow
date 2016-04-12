//
//  LWSUserModel.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSUserModel.h"

@implementation LWSUserModel

- (instancetype)initWithName:(NSString *)name Password:(NSString *)password Email:(NSString *)email{
    self = [super init];
    if (self) {
        self.name = name;
        self.password = password;
        self.email = email;
    }
    return self;
}

+ (instancetype)modelWithName:(NSString *)name Password:(NSString *)password Email:(NSString *)email{
    return [[super alloc]initWithName:name Password:password Email:email];
}

@end
