//
//  LWSDetialWebViewViewController.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSSQLModel.h"

@interface LWSDetialWebViewViewController : UIViewController

@property (nonatomic , copy)NSString *strUrl;
@property (nonatomic , retain)LWSSQLModel *model;

@end
