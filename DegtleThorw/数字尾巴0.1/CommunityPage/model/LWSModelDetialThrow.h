//
//  LWSModelDetialThrow.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelDetialThrow : LWSBasicModel

@property (nonatomic , copy)NSString *username;
@property (nonatomic , copy)NSString *dateline;
@property (nonatomic , copy)NSString *message;
@property (nonatomic , copy)NSString *email;
@property (nonatomic , retain)NSMutableArray *pics;
@property (nonatomic , retain)NSArray *optionlist;

@end
