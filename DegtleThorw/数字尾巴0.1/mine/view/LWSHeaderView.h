//
//  LWSHeaderView.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWSHeaderViewDelegate <NSObject>

- (void)jumpToRegisterPAger;
- (void)jumpToLoginPager;
- (void)jumpByAlertView:(UIAlertController *)alert;

@end

@interface LWSHeaderView : UIView

@property (nonatomic , assign)id<LWSHeaderViewDelegate> delegate;
@property (nonatomic , retain)UILabel *labelSign;

@end
