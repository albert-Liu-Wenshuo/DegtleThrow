//
//  LWSModelFirstPage.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelFirstPage.h"

@implementation LWSModelFirstPage


- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"fromurl"]) {
        _fromurl = [NSString stringWithFormat:@"http://www.dgtle.com/%@",value];
    }
    else if ([key isEqualToString:@"dateline"]){
        if (![value isKindOfClass:[NSString class]]) {
            _dateline = [NSString stringWithFormat:@"%@",value];
        }
    }
    else{
        [super setValue:value forKey:key];
    }
}


@end
