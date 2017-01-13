//
//  SDCycleController.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/28.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "SDCycleController.h"
#import <SDCycleScrollView.h>
#import "Header.h"
#import "UIControl+recurClick.h"
#import "UIButton+touch.h"
@interface SDCycleController ()<SDCycleScrollViewDelegate>

@end

@implementation SDCycleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 50, WIDTH, 111) delegate:self placeholderImage:nil];
    scrollView.localizationImageNamesGroup=@[@"002.png",@"003.png",@"004.png",@"005.png"];
//    scrollView.titlesGroup=@[@"艾美阅读001",@"艾美阅读002",@"艾美阅读003",@"艾美阅读004",@"艾美阅读005"];
    [scrollView adjustWhenControllerViewWillAppera];
    scrollView.currentPageDotColor=[UIColor orangeColor];
    scrollView.pageDotColor=[UIColor blueColor];
    scrollView.pageControlDotSize=CGSizeMake(5, 5);
    scrollView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    scrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
    
    [self.view addSubview:scrollView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, scrollView.bottom+50, WIDTH-100, 50);
    [button setTitle:@"连击测试11" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchUpInside];
    button.fx_acceptEventInterval = 1.0;
    button.backgroundColor=[[UIColor orangeColor]colorWithAlphaComponent:0.86];
    [self.view addSubview:button];
    
    
    UIButton *buttonTest = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTest.frame = CGRectMake(50, button.bottom+50, WIDTH-100, 50);
    [buttonTest setTitle:@"连击测试22" forState:UIControlStateNormal];
    [buttonTest addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchUpInside];
    buttonTest.timeInterval = 1.0;
    buttonTest.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:buttonTest];
    
}
- (void)clickTest {
    NSLog(@"----------------------");
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"%@",cycleScrollView.titlesGroup[index]);
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    //NSLog(@"%@",@(index));
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
