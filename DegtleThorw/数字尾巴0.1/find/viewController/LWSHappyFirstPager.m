//
//  LWSHappyFirstPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSHappyFirstPager.h"
#import "LWSDataAlay.h"
#import "LWSHappyFirstCell.h"
#import "LWSHappyImageCell.h"
#import "LWSHappyNormalCell.h"
#import "LWSHappyerFooterView.h"
#import "LWSHappyHeaderView.h"
#import "LWSDetialWebViewViewController.h"

@interface LWSHappyFirstPager ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)UITableView *tableView;
//获取的是头视图和尾视图的相关内容的模型数组
@property (nonatomic , retain)NSMutableArray *models;


@end

@implementation LWSHappyFirstPager

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
        /**在模型数组的懒加载中加两个模型同时赋值 */
        [LWSDataAlay getFindHappyListByStrUrl:self.strUrl Result:^(NSMutableArray *results) {
            _models = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
    return _models;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView{
    
    CGRect frame = self.view.frame;
    frame.size.height -= 64;
    
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    /** 将需要注册的cell都注册了*/
    [self.tableView registerClass:[LWSHappyFirstCell class] forCellReuseIdentifier:@"firstCell"];
    [self.tableView registerClass:[LWSHappyNormalCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[LWSHappyImageCell class] forCellReuseIdentifier:@"imageCell"];
    /**注册头视图和尾视图 
     网易新闻没有所谓的头视图，都是通过cell来实现的
     */
    [self.tableView registerClass:[LWSHappyHeaderView class] forCellReuseIdentifier:@"header"];
    [self.tableView registerClass:[LWSHappyerFooterView class] forCellReuseIdentifier:@"footer"];
    
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /** 
     需要注意isMemberOfClass和iskindofClass的区别
     */
    if ([self.models[indexPath.row] isKindOfClass:[LWSModelHappyHeader class]]) {
        LWSHappyHeaderView *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
        cell.model = self.models[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        return cell;
    }
    else if ([self.models[indexPath.row] isKindOfClass:[LWSModelHappy class]]){
        LWSModelHappy *model = self.models[indexPath.row];
        if ([model.hasHead isEqualToNumber:@1]) {
//            NSLog(@"是头cell");
            LWSHappyFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
            cell.model = model;
            return cell;
        }
        else if ([model.imgType isEqualToNumber:@1]){
//            NSLog(@"是大图cell");
            LWSHappyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
            cell.model = model;
            return cell;
        }
        else{
            LWSHappyNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.model = model;
            return cell;
        }
    }
    else
        NSLog(@"第%ld个数据有问题",indexPath.row);
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.models[indexPath.row] isKindOfClass:[LWSModelHappyHeader class]]) {
        return 60;
    }
    else if ([self.models[indexPath.row] isKindOfClass:[LWSModelHappy class]]){
        LWSModelHappy *model = self.models[indexPath.row];
        if ([model.hasHead isEqualToNumber:@1]) {
            return 180;
        }
        else if ([model.imgType isEqualToNumber:@1]){
            return 240;
        }
        else
           return 120;
    }
            return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSDetialWebViewViewController *pager = [[LWSDetialWebViewViewController alloc]init];
    if ([self.models[indexPath.row] isKindOfClass:[LWSModelHappyHeader class]]) {
        LWSModelHappyHeader *model = self.models[indexPath.row];
        pager.strUrl = model.url;
        pager.model = [[LWSSQLModel alloc]init];
        pager.model.title = model.subtitle;
        pager.model.url = model.url;
    }else{
        LWSModelHappy *model = self.models[indexPath.row];
        pager.strUrl = model.url;
        pager.model = [[LWSSQLModel alloc]init];
        pager.model.title = model.title;
        pager.model.summary = model.digest;
        pager.model.url = model.url;

    }
    [self.navigationController pushViewController:pager animated:YES];
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
