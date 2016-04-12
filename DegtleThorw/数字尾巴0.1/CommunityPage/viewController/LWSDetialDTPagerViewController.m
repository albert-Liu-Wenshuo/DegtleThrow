//
//  LWSDetialDTPagerViewController.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSDetialDTPagerViewController.h"
#import "LWSComDegtleThrowDetialView.h"

@interface LWSDetialDTPagerViewController ()<LWSComDegtleThrowDetialViewDelegate>

@property (nonatomic , retain)LWSComDegtleThrowDetialView *showView;
@property (nonatomic , assign)BOOL isObserveColsed;

@end

@implementation LWSDetialDTPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isObserveColsed = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.showView = [[LWSComDegtleThrowDetialView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.showView.model = self.model;
    [self.view addSubview:self.showView];
    self.showView.delegate = self;
}

- (void)closeObserver{
    for (UIImageView *imageView in self.showView.images) {
        [imageView removeObserver:self.showView forKeyPath:@"image" context:nil];
    }
    self.isObserveColsed = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.isObserveColsed) {
        for (UIImageView *imageView in self.showView.images) {
            [imageView removeObserver:self.showView forKeyPath:@"image" context:nil];
        }
        self.isObserveColsed = YES;
    }
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"username"]) {
//        NSString *name = [change valueForKey:@"new"];
//        if (name) {
//            LWSComDegtleThrowDetialView *view = [[LWSComDegtleThrowDetialView alloc]initWithFrame:self.view.frame];
//            view.model = self.model;
//            [self.view addSubview:view];
//        }
//    }
//}

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
