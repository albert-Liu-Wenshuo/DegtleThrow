//
//  LWSFirstPageController.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelFirstPage.h"

/**添加必要的代理 */
@protocol FirstPagerControllerDelegate <NSObject>

- (void)getDetialWedViewStrUrl:(NSString *)strUrl
                         Model:(LWSModelFirstPage *)model;

- (void)getScrollerWebViewStrUrl:(NSString *)strUrl
                           Title:(NSString *)title;

@end

@interface LWSFirstPageController : UIViewController

@property (nonatomic , assign)id<FirstPagerControllerDelegate> delegate;
@property (nonatomic , assign)CGFloat height;

@end
