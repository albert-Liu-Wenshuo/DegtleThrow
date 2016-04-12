//
//  LWSLabelSize.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSLabelSize.h"

@implementation LWSLabelSize

+ (CGSize)getLabelForumSize:(NSString *)s{
    UIFont *font = [UIFont systemFontOfSize:17.0];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 10,2000);
    CGSize labelsize = [s boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return labelsize;
}

+ (CGFloat)getLabelHeightByLabelWidth:(CGFloat)width
                            LabelFont:(UIFont *)font
                            LabelText:(NSString *)text{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(width,2000);
    CGSize labelsize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return labelsize.height;
}

+ (CGFloat)getLabelWidthByLabelFont:(UIFont *)font
                          LabelText:(NSString *)text{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(414,20);
    CGSize labelsize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return labelsize.width;
}


@end
