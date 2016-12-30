//
//  XMNetController.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/27.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "XMNetController.h"
#import "Header.h"
@interface XMNetController ()

@end

@implementation XMNetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *name=@[@"GET",@"POST",@"队列"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(50, 50+80*i, WIDTH-100, 50);
        [button setTitle:name[i] forState:UIControlStateNormal];
        button.tag=i;
        [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor=[[UIColor orangeColor]colorWithAlphaComponent:0.86];
        [self.view addSubview:button];
    }
}

- (void)login:(UIButton *)button {
    switch (button.tag) {
        case 0:

            break;
        case 1:

            break;
        default:

            break;
    }
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
