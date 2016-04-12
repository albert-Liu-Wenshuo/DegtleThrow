//
//  LWSModelCollection.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelCollection : LWSBasicModel

@property (nonatomic , copy)NSString *author;
@property (nonatomic , copy)NSString *dateline;
@property (nonatomic , copy)NSString *subject;
@property (nonatomic , copy)NSString *replies;

@end
