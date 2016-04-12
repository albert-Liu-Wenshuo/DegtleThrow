//
//  LWSShowImageCell.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSShowImageCell.h"
#import "UIImageView+WebCache.h"

@interface LWSShowImageCell ()

@property (nonatomic , retain)UIImageView *imgView;

@end

@implementation LWSShowImageCell

/**该图片需要自适应高 */

/**
 layoutSubviews在以下情况下会被调用：
 
 1、init初始化不会触发layoutSubviews
 
 但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
 
 2、addSubview会触发layoutSubviews
 
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 
 4、滚动一个UIScrollView会触发layoutSubviews
 
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imgView = [[UIImageView alloc]initWithFrame:self.contentView.frame];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame = CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20);
    frame.size = [self getActualPicSizeByImage:[UIImage imageNamed:@"Deg_holder.jpg"] imageViewWidth:frame.size.width];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.picUrl] placeholderImage:[UIImage imageNamed:@"Deg_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"%@", NSStringFromCGSize(image.size));
    }];
    self.imgView.frame = frame;
    frame = self.frame;
    frame.size = CGSizeMake(self.imgView.frame.size.width + 20, self.imgView.frame.size.height + 20);
    self.frame = frame;
//    [self.imgView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"image"]) {
//        UIImage *image = [change valueForKey:@"new"];
//        if (![image isEqual:[UIImage imageNamed:@"Deg_holder.jpg"]]) {
//            CGSize size = [self getActualPicSizeByImage:image imageViewWidth:self.imgView.frame.size.width];
//            CGRect frame = self.imgView.frame;
//            frame.size = size;
//            self.imgView.frame = frame;
//            
//            frame = self.frame;
//            frame.size.height = self.imgView.frame.size.height + 20;
//            self.frame = frame;
//            
//            [self.imgView removeObserver:self forKeyPath:@"image"];
//        }
//    }
//}
//

- (CGSize)getActualPicSizeByImage:(UIImage *)image
                   imageViewWidth:(CGFloat)width{
    CGSize size = image.size;
    size = CGSizeMake(width, (width / size.width) * size.height);
    return size;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
