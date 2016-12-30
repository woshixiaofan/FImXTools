//
//  UMLoginController.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/22.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "UMLoginController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "Header.h"
@interface UMLoginController ()

@end

@implementation UMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *name=@[@"微信",@"QQ",@"新浪"];
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
    UMSocialPlatformType type;
    switch (button.tag) {
        case 0:
            type=UMSocialPlatformType_WechatSession;
            break;
        case 1:
            type=UMSocialPlatformType_QQ;
            break;
        default:
            type=UMSocialPlatformType_Sina;
            break;
    }
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:type completion:^(id result, NSError *error) {
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
            UMSocialUserInfoResponse *userinfo =result;
            NSLog(@"%@",userinfo);
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil] show];
        }];
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
