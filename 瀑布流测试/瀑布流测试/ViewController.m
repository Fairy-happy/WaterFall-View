//
//  ViewController.m
//  瀑布流测试
//
//  Created by fairy on 2017/4/25.
//  Copyright © 2017年 fairy. All rights reserved.
//

#import "ViewController.h"
#import "FairyFallsLayout.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "FairyShopCell.h"
#import "FairyShop.h"

@interface ViewController ()<UICollectionViewDataSource, FairyFallsLayoutDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, strong) FairyFallsLayout *fallsLayout;
@end

@implementation ViewController

static NSString *const ID = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self setupRefresh];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 创建collectionView
- (void)setupCollectionView
{
    _fallsLayout = [[FairyFallsLayout alloc] init];
    _fallsLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_fallsLayout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FairyShopCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - 创建上下拉刷新
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 加载下拉数据
- (void)loadNewShops
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *shops = [FairyShop mj_objectArrayWithFilename:@"1.plist"];
        [weakSelf.shops removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            [weakSelf.shops addObjectsFromArray:shops];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView reloadData];
            _fallsLayout.i = 0;
        });
    });
}

#pragma mark - 加载上拉数据
- (void)loadMoreShops
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *shops = [FairyShop mj_objectArrayWithFilename:@"1.plist"];
        [weakSelf.shops addObjectsFromArray:shops];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView reloadData];
        });
    });
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FairyShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (self.shops && self.shops.count >= indexPath.item+1) cell.shop = self.shops[indexPath.item];
    return cell;
}

- (CGFloat)columnMarginInFallsLayout:(FairyFallsLayout *)fallsLayout
{
    return 3;
}

- (CGFloat)rowMarginInFallsLayout:(FairyFallsLayout *)fallsLayout
{
    return 3;
}

- (CGFloat)columnCountInFallsLayout:(FairyFallsLayout *)fallsLayout
{
    return 4;
}

- (UIEdgeInsets)edgeInsetsInFallsLayout:(FairyFallsLayout *)fallsLayout
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
