//
//  LWSMusicDetialPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSMusicDetialPager.h"
#import "LWSMusicPlayView.h"
#import "LWSIrcCell.h"
#import "LWSSingleManager.h"

@interface LWSMusicDetialPager ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)NSMutableArray *ircs;
@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)LWSMusicPlayView *playerView;

@end

@implementation LWSMusicDetialPager

- (NSMutableArray *)ircs{
    if (_ircs == nil) {
        _ircs = [[NSMutableArray alloc]init];
        /**由一个个具有两个元素的数组组成 数组[1]的内容是irc的字符串 */
        [self getListFromModel:self.model.lyric];
    }
    return _ircs;
}

- (void)getListFromModel:(NSString *)lyirc{
    NSString *ircAll = lyirc;
    NSArray *arr = [ircAll componentsSeparatedByString:@"["];
    for (NSString *str in arr) {
        NSArray *irc = [str componentsSeparatedByString:@"]"];
        if (irc.count == 2) {
            [self.ircs addObject:irc];
        }
    }
//    NSLog(@"%@",self.ircs);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self createMusicPlayerView];
    // Do any additional setup after loading the view.
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LWSIrcCell class] forCellReuseIdentifier:@"cell"];
}

- (void)createMusicPlayerView{
    CGRect frame = self.view.frame;
    frame.origin.y = frame.size.height - 100 - 64;
    frame.size.height = 100;
    self.playerView = [[LWSMusicPlayView alloc]initWithFrame:frame];
    self.playerView.model = self.model;
    __weak LWSMusicDetialPager *weakSelf = self;
    self.playerView.myBlock = ^(LWSMusicUseType type){
        /**防止因为使用了block和self导致的循环引用 */
        LWSModelMusic __block *model = [weakSelf.pagerDelegate getNextMusicModel:weakSelf.model];
        if (model) {
            weakSelf.model = model;
            [weakSelf.ircs removeAllObjects];
            weakSelf.ircs = [NSMutableArray array];
            [weakSelf getListFromModel:weakSelf.model.lyric];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                weakSelf.playerView.model = weakSelf.model;
                [[LWSSingleManager shanreSingleManager] musicPlayWithUrl:[NSURL URLWithString:weakSelf.model.mp3Url]];
            });
        }
    };
    [self.view addSubview:self.playerView];
    frame = self.tableView.frame;
    frame.size.height -= 164;
    self.tableView.frame = frame;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSIrcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.irc = [self.ircs[indexPath.row] objectAtIndex:1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ircs.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
