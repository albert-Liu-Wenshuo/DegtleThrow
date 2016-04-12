//
//  LWSCommunityListCell.h
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSModelList.h"

@interface LWSCommunityListCell : UITableViewCell

@property (nonatomic , retain)LWSModelList *model;

@property (weak, nonatomic) IBOutlet UILabel *labelDateline;
@property (weak, nonatomic) IBOutlet UILabel *labelTypeId;
@property (weak, nonatomic) IBOutlet UILabel *labelReplies;
@property (weak, nonatomic) IBOutlet UIButton *buttonAuthriod;
- (IBAction)clickOnAuthriodBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelSubject;


@end
