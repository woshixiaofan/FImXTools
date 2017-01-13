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
    
    NSInteger numLine=0;
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, 20, WIDTH-40, HEIGHT-40-64)];
    
    label.delegate = self;
    label.font = [UIFont systemFontOfSize:18];
    label.numberOfLines = numLine;
    [self.view addSubview:label];
    label.backgroundColor=[UIColor lightGrayColor];
    label.textColor = [UIColor redColor];
    
    label.text=TEXT;
    
    //检测url
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber;

    
    //对齐方式(垂直)
//    label.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    label.firstLineIndent=0;
    //行间距
    label.lineSpacing = 2;
    //段首行
    //文字内缩
    label.textInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    label.textAlignment=NSTextAlignmentJustified;
    
    //URL下划线
    label.linkAttributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleNone],NSForegroundColorAttributeName:[UIColor orangeColor]};
    //链接高亮状态文本属性
    label.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSUnderlineStyleAttributeName:@(1)};
    
    __weak typeof(label)myLabel=label;
    [label setText:label.text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString)
     {
         CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:mutableAttributedString withConstraints:CGSizeMake(myLabel.width, 0) limitedToNumberOfLines:numLine];
         NSLog(@"NSStringFromCGSize ***  %@",NSStringFromCGSize(size));
         myLabel.frame=CGRectMake(myLabel.left, myLabel.top, myLabel.width, size.height);
         return mutableAttributedString;
     }];
    
    NSRange boldRange1 = [label.text rangeOfString:@"毁天灭地" options:NSCaseInsensitiveSearch];
    [label addLinkToURL:[NSURL URLWithString:@"http://www.baidu.com"]
              withRange:boldRange1];
    
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
