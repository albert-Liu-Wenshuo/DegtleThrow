//
//  LWSFindMainPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSFindMainPager.h"
#import "LWSSingleManager.h"
#import "LWSMusicPager.h"
#import "LWSHappyFirstPager.h"
#import "LWSAudioShowList.h"

#define URLMUSIC @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"
#define URLHAPPY @"http://c.m.163.com/nc/article/list/T1350383429665/0-20.html"

@interface LWSFindMainPager ()

@end

@implementation LWSFindMainPager

- (NSMutableDictionary *)urls{
    if (_urls == nil) {
        _urls = [[NSMutableDictionary alloc]init];
        [_urls setValue:[NSString stringWithFormat:URLMUSIC] forKey:@"music"];
    }
    return _urls;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createDetialShowView];
    // Do any additional setup after loading the view.
}

- (void)createDetialShowView{
    /**获取图片的自适应高度 */
    UIImage *musciPic = [UIImage imageNamed:@"Deg_MusicCell.jpg"];
    CGSize size = musciPic.size;
    size = CGSizeMake(self.view.frame.size.width - 10, (self.view.frame.size.width - 10) / size.width * size.height * 0.8);
    UIImageView *musicCell = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, size.width, size.height)];
    musicCell.image = musciPic;
    [self.view addSubview:musicCell];
    [musicCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMusicCell)]];
    musicCell.userInteractionEnabled = YES;
    CGRect rect = musicCell.frame;
    rect.origin.y += 5 + rect.size.height;
    rect.size.height = 20;
    UILabel *labelMusic = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labelMusic];
    labelMusic.text = @"我的音乐";
    labelMusic.textAlignment = NSTextAlignmentCenter;
    
    UIImage *happyPic = [UIImage imageNamed:@"Deg_happyPic.jpg"];
    size = happyPic.size;
    CGRect frame = self.view.frame;
    size = CGSizeMake(frame.size.width - 10, size.width / (frame.size.width - 10) * size.height);
    UIImageView *happyCell = [[UIImageView alloc]initWithFrame:CGRectMake(5, labelMusic.frame.origin.y + labelMusic.frame.size.height + 5, size.width, size.height)];
    [self.view addSubview:happyCell];
    happyCell.image = happyPic;
    UITapGestureRecognizer *happyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnHappyPager)];
    [happyCell addGestureRecognizer:happyTap];
    happyCell.userInteractionEnabled = YES;
    
    rect = happyCell.frame;
    rect.origin.y += 5 + rect.size.height;
    rect.size.height = 20;
    UILabel *labelHappy = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labelHappy];
    labelHappy.text = @"开心一刻";
    labelHappy.textAlignment = NSTextAlignmentCenter;
    
    rect.origin.y += 5 + rect.size.height;
    rect.size.height = self.view.frame.size.height - rect.origin.y - 100;
    UIImage *img = [UIImage imageNamed:@"Deg_audio_icon.jpg"];
    UIImageView *audioView = [[UIImageView alloc]initWithFrame:rect];
    CGPoint center = audioView.center;
    center.x = self.view.center.x;
    audioView.center = center;
    audioView.image = img;
    [self.view addSubview:audioView];
    UITapGestureRecognizer *audioTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnAudioPager)];
    audioView.userInteractionEnabled = YES;
    [audioView addGestureRecognizer:audioTap];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)tapOnMusicCell{
    /**跳转到音乐相关的界面 */
    LWSMusicPager *pager = [[LWSMusicPager alloc]init];
    pager.strUrl = [self.urls valueForKey:@"music"];
    [self.navigationController pushViewController:pager animated:YES];
}

- (void)tapOnHappyPager{
    LWSHappyFirstPager *pager = [[LWSHappyFirstPager alloc]init];
    pager.strUrl = URLHAPPY;
    [self.navigationController pushViewController:pager animated:YES];
}

- (void)tapOnAudioPager{
    LWSAudioShowList *pager = [[LWSAudioShowList alloc]init];
    pager.isCreateHeader = YES;
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
