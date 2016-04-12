//
//  LWSModelAudioCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelAudioCell.h"

@implementation LWSModelAudioCell

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        _summary = value;
    }
    else{
        [super setValue:value forUndefinedKey:key];
    }
}

@end
