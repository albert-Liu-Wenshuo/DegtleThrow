//
//  LWSAudioCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSAudioCell.h"
#import "UIImageView+WebCache.h"

@interface LWSAudioCell ()

@property (nonatomic , retain)UILabel *labelTitle;
@property (nonatomic , retain)UILabel *labelSummary;
@property (nonatomic , retain)UIImageView *imgAudio;
@property (nonatomic , retain)UILabel *labelTime;
@property (nonatomic , retain)UILabel *labelPCount;

@end

@implementation LWSAudioCell

- (void)setModel:(LWSModelAudioCell *)model{
    _model = model;
    _labelTitle.text = _model.title;
    _labelSummary.text = _model.summary;
    NSString *time = [[_model.ptime componentsSeparatedByString:@" "] firstObject];
    _labelTime.text = time;
    CGFloat count = _model.playCount.integerValue / 10000.0;
    _labelPCount.text = [NSString stringWithFormat:@"%.1f万",count];
    [_imgAudio sd_setImageWithURL:[NSURL URLWithString:_model.cover] placeholderImage:[UIImage imageNamed:@"Deg_audio_item.jpg"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelTime = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelSummary = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelPCount = [[UILabel alloc]initWithFrame:CGRectZero];
        self.imgAudio = [[UIImageView alloc]initWithFrame:CGRectZero];
        
        self.labelSummary.font = [UIFont systemFontOfSize:15.0];
        self.labelSummary.textColor = [UIColor grayColor];
        self.labelPCount.font = [UIFont systemFontOfSize:14.0];
        self.labelPCount.textColor = [UIColor darkGrayColor];
        self.labelTime.font = [UIFont systemFontOfSize:14.0];
        self.labelTime.textColor = [UIColor darkGrayColor];
        self.labelPCount.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelTime];
        [self.contentView addSubview:self.labelSummary];
        [self.contentView addSubview:self.labelPCount];
        [self.contentView addSubview:self.imgAudio];

    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectZero];
//        self.labelTime = [[UILabel alloc]initWithFrame:CGRectZero];
//        self.labelSummary = [[UILabel alloc]initWithFrame:CGRectZero];
//        self.labelPCount = [[UILabel alloc]initWithFrame:CGRectZero];
//        self.imgAudio = [[UIImageView alloc]initWithFrame:CGRectZero];
//        
//        self.labelSummary.font = [UIFont systemFontOfSize:15.0];
//        self.labelSummary.textColor = [UIColor grayColor];
//        self.labelPCount.font = [UIFont systemFontOfSize:14.0];
//        self.labelPCount.textColor = [UIColor darkGrayColor];
//        self.labelTime.font = [UIFont systemFontOfSize:14.0];
//        self.labelTime.textColor = [UIColor darkGrayColor];
//        self.labelPCount.textAlignment = NSTextAlignmentRight;
//        
//        [self.contentView addSubview:self.labelTitle];
//        [self.contentView addSubview:self.labelTime];
//        [self.contentView addSubview:self.labelSummary];
//        [self.contentView addSubview:self.labelPCount];
//        [self.contentView addSubview:self.imgAudio];
//    }
//    return self;
//}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    self.labelTitle.frame = CGRectMake(10, 10, frame.size.width - 20, 30);
    CGFloat oriY = self.labelTitle.frame.origin.x + self.labelTitle.frame.size.height + 5;
    self.labelSummary.frame = CGRectMake(10, oriY, self.labelTitle.frame.size.width, 20);
    oriY += self.labelSummary.frame.size.height + 5;
    CGFloat height = frame.size.height - oriY - 30;
    self.imgAudio.frame = CGRectMake(10, oriY, self.labelSummary.frame.size.width, height);
    oriY += self.imgAudio.frame.size.height + 10;
    CGFloat width = frame.size.width / 2.0 - 20;
    self.labelTime.frame = CGRectMake(10, oriY, width, 20);
    CGFloat oriX = frame.size.width - 10 - width;
    self.labelPCount.frame = CGRectMake(oriX, oriY, width, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
