//
//  LWSAudioShowList.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSAudioShowList.h"
#import "LWSAudioHeader.h"
#import "LWSAudioCell.h"
#import "LWSDataAlay.h"
#import <MediaPlayer/MediaPlayer.h>

#define URL @"http://c.3g.163.com/nc/video/home/0-10.html"

@interface LWSAudioShowList ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)LWSAudioHeader *header;
@property (nonatomic , retain)LWSAudioShowList *pager;
@property (nonatomic , assign)CGFloat pointX;

@end

@implementation LWSAudioShowList

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
        if (self.isCreateHeader) {
            self.strUrl = URL;
            [LWSDataAlay getAudioCellListByStrUrl:self.strUrl Result:^(NSMutableArray *results) {
                _models = results;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];
        }
        else{
            [LWSDataAlay getAudioCellDetialListByStrUrl:self.strUrl Result:^(NSMutableArray *results) {
                _models = results;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];

        }
        
    }
    return _models;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    CGRect frame = self.tableView.frame;
//    frame.size.height -= 64;
    self.tableView.frame = frame;
    /**table的header的高度可能需要调节 */
//    self.tableView.tableHeaderView = [[LWSAudioHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)]; 
    [self.tableView registerClass:[LWSAudioCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    if (_isCreateHeader) {
        [LWSDataAlay getAudioHeaderListByStrUrl:URL Result:^(NSMutableArray *results) {
            /**在主线程中进行为头视图赋值的操作 */
            self.header = [[LWSAudioHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80) Models:results];
            self.header.userInteractionEnabled = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.tableHeaderView = self.header;
                self.tableView.tableHeaderView.userInteractionEnabled = YES;
            });
        }];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSAudioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSModelAudioCell *model = self.models[indexPath.row];
    MPMoviePlayerViewController *movieVc=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.mp4_url]];
    [self presentMoviePlayerViewControllerAnimated:movieVc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] preciseLocationInView:self.view];
    if (self.pointX != touchPoint.x) {
        if (touchPoint.y - 64 > 0 && touchPoint.y - 64 < 80) {
            LWSModelAudioHeader *model;
            self.pager = [[LWSAudioShowList alloc]init];
            self.pager.isCreateHeader = NO;
            if (touchPoint.x > 0 && touchPoint.x < self.view.frame.size.width / 4.0) {
                model = self.header.models[0];
                self.pager.strUrl = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/%@/y/0-10.html",model.sid];
                
            }else if (touchPoint.x > self.view.frame.size.width / 4.0 && touchPoint.x < self.view.frame.size.width / 4.0 * 2){
                model = self.header.models[1];
                self.pager.strUrl = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/%@/y/0-10.html",model.sid];
            }else if (touchPoint.x > self.view.frame.size.width / 4.0 * 2 && touchPoint.x < self.view.frame.size.width / 4.0 * 3){
                model = self.header.models[2];
                self.pager.strUrl = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/%@/y/0-10.html",model.sid];
            }else{
                model = self.header.models[3];
                self.pager.strUrl = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/%@/y/0-10.html",model.sid];
            }
            [self.navigationController pushViewController:self.pager animated:YES];
            self.pointX = touchPoint.x;
        }

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
