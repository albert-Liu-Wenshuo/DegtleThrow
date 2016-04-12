//
//  LWSModelDegtleThrow.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelDegtleThrow : LWSBasicModel

@property (nonatomic , copy)NSString *tid;
@property (nonatomic , copy)NSString *subject;
@property (nonatomic , copy)NSString *price;
@property (nonatomic , copy)NSString *PTime;
@property (nonatomic , copy)NSString *PContact;
@property (nonatomic , copy)NSString *Ppic;
@property (nonatomic , retain)NSDictionary *threadsort_data;

@end
