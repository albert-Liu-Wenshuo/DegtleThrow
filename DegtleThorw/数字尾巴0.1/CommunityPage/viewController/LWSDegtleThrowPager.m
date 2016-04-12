//
//  LWSDegtleThrowPager.m
//  数字尾巴0.1
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSDegtleThrowPager.h"
#import "LWSDataAlay.h"
#import "LWSCollectionViewCell.h"
#import "LWSDetialDTPagerViewController.h"

#import "UIView+MJExtension.h"
#import "MJRefresh.h"

#define WEBPINTID @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&modules=forum&actions=viewthread&ordertype=1&tid=%@",model.tid
#define URLREFRESH @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&sortsearch=1&sortid=27&attachdata=1&page=%@&orderby=dateline&fid=46&REQUESTCODE=5",page

#define URLMAIN @"http://www.dgtle.com/api/dgtle_api/v1/api.php?charset=UTF8&dataform=json&swh=480x800&apikeys=DGTLECOM_APITEST1&sortsearch=1&sortid=27&attachdata=1&page=1&orderby=dateline&fid=46&REQUESTCODE=5"

@interface LWSDegtleThrowPager ()<UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic , retain)NSMutableArray *models;
@property (nonatomic , retain)UICollectionView *collectionView;
@property (nonatomic , assign)NSInteger page;

@end

@implementation LWSDegtleThrowPager

- (NSMutableArray *)models{
    if (_models == nil) {
        self.page = 1;
        _models = [[NSMutableArray alloc]init];
        [LWSDataAlay getCommunityDegtleThrowPagerDetialByUrl:self.url Results:^(NSMutableArray *results) {
            _models = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
    return _models;
    
}


/**在这里需要创建一个collectionView */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCollectionView];
    // Do any additional setup after loading the view.
}

- (void)createCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
//    @property (nonatomic) CGFloat minimumLineSpacing;
//    @property (nonatomic) CGFloat minimumInteritemSpacing;
//    @property (nonatomic) CGSize itemSize;
//    @property (nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0); // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
//    @property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
//    @property (nonatomic) CGSize headerReferenceSize;
//    @property (nonatomic) CGSize footerReferenceSize;
//    @property (nonatomic) UIEdgeInsets sectionInset;
    
    CGSize size = self.view.frame.size;
    flowLayout.itemSize = CGSizeMake((size.width - 30) / 2, (size.width - 30) / 2);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGRect frame = self.view.frame;
    frame.size.height -= 64;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[LWSCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor grayColor];
    /**为collection添加刷新 */
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

/**上拉刷新的加载数据的方法 */
- (void)loadNewData{
    /*
     1.判断上拉是否有数据
     2.若有，清空原来数组，将新数组刷新到模型数组中（在返回到主线程中刷新数据）
     3.若没有则不变
     */
    [LWSDataAlay getCommunityDegtleThrowPagerDetialByUrl:[NSURL URLWithString:URLMAIN] Results:^(NSMutableArray *results) {
        if (results.count > 0) {
            [self.models removeAllObjects];
            self.page = 1;
            self.models = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                [self.collectionView.mj_header endRefreshing];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView.mj_header endRefreshing];
            });

        }
    }];
}

/**实现下拉加载数据的方法 */
- (void)loadMoreData{
    /*
     1.根据self.page拼接刷新网址，若有数据，数组添加新的数组元素，若没有，不作处理
     */
    self.page ++;
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    [LWSDataAlay getCommunityDegtleThrowPagerDetialByUrl:[NSURL URLWithString:[NSString stringWithFormat:URLREFRESH]] Results:^(NSMutableArray *results) {
        if (results.count > 0) {
            NSLog(@"%ld",results.count);
            [self.models addObjectsFromArray:results];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                [self.collectionView.mj_footer endRefreshing];
            });
        }
        else{
            self.page --;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView.mj_footer endRefreshing];
            });
        }
    }];
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LWSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LWSModelDegtleThrow *model = self.models[indexPath.row];
    LWSDetialDTPagerViewController *detialPager = [[LWSDetialDTPagerViewController alloc]init];
    [LWSDataAlay getCommunityDetialDegtleCollectionModelByStrUrl:[NSString stringWithFormat:WEBPINTID] Result:^(LWSModelDetialThrow *result) {
        detialPager.model = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:detialPager animated:YES];
        });
    }];
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
