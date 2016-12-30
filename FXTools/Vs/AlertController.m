//
//  RootViewController.m
//  UIAlertController
//
//  Created by 凡迅 on 16/4/15.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "AlertController.h"
#import "Header.h"

@interface AlertController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UIImageView *aImageView;
@end
@implementation AlertController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(100, 100, WIDTH-200, 100);
    [self.view addSubview:button];
    button.tag=1;
    button.backgroundColor=DEBUG_COLOR;
    [button setTitle:@"actionSheet" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:0];
    button2.frame = CGRectMake(100, 300, WIDTH-200, 100);
    [self.view addSubview:button2];
    button2.backgroundColor=DEBUG_COLOR;
    [button2 setTitle:@"alertview" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(alertview) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)ssssss:(UIButton *)btn {
    
    [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    //停止动画时候调用clockwiseRotationStopped方法
//    [UIView setAnimationDidStopSelector:@selector(clockwiseRotationStopped:finished:context:)];
    //顺时针旋转90度
    [UIView setAnimationRepeatCount:1];
    btn.transform = CGAffineTransformMakeRotation(M_PI/2);
    [UIView commitAnimations];
}

- (void)clock{
    UIButton *btn=[self.view viewWithTag:1];
    
    [UIView beginAnimations:@"counterclockwiseAnimation"context:NULL];
    /* 5 seconds long */
    [UIView setAnimationDuration:0.30f];
    /* 回到原始旋转 */
    btn.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

- (void)actionSheet {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *aciton1=[UIAlertAction actionWithTitle:@"拍照选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
        [self actionSheetAtIndex:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *aciton2=[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
        [self actionSheetAtIndex:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *aciton3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alert addAction:aciton1];
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [alert addAction:aciton2];
    }
    [alert addAction:aciton3];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)actionSheetAtIndex:(UIImagePickerControllerSourceType)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = buttonIndex;
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        self.aImageView.image=image;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"你已经取消了选取的图片");
    }];
}


- (void)alertview {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"真的要取消我吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.secureTextEntry=YES;
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidEndEditingNotification object:textField];
        self.textField=textField;
        textField.tag=5;
    }];
    
    UIAlertAction *aciton1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField=[alert.view viewWithTag:5];
        
        NSLog(@"%@  %@  %@",action.title,self.textField.text,textField.text);
    }];
    UIAlertAction *aciton2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];

    [alert addAction:aciton1];
    [alert addAction:aciton2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSLog(@"%@",textField.text);
}

- (UIImageView *)aImageView {
    if (!_aImageView) {
        _aImageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, HEIGHT - 150 - 64, WIDTH-200, 100)];
        [self.view addSubview:_aImageView];
    }
    return _aImageView;
}

@end
