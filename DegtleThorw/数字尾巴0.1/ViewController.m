//
//  ViewController.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ViewController.h"
#import "LWSFirstPageController.h"
#import "LWSDetialWebViewViewController.h"
#import "LWSComFirstPage.h"
#import "LWSComListDetialPager.h"
#import "LWSComAuthriodPager.h"
#import "LWSModelAuthor.h"
#import "LWSModelList.h"
#import "LWSDegtleThrowPager.h"
#import "LWSFindMainPager.h"
#import "LWSSQLModel.h"
#import "LWSMinePagerViewController.h"
#import "LWSSeacchPager.h"

#define COMLISTNotication @"communityListUrlNotication"
#define COMUIDNotication @"communityUidUrlNotication"
#define COMDgtleThrow @"communityDegtleThroeListUrlNotication"

#define URLPUID @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&uid=%@&actions=thread&modules=forum&perpage=10&page=1&limit=0_9",model.authorid

#define URLPTID @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&uid=%@&idtype=tid&nodisplay=1&page=1&REQUESTCODE=31",model.authorid

@interface ViewController ()<UIScrollViewDelegate , FirstPagerControllerDelegate , ComFirstPagerControllerDelegate>

@property (nonatomic , retain)UILabel *labelFirstPage;
@property (nonatomic , retain)UILabel *labelCommunity;
@property (nonatomic , retain)UILabel *lableFind;
@property (nonatomic , retain)UILabel *showLabel;
@property (nonatomic , assign)NSInteger selectedLabel;
@property (nonatomic , retain)UIScrollView *myScroller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedLabel = 0;
    //去掉导航栏的透明度等操作
    [self setOnNavBar];
    //添加下一行的三个标签栏的操作
    [self createTabBar];
    //添加下面的滑动部分
    [self createMyScroller];
    //添加首页的vc
    [self insertFirstPage];
    //添加社区的vc
    [self insertCommunityFirstPage];
    //添加发现的vc
    [self insertFindPager];
    // Do any additional setup after loading the view, typically from a nib.
}

/**第一部分，导航栏部分的功能*/
- (void)setOnNavBar{
    self.navigationController.navigationBar.translucent = NO;
    //1.添加左按钮
    UIBarButtonItem *moreBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(clickOnMoreBtn:)];
    self.navigationItem.leftBarButtonItem = moreBtn;
    //2.添加标题
    self.navigationItem.title = @"数字尾巴";
    //3.添加右边的按钮组
    UIBarButtonItem *alert = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(clickOnAlertBtn:)];
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickOnSearchBtn:)];
    NSArray *array = @[search , alert];
    self.navigationItem.rightBarButtonItems = array;
}

- (void)clickOnMoreBtn:(UIBarButtonItem *)sender{
    /**在这里实现跳转到功能界面 */
    LWSMinePagerViewController *pager = [[LWSMinePagerViewController alloc]init];
    pager.title = @"我";
    [self.navigationController pushViewController:pager animated:YES];
}

- (void)clickOnAlertBtn:(UIBarButtonItem *)sender{
    
}

- (void)clickOnSearchBtn:(UIBarButtonItem *)sender{
    LWSSeacchPager *pager = [[LWSSeacchPager alloc]init];
    [self.navigationController pushViewController:pager animated:YES];
}

/**第二部分 设置三个标签栏*/
/*
 1.导航栏加上状态栏的高度是24(但是当导航栏显示不是半透明的时候，并不计算在view的尺寸中)
 2.添加手势
 */

- (void)createTabBar{
    CGFloat width = self.view.frame.size.width / 3.0;
    CGRect frame = CGRectMake(0, 0, width, 30);
    self.labelFirstPage = [[UILabel alloc]initWithFrame:frame];
    [self.view addSubview:self.labelFirstPage];
    self.labelFirstPage.text = @"首页";
    frame.origin.x += width;
    self.labelCommunity = [[UILabel alloc]initWithFrame:frame];
    [self.view addSubview:self.labelCommunity];
    self.labelCommunity.text = @"社区";
    frame.origin.x += width;
    self.lableFind = [[UILabel alloc]initWithFrame:frame];
    [self.view addSubview:self.lableFind];
    self.lableFind.text = @"发现";
    self.labelCommunity.userInteractionEnabled = YES;
    self.labelFirstPage.userInteractionEnabled = YES;
    self.lableFind.userInteractionEnabled = YES;
    self.labelCommunity.textAlignment = NSTextAlignmentCenter;
    self.labelFirstPage.textAlignment = NSTextAlignmentCenter;
    self.lableFind.textAlignment = NSTextAlignmentCenter;
    self.labelFirstPage.textColor = [UIColor blackColor];
    self.labelCommunity.textColor = [UIColor grayColor];
    self.lableFind.textColor = [UIColor grayColor];
    frame.origin.x = 0;
    frame.origin.y += 30;
    frame.size.height = 2;
    self.showLabel = [[UILabel alloc]initWithFrame:frame];
    [self.view addSubview:self.showLabel];
    self.showLabel.backgroundColor = [UIColor blueColor];
    [self addGesture];
}

