//
//  LWSHappyerFooterView.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelHappyHeader.h"

@protocol LWSHappyerFooterViewDelegate <NSObject>

- (void)jumpToAidWebView:(NSString *)strUrl;

@end

@interface LWSHappyerFooterView : UITableViewCell

@property (nonatomic , retain)LWSModelHappyHeader *model;
@property (nonatomic , assign)id<LWSHappyerFooterViewDelegate> delegate;

@end
