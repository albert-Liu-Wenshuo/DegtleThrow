//
//  LWSModelHappy.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelHappy : LWSBasicModel

@property (nonatomic , copy)NSString *title;
@property (nonatomic , copy)NSString *digest;
@property (nonatomic , retain)NSNumber *replyCount;
@property (nonatomic , copy)NSString *imgsrc;
@property (nonatomic , copy)NSString *TAGS;
@property (nonatomic , retain)NSNumber *imgType;
@property (nonatomic , assign)NSInteger user_count;
@property (nonatomic , retain)NSNumber *hasHead;
@property (nonatomic , copy)NSString *url;

@end
