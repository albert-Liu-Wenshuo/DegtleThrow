//
//  LWSAudioHeader.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelAudioHeader.h"

@interface LWSAudioHeader : UIView

@property (nonatomic , retain)NSMutableArray *models;


- (instancetype)initWithFrame:(CGRect)frame
                       Models:(NSMutableArray *)models;

@end
