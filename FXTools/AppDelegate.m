//
//  AppDelegate.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/20.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "Header.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UIColor+Extension.h"
#import <IQKeyboardManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RootViewController *rootVC = [[RootViewController alloc]init];
    UINavigationController*naVC = [[UINavigationController alloc]initWithRootViewController:rootVC];
    self.window.rootViewController=naVC;
    
    UIImage *image = [[UIColor redColor] imageWithColor];
    [naVC.navigationBar setBackgroundImage:image  forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    naVC.navigationBar.shadowImage = image;
    [self appearance];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_AppKey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_AppID  appSecret:QQ_AppKey redirectURL:UM_Login_URL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_AppID  appSecret:WX_AppSecret redirectURL:UM_Login_URL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:XL_AppKey  appSecret:XL_AppSecret redirectURL:XL_url];
    
    
    [IQKeyboardManager sharedManager].enable = YES;
    //如果产品需要当键盘弹起时，点击背景收起键盘，也是一行代码解决。
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //而当产品需要支持内联编辑(Inline Editing), 这就需要隐藏键盘上的工具条(默认打开)
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}

- (void)appearance {
//    [[UINavigationBar appearance] setBarTintColor:[K_BarColor colorWithAlphaComponent:0.1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    UIImage *backimage=[[UIImage imageNamed:@"icon_back"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, 0, -3, 0)];
    [[UINavigationBar appearance] setBackIndicatorImage:backimage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backimage];
    if(IOS_VERSION>=8)
    {
        [UINavigationBar appearance].translucent = NO;
    }
    
    [[UITextField appearance] setTintColor:K_BarColor];
    [[UITextView appearance] setTintColor:K_BarColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.window.windowLevel=UIWindowLevelNormal;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
