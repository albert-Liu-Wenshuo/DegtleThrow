//
//  LWSFirstPageController.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

/**
 曾几何时，被自己坑过，为了防止下次继续被自己坑，我决定了！在每个我能看到的地方，都把问题写一遍！！！
 方法一：
 第一步：
 [self.collectionView registerNib:[UINib nibWithNibName:@"QGLShareBtnCell" bundle:nil] forCellWithReuseIdentifier:@"QGLShareBtnCell”];
 第二步：
 QGLShareBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QGLShareBtnCell" forIndexPath:indexPath];
 方法二：
 
 QGLIMGroupListCell *cell = (QGLIMGroupListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell= (QGLIMGroupListCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"QGLIMGroupListCell" owner:self options:nil]  lastObject];
 }
 － －！更为坑的是，居然忘记给xib设置identifier了。。。
 */

#import "LWSFirstPageController.h"
#import "LWSDataAlay.h"
#import "LWSShowListCell.h"
#import "LWSHeaderScrollerView.h"

#import "UIView+MJExtension.h"
#import "MJRefresh.h"


#define URLMAIN @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=portal&actions=article&limit=0_20&order=dateline_desc"
#define URLREFRESH @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=portal&actions=article&limit=0_%@&order=dateline_desc",page
#define URLHEADER @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=portal&actions=diydata&bid=274"
#define IDENTIFIER @"ShowListCell"

@interface LWSFirstPageController ()<UITableViewDataSource , UITableViewDelegate , HeaderScrollerViewDelegate>

@property (nonatomic , retain)NSString *MyUrl;
@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *myTableView;
@property (nonatomic , assign)NSInteger page;

@end

@implementation LWSFirstPageController

/**所有跟firstPage相关的界面的铺设都在这里 可以考虑将网址写成一个宏或者属性*/

- (NSString *)MyUrl{
    if (_MyUrl == nil) {
        _MyUrl = URLMAIN;
    }
    return _MyUrl;
}

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
        _page = 20;
        [LWSDataAlay getFirstPagerCellModelsByStrUrl:self.MyUrl Results:^(NSMutableArray *results) {
            _models = results;
            /**这在里，刷新界面应该在回到主线程中操作 */
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
            });
        }];
    }
    return _models;
    
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    CGRect frame = self.view.frame;
    frame.size.height = self.height;
    self.myTableView.frame = frame;
}

- (void)createTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"LWSShowListCell" bundle:nil];
    [self.myTableView registerNib:nib forCellReuseIdentifier:IDENTIFIER];
    [self.view addSubview:self.myTableView];
    /**添加头视图 */
    [LWSDataAlay getFirstPagerHeaderViewModelsByStrUrl:URLHEADER Results:^(NSMutableArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect frame = self.view.frame;
            frame.size.height = 150;
            LWSHeaderScrollerView *scroller = [[LWSHeaderScrollerView alloc]initWithFrame:frame Model:results];
            self.myTableView.tableHeaderView = scroller;
            scroller.delegate = self;
        });
    }];
    /**添加mj的刷新界面方法 */
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

/**上拉刷新的加载数据的方法 */
- (void)loadNewData{
    /*
     1.判断上拉是否有数据
     2.若有，清空原来数组，将新数组刷新到模型数组中（在返回到主线程中刷新数据）
     3.若没有则不变
     */
    [LWSDataAlay getFirstPagerCellModelsByStrUrl:URLMAIN Results:^(NSMutableArray *results) {
        if (results.count > 0) {
            self.page = 20;
            [self.models removeAllObjects];
            self.models = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
                [self.myTableView.mj_header endRefreshing];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView.mj_header endRefreshing];
            });
        }
    }];
}

/**实现下拉加载数据的方法 */
- (void)loadMoreData{
    /*
     1.根据self.page拼接刷新网址，若有数据，数组添加新的数组元素，若没有，不作处理
     */
    self.page += 20;
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [LWSDataAlay getFirstPagerCellModelsByStrUrl:[NSString stringWithFormat:URLREFRESH] Results:^(NSMutableArray *results) {
        if (results.count > 0) {
//            NSLog(@"%ld",results.count);
            [self.models removeAllObjects];
            self.models = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
                [self.myTableView.mj_header endRefreshing];
            });
        }
        else{
            self.page -= 20;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView.mj_header endRefreshing];
            });
        }
    }];
}


/**实现协议方法 轮播图的 */
- (void)getDetialUrl:(NSString *)strUrl Title:(NSString *)title{
    [self.delegate getScrollerWebViewStrUrl:strUrl Title:title];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSShowListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"LWSShowListCell" owner:self options:nil] lastObject];
//    }
    cell.model = self.models[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 414;
}

/**cell的选中方法，需要将网址传到上层VC之后使用上层VC的的nav跳转 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSModelFirstPage *model = self.models[indexPath.row];
    [self.delegate getDetialWedViewStrUrl:model.fromurl Model:model];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
