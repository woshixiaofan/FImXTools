//
//  VoiceController.m
//  MYWORK
//
//  Created by 凡迅 on 2016/11/29.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "VoiceController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VoiceController ()<AVSpeechSynthesizerDelegate,UIGestureRecognizerDelegate>
{
    AVSpeechSynthesizer*av;
    MPVolumeView *volumeView;
    BOOL nnn;
}
@end

@implementation VoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100,100,100,50);
    
    [button setTitle:@"讲"forState:UIControlStateNormal];
    
    [button setTitle:@"停"forState:UIControlStateSelected];
    
    [button setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    
    button.backgroundColor=[UIColor grayColor];
    
    button.showsTouchWhenHighlighted=YES;
    
    [button addTarget:self action:@selector(start:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}
- (void)panDirection:(UIPanGestureRecognizer *)pan
{
    CGPoint veloctyPoint = [pan velocityInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: { // 开始移动
            volumeView = [[MPVolumeView alloc] init];
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x>y) {
                nnn=YES;
            }else{
                nnn=NO;
            }
        }
            break;
        case UIGestureRecognizerStateChanged: { // 正在移动
            NSLog(@"%@",@(nnn));
            if (nnn) {
                UISlider* volumeViewSlider = nil;
                for (UIView *view in [volumeView subviews]){
                    if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
                        volumeViewSlider = (UISlider*)view;
                        break;
                    }
                }
                
                float systemVolume = volumeViewSlider.value+0.015;
                NSLog(@"----%@",@(systemVolume));
                
                [volumeViewSlider setValue:systemVolume animated:NO];
                [volumeViewSlider sendActionsForControlEvents:UIControlEventValueChanged];
            }else {
                UISlider* volumeViewSlider = nil;
                for (UIView *view in [volumeView subviews]){
                    if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
                        volumeViewSlider = (UISlider*)view;
                        break;
                    }
                }
                
                float systemVolume = volumeViewSlider.value-0.015;
                NSLog(@"%@",@(systemVolume));
                
                [volumeViewSlider setValue:systemVolume animated:NO];
                [volumeViewSlider sendActionsForControlEvents:UIControlEventValueChanged];
            }
        }
            break;
        case UIGestureRecognizerStateEnded: { // 移动停止
            
        }
            break;
            
        default:
            break;
    }
}

-(void)start:(UIButton*)sender{
    
    if(sender.selected==NO) {
        if([av isPaused]) {
            
            //如果暂停则恢复，会从暂停的地方继续
            
            [av continueSpeaking];
            
        }else{
            
            //初始化对象
            
            av= [[AVSpeechSynthesizer alloc]init];
            
            av.delegate=self;//挂上代理
            
            NSString * filePath = [[NSBundle mainBundle] pathForResource:@"Chapter1" ofType:@"txt"];
            
            NSString *txt=[[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:txt];//需要转换的文字
            
            utterance.rate=AVSpeechUtteranceMinimumSpeechRate;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
            
            utterance.pitchMultiplier = 1.0f;
            
            //utterance.postUtteranceDelay = 0.1f;
            
            AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-HK"];//设置发音，这是中文普通话
            
            utterance.voice= voice;
            utterance.rate=0.1;
            
            [av speakUtterance:utterance];//开始
        }
        
    }else{
        //[av stopSpeakingAtBoundary:AVSpeechBoundaryWord];//感觉效果一样，对应代理>>>取消
        [av pauseSpeakingAtBoundary:AVSpeechBoundaryWord];//暂停
    }
    sender.selected=!sender.selected;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---完成播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放中止");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---恢复播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放取消");
    
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
