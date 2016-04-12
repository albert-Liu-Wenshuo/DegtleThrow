//
//  LWSSeacchPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSSeacchPager.h"
#import "LWSModelFirstPage.h"
#import "LWSShowListCell.h"
#import "LWSDetialWebViewViewController.h"
#import "LWSSQLModel.h"
#import "LWSDataAlay.h"

#define IDENTIFIER @"ShowListCell"
#define POSTURL @"http://www.dgtle.com/api/dgtle_api/v1/api.php?REQUESTCODE=29&page=1&perpage=20&swh=480x800&charset=UTF8&dataform=json&apikeys=DGTLECOM_APITEST1&platform=ios&version=2.8&inapi=yes"

@interface LWSSeacchPager ()<UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , retain)UITextField *textSearch;
@property (nonatomic , assign)BOOL isSelected;
@property (nonatomic , retain)UIButton *searchBtn;

@end

@implementation LWSSeacchPager

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc]init];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**创建搜索框 */
    self.isSelected = YES;
    [self createTableView];
    [self createSearchView];
    // Do any additional setup after loading the view.
}

- (void)createSearchView{
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width - 20, 40);
    UIView *searchView = [[UIView alloc]initWithFrame:frame];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchView];
    self.textSearch = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, (frame.size.width - 40) / 6.0 * 5 - 10, 30)];
    [searchView addSubview:self.textSearch];
    self.textSearch.delegate = self;
    self.textSearch.borderStyle = UITextBorderStyleRoundedRect;
    self.textSearch.clearButtonMode = UITextFieldViewModeAlways;
    self.textSearch.placeholder = @"请输入搜索内容";
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(30 + self.textSearch.frame.size.width, 5, (frame.size.width - 40) / 6.0, 30)];
    self.searchBtn.backgroundColor = [UIColor grayColor];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    self.searchBtn.titleLabel.textColor = [UIColor darkGrayColor];
    [self.searchBtn addTarget:self action:@selector(clickOnSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:self.searchBtn];
}

- (void)createTableView{
    CGRect frame = self.view.frame;
    frame.size.height -= 64;
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"LWSShowListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:IDENTIFIER];
    [self.view addSubview:self.tableView];
}

- (void)clickOnSearchBtn:(UIButton *)sender{
    if (self.isSelected) {
        self.isSelected = !self.isSelected;
        NSString *name = self.textSearch.text;
        NSLog(@"%@", name);
        [self.textSearch resignFirstResponder];
        [self doSearchByName:name SearchButton:sender];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)doSearchByName:(NSString *)name
          SearchButton:(UIButton *)sender{
    if (![name isEqualToString:@""]) {
        [LWSDataAlay getSearchPageCellModelsByStrUrl:POSTURL SearchTitle:name Result:^(NSMutableArray *results) {
            [self.models removeAllObjects];
            self.models = results;
            if (self.models.count > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    sender.titleLabel.text = @"取消";
                });
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"消息提示" message:@"没有你搜索的结果" preferredStyle:UIAlertControllerStyleActionSheet];
                [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:YES completion:^{
                        sender.titleLabel.text = @"取消";
                    }];
                });
            }
        }];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self doSearchByName:textField.text SearchButton:self.searchBtn];
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSShowListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
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
    return 414;
}

/**cell的选中方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LWSModelFirstPage *model = self.models[indexPath.row];
    LWSDetialWebViewViewController *pager = [[LWSDetialWebViewViewController alloc]init];
    pager.model = [[LWSSQLModel alloc]init];
    pager.model.title = model.title;
    pager.model.summary = model.summary;
    pager.model.url = model.fromurl;
    pager.strUrl = model.fromurl;
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
