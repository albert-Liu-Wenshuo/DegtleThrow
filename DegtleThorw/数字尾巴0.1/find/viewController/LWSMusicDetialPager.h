//
//  LWSMusicDetialPager.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelMusic.h"

@protocol LWSMusicDetialPagerDelegate <NSObject>

- (LWSModelMusic *)getNextMusicModel:(LWSModelMusic *)model;

@end

@interface LWSMusicDetialPager : UIViewController

@property (nonatomic , retain)LWSModelMusic *model;
@property (nonatomic , assign)id pagerDelegate;

@end
