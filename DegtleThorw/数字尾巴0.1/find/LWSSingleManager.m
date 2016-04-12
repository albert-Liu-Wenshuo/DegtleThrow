//
//  LWSSingleManager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSSingleManager.h"

@implementation LWSSingleManager

static LWSSingleManager *_instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (_instance == nil) {
        @synchronized(self) {
            if (_instance == nil) {
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

+ (instancetype)shanreSingleManager{
    if (_instance == nil) {
        @synchronized(self) {
            if (_instance == nil) {
                _instance = [[super alloc] init];
            }
        }
    }
    return _instance;
}

- (void)musicPlayWithUrl:(NSURL *)url{
    LWSSingleManager *manager = [LWSSingleManager shanreSingleManager];
    if (manager.musicPlayer == nil) {
        manager.musicPlayer = [[AVPlayer alloc]initWithURL:url];
    }
    else{
        [manager.musicPlayer replaceCurrentItemWithPlayerItem:[[AVPlayerItem alloc] initWithURL:url]];
    }
    [manager.musicPlayer play];
}

@end
