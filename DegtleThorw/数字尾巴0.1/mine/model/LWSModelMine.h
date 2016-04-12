//
//  LWSModelMine.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LWSModelMine : NSObject

@property (nonatomic , copy)NSString *title;
@property (nonatomic , retain)UIImage *icon;
@property (nonatomic , assign)BOOL needLogin;

- (instancetype)initWithTitle:(NSString *)title
                         Icon:(UIImage *)icon
                    NeedLogin:(BOOL)needLogin;

+ (instancetype)modelWithTitle:(NSString *)title
                          Icon:(UIImage *)icon
                     NeedLogin:(BOOL)needLogin;

@end
