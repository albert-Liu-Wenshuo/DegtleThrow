//
//  LWSHeaderScrollerView.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHeaderScrollerView.h"
#import "UIImageView+WebCache.h"
#import "LWSModelHeaderView.h"
#import "UIScrollView+LWSScroller_Touch.h"

@interface LWSHeaderScrollerView ()<UIScrollViewDelegate>

@property (nonatomic , retain)UIScrollView *myScrollerView;
@property (nonatomic , retain)UILabel *myLabel;
@property (nonatomic , assign)CGFloat pointX;

@end

@implementation LWSHeaderScrollerView

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
    }
    return _models;
}

/**视图包括上面的轮播图和下面的标签 */
- (instancetype)initWithFrame:(CGRect)frame
                        Model:(NSMutableArray *)models{
    self = [super initWithFrame:frame];
    if (self) {
        self.models = models;
        [self createScrollerView];
        [self createLabel];
    }
    return self;
}

- (void)createScrollerView{
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20);
    self.myScrollerView = [[UIScrollView alloc]initWithFrame:frame];
    [self addSubview:self.myScrollerView];
    self.myScrollerView.contentSize = CGSizeMake((self.models.count + 2) * frame.size.width, frame.size.height);
    self.myScrollerView.backgroundColor = [UIColor yellowColor];
    self.myScrollerView.pagingEnabled = YES;
    self.myScrollerView.showsHorizontalScrollIndicator = NO;
    self.myScrollerView.showsVerticalScrollIndicator = NO;
    self.myScrollerView.delegate = self;
    //关闭myScroller的回弹
    self.myScrollerView.bounces = NO;
    /**
     1.在这里添加page
     2.根据模型的数量添加相框（模型数量加二）
     */
    [self createImageViewByNumber:(self.models.count + 2)];
    /**默认开始显示的时候显示的是第二张（因为第一张就是最后一张） */
    CGPoint point = self.myScrollerView.contentOffset;
    point.x = self.myScrollerView.frame.size.width;
    self.myScrollerView.contentOffset = point;
    self.myScrollerView.userInteractionEnabled = YES;
    
}

/**根据模型数量添加相框和假的相框 */
- (void)createImageViewByNumber:(NSInteger)number{
    CGRect frame = self.myScrollerView.frame;
    for (int i = 0; i < number; i++) {
        LWSModelHeaderView *model = [[LWSModelHeaderView alloc]init];
        if (i == 0) {
            model = [self.models lastObject];
        }
        else if (i == number - 1){
            model = [self.models firstObject];
        }
        else{
            model = self.models[i - 1];
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.tag = 1000 + i;
        [self.myScrollerView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"showlistPic.jpg"]];
        imageView.userInteractionEnabled = YES;
        frame.origin.x += frame.size.width;
    }
}

/**添加下面的标签 */
- (void)createLabel{
    CGRect frame = self.myScrollerView.frame;
    frame.origin.y += frame.size.height;
    frame.size.height = 20;
    self.myLabel = [[UILabel alloc]initWithFrame:frame];
    [self addSubview:self.myLabel];
    self.myLabel.textAlignment = NSTextAlignmentCenter;
//    self.myLabel.text = [self.models[0] title];
}

/**在这里实现
 1.根据偏移量动态变换下面标签的内容
 2.当偏移量达到最大时将最后一张替换成第一张（第二个相框）
 3.当偏移量达到最小是替换成偏移量是倒数第二张的位置
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point;
    if (scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.frame.size.width) {
        //翻到第一张的假图的时候
        point = scrollView.contentOffset;
        point.x = scrollView.frame.size.width;
        scrollView.contentOffset = point;
        self.myLabel.text = [self.models[0] title];
    }
    else if (scrollView.contentOffset.x == 0){
        point = scrollView.contentOffset;
        point.x = (scrollView.contentSize.width - 2 * scrollView.frame.size.width);
        scrollView.contentOffset = point;
        self.myLabel.text = [[self.models lastObject] title];
    }
    else{
        NSInteger number = (scrollView.contentOffset.x / self.myScrollerView.frame.size.width) - 1;
        self.myLabel.text = [self.models[number] title];
    }
}

/**根据点击的偏移量来确定是第几个模型的网址
 由于添加在了scrollerview的下面，不能直接响应touchbegin需要添加一个自定义的类目
 会响应两次
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.myScrollerView];
//    NSLog(@"位置横坐标 %f",point.x);
    if (self.pointX != point.x) {
        //获取的是第几张的图片
        NSInteger number = point.x / self.myScrollerView.frame.size.width;
        LWSModelHeaderView *model = self.models[number - 1];
        //添加协议方法，将模型的网址传递过去
        [self.delegate getDetialUrl:model.url Title:model.title];
    }
    self.pointX = point.x;
}

@end
