//
//  LWSUserManagerPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSUserManagerPager.h"
#import "LWSSQLUser.h"
#import "LWSUserModel.h"


@interface LWSUserManagerPager ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *tableView;

@end

@implementation LWSUserManagerPager

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [LWSSQLUser selectUserByName:nil];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置右侧按钮
    self.navigationItem.rightBarButtonItem =self.editButtonItem;
    /** 重写左返回按钮*/
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)goback{
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    if ([LWSSQLUser selectUserByName:name].count > 0) {
        
    }else
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userName"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    CGRect frame = self.view.frame;
    frame.origin.y = frame.size.height - 30 - 64;
    frame.size.height = 30;
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"删除全部" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleteAllCell) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:button];
}

- (void)deleteAllCell{
    [LWSSQLUser deleteUserAllItems];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userName"];
    [self.models removeAllObjects];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSUserModel *model = self.models[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"姓名";
    cell.detailTextLabel.text = model.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LWSUserModel *model = self.models[indexPath.row];
//    LWSDetialWebViewViewController *pager = [[LWSDetialWebViewViewController alloc]init];
//    pager.strUrl = model.url;
//    [self.navigationController pushViewController:pager animated:YES];
//}

//!第二步，重写方法(添加关联)
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

//设置是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//设置编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //清空数据库中该行数据
        LWSUserModel *model = self.models[indexPath.row];
        [self.models removeObjectAtIndex:indexPath.row];
        [LWSSQLUser deleteUserWithName:model.name];
        //更新UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
