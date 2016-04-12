//
//  ListCell.m
//  音乐播放器
//
//  Created by dllo on 16/1/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ListCell.h"
#import "UIImageView+WebCache.h"

@implementation ListCell

- (void)setModel:(LWSModelMusic *)model{
    _model = model;
    _textTitle.text = _model.album;
    _textWriter.text = _model.artists_name;
    [_img sd_setImageWithURL:[NSURL URLWithString:_model.picUrl] placeholderImage:[UIImage imageNamed:@"Deg_MusicHolder"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
