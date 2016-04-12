//
//  LWSModelList.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelList : LWSBasicModel

@property (nonatomic , copy)NSString *tid;
@property (nonatomic , copy)NSString *authorid;
@property (nonatomic , copy)NSString *author;
@property (nonatomic , copy)NSString *subject;
@property (nonatomic , copy)NSString *dateline;
/**该类型需要通过内容1的字典获取正确的内容*/
@property (nonatomic , copy)NSString *typeid;
@property (nonatomic , copy)NSString *replies;


@end
