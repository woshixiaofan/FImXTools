//
//  PlaceHolderController.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/29.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "PlaceHolderController.h"
#import "Header.h"
#import "UITextView+Extension.h"
@interface PlaceHolderController ()

@end

@implementation PlaceHolderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *holder=@"艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读艾美阅读";
    
    UITextField *filed=[[UITextField alloc]initWithFrame:CGRectMake(10, 20, WIDTH-20, 40)];
    filed.attributedPlaceholder=[[NSAttributedString alloc]initWithString:holder attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    filed.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:filed];
    filed.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.1];
    
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, filed.bottom+30, [UIScreen mainScreen].bounds.size.width - 20, 200);
    [textView setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.1]];
    [self.view addSubview:textView];
    [textView setPlaceholderWithText:holder Color:[UIColor orangeColor]];
    
    textView.font = [UIFont systemFontOfSize:15];
    
    // Do any additional setup after loading the view.
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
