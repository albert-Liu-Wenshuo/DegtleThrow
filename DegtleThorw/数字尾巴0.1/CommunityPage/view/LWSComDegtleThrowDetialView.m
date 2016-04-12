//
//  LWSComDegtleThrowDetialView.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSComDegtleThrowDetialView.h"
#import "UIScrollView+LWSScroller_Touch.h"
#import "LWSLabelSize.h"
#import "UIImageView+WebCache.h"

@interface LWSComDegtleThrowDetialView ()

@property (nonatomic , retain)UIScrollView *scrollerView;

@property (nonatomic , retain)UILabel *labelTitle;
@property (nonatomic , retain)UILabel *labelTitleList;
@property (nonatomic , retain)UILabel *labelAuthorName;
@property (nonatomic , retain)UILabel *labelDataline;
@property (nonatomic , retain)UILabel *labelPrice;
@property (nonatomic , retain)UILabel *labelcount;
@property (nonatomic , retain)UILabel *labelColor;
@property (nonatomic , retain)UILabel *labelLocation;
@property (nonatomic , retain)UILabel *labelHaveTime;
@property (nonatomic , retain)UILabel *labelSummary;

@property (nonatomic , assign)BOOL isCreatePics;

@end

@implementation LWSComDegtleThrowDetialView

- (NSMutableArray *)images{
    if (_images == nil) {
        _images = [[NSMutableArray alloc]init];
    }
    return _images;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isCreatePics = YES;
        [self createBodyScrollerView];
        [self createTitleView];
    }
    return self;
}

