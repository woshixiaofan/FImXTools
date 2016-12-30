//
//  ReadBookController.m
//  MYWORK
//
//  Created by 凡迅 on 16/8/22.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "ReadBookController.h"
#import<AVFoundation/AVSpeechSynthesis.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZXVideoPlayerBrightnessView.h"
#import "ZXVideoPlayerVolumeView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ReadBookController ()<AVSpeechSynthesizerDelegate,UIGestureRecognizerDelegate>
/// 是否在调节音量
@property (nonatomic, assign) BOOL isVolumeAdjust;
/// 系统音量slider
@property (nonatomic, strong) UISlider *volumeViewSlider;
@property (nonatomic, assign) ZXPanDirection panDirection;
@property (nonatomic, strong) UIView *aView;
/// 亮度指示器
@property (nonatomic, strong, readwrite) ZXVideoPlayerBrightnessView *brightnessIndicatorView;
/// 音量指示器
@property (nonatomic, strong, readwrite) ZXVideoPlayerVolumeView *volumeIndicatorView;
@property (nonatomic, strong)UIButton*button;
@end

@implementation ReadBookController
{
    AVSpeechSynthesizer*av;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _button.frame=CGRectMake(100,100,100,50);
    
    [_button setTitle:@"讲"forState:UIControlStateNormal];
    
    [_button setTitle:@"停"forState:UIControlStateSelected];
    
    [_button setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    
    _button.backgroundColor=[UIColor grayColor];
    
    _button.showsTouchWhenHighlighted=YES;
    
    [_button addTarget:self action:@selector(start:)forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.aView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREENHEIGHT-100)];
    _aView.backgroundColor=[[UIColor magentaColor]colorWithAlphaComponent:0.1];
    [self.view addSubview:self.aView];
    _aView.userInteractionEnabled=YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    pan.delegate = self;
    [self.aView addGestureRecognizer:pan];
    [self configVolume];
    
    self.brightnessIndicatorView.center = self.view.center;
    // 音量指示器
    self.volumeIndicatorView.center = self.view.center;
    
    // 亮度指示器
    [self.aView addSubview:self.brightnessIndicatorView];
    // 音量指示器
    [self.aView addSubview:self.volumeIndicatorView];
    [self.view addSubview:_button];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)panDirection:(UIPanGestureRecognizer *)pan
{
    CGPoint locationPoint = [pan locationInView:self.aView];
    CGPoint veloctyPoint = [pan velocityInView:self.aView];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: { // 开始移动
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            
            if (x > y) { // 水平移动
                self.panDirection = ZXPanDirectionHorizontal;
            } else if (x < y) { // 垂直移动
                self.panDirection = ZXPanDirectionVertical;
                if (locationPoint.x > self.view.bounds.size.width / 2) { // 音量调节
                    self.isVolumeAdjust = YES;
                } else { // 亮度调节
                    self.isVolumeAdjust = NO;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged: { // 正在移动
            switch (self.panDirection) {
                case ZXPanDirectionHorizontal: {
                    [self horizontalMoved:veloctyPoint.x];
                }
                    break;
                case ZXPanDirectionVertical: {
                    [self verticalMoved:veloctyPoint.y];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case UIGestureRecognizerStateEnded: { // 移动停止
            switch (self.panDirection) {
                case ZXPanDirectionHorizontal: {
                    
                }
                    break;
                case ZXPanDirectionVertical: {
                    break;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

/// pan水平移动
- (void)horizontalMoved:(CGFloat)value
{
    NSLog(@"水平移动");
}

/// pan垂直移动
- (void)verticalMoved:(CGFloat)value
{
    if (self.isVolumeAdjust) {
        // 调节系统音量
        self.volumeViewSlider.value -= value / 10000;
    }else {
        // 亮度
        [UIScreen mainScreen].brightness -= value / 10000;
    }
}
/// 获取系统音量控件
- (void)configVolume
{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    volumeView.center = CGPointMake(-1000, 0);
    [self.view addSubview:volumeView];
    
    _volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    
    // 使用这个category的应用不会随着手机静音键打开而静音，可在手机静音下播放声音
    NSError *error = nil;
    BOOL success = [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &error];
    
    if (!success) {/* error */}
    
    // 监听耳机插入和拔掉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVAudioSessionInterruptionNotification:) name:AVAudioSessionInterruptionNotification object:nil];
}

- (void)AVAudioSessionInterruptionNotification:(NSNotification*)notification {
    NSLog(@"------------+++++++++++++++++++++");
    [self start:_button];
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
            // 拔掉耳机继续播放
        }
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            break;
            
        default:
            break;
    }
}
- (ZXVideoPlayerBrightnessView *)brightnessIndicatorView
{
    if (!_brightnessIndicatorView) {
        _brightnessIndicatorView = [[ZXVideoPlayerBrightnessView alloc] initWithFrame:CGRectMake(0, 0, kVideoBrightnessIndicatorViewSide, kVideoBrightnessIndicatorViewSide)];
    }
    return _brightnessIndicatorView;
}

- (ZXVideoPlayerVolumeView *)volumeIndicatorView
{
    if (!_volumeIndicatorView) {
        _volumeIndicatorView = [[ZXVideoPlayerVolumeView alloc] initWithFrame:CGRectMake(0, 0, kVideoVolumeIndicatorViewSide, kVideoVolumeIndicatorViewSide)];
    }
    return _volumeIndicatorView;
}
-(void)stdddart:(UIButton*)sender {
    AVSpeechSynthesizer *aaaaa = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"6666666"];  //需要转换的文本
    [aaaaa speakUtterance:utterance];
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
            
            AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
            
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
