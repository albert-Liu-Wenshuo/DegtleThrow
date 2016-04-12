//
//  LWSShowTitleCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSShowTitleCell.h"
#import "LWSLabelSize.h"

@interface LWSShowTitleCell ()

@property (nonatomic , retain)UILabel *labelTitle;

@end

@implementation LWSShowTitleCell

- (void)setTitle:(NSString *)title{
    _title = title;
    self.labelTitle.numberOfLines = 0;
    self.labelTitle.text = self.title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.labelTitle];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = CGRectMake(5, 5, self.contentView.frame.size.width - 10, self.contentView.frame.size.height - 10);
    self.labelTitle.frame = frame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
