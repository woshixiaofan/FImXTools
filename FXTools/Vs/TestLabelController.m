
//
//  TestLabelController.m
//  MYWORK
//
//  Created by 凡迅 on 16/10/31.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "TestLabelController.h"
#import "TestLabel.h"
@interface TestLabelController ()

@end

@implementation TestLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    TestLabel *la1=[[TestLabel alloc]initWithFrame:CGRectMake(50.6, 100.5, 200.4, 60.3)];
    la1.numberOfLines=0;
    la1.text=@"艾美阅读";
    la1.textColor=[UIColor blueColor];
    la1.backgroundColor=[[UIColor magentaColor]colorWithAlphaComponent:0.3];
    [self.view addSubview:la1];
    NSLog(@"%@---\n\n\n",NSStringFromCGRect(la1.frame));
    
    
    TestLabel *la2=[[TestLabel alloc]initWithFrame:CGRectMake(30, 50, 90, 100)];
    la2.numberOfLines=0;
    la2.frames=CGRectMake(50.6, 200.7, 200.8, 60.9);
    la2.textColor=[UIColor orangeColor];
    la2.backgroundColor=[[UIColor magentaColor]colorWithAlphaComponent:0.3];
    la2.text=@"艾美阅读";
    [self.view addSubview:la2];
    NSLog(@"%@---",NSStringFromCGRect(la2.frame));
    
    
    
    
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
