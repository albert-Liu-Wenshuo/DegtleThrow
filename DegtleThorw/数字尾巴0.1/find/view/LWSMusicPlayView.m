//
//  LWSMusicPlayView.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSMusicPlayView.h"
#import "UIImageView+WebCache.h"
#import "LWSSingleManager.h"

@interface LWSMusicPlayView ()

@property (nonatomic , retain)UIImageView *MyAuthorIcon;
@property (nonatomic , retain)UILabel *MyAuthorLabel;
@property (nonatomic , retain)UIButton *MyPlayBtn;
@property (nonatomic , retain)UIButton *MyNextBtn;

@end

@implementation LWSMusicPlayView

- (void)setModel:(LWSModelMusic *)model{
    _model = model;
    /**在这里将模型中的数据铺出来 */
    [self.MyAuthorIcon sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"Deg_MusicHolder"]];
    self.MyAuthorLabel.text = model.album;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createDetialView];
    }
    return self;
}

- (void)createDetialView{
    /** 创建全部的组件*/
    CGRect frame = self.frame;
    self.MyAuthorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, frame.size.height - 10, frame.size.height - 10)];
    [self addSubview:self.MyAuthorIcon];
    
    self.MyAuthorLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.MyAuthorIcon.frame.size.width + self.MyAuthorIcon.frame.origin.x + 10, 10, frame.size.width / 2.0, 20)];
    [self addSubview:self.MyAuthorLabel];
    self.MyAuthorLabel.textAlignment = NSTextAlignmentCenter;
    self.MyAuthorLabel.textColor = [UIColor darkGrayColor];
    
    CGFloat height = self.MyAuthorIcon.frame.size.height - 30;
    self.MyPlayBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.MyAuthorLabel.frame.origin.x + self.MyAuthorIcon.frame.size.width +5, self.MyAuthorLabel.frame.origin.y + self.MyAuthorLabel.frame.size.height, height, height)];
    [self.MyPlayBtn addTarget:self action:@selector(clickOnBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.MyPlayBtn.selected = NO;
    [self.MyPlayBtn setBackgroundImage:[UIImage imageNamed:@"icon_disc_play_pressed@2x"] forState:UIControlStateNormal];
    [self addSubview:self.MyPlayBtn];
    
    frame = self.MyPlayBtn.frame;
    frame.origin.x = self.frame.size.width - height - 30;
    self.MyNextBtn = [[UIButton alloc]initWithFrame:frame];
    [self.MyNextBtn setBackgroundImage:[UIImage imageNamed:@"playBar_next"] forState:UIControlStateNormal];
    [self.MyNextBtn addTarget:self action:@selector(clickOnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.MyNextBtn];
}


- (void)clickOnBtn:(UIButton *)sender{
    if ([sender isEqual:self.MyPlayBtn]) {
        if ([sender isSelected]) {
            [[LWSSingleManager shanreSingleManager].musicPlayer play];
            [sender setBackgroundImage:[UIImage imageNamed:@"icon_disc_play_pressed@2x"] forState:UIControlStateNormal];
        }
        else{
            [[LWSSingleManager shanreSingleManager].musicPlayer pause];
            [sender setBackgroundImage:[UIImage imageNamed:@"colorring_stop"] forState:UIControlStateNormal];
        }
        sender.selected = !sender.selected;
    }
    if ([sender isEqual:self.MyNextBtn]) {
        /**
         通过block将 下一曲模型的请求传递给vc
         */
        self.myBlock(LWSMUSICONNEXT);
    }
}

@end
