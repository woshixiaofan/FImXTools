//
//  MohuController.m
//  MYWORK
//
//  Created by 凡迅 on 16/5/24.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "MohuController.h"

@interface MohuController ()

@end

@implementation MohuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self canSetVisualDegree];
        });
    });
    
    [self cannotSetVisualDegree];
}

- (void)cannotSetVisualDegree {
    UIImage * image = [UIImage imageNamed:@"mohuImage"];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建模糊view
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = CGRectMake(0, 250, imageView.frame.size.width, 200);
    [imageView addSubview:effectView];
    
    //添加显示文本
    UILabel * lable = [[UILabel alloc]initWithFrame:effectView.bounds];
    lable.text = @"哈哈哈哈哈";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:24];
    
    NSString *str=@"字体不模糊";
    if (str) {
        [effectView.contentView addSubview:lable];
    } else {
        UIVisualEffectView * subEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)effectView.effect]];
        subEffectView.frame = effectView.bounds;
        [effectView.contentView addSubview:subEffectView];
        [subEffectView.contentView addSubview:lable];
    }
}

- (void)canSetVisualDegree {
    UIImage * image = [UIImage imageNamed:@"mohuImage"];
    
    /*..CoreImage中的模糊效果滤镜..*/
    
    //CIImage,相当于UIImage,作用为获取图片资源
    CIImage * ciImage = [[CIImage alloc]initWithImage:image
                         ];
    //CIFilter,高斯模糊滤镜
    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    //将图片输入到滤镜中
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    
    //用来查询滤镜可以设置的参数以及一些相关的信息
    NSLog(@"%@",[blurFilter attributes]);
    
    //设置模糊程度,默认为10,取值范围(0-100)
    [blurFilter setValue:@(20) forKey:@"inputRadius"];
    
    //将处理好的图片输出
    CIImage * outCiImage = [blurFilter valueForKey:kCIOutputImageKey];
    
    //CIContext
    CIContext * context = [CIContext contextWithOptions:nil];
    
    //获取CGImage句柄,也就是从数据流中取出图片
    CGImageRef outCGImage = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
    
    //最终获取到图片
    UIImage * blurImage = [UIImage imageWithCGImage:outCGImage];
    
    //释放CGImage句柄
    CGImageRelease(outCGImage);
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = blurImage;
    [self.view addSubview:imageView];
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
