//
//  ToolAboutTime.m
//  数字尾巴
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ToolAboutTime.h"

@implementation ToolAboutTime

+ (NSString *)getTimeStrByTimeSp:(NSString *)timeSp{
    //时间戳转时间的方法
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp.doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date1 = [formatter stringFromDate:date];
//    NSLog(@"date1:%@",date1);
    return date1;
}


@end
