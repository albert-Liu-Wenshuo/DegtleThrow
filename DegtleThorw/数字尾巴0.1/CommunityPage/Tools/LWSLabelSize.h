//
//  LWSLabelSize.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LWSLabelSize : NSObject

+ (CGSize)getLabelForumSize:(NSString *)s;

+ (CGFloat)getLabelHeightByLabelWidth:(CGFloat)width
                            LabelFont:(UIFont *)font
                            LabelText:(NSString *)text;

@end
