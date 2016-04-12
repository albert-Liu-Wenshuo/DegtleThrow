//
//  LWSCollectionTableCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSCollectionTableCell.h"

@interface LWSCollectionTableCell ()

@property (nonatomic , retain)UILabel *labelAuthor;
@property (nonatomic , retain)UILabel *labelDataline;
@property (nonatomic , retain)UILabel *labelSubject;
@property (nonatomic , retain)UILabel *labelReplies;
@property (nonatomic , retain)UILabel *label;

@end

@implementation LWSCollectionTableCell

- (void)setModel:(LWSModelCollection *)model{
    _model = model;
    /**在这里执行给每个条目赋值的操作 */
    self.labelAuthor.text = self.model.author;
    self.labelDataline.text = self.model.dateline;
    self.labelReplies.text = self.model.replies;
    self.labelSubject.text = self.model.subject;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellItems];
    }
    return self;
}

- (void)createCellItems{
    /**因为后期会动态修改位置，所以在这里frame不设死值 */
    self.labelAuthor = [[UILabel alloc]initWithFrame:CGRectZero];
    self.labelDataline = [[UILabel alloc]initWithFrame:CGRectZero];
    self.labelReplies = [[UILabel alloc]initWithFrame:CGRectZero];
    self.labelSubject = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.labelAuthor];
    [self.contentView addSubview:self.labelDataline];
    [self.contentView addSubview:self.labelReplies];
    [self.contentView addSubview:self.labelSubject];
    self.labelAuthor.font = [UIFont systemFontOfSize:13.0];
    self.labelAuthor.textColor = [UIColor darkGrayColor];
    self.labelDataline.font = [UIFont systemFontOfSize:13.0];
    self.labelDataline.textColor = [UIColor darkGrayColor];
    self.labelSubject.textColor = [UIColor blackColor];
    self.labelSubject.font = [UIFont systemFontOfSize:14.0];
    self.labelSubject.numberOfLines = 2;
    self.labelReplies.textColor = [UIColor darkGrayColor];
    self.labelReplies.font = [UIFont boldSystemFontOfSize:15.0];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    /**在这里动态的修改位置和大小 */
    CGRect frame = self.contentView.frame;
    CGSize size = [self getLabelForumSize];
    CGRect rect = CGRectMake(10, 10, size.width, size.height);
    self.labelAuthor.frame = rect;
    
    rect.origin.x += (10 + rect.size.width);
    rect.size.width = frame.size.width / 7.0 * 6 - rect.origin.x - 20;
    self.labelDataline.frame = rect;
    
    rect = CGRectMake(10, frame.size.height - 30 - size.height, frame.size.width / 7.0 * 6 - 20, size.height + 20);
    self.labelSubject.frame = rect;
    
    rect = CGRectMake(10 + frame.size.width / 7.0 * 6, 10, frame.size.width / 7.0 - 20, 30);
    self.labelReplies.frame = rect;
    
       if (self.label == nil) {
           rect = CGRectMake(frame.size.width / 7.0 * 6 - 1, 5, 1, frame.size.height - 10);
        self.label = [[UILabel alloc]initWithFrame:rect];
        [self.contentView addSubview:self.label];
        self.label.backgroundColor = [UIColor grayColor];
    }
    
    CGPoint center = self.labelReplies.center;
    center.y = self.contentView.center.y;
    self.labelReplies.center = center;

}

/**获取label的动态尺寸 */
- (CGSize)getLabelForumSize{
    NSString *s = self.model.author;
    UIFont *font = [UIFont systemFontOfSize:13.0];
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
