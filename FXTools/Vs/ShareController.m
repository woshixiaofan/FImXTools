//
//  ShareController.m
//  MYWORK
//
//  Created by 凡迅 on 16/10/9.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "ShareController.h"
#import "Header.h"
#import <Social/Social.h>
@interface ShareController ()

@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(100, 30, WIDTH-200, 50);
    [self.view addSubview:button];
    button.backgroundColor=DEBUG_COLOR;
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(share123) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSLog(@"%@",self.navigationController);
    
    
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"---++++++++---%@",self.navigationController);
}

- (void)share123 {
    UIImage*imageV=[UIImage imageNamed:@"mohuImage"];
    UIActivityViewController *activeViewController = [[UIActivityViewController alloc]initWithActivityItems:@[@"艾美阅读",imageV,[NSURL URLWithString:@"http://www.baidu.com"]] applicationActivities:nil];
    activeViewController.excludedActivityTypes = @[UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypePrint,UIActivityTypePostToTwitter,UIActivityTypePostToFacebook,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo];
    
    [self presentViewController:activeViewController animated:YES completion:nil];
    activeViewController.completionWithItemsHandler = ^(UIActivityType type,BOOL completed,NSArray * returnedItems,NSError * activityError){
        
    };
}

- (void)share {
    SLComposeViewController *composeVc=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    [composeVc setInitialText:@"艾美阅读"];
    [composeVc addImage:[UIImage imageNamed:@"mohuImage"]];
    [composeVc addURL:[NSURL URLWithString:@"http://www.imread.com"]];
    
    [self presentViewController:composeVc animated:YES completion:nil];
    
    composeVc.completionHandler = ^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultDone) {
            NSLog(@"用户点击了分享按钮");
        } else {
            NSLog(@"用户点击了取消按钮");
        }
    };
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
