//
//  LWSAuthorForumCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSAuthorForumCell.h"
#import "ToolAboutTime.h"

@interface LWSAuthorForumCell ()

@property (nonatomic  ,retain)UILabel *labelSummary;
@property (nonatomic , retain)UILabel *labelForum;
@property (nonatomic , retain)UILabel *labelDataline;
@property (nonatomic , retain)UILabel *labelReply;
@property (nonatomic , retain)UILabel *labelOne;

@end

@implementation LWSAuthorForumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /**创建初始的label属性 */
        [self createCell];
    }
    return self;
}

- (void)createCell{
    self.labelSummary = [[UILabel alloc]initWithFrame:CGRectZero];
    self.labelForum = [[UILabel alloc]initWithFrame:CGRectZero];
    self.labelDataline = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelReply = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.labelSummary];
    [self.contentView addSubview:self.labelForum];
    [self.contentView addSubview:self.labelDataline];
    [self.contentView addSubview:self.labelReply];
}

- (void)createCellDetial{
    CGRect frame = self.contentView.frame;
    frame = CGRectMake(20, 10, frame.size.width / 7.0 * 6 - 40 , (frame.size.height - 30) / 2);
    self.labelSummary.frame = frame;
    self.labelSummary.textAlignment = NSTextAlignmentCenter;
    
    frame.origin.y += frame.size.height + 5;
    frame.size.width = 10;
    self.labelForum.frame = frame;
    self.labelForum.textAlignment = NSTextAlignmentLeft;
    frame.origin.x += frame.size.width + 5;
    frame.size.width = 120;
    self.labelDataline.frame = frame;
    self.labelDataline.textAlignment = NSTextAlignmentLeft;
    frame.origin.x = self.contentView.frame.size.width / 7.0 * 6 - 1;
    frame.origin.y = 2;
    frame.size.width = 1;
    frame.size.height = self.contentView.frame.size.height - 4;
        
    if (self.labelOne == nil) {
        UILabel *labelOne = [[UILabel alloc]initWithFrame:frame];
        labelOne.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:labelOne];
    }
    
    frame = CGRectMake(frame.origin.x + 6, 10, (self.contentView.frame.size.width / 7.0) - 10, self.contentView.frame.size.height - 20);
    self.labelReply.frame = frame;
    self.labelDataline.textColor = [UIColor darkGrayColor];
    self.labelForum.textColor = [UIColor darkGrayColor];
    self.labelReply.textColor = [UIColor darkGrayColor];
}

/**在这里动态修改cell内部的属性 */
- (void)layoutSubviews{
    [super layoutSubviews];
    [self createCellDetial];
    /**根据屏幕来修改cell字体的大小 */
    [self.labelReply setFont:[self getLaebFont]];
    [self.labelForum setFont:[self getLaebFont]];
    [self.labelDataline setFont:[self getLaebFont]];
    [self.labelSummary setFont:[self getLaebFont]];
    
    self.labelSummary.text = self.model.subject;
    self.labelSummary.numberOfLines = 2;
    
//    CGRect frame = self.labelForum.frame;
//    frame.size = [self getLabelForumSize];
//    self.labelSummary.frame = frame;
    
//    CGRect rect = self.labelDataline.frame;
//    rect.origin.x = frame.origin.x + frame.size.width + 5;
//    self.labelDataline.frame = rect;
    self.labelDataline.text = [ToolAboutTime getTimeStrByTimeSp:self.model.dateline];
    self.labelDataline.font = [self getLaebFont];
    
    self.labelReply.text = self.model.replies;
    self.labelReply.font = [self getLaebFont];
    
}

/**根据屏幕的大小确定使用的字体 */
- (UIFont *)getLaebFont{
    if ([UIScreen mainScreen].bounds.size.width == 414) {
        return [UIFont systemFontOfSize:14.0];
    }
    else
        return [UIFont systemFontOfSize:14.0];
}

/**获取label的动态尺寸 */
- (CGSize)getLabelForumSize{
    NSString *s = self.model.typeid;
    UIFont *font = [self getLaebFont];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [s boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return labelsize;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
