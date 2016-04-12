//
//  LWSModelCollection.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelCollection.h"
#import "ToolAboutTime.h"

@implementation LWSModelCollection

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"dateline"]) {
        self.dateline = [ToolAboutTime getTimeStrByTimeSp:value];
    }
    else
        [super setValue:value forKey:key];
}

@end
