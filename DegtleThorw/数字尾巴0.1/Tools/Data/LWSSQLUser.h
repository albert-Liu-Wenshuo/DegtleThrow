//
//  LWSSQLUser.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWSUserModel.h"

@interface LWSSQLUser : NSObject


+ (BOOL)insertUserWithModel:(LWSUserModel *)model;

+ (void)deleteUserWithName:(NSString *)name;

+ (void)deleteUserAllItems;

+ (NSMutableArray *)selectUserByName:(NSString *)name;

@end
