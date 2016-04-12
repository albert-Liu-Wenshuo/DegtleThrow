//
//  LWSAuthorCollectionPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSAuthorCollectionPager.h"
#import "LWSDataAlay.h"
#import "LWSModelCollection.h"
#import "LWSCollectionTableCell.h"

@interface LWSAuthorCollectionPager ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *tableView;

@end

@implementation LWSAuthorCollectionPager

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
        [LWSDataAlay getCommunityCollectionPagerDetialByStrUrl:self.strUrl Result:^(NSMutableArray *results) {
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
    [self.tableView registerClass:[LWSCollectionTableCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSCollectionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.models[indexPath.row];
    return cell;
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
