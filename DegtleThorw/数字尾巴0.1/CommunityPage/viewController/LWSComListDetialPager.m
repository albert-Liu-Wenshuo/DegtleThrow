//
//  LWSComListDetialPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSComListDetialPager.h"
#import "LWSCommunityListCell.h"
#import "LWSDataAlay.h"
#import "LWSCommunityShowDetialPager.h"

#define IDENTIFINER @"CommunityListCell"

@interface LWSComListDetialPager ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *myTableView;

@end

@implementation LWSComListDetialPager

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
        //在这里获取对应的模型
        [LWSDataAlay getCommunityPagerListDetialModelsByUrl:self.url Results:^(NSMutableArray *results) {
            _models = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
            });
        }];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    // Do any additional setup after loading the view.
}


- (void)createTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"LWSCommunityListCell" bundle:nil];
    [self.myTableView registerNib:nib forCellReuseIdentifier:IDENTIFINER];
    [self.view addSubview:self.myTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    CGRect frame = self.myTableView.frame;
    frame.size.height = self.view.frame.size.height;
    self.myTableView.frame = frame;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSCommunityListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFINER];
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
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSCommunityShowDetialPager *showPager = [[LWSCommunityShowDetialPager alloc]init];
    showPager.strUrl = [NSString stringWithFormat:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=forum&actions=viewthread&ordertype=1&tid=%@",[self.models[indexPath.row] tid]];
    [self.navigationController pushViewController:showPager animated:YES];
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
