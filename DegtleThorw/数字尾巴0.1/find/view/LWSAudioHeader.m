//
//  LWSAudioHeader.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSAudioHeader.h"
#import "UIImageView+WebCache.h"

@interface LWSAudioHeader ()


@end

@implementation LWSAudioHeader

- (instancetype)initWithFrame:(CGRect)frame
                       Models:(NSMutableArray *)models{
    self = [super initWithFrame:frame];
    if (self) {
        self.models = models;
        /**初始化写在这里，尺寸的修改在layoutsubView中 */
        CGFloat oriX = self.frame.size.width / 4.0;
        CGFloat height = self.frame.size.height;
        for (int i = 0; i < 3; i++) {
            CGRect frame = CGRectMake(oriX - 1, 0, 1, height);
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            [self addSubview:label];
            label.backgroundColor = [UIColor grayColor];
            oriX += self.frame.size.width / 4.0;
//            NSLog(@"%f",oriX);
        }
        /**设置地下标签的label */
        oriX = 20;
        CGFloat oriY = height - 20;
        CGFloat width = self.frame.size.width / 4.0 - 40;
        height = 20;
        for (int i = 0; i < 4; i++) {
            CGRect frame = CGRectMake(oriX, oriY, width, height);
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            [self addSubview:label];
            LWSModelAudioHeader *model = self.models[i];
            label.text = model.title;
            label.textAlignment = NSTextAlignmentCenter;
            oriX += self.frame.size.width / 4.0;
        }
        width = self.frame.size.height - 40;
        CGFloat centerX = self.frame.size.width / 8.0;
        for (int i = 0; i < 4; i++) {
            CGRect frame = CGRectMake(0, 10, width , width);
            LWSModelAudioHeader *model = self.models[i];
            UIImageView *image = [[UIImageView alloc]initWithFrame:frame];
            CGPoint imgCenter = image.center;
            imgCenter.x = centerX;
            image.center = imgCenter;
            centerX += self.frame.size.width / 4.0;
            [image sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"Deg_audio_icon"]];
            image.userInteractionEnabled = YES;
            [self addSubview:image];
            /**需要在外界vc调用touchbegin方法判断是哪个image被点击 */
        }
    }
    return self;
}

@end
