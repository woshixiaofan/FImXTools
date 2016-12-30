//
//  IMScrollView.m
//  ImRead
//
//  Created by 凡迅 on 16/6/24.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "IMScrollView.h"
#import "Header.h"
#import "UIViewAdditions.h"

#define MAXCOUNT 5

@interface IMScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIViewController*viewController;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)NSArray *VCArray;
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, assign)double labelW;
@property (nonatomic, assign)NSInteger maxCount;
@end

@implementation IMScrollView

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController*)viewController titleArr:(NSArray *)titleArr VCArr:(NSArray *)VCArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController=viewController;
        self.titleArray=titleArr;
        self.VCArray=VCArr;
        
        self.maxCount=VCArr.count>=MAXCOUNT?MAXCOUNT:VCArr.count;
        self.labelW=WIDTH/self.maxCount;
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [self addSubview:self.titleScrollView];
    [self addSubview:self.contentScrollView];
    
    [self setUpChildViewController];
    [self setUpTitleLabel];
    [self setUpScrollView];
}

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.titleScroll_Height)];
        _titleScrollView.backgroundColor=[UIColor whiteColor];
        
        UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleScroll_Height - 0.5, WIDTH, 0.5)];
//        aView.backgroundColor = K_Part_line;
        [_titleScrollView addSubview:aView];
        
        self.sliderView =[[UIView alloc]initWithFrame:CGRectMake(0,_titleScrollView.height-self.slider_height,self.labelW,_slider_height)];
        self.sliderView.backgroundColor =self.sliderColor?self.sliderColor:[UIColor blueColor];
        [_titleScrollView addSubview:self.sliderView];
    }
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titleScroll_Height, WIDTH, HEIGHT)];
        _contentScrollView.backgroundColor=[UIColor whiteColor];
    }
    return _contentScrollView;
}

// 初始化UIScrollView
- (void)setUpScrollView
{
    NSUInteger count = self.viewController.childViewControllers.count;
    self.titleScrollView.contentSize = CGSizeMake(count * self.labelW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    self.contentScrollView.contentSize = CGSizeMake(count * WIDTH, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    self.contentScrollView.delegate = self;
}

-(void)setUpTitleLabel
{
    NSUInteger count = self.viewController.childViewControllers.count;
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScroll_Height;
    
    [self.titleLabels removeAllObjects];
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.viewController.childViewControllers[i];
        UILabel *label = [[UILabel alloc] init];
        
        labelX = i * self.labelW;
        
        label.frame = CGRectMake(labelX, labelY, self.labelW, labelH);
        
        label.text = vc.title;
        label.highlightedTextColor = self.titleColor_select;
        label.textColor = self.titleColor_nomal;
        label.tag = i;
        label.userInteractionEnabled = YES;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.titleLabels addObject:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        if (i == 0) {
            [self titleClick:tap];
        }
        [self.titleScrollView addSubview:label];
    }
}

- (void)titleClick:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    if (label!=_selLabel) {
//        [IMProgressHUD dismiss];
    }
    
    [self selectView:label];
    
    NSInteger index = tap.view.tag;
    
    CGFloat offsetX = index * WIDTH;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    self.sliderView.transform =CGAffineTransformMakeTranslation(label.left, 0);
    
    [self showVc:index];
    
    [self setupTitleCenter:label];
}


-(void)showVc:(NSInteger)index
{
    CGFloat offsetX = index*WIDTH;
    
    UIViewController *vc = self.viewController.childViewControllers[index];
    
    if (vc.isViewLoaded) {
        return;
    }
    
    vc.view.frame = CGRectMake(offsetX, 0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}


-(void)selectView:(UILabel *)label
{
    _selLabel.highlighted = NO;
    _selLabel.textColor = self.titleColor_nomal;
    label.highlighted = YES;
    label.textColor = self.titleColor_select;
    _selLabel = label;
}

- (void)setUpChildViewController
{
    for (UIViewController * VC in self.viewController.childViewControllers) {
        [VC removeFromParentViewController];
    }
    for (int i=0; i<self.VCArray.count; i++) {
        UIViewController * VC = self.VCArray[i];
        VC.title=self.titleArray[i];
        [self.viewController addChildViewController:VC];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.sliderView.transform =CGAffineTransformMakeTranslation(scrollView.contentOffset.x/self.maxCount, 0);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (_index!=index) {
//        [IMProgressHUD dismiss];
        [self showVc:index];
        
        UILabel *selLabel = self.titleLabels[index];
        
        [self selectView:selLabel];
        
        [self setupTitleCenter:selLabel];
        _index=index;
    }
}

-(void)setupTitleCenter:(UILabel *)label
{
    CGFloat offsetX = label.center.x - WIDTH * 0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - WIDTH;
    if (offsetX>maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(MAX(offsetX, 0), 0) animated:NO];
}

@end
