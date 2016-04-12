//
//  LWSMusicPlayView.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelMusic.h"

typedef NS_ENUM(NSUInteger, LWSMusicUseType) {
    LWSMUSICONPLAY,
    LWSMUSICONSTOP,
    LWSMUSICONNEXT,
};

typedef void(^MusicBlock)(LWSMusicUseType type);

@interface LWSMusicPlayView : UIView

@property (nonatomic , copy)MusicBlock myBlock;
@property (nonatomic , retain)LWSModelMusic *model;

@end
