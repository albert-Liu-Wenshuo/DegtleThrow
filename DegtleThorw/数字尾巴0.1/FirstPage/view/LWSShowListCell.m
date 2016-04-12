//
//  LWSShowListCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSShowListCell.h"
#import "ToolAboutTime.h"

@implementation LWSShowListCell

@synthesize model = _model;

- (LWSModelFirstPage *)model{
    if (_model == nil) {
        _model = [[LWSModelFirstPage alloc]init];
    }
    return _model;
    
}

- (void)setModel:(LWSModelFirstPage *)model{
    _model = model;
    [_imageViewPic sd_setImageWithURL:[NSURL URLWithString:_model.pic_url] placeholderImage:[UIImage imageNamed:@"showlistPic.jpg"]];
    _labelUserName.text = _model.username;
    _labelDateLine.text = [ToolAboutTime getTimeStrByTimeSp:_model.dateline];
    _labelTitle.text = _model.title;
    _labelSummary.text = _model.summary;
    if (_model.recommend_add != nil) {
        _labelRecommend.text = [NSString stringWithFormat:@"点赞 %@ ",_model.recommend_add];
    }
    if (_model.commentnum != nil) {
        _labelCommentnum.text = [NSString stringWithFormat:@"评论 %@",_model.commentnum];
    }
    _labelTagName.text = _model.tag_name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
