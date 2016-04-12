//
//  LWSDataAlay.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSDataAlay.h"

@implementation LWSDataAlay

+ (void)getFirstPagerCellModelsByStrUrl:(NSString *)strUrl
                                Results:(blockArray)relusts{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *returnData = [bigDic valueForKey:@"returnData"];
        NSDictionary *articlelist = [returnData valueForKey:@"articlelist"];
        for (NSString *tempKey in articlelist) {
            NSDictionary *temp = [articlelist valueForKey:tempKey];
            [array addObject:[LWSModelFirstPage modelWithDic:temp]];
        }
        relusts(array);
    }];
}


+ (void)getFirstPagerHeaderViewModelsByStrUrl:(NSString *)strUrl Results:(blockArray)relusts{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *returnData = [bigDic valueForKey:@"returnData"];
        NSDictionary *blocklist = [returnData valueForKey:@"blocklist"];
        NSDictionary *keyDic = [blocklist valueForKey:@"274"];
        for (NSString *tempKey in keyDic) {
            NSDictionary *temp = [keyDic valueForKey:tempKey];
            [array addObject:[LWSModelHeaderView modelWithDic:temp]];
        }
        relusts(array);
    }];
}

+ (void)getCommunityPagerListDetialModelsByUrl:(NSURL *)url Results:(blockArray)relusts{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:[NSString stringWithFormat:@"%@",url] Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *returnData = [bigDic valueForKey:@"returnData"];
        
        /**获取通过typeid确定类型的字典 */
        NSDictionary *types = [returnData valueForKeyPath:@"forum.threadtypes.types"];
        
        NSArray *threadlist = [returnData valueForKey:@"threadlist"];
        for (NSDictionary *temp in threadlist) {
            LWSModelList *model = [LWSModelList modelWithDic:temp];
            model.typeid = [types valueForKey:model.typeid];
            [array addObject:model];
        }
        relusts(array);
    }];
}

+ (void)getCommunityAuthorListDetialModelsByUrl:(NSURL *)url Results:(blockArray)relusts{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:[NSString stringWithFormat:@"%@",url] Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *returnData = [bigDic valueForKey:@"returnData"];
        NSDictionary *threadlist = [returnData valueForKey:@"threadlist"];
        for (NSString *str in threadlist) {
            NSDictionary *temp = [threadlist valueForKey:str];
            LWSModelList *model = [LWSModelList modelWithDic:temp];
            [array addObject:model];
        }
        relusts(array);
    }];
}

+ (void)getCommunityDegtleThrowPagerDetialByUrl:(NSURL *)url Results:(blockArray)relusts{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:[NSString stringWithFormat:@"%@",url] Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *threadlist = [bigDic valueForKey:@"threadlist"];
        for (NSString *str in threadlist) {
            NSDictionary *temp = [threadlist valueForKey:str];
            LWSModelDegtleThrow *model = [LWSModelDegtleThrow modelWithDic:temp];
            model.price = [model.threadsort_data valueForKey:@"price"];
            [array addObject:model];
        }
        relusts(array);
    }];
}

+ (void)getCommunityCollectionPagerDetialByStrUrl:(NSString *)url
                                           Result:(blockArray)results{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:url Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *threadlist = [bigDic valueForKey:@"threadlist"];
        for (NSString *key in threadlist) {
            NSDictionary *temp = [threadlist valueForKey:key];
            NSDictionary *thread_data = [temp valueForKey:@"thread_data"];
            [array addObject:[LWSModelCollection modelWithDic:thread_data]];
        }
        results(array);
    }];
}

+ (void)getCommunityDetialDegtleCollectionModelByStrUrl:(NSString *)strUrl
                                                 Result:(blockModel)result{
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *returnData = [bigDic valueForKey:@"returnData"];
        NSArray *postlist = [returnData valueForKey:@"postlist"];
//        NSDictionary *dic = [postlist valueForKey:@"0"];
//        result([LWSModelDetialThrow modelWithDic:dic]);
        LWSModelDetialThrow *model = [LWSModelDetialThrow modelWithDic:postlist[0]];
        model.optionlist = [returnData valueForKeyPath:@"threadsortshow.optionlist"];
        result(model);
    }];
}

+ (void)getCommunityShowDetialArrayByStrUrl:(NSString *)strUrl
                                    Results:(blockShowModel)results{
    /**在这里对message的文字段进行处理之后将图片插在应该差的位置 */
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *returnData = [bigDic valueForKey:@"returnData"];
        NSArray *postlist = [returnData valueForKey:@"postlist"];
        NSString *message = [postlist[0] valueForKey:@"message"];
        /**通过拼网址将attachments中的网址数据获取 */
        NSMutableArray *pics = [NSMutableArray array];
        NSArray *attachments = [postlist valueForKey:@"attachments"];
        for (NSDictionary *contains in attachments[0]) {
            [pics addObject:[NSString stringWithFormat:@"%@%@",[contains valueForKey:@"url"] , [contains valueForKey:@"attachment"]]];
        }
        
        /**通过换行符将文字段截断 */
        NSArray *wordArray = [message componentsSeparatedByString:@"<br />"];
        LWSModelShowDetial *model = [[LWSModelShowDetial alloc]init];
        NSInteger picTime = 0;
        for (int i = 0; i < wordArray.count; i++) {
            /**将截断的文字分类为图片相关 ， 文字相关 ， 无用 */
            if ([[LWSDataAlay kindOfWordsContains:wordArray[i]] isEqualToString:@"jpg"]) {
                /**iamges的存储整体上是一个字典，然后key是对应word的段下标转化成的字符 值是网址 */
                NSNumber *number = [NSNumber numberWithInteger:model.titles.count];
                NSString *key = [NSString stringWithFormat:@"%@",number];
                [model.imageUrls addObject:@{key : pics[picTime]}];
                picTime ++;
            }
            else if ([[LWSDataAlay kindOfWordsContains:wordArray[i]] isEqualToString:@"str"]){
                [model.titles addObject:wordArray[i]];
            }
        }
        results(model);
    }];
}

+ (NSString *)kindOfWordsContains:(NSString *)words{
    if ([words containsString:@".jpg"]) {
        return @"jpg";
    }
    else if ([words containsString:@"<blockquote>"]){
        return @"nothing";
    }
    else if ([words containsString:@"<"]){
        return @"nothing";
    }
    else
        return @"str";
}


@end
