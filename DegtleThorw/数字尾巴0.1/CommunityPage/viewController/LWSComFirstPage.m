//
//  LWSComFirstPage.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSComFirstPage.h"
#import "LWSModelCommunityList.h"
#import "LWSDataAlay.h"
#import "LWSHeaderScrollerView.h"

#define COMLISTNotication @"communityListUrlNotication"
#define COMDgtleThrow @"communityDegtleThroeListUrlNotication"
#define URLDegtleMain @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=forum&actions=forumdisplay&fid=2&page=1&typeid=&orderby=lastpost"
#define URLDegtleThrow @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&sortsearch=1&sortid=27&attachdata=1&page=1&orderby=dateline&fid=46&REQUESTCODE=5"
#define URLDegtleIdentification @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=forum&actions=forumdisplay&fid=77&page=1&typeid=&orderby=lastpost"
#define URLDegtleThing @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=forum&actions=forumdisplay&fid=36&page=1&typeid=&orderby=lastpost"
#define URLDegtleTrangle @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=forum&actions=forumdisplay&fid=49&page=1&typeid=&orderby=lastpost"
#define URLHEADER @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=portal&actions=diydata&bid=274"

@interface LWSComFirstPage ()<UITableViewDataSource , UITableViewDelegate , HeaderScrollerViewDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *tableView;

@end

@implementation LWSComFirstPage

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
    }
    return _models;
}

- (void)viewDidLoad{
    //获取模型
    [self addMessageToModels];
    //添加tableView
    [self createTableView];
}

/**在这里将能用到的模型的数据封装好 */
- (void)addMessageToModels{
    NSString *urlDegtleMain = URLDegtleMain;
    NSString *strDegtleMain = @"尾巴主版";
    
    NSString *urlDegtleThrow = URLDegtleThrow;
    NSString *strDegtleThrow = @"甩甩尾巴";
    
    NSString *urlDegtleIdentification = URLDegtleIdentification;
    NSString *strDegtleIdentification = @"尾巴认证";
    
    NSString *urlDegtleThing = URLDegtleThing;
    NSString *strDegtleThing = @"尾巴良品";
    
    NSString *urlDegtleTangle = URLDegtleTrangle;
    NSString *strDegtleTangle = @"纠结尾巴";
    
    [self.models addObject:[LWSModelCommunityList modelCommunityWithTitle:strDegtleMain Url:urlDegtleMain]];
    [self.models addObject:[LWSModelCommunityList modelCommunityWithTitle:strDegtleThrow Url:urlDegtleThrow]];
    [self.models addObject:[LWSModelCommunityList modelCommunityWithTitle:strDegtleIdentification Url:urlDegtleIdentification]];
    [self.models addObject:[LWSModelCommunityList modelCommunityWithTitle:strDegtleThing Url:urlDegtleThing]];
    [self.models addObject:[LWSModelCommunityList modelCommunityWithTitle:strDegtleTangle Url:urlDegtleTangle]];
}

/**创建将要使用的tableView */
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    /**添加头视图 */
    [LWSDataAlay getFirstPagerHeaderViewModelsByStrUrl:URLHEADER Results:^(NSMutableArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect frame = self.view.frame;
            frame.size.height = 150;
            LWSHeaderScrollerView *scroller = [[LWSHeaderScrollerView alloc]initWithFrame:frame Model:results];
            self.tableView.tableHeaderView = scroller;
            scroller.delegate = self;
        });
    }];
}

/**实现协议方法 */

- (void)getDetialUrl:(NSString *)strUrl Title:(NSString *)title{
    [self.delegate getScrollerWebViewStrUrl:strUrl Title:title];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.models[indexPath.row] title];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

/**在这里添加通知当cell选中的时候将对应的网址传到首页的vc进行跳转 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSURL *strUrl = [self.models[indexPath.row] url];
    //这里获取到的是网址对象不是字符串
    NSDictionary *dic = @{@"url" : strUrl};
    //添加(发送)通知
    if (indexPath.row != 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:COMLISTNotication object:nil userInfo:dic];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:COMDgtleThrow object:nil userInfo:dic];
    }
}

@end