//添加手势
/**添加手势的响应方法的参数只能识别手势*/
/**注：一个手势对象只能给一个标签添加，所以这里需要三个手势对象 */
- (void)addGesture{
    UITapGestureRecognizer *tapFirstPage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFirstPage:)];
    [self.labelFirstPage addGestureRecognizer:tapFirstPage];
    UITapGestureRecognizer *tapCommunity = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCommunity:)];
    [self.labelCommunity addGestureRecognizer:tapCommunity];
    UITapGestureRecognizer *tapFind = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFind:)];
    [self.lableFind addGestureRecognizer:tapFind];
}

//手势的响应方法
- (void)tapFirstPage:(UIGestureRecognizer *)tap{
        [self changeCoclorByNumber:0];
}

- (void)tapCommunity:(UIGestureRecognizer *)tap{
    [self changeCoclorByNumber:1];
}

- (void)tapFind:(UIGestureRecognizer *)tap{
    [self changeCoclorByNumber:2];
}

- (void)changeCoclorByNumber:(NSInteger)number{
    [self change:[UIColor grayColor] Number:self.selectedLabel];
    [self change:[UIColor blackColor] Number:number];
    self.selectedLabel = number;
}

- (void)change:(UIColor *)color Number:(NSInteger)number{
    
    CGFloat width = self.view.frame.size.width / 3.0;
    
    if (number == 0) {
        self.labelFirstPage.textColor = color;
    }
    else if (number == 1){
        self.labelCommunity.textColor = color;
    }
    else if (number == 2){
        self.lableFind.textColor = color;
    }
    /**在这里移动下面的条状的蓝色标签的位置 
       同时把下面的Scroller移动到正确的位置 */
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.showLabel.frame;
        frame.origin.x = number * width;
        self.showLabel.frame = frame;
        
        CGPoint point = self.myScroller.contentOffset;
        point.x = number * width * 3;
        self.myScroller.contentOffset = point;
    }];
}

/**第三部分 设置下面的大型scroller，下面的内容由其他vc的view视图覆盖 */
- (void)createMyScroller{
    CGRect frame = self.view.frame;
    //标签栏的高度加上下面两个高度的细条，总计32
    frame.origin.y = 32;
    frame.size.height -= (32 + 64);
    self.myScroller = [[UIScrollView alloc]initWithFrame:frame];
    [self.view addSubview:self.myScroller];
    self.myScroller.contentSize = CGSizeMake(frame.size.width * 3, frame.size.height);
    self.myScroller.backgroundColor = [UIColor yellowColor];
    self.myScroller.pagingEnabled = YES;
    self.myScroller.showsHorizontalScrollIndicator = NO;
    self.myScroller.showsVerticalScrollIndicator = NO;
    self.myScroller.delegate = self;
    //关闭myScroller的回弹
    self.myScroller.bounces = NO;
}

//填充首页的view进去（首页view的frame = 当前页面的scrollerview的frame）
/**
 需要注意的是，因为我在viewcontroller中调用了另一个vc的view为了保证这个vc不会被在使用的过程中被系统错误的回收
 我们需要注意的是，需要使用[self addChildViewController:firstPager];来达到管理这个vc的效果
 */
- (void)insertFirstPage{
    LWSFirstPageController *firstPager = [[LWSFirstPageController alloc]init];
    firstPager.height = self.view.frame.size.height - 90;
    CGRect frame = self.myScroller.frame;
    frame.origin.y = 0;
    firstPager.view.frame = frame;
    [self addChildViewController:firstPager];
    [self.myScroller addSubview:firstPager.view];
    /**设置firstPager的delegate为当前vc*/
    firstPager.delegate = self;
}

