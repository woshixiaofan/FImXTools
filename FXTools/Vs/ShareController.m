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
#import "UIColor+Extension.h"
@interface ShareController ()

@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"navigationController     %@",self.navigationController);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, WIDTH-100, 50);
    button.backgroundColor=[UIColor orangeColor];
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(share123) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=4;
    button.layer.masksToBounds=YES;
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *image = [[UIColor blueColor] imageWithColor];
    [self.navigationController.navigationBar setBackgroundImage:image  forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = image;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
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
