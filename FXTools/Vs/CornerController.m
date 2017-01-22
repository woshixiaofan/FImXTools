//
//  CornerController.m
//  FXTools
//
//  Created by 凡迅 on 2017/1/3.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import "CornerController.h"
#import "UIView+corners.h"
#import "Header.h"
#import "CALayer+PauseAimate.h"
@interface CornerController ()
@property (nonatomic, strong)UIImageView *imgV;
@end

@implementation CornerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(60, 10, WIDTH-120, WIDTH-120);
    [button setTitle:@"圆角位置" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickTest:) forControlEvents:UIControlEventTouchUpInside];
    [button setConnerType:CONNERTYPE_TopLeftAndBottomLeftAndTopRight cornerRedius:(WIDTH-120)/2];
    button.backgroundColor=[[UIColor orangeColor]colorWithAlphaComponent:0.86];
    [self.view addSubview:button];
    
    _imgV=[[UIImageView alloc]initWithFrame:CGRectMake(60, button.bottom+40, WIDTH-120, WIDTH-120)];
    _imgV.image=[UIImage imageNamed:@"mohuImage.png"];
    _imgV.contentMode=UIViewContentModeScaleAspectFill;
    [_imgV setConnerType:CONNERTYPE_TopLeftAndBottomLeftAndBottomRight cornerRedius:_imgV.width];
    [self.view addSubview:_imgV];
    
    [_imgV.layer removeAnimationForKey:@"rotation"];
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.duration = 6;
    animation.keyPath = @"transform.rotation.z";
    animation.repeatCount = NSIntegerMax;
    animation.removedOnCompletion = NO;
    [_imgV.layer addAnimation:animation forKey:@"rotation"];
    
}

- (void)clickTest:(UIButton*)button {
    if (button.selected) {
        [_imgV.layer resumeAnimate];
    }else {
        [_imgV.layer pauseAnimate];
    }
    button.selected=!button.selected;
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
