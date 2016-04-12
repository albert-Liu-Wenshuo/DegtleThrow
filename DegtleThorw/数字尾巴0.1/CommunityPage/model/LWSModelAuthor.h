//
//  LWSModelAuthor.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWSModelAuthor : NSObject
/*
 需要设置的属性：name ， 贴子板块的网址 ， 收藏板块的网址
 
 */

@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *forunUrl;
@property (nonatomic , copy)NSString *collectionUrl;

- (instancetype)initWithName:(NSString *)name
                    ForunUrl:(NSString *)forunUrl
               CollectionUrl:(NSString *)collectionUrl;

+ (instancetype)modelAuthorWithName:(NSString *)name
                           ForunUrl:(NSString *)forunUrl
                      CollectionUrl:(NSString *)collectionUrl;

@end