//填充第二个界面(社区界面)进去
- (void)insertCommunityFirstPage{
    LWSComFirstPage *community = [[LWSComFirstPage alloc]init];
    CGRect frame = self.myScroller.frame;
    frame.origin.y = 0;
    frame.origin.x = frame.size.width;
    community.view.frame = frame;
    community.delegate = self;
    [self addChildViewController:community];
    [self.myScroller addSubview:community.view];
    //注册接受社区界面的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCommunityListDetialPagerController:) name:COMLISTNotication object:nil];
    //注册接受尾巴社区点击作者时候发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCommunityUidDetialPagerController:) name:COMUIDNotication object:nil];
    //注册接受甩甩尾巴网址界面的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCommunityDgtleThrowDetialPagerController:) name:COMDgtleThrow object:nil];
}

//填充第三个界面：（发现）
- (void)insertFindPager{
    LWSFindMainPager *pager = [[LWSFindMainPager alloc]init];
    CGRect frame = self.myScroller.frame;
    frame.origin.y = 0;
    frame.origin.x = frame.size.width * 2;
    pager.view.frame = frame;
    [self addChildViewController:pager];
    [self.myScroller addSubview:pager.view];
}

- (void)getCommunityDgtleThrowDetialPagerController:(NSNotification *)notification{
    NSURL *url = [notification.userInfo valueForKey:@"url"];
    NSLog(@"接收到甩甩尾巴的网址 %@",url);
    //在下面执行对应的页面跳转操作
    LWSDegtleThrowPager *throwPager = [[LWSDegtleThrowPager alloc]init];
    throwPager.url = url;
    [self.navigationController pushViewController:throwPager animated:YES];
}

- (void)getCommunityListDetialPagerController:(NSNotification *)notification{
    NSURL *url = [notification.userInfo valueForKey:@"url"];
    NSLog(@"接收到了通知 %@",url);
    //在下面执行对应的页面跳转操作
    LWSComListDetialPager *listPage = [[LWSComListDetialPager alloc]init];
    listPage.url = url;
    [self.navigationController pushViewController:listPage animated:YES];
}

- (void)getCommunityUidDetialPagerController:(NSNotification *)notification{
    
    //在下面执行对应的页面跳转
    LWSModelList *model = [notification.userInfo valueForKey:@"model"];
    NSString *name = model.author;
    NSString *forunUrl = [NSString stringWithFormat:URLPUID];
    NSString *collectionUrl = [NSString stringWithFormat:URLPTID];
    LWSComAuthriodPager *authriodPager = [[LWSComAuthriodPager alloc]init];
    LWSModelAuthor *modelAuthor = [LWSModelAuthor modelAuthorWithName:name ForunUrl:forunUrl CollectionUrl:collectionUrl];
    authriodPager.model = modelAuthor;
    authriodPager.title = name;
    [self.navigationController pushViewController:authriodPager animated:YES];
}

/**实现代理方法 */

- (void)getDetialWedViewStrUrl:(NSString *)strUrl Model:(LWSModelFirstPage *)model{
    LWSDetialWebViewViewController *detialVC = [[LWSDetialWebViewViewController alloc]init];
    detialVC.strUrl = strUrl;
    /**在这里将一切模型转化成数据库能够识别的模型 */
    LWSSQLModel *useModel = [[LWSSQLModel alloc]init];
    useModel.type = 1;
    useModel.title = model.title;
    useModel.summary = model.summary;
    useModel.url = strUrl;
    detialVC.model = useModel;
    [self.navigationController pushViewController:detialVC animated:YES];
}

- (void)getScrollerWebViewStrUrl:(NSString *)strUrl Title:(NSString *)title{
    LWSDetialWebViewViewController *detialVC = [[LWSDetialWebViewViewController alloc]init];
    detialVC.strUrl = strUrl;
    /**在这里将一切模型转化成数据库能够识别的模型 */
    LWSSQLModel *useModel = [[LWSSQLModel alloc]init];
    useModel.type = 2;
    useModel.title = title;
    useModel.summary = @"";
    useModel.url = strUrl;
    detialVC.model = useModel;
    [self.navigationController pushViewController:detialVC animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect frame = self.showLabel.frame;
    frame.origin.x = self.myScroller.contentOffset.x / 3.0;
    self.showLabel.frame = frame;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    /**在减速的时候根据停留在的位置确定进入的是哪个标签栏的内容 */
    CGFloat width = self.view.frame.size.width;
    NSInteger number = (int)self.myScroller.contentOffset.x / width;
    [self changeCoclorByNumber:number];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
