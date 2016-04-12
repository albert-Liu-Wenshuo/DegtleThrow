//
//  LWSClearCache.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWSClearCache : NSObject

+ (float)fileSizeAtPath:(NSString *)path;

+ (float)flodersSizeAtPath:(NSString *)path;

+(void)clearCache:(NSString *)path;

@end
