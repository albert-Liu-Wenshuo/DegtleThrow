//
//  LWSComAuthriodPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSComAuthriodPager.h"
#import "LWSAuthorForumPager.h"
#import "LWSAuthorCollectionPager.h"

@interface LWSComAuthriodPager ()<UIScrollViewDelegate>

@property (nonatomic , retain)UILabel *labelCountForun;
@property (nonatomic , retain)UILabel *labelCountCollection;
@property (nonatomic , assign)CGFloat heightBegin;
@property (nonatomic , retain)UIScrollView *scrollerList;
@property (nonatomic , retain)UIButton *buttonCollection;
@property (nonatomic , retain)UIButton *buttonForum;
@property (nonatomic , retain)LWSAuthorCollectionPager *collectionPager;

@end

@implementation LWSComAuthriodPager

/*
 1.需要设置左按钮的图标并关联返回的方法
 2.
 */

- (void)viewDidLoad{
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    /**创建页面上面的展示类的标签应用等界面 */
    [self createShowView];
    /**创建下面显示详情的scroller */
    [self createShowScrollerView];
}

- (void)createShowView{
    CGRect rect = CGRectMake(self.view.center.x - 50 ,10 , 100, 20);
    UILabel *labelName = [[UILabel alloc]initWithFrame:rect];
    labelName.text = self.model.name;
    labelName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelName];
    
    rect.origin.x -= 50;
    rect.size.width = 80;
    rect.origin.y += 40;
    rect.size.height = 30;
    UIButton *buttonMessage = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonMessage];
    [buttonMessage addTarget:self action:@selector(clickOnPersonalMessage:) forControlEvents:UIControlEventTouchUpInside];
    [buttonMessage setTitle:@"私信" forState:UIControlStateNormal];
    buttonMessage.titleLabel.textAlignment = NSTextAlignmentCenter;
    buttonMessage.backgroundColor = [UIColor colorWithRed:(237 / 255.0) green:(237 / 255.0) blue:(239 / 255.0) alpha:1.0];
    [buttonMessage setTitleColor:[UIColor colorWithRed:(166 / 255.0) green:(166 / 255.0) blue:(167 / 255.0) alpha:1.0] forState:UIControlStateNormal];
    //设置按钮的圆角，不知道应该如何调节
    buttonMessage.layer.cornerRadius = 5;
    
    rect.origin.x += 120;
    UIButton *buttonCare = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonCare];
    [buttonCare addTarget:self action:@selector(clickOnButtonCare:) forControlEvents:UIControlEventTouchUpInside];
    [buttonCare setTitle:@"关注" forState:UIControlStateNormal];
    buttonCare.titleLabel.textAlignment = NSTextAlignmentCenter;
    buttonCare.backgroundColor = [UIColor colorWithRed:(237 / 255.0) green:(237 / 255.0) blue:(239 / 255.0) alpha:1.0];
    [buttonCare setTitleColor:[UIColor colorWithRed:(166 / 255.0) green:(166 / 255.0) blue:(167 / 255.0) alpha:1.0] forState:UIControlStateNormal];
    //设置按钮的圆角，不知道应该如何调节
    buttonCare.layer.cornerRadius = 5;
    
    rect.origin.x = 5;
    rect.size.width = self.view.frame.size.width - 10;
    rect.origin.y += 40;
    rect.size.height = 1;
    UILabel *labelOne = [[UILabel alloc]initWithFrame:rect];
    labelOne.backgroundColor = [UIColor grayColor];
    [self.view addSubview:labelOne];
    
    /**在这里添加·跳转到贴子的按钮 */
    rect.origin.x = 60;
    rect.size.width = 100;
    rect.size.height = 30;
    rect.origin.y += 5;
    self.labelCountForun = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:self.labelCountForun];
    /**在这里添加修改贴子数量的值 */
    self.labelCountForun.text = @"120";
    self.labelCountForun.textAlignment = NSTextAlignmentCenter;
    
    CGRect btnrect = rect;
    btnrect.origin.y += 40;
    self.buttonForum = [[UIButton alloc]initWithFrame:btnrect];
    [self.view addSubview:self.buttonForum];
    [self.buttonForum setTitle:@"贴子" forState:UIControlStateNormal];
    self.buttonForum.backgroundColor = [UIColor whiteColor];
    [self.buttonForum setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.buttonForum addTarget:self action:@selector(clickOnForunButton:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = self.view.center.x;
    rect.origin.y += 1;
    rect.size.height = 80;
    rect.size.width = 1;
    UILabel *labelTwo = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labelTwo];
    labelTwo.backgroundColor = [UIColor grayColor];
    
    /**在这里添加收藏的按钮 */
    rect.origin.x += 61;
    rect.size.width = 100;
    rect.size.height = 30;
    self.labelCountCollection = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:self.labelCountCollection];
    /**在这里添加修改收藏数量的值 */
    self.labelCountCollection.text = @"24";
    self.labelCountCollection.textAlignment = NSTextAlignmentCenter;
    
    btnrect = rect;
    btnrect.origin.y += 40;
    self.buttonCollection = [[UIButton alloc]initWithFrame:btnrect];
    [self.view addSubview:self.buttonCollection];
    [self.buttonCollection setTitle:@"收藏" forState:UIControlStateNormal];
    self.buttonCollection.backgroundColor = [UIColor whiteColor];
    [self.buttonCollection setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buttonCollection addTarget:self action:@selector(clickOnCollectionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = 5;
    rect.size.width = self.view.frame.size.width - 10;
    rect.origin.y += 5 + 80;
    rect.size.height = 1;
    UILabel *labelThree = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labelThree];
    labelThree.backgroundColor = [UIColor grayColor];
    
    self.heightBegin = rect.origin.y + 1;
}

