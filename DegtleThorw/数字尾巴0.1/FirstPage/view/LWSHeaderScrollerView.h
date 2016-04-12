//
//  LWSHeaderScrollerView.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 
 需要一个模型用来承接轮播图的属性：（包括标题，图片网址和详情网址）
 */

@protocol HeaderScrollerViewDelegate <NSObject>

- (void)getDetialUrl:(NSString *)strUrl
               Title:(NSString *)title;

@end

@interface LWSHeaderScrollerView : UIView

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , assign)id delegate;

- (instancetype)initWithFrame:(CGRect)frame
                        Model:(NSMutableArray *)models;

@end
