//
//  LWSComDegtleThrowDetialView.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelDetialThrow.h"

@protocol LWSComDegtleThrowDetialViewDelegate <NSObject>

- (void)closeObserver;

@end

@interface LWSComDegtleThrowDetialView : UIView

@property (nonatomic , retain)LWSModelDetialThrow *model;
@property (nonatomic , retain)NSMutableArray *images;

@property (nonatomic , assign)id delegate;

@end
