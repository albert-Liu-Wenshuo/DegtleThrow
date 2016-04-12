//
//  LWSCommunityShowDetialPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSCommunityShowDetialPager.h"
#import "LWSDataAlay.h"
#import <WebKit/WebKit.h>
#import "LWSModelShowDetial.h"
#import "LWSShowImageCell.h"
#import "LWSShowTitleCell.h"
#import "LWSDataAlay.h"
#import "LWSLabelSize.h"

@interface LWSCommunityShowDetialPager ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain)UITableView *tableView;
@property (nonatomic , assign)NSInteger titleIndex;

@end

@implementation LWSCommunityShowDetialPager


/**
 tableview 选中一行后，不显示选中颜色，不要将tableview的allowsSelection设置成NO，那样的话可能导致tableview不能响应点击动作。合理的解决方法是：cell.selectionStyle = UITableViewCellSelectionStyleNone;
 */

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [[NSMutableArray alloc]init];
        [LWSDataAlay getCommunityShowDetialArrayByStrUrl:self.strUrl Results:^(LWSModelShowDetial *result) {
            for (int i = 0; i < result.titles.count; i++) {
                if ([self removeFromStr:result.titles[i]]) {
                    [self.array addObject:[self removeFromStr:result.titles[i]]];
                }
                for (NSDictionary *item in result.imageUrls) {
                    NSString *url = [item valueForKey:[NSString stringWithFormat:@"%d",i]];
                    if (url != NULL) {
                        [self.array addObject:url];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
    return _array;
    
}

- (NSString *)removeFromStr:(NSString *)str{
    if ([str containsString:@"\r\n"]) {
        if ([str isEqualToString:@"\r\n"]) {
            return nil;
        }
        return [NSString stringWithFormat:@"      %@",[str substringFromIndex:2]];
    }
    return str;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    /**实现显示网址文件的话，考虑使用tableView （需要重写一个方法是tableView选中不改变颜色） */
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView{
    CGRect frame = self.view.frame;
    frame.size.height -= 64;
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LWSShowImageCell class] forCellReuseIdentifier:@"img"];
    [self.tableView registerClass:[LWSShowTitleCell class] forCellReuseIdentifier:@"title"];
    [self.view addSubview:self.tableView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.array[indexPath.row] containsString:@".jpg"]) {
        LWSShowImageCell *imgCell = [tableView dequeueReusableCellWithIdentifier:@"img"];
        imgCell.picUrl = self.array[indexPath.row];
        /**使cell选中后不会发生变化，但是实际上有点击效果 */
        imgCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return imgCell;
    }
    else{
        LWSShowTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        titleCell.title = self.array[indexPath.row];
        titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return titleCell;
    }
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.array[indexPath.row] containsString:@".jpg"]) {
        
        return [self getActualPicSizeByImage:[UIImage imageNamed:@"Deg_holder.jpg"] imageViewWidth:self.view.frame.size.width - 20].height + 20;
    }
    else{
        NSString *str = self.array[indexPath.row];
//        NSLog(@"字符串形式的行高是：%f",[LWSLabelSize getLabelForumSize:str].height + 10);
         return [LWSLabelSize getLabelForumSize:str].height + 20;
    }
    return 100;
}

- (CGSize)getActualPicSizeByImage:(UIImage *)image
                   imageViewWidth:(CGFloat)width{
    CGSize size = image.size;
    size = CGSizeMake(width, (width / size.width) * size.height);
    return size;
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
