//
//  LWSDetialWebViewViewController.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSDetialWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "LWSSQLTool.h"
@interface LWSDetialWebViewViewController ()

@end

@implementation LWSDetialWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self changeTabBar];
    /**在这里添加webView */
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:webView];
//    webView.scalesPageToFit = YES;
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strUrl]]];
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=self.view.frame.size.width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\""];
//    [webView stringByEvaluatingJavaScriptFromString:meta];
    // Do any additional setup after loading the view.
    
    
    /**!!!新版的webView*/
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webView];
//    webView.scalesPageToFit = YES;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strUrl]]];
}

/**修改导航栏 */
- (void)changeTabBar{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<--" style:UIBarButtonItemStylePlain target:self action:@selector(clickOnBackBtn)];
    UIBarButtonItem *bookSign = [[UIBarButtonItem alloc]initWithTitle:@"书签" style:UIBarButtonItemStylePlain target:self action:@selector(clickOnBookSignBtn)];
    UIBarButtonItem *share = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(clickOnShareBtn)];
    UIBarButtonItem *message = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(clickOnMessageBtn)];
    NSArray *array = @[bookSign , share , message];
    self.navigationItem.rightBarButtonItems = array;
}

- (void)clickOnBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickOnBookSignBtn{
    
}

- (void)clickOnShareBtn{
//    [LWSSQLTool deleteCollectionAllItems];
}

/**修改后作为收藏界面使用 */
- (void)clickOnMessageBtn{
    //将该模型收藏进数据库
    [LWSSQLTool insertCollectionWithModel:self.model];
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
