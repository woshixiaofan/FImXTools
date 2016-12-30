//
//  TTTAttributedLabelController.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/23.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "TTTAttributedLabelController.h"
#import <TTTAttributedLabel.h>
#import "Header.h"
#import "UIColor+Extension.h"
@interface TTTAttributedLabelController ()<TTTAttributedLabelDelegate>

@end

@implementation TTTAttributedLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, 20, WIDTH-40, HEIGHT-40-64)];
    
    label.delegate = self;
    label.font = [UIFont systemFontOfSize:18];
    label.numberOfLines = 10;
    [self.view addSubview:label];
    label.backgroundColor=[UIColor lightGrayColor];
    label.textColor = [UIColor redColor];
    ///Users/fanxun/Desktop/MyTools
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:TEXT
                                                                    attributes:[self coreTextAttributes]];
    label.text=attString;
    
    //检测url
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber;
    //设置高亮颜色
    label.highlightedTextColor = [UIColor greenColor];
    //对齐方式(垂直)
    label.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    //行间距
    label.lineSpacing = 2;
    //段首行
    label.firstLineIndent=0;
    //文字内缩
    label.textInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    label.textAlignment=NSTextAlignmentJustified;
    
    //URL下划线
    label.linkAttributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleNone],NSForegroundColorAttributeName:[UIColor blackColor]};
    
    [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];

    //设置阴影
//    label.shadowColor = [UIColor magentaColor];
    
    [label setText:label.text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString)
     {
         //设置可点击文字的范围
         NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"毁天灭地" options:NSCaseInsensitiveSearch];
         
         //设定可点击文字的的大小
         UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
         CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
         
         if (font) {
             
             //设置可点击文本的大小
             [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
             
             //设置可点击文本的颜色
             [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blueColor] CGColor] range:boldRange];
             
             
             
             CFRelease(font);
             
         }
         return mutableAttributedString;
     }];
    
    
    
    
}

- (NSDictionary *)coreTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    paragraphStyle.firstLineHeadIndent = 30;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    paragraphStyle.paragraphSpacing=20;
    NSDictionary *dic = @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@(0),NSUnderlineStyleAttributeName :[NSNumber numberWithInt:NSUnderlineStyleNone]};
    return dic;
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    
    NSLog(@"1111 ---- %@",url);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithAddress:(NSDictionary *)addressComponents{
    NSLog(@"22222 ---- %@",addressComponents);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithPhoneNumber:(NSString *)phoneNumber{
    NSLog(@"33333 ---- %@",phoneNumber);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
  didSelectLinkWithDate:(NSDate *)date{
    NSLog(@"444444 ---- %@",date);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithTextCheckingResult:(NSTextCheckingResult *)result
                atPoint:(CGPoint)point{
    NSLog(@"5555555 ---- %@",result);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithTransitInformation:(NSDictionary *)components
                atPoint:(CGPoint)point{
    NSLog(@"6666666 ---- %@",components);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithDate:(NSDate *)date
               timeZone:(NSTimeZone *)timeZone
               duration:(NSTimeInterval)duration
                atPoint:(CGPoint)point{
    NSLog(@"77777777 ---- %@",timeZone);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithDate:(NSDate *)date
                atPoint:(CGPoint)point{
    NSLog(@"88888888 ---- %@",date);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithPhoneNumber:(NSString *)phoneNumber
                atPoint:(CGPoint)point{
    NSLog(@"99999999 ---- %@",phoneNumber);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithAddress:(NSDictionary *)addressComponents
                atPoint:(CGPoint)point{
    NSLog(@"qqqqqqq ---- %@",addressComponents);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithURL:(NSURL *)url
                atPoint:(CGPoint)point{
    NSLog(@"wwwwwwww ---- %@",url);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result{
    NSLog(@"aaaaaaaa ---- %@",result);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithTransitInformation:(NSDictionary *)components{
    NSLog(@"sssssssss ---- %@",components);
}

- (void)attributedLabel:(TTTAttributedLabel *)label
  didSelectLinkWithDate:(NSDate *)date
               timeZone:(NSTimeZone *)timeZone
               duration:(NSTimeInterval)duration{
    NSLog(@"ddddddddd ----");
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
