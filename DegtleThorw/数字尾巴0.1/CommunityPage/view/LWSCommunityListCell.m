//
//  LWSCommunityListCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSCommunityListCell.h"


#define COMUIDNotication @"communityUidUrlNotication"

@implementation LWSCommunityListCell

- (void)setModel:(LWSModelList *)model{
   if (_model != model){
        _model = model;
    }
    [_buttonAuthriod setTitle:_model.author forState:UIControlStateNormal];
    _labelDateline.text = [NSString stringWithFormat:@"%@",_model.dateline];
    _labelReplies.text = [NSString stringWithFormat:@"%@",_model.replies];
    _labelSubject.text = _model.subject;
    _buttonAuthriod.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (_model.typeid == NULL) {
        _labelTypeId.text = @"";
    }
    else
    _labelTypeId.text = [NSString stringWithFormat:@"%@",_model.typeid];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickOnAuthriodBtn:(UIButton *)sender {
    NSLog(@"=======");
    //发出通知
    NSDictionary *dic = @{@"model" : self.model};
    [[NSNotificationCenter defaultCenter] postNotificationName:COMUIDNotication object:nil userInfo:dic];
}

@end
