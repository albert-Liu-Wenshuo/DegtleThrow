//
//  LWSUserModel.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWSUserModel : NSObject

@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *password;
@property (nonatomic , copy)NSString *email;

- (instancetype)initWithName:(NSString *)name
                    Password:(NSString *)password
                       Email:(NSString *)email;

+ (instancetype)modelWithName:(NSString *)name
                     Password:(NSString *)password
                        Email:(NSString *)email;

@end
