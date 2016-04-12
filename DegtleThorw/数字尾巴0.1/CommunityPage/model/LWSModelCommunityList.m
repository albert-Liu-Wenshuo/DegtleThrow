//
//  LWSModelCommunityList.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSModelCommunityList.h"

@implementation LWSModelCommunityList

- (instancetype)initWithTitle:(NSString *)title Url:(NSString *)strUrl{
    self = [super init];
    if (self) {
        self.title = title;
        self.url = strUrl;
    }
    return self;
}

+ (instancetype)modelCommunityWithTitle:(NSString *)title Url:(NSString *)strUrl{
    return [[super alloc] initWithTitle:title Url:strUrl];
}


@end
