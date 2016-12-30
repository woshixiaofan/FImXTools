//
//  ErweimaController.m
//  MYWORK
//
//  Created by 凡迅 on 16/5/24.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "ErweimaController.h"
#import <AVFoundation/AVFoundation.h>
#import "Header.h"

@interface ErweimaController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(strong, nonatomic)AVCaptureSession *session;
@property(strong, nonatomic)AVCaptureVideoPreviewLayer*layer;
@property(strong, nonatomic)UILabel *label;
@end

@implementation ErweimaController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1、首先导入 CoreImage 框架
    
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(100, 30, WIDTH-200, 50);
    [self.view addSubview:button];
    button.backgroundColor=DEBUG_COLOR;
    [button setTitle:@"生成二维码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(createErweima:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:0];
    button2.frame = CGRectMake(100, 300, WIDTH-200, 50);
    [self.view addSubview:button2];
    button2.backgroundColor=DEBUG_COLOR;
    [button2 setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(getErweima) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createErweima:(UIButton*)button {
    button.userInteractionEnabled=NO;
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复滤镜的默认属性
    [filter setDefaults];
    
    
    // 3.给过滤器添加数据
    NSString *dataString = @"http://www.baidu.com";
    
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKey:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, WIDTH/2-40, WIDTH/2-40)];
    
    // 5.显示二维码
    imageView.image = [UIImage imageWithCIImage:outputImage];
    
    [self.view addSubview:imageView];
    
    
    // 因为生成的二维码模糊,重新获得高清的二维码图片
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2+20, imageView.top, imageView.width, imageView.height)];
    
    newImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:newImageView.width];
    
    [self.view addSubview:newImageView];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)getErweima {
    self.session = [[AVCaptureSession alloc] init];
    
    // 2.添加输入设备(数据从摄像头输入)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [self.session addInput:input];
    
    // 3.添加输出数据
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.session addOutput:output];
    
    // 3.1.设置输入元数据的类型(类型是二维码数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 4.添加扫描图层
    self.layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.layer.frame = CGRectMake(WIDTH/2-75, HEIGHT/2-75, 150, 150);
    self.layer.videoGravity =AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.layer];
    
    // 5.开始扫描
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        //获得扫描数据，最后一个时最新扫描的数据
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        self.label.text=object.stringValue;
        
        // 停止扫描
        [self.session stopRunning];
        
        // 将预览图层移除
        [self.layer removeFromSuperlayer];
    } else {
        NSLog(@"没有扫描到数据");
    }
}

- (UILabel *)label {
    if (!_label) {
        _label=[[UILabel alloc]initWithFrame:CGRectMake(20, HEIGHT-64-50, WIDTH-40, 30)];
        [self.view addSubview:_label];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.backgroundColor=[[UIColor magentaColor]colorWithAlphaComponent:0.2];
    }
    return _label;
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
