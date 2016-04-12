//
//  LWSAuthorForumPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSAuthorForumPager.h"
#import "LWSDataAlay.h"
#import "LWSAuthorForumCell.h"
#import "LWSDataAlay.h"

@interface LWSAuthorForumPager ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)UITableView *tableView;

@end

@implementation LWSAuthorForumPager

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
        //从网络获取该模型的数据
        [LWSDataAlay getCommunityAuthorListDetialModelsByUrl:[NSURL URLWithString:self.strUrl] Results:^(NSMutableArray *results) {
            _models = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
    return _models;
}

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LWSAuthorForumCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSAuthorForumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view removeObserver:self forKeyPath:@"frame" context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    NSLog(@"vc的view的高改变为%@",[change valueForKey:@"new"]);
    CGRect frame = self.view.frame;
    frame.size.height -= 64;
    self.tableView.frame = frame;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


@end