- (void)createShowScrollerView{
    CGRect frame = self.view.frame;
    frame.origin.y = self.heightBegin;
    frame.size.height -= (self.heightBegin + 64);
    self.scrollerList = [[UIScrollView alloc]initWithFrame:frame];
    self.scrollerList.contentSize = CGSizeMake(frame.size.width * 2, frame.size.height);
    [self.view addSubview:self.scrollerList];
    self.scrollerList.backgroundColor = [UIColor yellowColor];
    self.scrollerList.pagingEnabled = YES;
    self.scrollerList.bounces = NO;
    self.scrollerList.showsHorizontalScrollIndicator = NO;
    self.scrollerList.showsVerticalScrollIndicator = NO;
    self.scrollerList.delegate = self;
    
    /**添加显示第一个界面的vc */
    LWSAuthorForumPager *forumPager = [[LWSAuthorForumPager alloc]init];
    forumPager.strUrl = self.model.forunUrl;
    [self addChildViewController:forumPager];
    frame.size.height += 64;
    frame.origin.y = 0;
    forumPager.view.frame = frame;
    [self.scrollerList addSubview:forumPager.view];
}

- (void)clickOnPersonalMessage:(UIButton *)sender{
    
}

- (void)clickOnButtonCare:(UIButton *)sender{
    
}

- (void)clickOnForunButton:(UIButton *)sender{
    CGPoint point = self.scrollerList.contentOffset;
    point.x = 0;
    self.scrollerList.contentOffset = point;
    [self.buttonCollection setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buttonForum setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)clickOnCollectionButton:(UIButton *)sender{
    CGPoint point = self.scrollerList.contentOffset;
    point.x = self.scrollerList.frame.size.width;
    self.scrollerList.contentOffset = point;
    [self.buttonForum setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buttonCollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    /**添加子vc并创建 */
    [self createCollectionPager];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == scrollView.frame.size.width) {
//        NSLog(@"滑动的协议方法执行了");
        [self createCollectionPager];
        [self.buttonForum setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.buttonCollection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else{
        [self.buttonCollection setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.buttonForum setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

/**创建子vc的方法 */
- (void)createCollectionPager{
    if (self.collectionPager == nil) {
        self.collectionPager = [[LWSAuthorCollectionPager alloc]init];
        self.collectionPager.strUrl = self.model.collectionUrl;
        [self addChildViewController:self.collectionPager];
        CGRect frame = self.scrollerList.frame;
        frame.origin = CGPointMake(frame.size.width, 0);
        self.collectionPager.view.frame = frame;
        [self.scrollerList addSubview:self.collectionPager.view];
//        NSLog(@"创建了一次子vc");
        NSLog(@"网址是：%@",self.collectionPager.strUrl);
    }

}

@end
