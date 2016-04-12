//
//  LWSModelHappyHeader.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelHappyHeader : LWSBasicModel

//头视图的图片网址
@property (nonatomic , copy)NSString *imgsrc;
//头视图的标题
@property (nonatomic , copy)NSString *subtitle;
//对应点击尾视图时候的跳转网址
@property (nonatomic , copy)NSString *url;

@end
