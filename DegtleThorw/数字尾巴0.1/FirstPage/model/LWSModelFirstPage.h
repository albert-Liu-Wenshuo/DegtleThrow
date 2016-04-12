//
//  LWSModelFirstPage.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelFirstPage : LWSBasicModel

@property (nonatomic , copy)NSString *title;
@property (nonatomic , copy)NSString *pic_url;
@property (nonatomic , copy)NSString *fromurl;
@property (nonatomic , copy)NSString *summary;
@property (nonatomic , copy)NSString *username;
//@property (nonatomic , copy)NSString *favtimes;
@property (nonatomic , copy)NSString *recommend_add ;
@property (nonatomic , strong)NSNumber *commentnum;
@property (nonatomic , copy)NSString *tag_name;
@property (nonatomic , strong)NSString *dateline;

@end
