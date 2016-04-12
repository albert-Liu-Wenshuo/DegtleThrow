//
//  LWSComFirstPage.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelFirstPage.h"

@protocol ComFirstPagerControllerDelegate <NSObject>

- (void)getScrollerWebViewStrUrl:(NSString *)strUrl
                           Title:(NSString *)title;


@end


@interface LWSComFirstPage : UIViewController

@property (nonatomic , assign)id<ComFirstPagerControllerDelegate> delegate;

@end
