//
//  LWSMinePagerViewController.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSMinePagerViewController.h"
#import "LWSHeaderView.h"
#import "LWSMineCell.h"
#import "LWSModelMine.h"
#import "LWSLoginPager.h"
#import "LWSJudgeLogin.h"
#import "LWSRegisterPager.h"
#import "LWSCollectionPager.h"
#import "LWSUserManagerPager.h"
#import "LWSClearCache.h"

@interface LWSMinePagerViewController ()<UITableViewDataSource , UITableViewDelegate , LWSHeaderViewDelegate>

@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)LWSHeaderView *header;

@end

@implementation LWSMinePagerViewController

- (NSMutableArray *)models{
    if (_models == nil) {
        /**在这里设置模型数组 */
        NSMutableArray *arrOne = [NSMutableArray array];
        NSMutableArray *arrTwo = [NSMutableArray array];
        [arrOne addObject:[LWSModelMine modelWithTitle:@"我的账户" Icon:[[UIImage imageNamed:@"account@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] NeedLogin:YES]];
        [arrOne addObject:[LWSModelMine modelWithTitle:@"我的收藏" Icon:[[UIImage imageNamed:@"collection@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] NeedLogin:YES]];
        [arrOne addObject:[LWSModelMine modelWithTitle:@"我的帖子" Icon:[[UIImage imageNamed:@"article"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] NeedLogin:YES]];
        [arrOne addObject:[LWSModelMine modelWithTitle:@"清除缓存" Icon:[[UIImage imageNamed:@"culture_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] NeedLogin:NO]];
        
        [arrTwo addObject:[LWSModelMine modelWithTitle:@"离线下载" Icon:[[UIImage imageNamed:@"download@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] NeedLogin:NO]];
        [arrTwo addObject:[LWSModelMine modelWithTitle:@"系统设置" Icon:[[UIImage imageNamed:@"category_menu@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] NeedLogin:NO]];
        _models = [NSMutableArray arrayWithObjects:arrOne , arrTwo, nil];
    }
    return _models;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    // Do any additional setup after loading the view.
}

/**在这里判断登录状态的标签变化 */
- (void)viewWillAppear:(BOOL)animated{
    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    if (userName != nil && ![userName isEqualToString:@""]) {
        self.header.labelSign.text = userName;
    }
    else{
        self.header.labelSign.text = @"未登录";
    }
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.header = [[LWSHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.header.delegate = self;
    self.tableView.tableHeaderView = self.header;
    [self.tableView registerClass:[LWSMineCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

/**判断进入那个选中的条目的方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSModelMine *model = self.models[indexPath.section][indexPath.row];
    if (model.needLogin) {
        /**在这里添加判断，如果系统存在用户标示的时候直接进入功能，否则进入登录状态 */
        NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
        if (userName != nil && ![userName isEqualToString:@""]) {
            /**代表已进入登录状态 这里写进入对应功能 */
            NSLog(@"已经进入登录状态");
            [self judgeByMethodName:model.title];
        }else{
            LWSLoginPager *pager = [[LWSLoginPager alloc]init];
            [self presentViewController:pager animated:YES completion:^{
                
            }];

        }
    }
    else {
        [self judgeByMethodName:model.title];
    }
}

/** 根据功能的名字确定跳转的功能*/
- (void)judgeByMethodName:(NSString *)name{
    if ([name isEqualToString:@"我的收藏"]) {
        LWSCollectionPager *pager = [[LWSCollectionPager alloc]init];
        [self.navigationController pushViewController:pager animated:YES];
    }
    if ([name isEqualToString:@"我的账户"]) {
        LWSUserManagerPager *pager = [[LWSUserManagerPager alloc]init];
        [self.navigationController pushViewController:pager animated:YES];
    }
    if ([name isEqualToString:@"清除缓存"]) {
        NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        CGFloat size = [LWSClearCache flodersSizeAtPath:paths];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小为%.2fM ， 是否清除？",size] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LWSClearCache clearCache:paths];
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

/**headerView的 3 个协议方法的实现 */
- (void)jumpByAlertView:(UIAlertController *)alert{
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)jumpToLoginPager{
    LWSLoginPager *pager = [[LWSLoginPager alloc]init];
    [self presentViewController:pager animated:YES completion:^{
        
    }];
}

- (void)jumpToRegisterPAger{
     LWSRegisterPager *pager = [[LWSRegisterPager alloc]init];
    [self presentViewController:pager animated:YES completion:^{
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.models[indexPath.section][indexPath.row];
    cell.selectionStyle = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.models[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
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
