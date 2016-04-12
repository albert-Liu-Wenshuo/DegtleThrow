//
//  LWSSingleManager.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LWSSingleManager : NSObject

@property (nonatomic , retain)AVPlayer *musicPlayer;
@property (nonatomic , retain)AVPlayer *moviePlayer;

+ (instancetype)shanreSingleManager;

- (void)musicPlayWithUrl:(NSURL *)url;

@end