- (void)setModel:(LWSModelDetialThrow *)model{
    _model = model;
    /**因为图片的数量不确定，所以创建图片的尺寸的位置在这里，需要注意的是，初始化相框也在这里，所以需要确定属性是imageView的创建只执行2一次 */
    /**在这里将模型中的数据赋予标签(所以获取模型中的数据的操作将在这个界面的外面进行) */
    NSArray *optionlist = _model.optionlist;
    NSString *title;
    NSString *price;
    NSString *count;
    NSString *color;
    NSString *haveTime;
    NSString *location;
    title = [optionlist[0] valueForKey:@"value"];
    price = [optionlist[1] valueForKey:@"value"];
    count = [optionlist[2] valueForKey:@"value"];
    color = [optionlist[3] valueForKey:@"value"];
    if ([color containsString:@"&nbsp;"]) {
        NSArray *arr = [color componentsSeparatedByString:@"&nbsp;"];
        color = arr[0];
    }
    haveTime = [optionlist[4] valueForKey:@"value"];
    location = [optionlist[5] valueForKey:@"value"];
    _labelTitle.text = title;
    _labelTitleList.text = [NSString stringWithFormat:@"%@·%@",_model.username , _model.dateline];
    _labelAuthorName.text = _model.username;
    _labelDataline.text = _model.dateline;
    _labelPrice.text = [NSString stringWithFormat:@"￥%@",price];
    _labelcount.text = count;
    _labelColor.text = color;
    _labelLocation.text = location;
    _labelHaveTime.text = haveTime;
    
    self.labelSummary.text = _model.message;
    self.labelSummary.numberOfLines = 0;
    self.labelSummary.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [self getLabelForumSize:_model.message];
    CGRect frame = self.labelSummary.frame;
    frame.size = size;
    self.labelSummary.frame = frame;
    
    frame.origin = CGPointMake(0, frame.origin.y + 10 + frame.size.height);
    if (_isCreatePics) {
        NSInteger number = _model.pics.count;
        for (int i = 0; i < number; i++) {
            frame.size = [self getSizeByPic:[UIImage imageNamed:@"Deg_holder.jpg"]];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
            [_scrollerView addSubview:imageView];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_model.pics[i]] placeholderImage:[UIImage imageNamed:@"Deg_holder.jpg"]];
            [self.images addObject:imageView];
            frame.origin.y += frame.size.height + 10;
            [imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    
}

- (CGSize)getLabelForumSize:(NSString *)s{
    UIFont *font = [UIFont systemFontOfSize:17.0];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(self.frame.size.width - 10,2000);
    CGSize labelsize = [s boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return labelsize;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *image = [change valueForKey:@"new"];
        if (![image isEqual:[UIImage imageNamed:@"Deg_holder"]]) {
            for (UIImageView *imageView in self.images) {
                if ([imageView.image isEqual:image]) {
                    /**找到图片使用的不是占位图的imageView并修改它的尺寸 */
                    CGRect frame = imageView.frame;
                    frame.size = [self getSizeByPic:imageView.image];
                    imageView.frame = frame;
                    NSInteger index = [self.images indexOfObject:imageView];
                    /**根据第一张图片的尺寸调整下一张图片的位置 */
                    if (index != self.images.count - 1) {
                        UIImageView *temp = [self.images objectAtIndex:(index + 1)];
                        frame = temp.frame;
                        CGPoint point = [self getNextRectPointByFrame:imageView.frame];
                        frame.origin = point;
                        temp.frame = frame;
                    }
                    else{
                        /**当image是最后一张的时候下一image的frame的y坐标就是Scroller的大小 */
                        CGPoint ll = [self getNextRectPointByFrame:imageView.frame];
                        CGSize sizeScroller = self.scrollerView.contentSize;
                        sizeScroller.height = ll.y + 60;
                        self.scrollerView.contentSize = sizeScroller;
                        /**在这里添加协议方法让vc回收观察者 */
                        [self.delegate closeObserver];
                    }
                }
            }
        }
    }
    else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

/**根据图片大小获取尺寸 */
- (CGSize)getSizeByPic:(UIImage *)image{
    CGSize size = image.size;
    size = CGSizeMake(self.frame.size.width, self.frame.size.width / size.width * size.height);
    return size;
}

- (CGPoint)getNextRectPointByFrame:(CGRect)frame{
    CGRect Rframe = frame;
    Rframe.origin.y += frame.size.height;
    return Rframe.origin;
}

- (void)createBodyScrollerView{
//    CGRect frame = self.frame;
//    frame.origin = CGPointMake(0, 0);
//    self.scrollerView = [[UIScrollView alloc]initWithFrame:frame];
    self.scrollerView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollerView.contentSize = CGSizeMake(self.scrollerView.frame.size.width, self.scrollerView.frame.size.height);
    [self addSubview:self.scrollerView];
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self scrollerView].backgroundColor = [UIColor whiteColor];
}

- (void)createTitleView{
    CGRect frame = self.frame;
    frame.origin.y = 30;
    frame.size.width = frame.size.width / 5.0 * 4;
    frame.size.height = 30;
    self.labelTitle = [[UILabel alloc]initWithFrame:frame];
    CGPoint point = self.center;
    point.y = 30;
    self.labelTitle.center = point;
    [self.scrollerView addSubview:self.labelTitle];
    /**字体的大小未来可能需要调节 */
    self.labelTitle.font = [UIFont systemFontOfSize:20.0];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    frame.origin.y += 30 + frame.size.height;
    frame.size.height = 20;
    point.y += 30 + frame.size.height;
    self.labelTitleList = [[UILabel alloc]initWithFrame:frame];
    self.labelTitleList.center = point;
    [self.scrollerView addSubview:self.labelTitleList];
    self.labelTitleList.font = [UIFont systemFontOfSize:13.0];
    self.labelTitleList.textColor = [UIColor grayColor];
    self.labelTitleList.textAlignment = NSTextAlignmentCenter;
    
    frame.origin.y += 30 + frame.size.height;
    frame.origin.x = 20;
    frame.size.height = 15;
    frame.size.width = self.frame.size.width / 2 - 60;
    self.labelAuthorName = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelAuthorName];
    self.labelAuthorName.font = [UIFont boldSystemFontOfSize:15.0];
    self.labelAuthorName.textColor = [UIColor darkGrayColor];
    
    frame.origin.y += 15;
    self.labelDataline = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelDataline];
    self.labelDataline.font = [UIFont systemFontOfSize:13.0];
    self.labelDataline.textColor = [UIColor grayColor];
    
    frame.origin.y -= 15;
    self.labelPrice = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelPrice];
    self.labelPrice.textColor = [UIColor redColor];
    self.labelPrice.font = [UIFont boldSystemFontOfSize:20.0];
    self.labelPrice.textAlignment = NSTextAlignmentCenter;
    point = self.labelPrice.center;
    point.x = self.center.x / 2.0 + self.frame.size.width / 2.0;
    self.labelPrice.center = point;
    
    /**在这里设置整段文字的列表 */
    frame.origin.y += 30 + 20;
    frame.size.width = self.frame.size.width / 2 - 40;
    frame.origin.x = 20;
    frame.size.height = 20;
    
    UILabel *labelOne = [[UILabel alloc]initWithFrame:frame];
    frame.origin.y += 20;
    UILabel *labelTwo = [[UILabel alloc]initWithFrame:frame];
    frame.origin.y += 20;
    UILabel *labelThree = [[UILabel alloc]initWithFrame:frame];
    frame.origin.y += 20;
    UILabel *labelFour = [[UILabel alloc]initWithFrame:frame];
    
    [self.scrollerView addSubview:labelOne];
    [self.scrollerView addSubview:labelTwo];
    [self.scrollerView addSubview:labelThree];
    [self.scrollerView addSubview:labelFour];
    
    labelOne.text = @"数量：";
    labelTwo.text = @"成色：";
    labelThree.text = @"所在地：";
    labelFour.text = @"入手时间：";
    
    frame = labelOne.frame;
    frame.origin.x = self.frame.size.width / 2.0 + 20;
    self.labelcount = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelcount];
    self.labelcount.textColor = [UIColor grayColor];
    frame.origin.y += 20;
    self.labelColor = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelColor];
    self.labelColor.textColor = [UIColor grayColor];
    frame.origin.y += 20;
    self.labelLocation = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelLocation];
    self.labelLocation.textColor = [UIColor grayColor];
    frame.origin.y += 20;
    self.labelHaveTime = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelHaveTime];
    self.labelHaveTime.textColor = [UIColor grayColor];
    
    /**这里填写的是正文：需要计算label需要的大小,先模拟一个正常大小的标签，在模型中传入文字的时候计算并修改这个标签及其之后的全部内容的位置 */
    frame.origin = CGPointMake(10, frame.origin.y + 40);
    frame.size = CGSizeMake(self.frame.size.width - 20, 100);
    self.labelSummary = [[UILabel alloc]initWithFrame:frame];
    [self.scrollerView addSubview:self.labelSummary];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
