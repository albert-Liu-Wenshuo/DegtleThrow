//
//  LWSClearCache.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSClearCache.h"
#import "SDImageCache.h"

@implementation LWSClearCache

+ (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return  size / 1024.0 / 1024.0;
    }
    return 0;
}

+ (float)flodersSizeAtPath:(NSString *)path{
    /**有关收藏和用户的数据库文件不会被删除也不会被计算大小 */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float summarySize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childFiles) {
            if ([fileName isEqualToString:@"user.sqlite"] || [fileName isEqualToString:@"collection.sqlite"]) {
                
            }
            else{
                NSString *childPath = [path stringByAppendingPathComponent:fileName];
                summarySize += [self fileSizeAtPath:childPath];
            }
        }
        /**获取sdWedImage框架自身缓存的计算 */
        summarySize += [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0;
        return summarySize;
    }
    return 0;
}

+(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            if ([fileName isEqualToString:@"user.sqlite"] || [fileName isEqualToString:@"collection.sqlite"]) {
                
            }
            else{
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

@end
