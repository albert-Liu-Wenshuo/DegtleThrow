//
//  LWSDataAlay.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InternetService.h"
#import "LWSModelFirstPage.h"
#import "LWSModelHeaderView.h"
#import "LWSModelList.h"
#import "LWSModelDegtleThrow.h"
#import "LWSModelCollection.h"
#import "LWSModelDetialThrow.h"
#import "LWSModelShowDetial.h"

/**首先要设置一个block这样在数据收集好的同时就可以同步的在对应的界面执行relodata */
typedef void(^blockArray)(NSMutableArray *results);
typedef void (^blockModel)(LWSModelDetialThrow *result);
typedef void (^blockShowModel)(LWSModelShowDetial *result);


@interface LWSDataAlay : NSObject

+ (void)getFirstPagerCellModelsByStrUrl:(NSString *)strUrl
                                Results:(blockArray)relusts;

+ (void)getFirstPagerHeaderViewModelsByStrUrl:(NSString *)strUrl
                                      Results:(blockArray)relusts;

+ (void)getCommunityPagerListDetialModelsByUrl:(NSURL *)url
                                       Results:(blockArray)relusts;

+ (void)getCommunityAuthorListDetialModelsByUrl:(NSURL *)url Results:(blockArray)relusts;

+ (void)getCommunityDegtleThrowPagerDetialByUrl:(NSURL *)url Results:(blockArray)relusts;

+ (void)getCommunityCollectionPagerDetialByStrUrl:(NSString *)url
                                           Result:(blockArray)results;

+ (void)getCommunityDetialDegtleCollectionModelByStrUrl:(NSString *)strUrl
                                                 Result:(blockModel)result;

+ (void)getCommunityShowDetialArrayByStrUrl:(NSString *)strUrl
                                    Results:(blockShowModel)results;
@end
