//
//  MotaiController.m
//  FXTools
//
//  Created by 凡迅 on 2017/1/9.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import "MotaiController.h"
#import "Header.h"
@interface MotaiController ()

@end

@implementation MotaiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *backbtn=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backbtn;
}
- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:^{
        
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
