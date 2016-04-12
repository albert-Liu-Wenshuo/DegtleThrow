//
//  LWSModelCommunityList.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

/**设计一个模型包含属性title和url 
   但是目前没有找到相关的url，只能自己写
 */

@interface LWSModelCommunityList : NSObject

@property (nonatomic , copy)NSString *title;
@property (nonatomic , copy)NSString *url;

- (instancetype)initWithTitle:(NSString *)title
                          Url:(NSString *)strUrl;

+ (instancetype)modelCommunityWithTitle:(NSString *)title
                                    Url:(NSString *)strUrl;

@end
