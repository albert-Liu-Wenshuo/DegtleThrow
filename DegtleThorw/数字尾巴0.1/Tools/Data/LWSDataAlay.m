//
//  LWSDataAlay.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSDataAlay.h"

#define POSTBODYSTR @"apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&formhash=b7f5721a&inapi=yes&keyword=%@&platform=ios&searchsubmit=true&searchtype=portal&swh=480x800&version=2.8",title

@implementation LWSDataAlay

/**获取首页cell的模型数组 */
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

/**获取搜索界面的模型数组：需要根据提供的搜索内容拼接成post请求 */
+ (void)getSearchPageCellModelsByStrUrl:(NSString *)strUrl
                            SearchTitle:(NSString *)title
                                 Result:(blockArray)result{
    NSMutableArray *array = [NSMutableArray array];
    /**解决若搜索中出现中文的时候的将utf-8 转码成url编码的方法 */
    NSString *bodyText = [NSString stringWithFormat:POSTBODYSTR] ;
//    [ticketName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [InternetService getDataFromPostUrlMethod:strUrl UrlBody:bodyText Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *returnData = [bigDic valueForKey:@"returnData"];
        NSDictionary *articlelist = [returnData valueForKey:@"articlelist"];
        for (NSString *tempKey in articlelist) {
            NSDictionary *temp = [articlelist valueForKey:tempKey];
            [array addObject:[LWSModelFirstPage modelWithDic:temp]];
        }
        result(array);
    }];
    
}

/**获取首页头视图的模型数组 */
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

/**获取首页cell的模型数组获取社区cell的模型数组 */
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
            if (model.typeid != nil && [model.typeid containsString:@"<"]) {
                NSRange range = [model.typeid rangeOfString:@"<b>"];
                range.location = range.location + 3;
                range.length = 2;
                model.typeid = [model.typeid substringWithRange:range];
            }
            if (model.dateline.length > 9 && [model.dateline containsString:@"<"]) {
               model.dateline = [model.dateline substringWithRange:NSMakeRange(13, 9)];
            }
            [array addObject:model];
        }
        relusts(array);
    }];
}

/**获取社区作者界面的模型数组 */
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

/**获取社区甩甩尾巴板块的模型数组 */
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

/**获取社区作者板块收藏一列的模型数组 */
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

/**获取社区甩甩尾巴板框的详细信息数组 */
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

/**获取社区每个cell的二级界面的内容模型数组 */
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

/**根据字符串的内容确定内容决定是文字还是图片还是不需要显示的html内容（用于二级界面的图文混排） */
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

/**获取发现界面音乐版块的模型数组 */
+ (void)getFindMusicListByStrUrl:(NSString *)strUrl
                          Result:(blockArray)result{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation *urlOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:strUrl];
        NSArray *array = [NSArray arrayWithContentsOfURL:url];
        for (NSDictionary *item in array) {
            [dataArray addObject:[LWSModelMusic modelWithDic:item]];
        }
        result(dataArray);
    }];
    [queue addOperation:urlOperation];
}

/**获取发现界面开心一刻版块的模型数组 */
+ (void)getFindHappyListByStrUrl:(NSString *)strUrl
                          Result:(blockArray)result{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *contains;
        /**获取json字典中唯一的内容数组 */
        for (NSString *key in bigDic) {
            contains = [NSArray arrayWithArray:[bigDic valueForKey:key]];
            break;
        }
        /**当有效内容字典中出现specialextra时,内部的字典中存储的是开心一刻cell的model内容
            整体字典中包含头视图model的内容*/
        for (NSDictionary *tempDic in contains) {
            NSArray *spicalArr = [tempDic valueForKey:@"specialextra"];
            if (spicalArr != nil && spicalArr.count > 0) {
                [array addObject:[LWSModelHappyHeader modelWithDic:tempDic]];
                for (NSDictionary *dic in spicalArr) {
                    [array addObject:[LWSModelHappy modelWithDic:dic]];
                }
            }
            else{
                [array addObject:[LWSModelHappy modelWithDic:tempDic]];
            }
        }
        /**不知道这样可不可行，array中下标为一得内容是头视图模型数组
            另一个是cell的model数组*/
        result(array);
    }];
}

+ (void)getAudioHeaderListByStrUrl:(NSString *)strUrl
                            Result:(blockArray)result{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *videoSidList = [bigDic valueForKey:@"videoSidList"];
        for (NSDictionary *item in videoSidList) {
            [array addObject:[LWSModelAudioHeader modelWithDic:item]];
        }
        result(array);
    }];
}

+ (void)getAudioCellListByStrUrl:(NSString *)strUrl
                          Result:(blockArray)result{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *videoList = [bigDic valueForKey:@"videoList"];
        for (NSDictionary *item in videoList) {
            [array addObject:[LWSModelAudioCell modelWithDic:item]];
        }
        result(array);
    }];
}

+ (void)getAudioCellDetialListByStrUrl:(NSString *)strUrl
                                Result:(blockArray)result{
    NSMutableArray *array = [NSMutableArray array];
    [InternetService getDataFromGetUrlMethod:strUrl Data:^(NSData *data) {
        NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *videoList = [bigDic valueForKey:bigDic.allKeys[0]];
        for (NSDictionary *item in videoList) {
            [array addObject:[LWSModelAudioCell modelWithDic:item]];
        }
        result(array);
    }];

}




@end
