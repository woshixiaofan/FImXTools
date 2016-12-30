//
//  IOS10LabelController.m
//  MYWORK
//
//  Created by 凡迅 on 16/11/2.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "IOS10LabelController.h"
#import <AVFoundation/AVFoundation.h>
@interface IOS10LabelController ()

@end

@implementation IOS10LabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    BOOL success = [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &error];
    
    if (!success) {/* error */}
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
    NSLog(@"----------------  %d",success);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVAudioSessionInterruptionNotification:) name:AVAudioSessionInterruptionNotification object:nil];
    // Do any additional setup after loading the view.
}

/// 耳机插入、拔出事件
- (void)audioRouteChangeListenerCallback:(NSNotification*)notification
{
    NSInteger routeChangeReason = [[notification.userInfo valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            NSLog(@"---耳机插入");
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable: {
            NSLog(@"---耳机拔出");
        }
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            break;
            
        default:
            break;
    }
}
//通话结束事件
- (void)AVAudioSessionInterruptionNotification:(NSNotification*)notification {
    NSLog(@"+++++++++++ %@  %@",notification.object,notification.userInfo);
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
