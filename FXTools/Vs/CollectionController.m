//
//  CollectionController.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/22.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "CollectionController.h"
#import "Header.h"
#import "CollectionViewCell.h"
@interface CollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic) NSInteger sectionCount;
@property (nonatomic, strong) NSMutableArray *itemCounts;
@property (nonatomic) BOOL largeItems;
@property (nonatomic, strong) UICollectionViewFlowLayout *smallLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *largeLayout;
@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CollectionController
- (UICollectionView *)collectionView {
    if (_collectionView ==nil) {
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:self.smallLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"SimpleCell"];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor=[UIColor whiteColor];
    }
    return _collectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sectionCount = 1;
    self.itemCounts = [NSMutableArray arrayWithArray:@[@(6), @(16), @(14)]];
    
    self.smallLayout = [[UICollectionViewFlowLayout alloc] init];
    _smallLayout.sectionInset = UIEdgeInsetsMake(KLEFT, KLEFT, KSPACE, KLEFT);
    _smallLayout.minimumLineSpacing = KSPACE;
    _smallLayout.minimumInteritemSpacing = 20;
    
    self.largeLayout = [[UICollectionViewFlowLayout alloc] init];
    _largeLayout.sectionInset = UIEdgeInsetsMake(CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN);
    _largeLayout.minimumLineSpacing = CGFLOAT_MIN;
    _largeLayout.minimumInteritemSpacing = CGFLOAT_MIN;
    
    self.largeItems = NO;
    self.collectionView.collectionViewLayout = _smallLayout;
    
    UIBarButtonItem *insertItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(insertItem)];
    
    UIBarButtonItem *toggleSizeItem = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                       target:self
                                       action:@selector(toggleItemSize)];
    
    self.navigationItem.rightBarButtonItems = @[toggleSizeItem, insertItem];
    [self.view addSubview:self.collectionView];
    
    dispatch_async(dispatch_queue_create("com.imread.gcd", DISPATCH_QUEUE_SERIAL), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"--------- %d",i);
        }
        NSLog(@"--------------------------------------");
        
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)insertItem
{
    NSInteger randomSection = arc4random()%_sectionCount;
    
    NSInteger item = [_itemCounts[randomSection] integerValue] + 1;
    _itemCounts[randomSection] = @(item);
    
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:arc4random()%(item) inSection:randomSection]]];
}

- (void)toggleItemSize
{
    if (_largeItems) {
        _largeItems = NO;
        [self.collectionView setCollectionViewLayout:_smallLayout animated:YES];
    }
    else {
        _largeItems = YES;
        [self.collectionView setCollectionViewLayout:_largeLayout animated:YES];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell * cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!_largeItems) {
        [cell setCellsNum:0];
        return CGSizeMake(100, 120);
    }
    else {
        [cell setCellsNum:1];
        return CGSizeMake(WIDTH, 80);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_itemCounts[section] integerValue];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SimpleCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
    CGFloat colorValue = 1.0-(indexPath.item+1.0)/(2*itemCount);
    
    cell.backgroundColor = [UIColor colorWithRed:(indexPath.section==0)?colorValue:0.0
                                           green:(indexPath.section==1)?colorValue:0.0
                                            blue:(indexPath.section==2)?colorValue:0.0
                                           alpha:1.0];
    if (!_largeItems) {
        [cell setCellsNum:0];
    }
    else {
        [cell setCellsNum:1];
    }
    return cell;
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
