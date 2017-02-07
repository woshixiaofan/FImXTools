//
//  KeyboardController.m
//  FXTools
//
//  Created by 凡迅 on 2017/1/9.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import "KeyboardController.h"
#import "Header.h"
#import <AFNetworking.h>
#import "TestModel.h"
#import "EPHighlightLabel.h"
@interface KeyboardController ()

@end

@implementation KeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, WIDTH-100, 50)];
    field.text=@"占位符";
    field.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:field];
    
    
    EPHighlightLabel *label=[[EPHighlightLabel alloc]initWithFrame:CGRectMake(50, 200, WIDTH-100, 50)];
    label.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:label];
    label.userInteractionEnabled=YES;
    
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
