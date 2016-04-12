//
//  LWSSQLTool.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "LWSSQLModel.h"


@interface LWSSQLTool : NSObject

+ (NSMutableArray *)selectCollection:(NSString *)SQLselect;

+ (void)insertCollectionWithModel:(LWSSQLModel *)model;

+ (void)deleteCollectionWithTitle:(NSString *)title;

+ (void)deleteCollectionAllItems;

@end
