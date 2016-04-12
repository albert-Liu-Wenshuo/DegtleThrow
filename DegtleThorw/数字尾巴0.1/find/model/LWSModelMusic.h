//
//  LWSModelMusic.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelMusic : LWSBasicModel

@property (nonatomic, copy)NSString *album;
@property (nonatomic, copy)NSString *artists_name;
@property (nonatomic, copy)NSString *blurPicUrl;
@property (nonatomic, assign)NSInteger duration;
@property (nonatomic, assign)NSInteger ID;
@property (nonatomic, copy)NSString *lyric;
@property (nonatomic, copy)NSString *mp3Url;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *picUrl;
@property (nonatomic, copy)NSString *singer;

@end
