//
//  LWSModelHeaderView.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelHeaderView.h"

@implementation LWSModelHeaderView

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"url"]) {
        _url = [NSString stringWithFormat:@"http://www.dgtle.com/%@",value];
    }
    else{
        [super setValue:value forKey:key];
    }
}



@end
