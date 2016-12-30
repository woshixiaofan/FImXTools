//
//  IMScrollView.h
//  ImRead
//
//  Created by 凡迅 on 16/6/24.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMScrollView : UIView
@property (strong, nonatomic) UIScrollView *titleScrollView;
@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (nonatomic, strong) UILabel *selLabel;
@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) double titleScroll_Height;
@property (nonatomic, strong) UIColor *titleColor_nomal;
@property (nonatomic, strong) UIColor *titleColor_select;
@property (nonatomic, strong) UIColor *sliderColor;
@property (nonatomic, assign) double  slider_height;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController*)viewController titleArr:(NSArray*)titleArr VCArr:(NSArray*)VCArr;

@end
