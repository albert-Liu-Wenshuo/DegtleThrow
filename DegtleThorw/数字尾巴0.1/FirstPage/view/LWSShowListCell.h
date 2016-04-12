//
//  LWSShowListCell.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelFirstPage.h"
#import "UIImageView+WebCache.h"

@interface LWSShowListCell : UITableViewCell

@property (nonatomic , retain)LWSModelFirstPage *model;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPic;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelDateLine;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSummary;
@property (weak, nonatomic) IBOutlet UILabel *labelRecommend;
@property (weak, nonatomic) IBOutlet UILabel *labelCommentnum;
@property (weak, nonatomic) IBOutlet UILabel *labelTagName;

@end
