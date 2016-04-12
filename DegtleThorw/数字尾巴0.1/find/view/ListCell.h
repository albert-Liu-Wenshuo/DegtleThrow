//
//  ListCell.h
//  音乐播放器
//
//  Created by dllo on 16/1/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelMusic.h"

@interface ListCell : UITableViewCell

@property (nonatomic , retain)LWSModelMusic *model;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *textWriter;
@property (weak, nonatomic) IBOutlet UILabel *textTitle;

@end
