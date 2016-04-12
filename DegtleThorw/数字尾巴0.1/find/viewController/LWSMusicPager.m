//
//  LWSMusicPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSMusicPager.h"
#import "LWSDataAlay.h"
#import "ListCell.h"
#import "LWSMusicDetialPager.h"
#import "LWSSingleManager.h"

@interface LWSMusicPager ()<UITableViewDataSource , UITableViewDelegate , LWSMusicDetialPagerDelegate , LWSMusicDetialPagerDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *tableView;

@end

@implementation LWSMusicPager

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
        [LWSDataAlay getFindMusicListByStrUrl:self.strUrl Result:^(NSMutableArray *results) {
            _models = [NSMutableArray arrayWithArray:results];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
    return _models;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSMusicDetialPager *pager = [[LWSMusicDetialPager alloc]init];
    pager.model = self.models[indexPath.row];
    pager.pagerDelegate = self;
    /**跳转页面之前播放当前页面的音乐 */
    [[LWSSingleManager shanreSingleManager] musicPlayWithUrl:[NSURL URLWithString:pager.model.mp3Url]];
    [self.navigationController pushViewController:pager animated:YES];
}

- (LWSModelMusic *)getNextMusicModel:(LWSModelMusic *)model{
    NSInteger index = [self.models indexOfObject:model];
    if (index < self.models.count - 2) {
        index++;
        return [self.models objectAtIndex:index];
    }else
        return nil;
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
