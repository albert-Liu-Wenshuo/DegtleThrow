//
//  InternetService.m
//  UI_Class_16（网络请求）
//
//  Created by dllo on 16/1/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "InternetService.h"

@implementation InternetService

+ (void)getDataFromGetUrlMethod:(NSString *)strUrl
                           Data:(DataBlock)dataBlock{
    NSURL *url = [NSURL URLWithString:strUrl];
    
    //构建单例有三种方法
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dataBlock(data);
        
    }];
    
    [dataTask resume];
    
    
}

+ (void)getDataFromPostUrlMethod:(NSString *)strUrl UrlBody:(NSString *)urlBody Data:(DataBlock)dataBlock{
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    /**
     Host: www.dgtle.com
     Cookie: discuz_804f_forum_lastvisit=D_2_1457134399D_60_1457153600D_63_1457526706; discuz_804f_lastact=1457576665%09api.php%09; discuz_804f_lastvisit=1457130726; discuz_804f_mobile=no; discuz_804f_pc_size_c=0; discuz_804f_saltkey=h76tDT22; discuz_804f_seccodeS=73315ByyhP%2BO2AGbdChUFt6AM4mDYNjj24dvf957RyFBPvrGSmdYS%2BZDAcBDj8p2XBqP46Mpkw; discuz_804f_visitedfid=63
     Content-Type: application/x-www-form-urlencoded; charset=utf-8
     Content-Length: 167
     */
    
    [postRequest setValue:@"www.dgtle.com" forHTTPHeaderField:@"Host"];
    [postRequest setValue:@" discuz_804f_forum_lastvisit=D_2_1457134399D_60_1457153600D_63_1457526706; discuz_804f_lastact=1457576665%09api.php%09; discuz_804f_lastvisit=1457130726; discuz_804f_mobile=no; discuz_804f_pc_size_c=0; discuz_804f_saltkey=h76tDT22; discuz_804f_seccodeS=73315ByyhP%2BO2AGbdChUFt6AM4mDYNjj24dvf957RyFBPvrGSmdYS%2BZDAcBDj8p2XBqP46Mpkw; discuz_804f_visitedfid=63" forHTTPHeaderField:@"Cookie"];
    
    [postRequest setValue:@" application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [postRequest setValue:@" 167" forHTTPHeaderField:@"Content-Length"];
    
    [postRequest setHTTPMethod:@"POST"];
    
    [postRequest setHTTPBody:[urlBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:postRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dataBlock(data);
        NSLog(@"错误------%@", error);
    }];
    [dataTask resume];
}

@end
