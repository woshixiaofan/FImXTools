//
//  RootViewController.m
//  Label
//
//  Created by 凡迅 on 16/4/15.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "LabelController.h"
#import "IMLabel.h"
#import "Header.h"
#import <CoreText/CoreText.h>

#define LINESPACE   5
#define TEXTFONT    17
@interface LabelController ()
{
    CTFrameRef _ctFrame;
}
@property (nonatomic, strong)IMLabel *label1;
@property (nonatomic, strong)IMLabel *label2;
@property (nonatomic, strong)IMLabel *label3;
@property (nonatomic, strong)IMLabel *label4;
@end

@implementation LabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.label4];
    
    _label1.text=TEXT;
    _label2.text=TEXT;
    _label3.text=TEXT;
    _label4.text=TEXT;
    
    
    _label1.frame=CGRectMake(KLEFT, KLEFT, WIDTH-2*KLEFT, [_label1 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    _label2.frame=CGRectMake(KLEFT, KLEFT+_label1.bottom, WIDTH-2*KLEFT, [_label2 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    _label3.frame=CGRectMake(KLEFT, KLEFT+_label2.bottom, WIDTH-2*KLEFT, [_label3 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    _label4.frame=CGRectMake(KLEFT, KLEFT+_label3.bottom, WIDTH-2*KLEFT, [_label4 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapReadView:)];
    _label1.userInteractionEnabled=YES;
    [_label1 addGestureRecognizer:tapRecognizer2];
    
    
    NSRange boldRange1 = [_label1.text rangeOfString:@"穿越到武道世界" options:NSCaseInsensitiveSearch];
    
    NSLog(@"---   %@",NSStringFromRange(boldRange1));
    
}
-(void)tapReadView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_label1];
    
    CFIndex idx     = [self getTouchIndexWithTouchPoint:point];
    
    if (idx>=3) {
        NSLog(@"%@  %@",@(idx),[_label1.text substringWithRange:NSMakeRange(idx-3, 2)]);
    }
    
}
- (CTFrameRef)getCTFrame
{
    return _ctFrame;
}
- (CFIndex)getTouchIndexWithTouchPoint:(CGPoint)touchPoint
{
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) [[NSAttributedString alloc]initWithString:_label1.text]);
    CGPathRef path = CGPathCreateWithRect(_label1.frame, NULL);;
    _ctFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    CTFrameRef textFrame = [self getCTFrame];
    NSArray *lines = (NSArray*)CTFrameGetLines(textFrame);
    if (!lines)
    {
        return -1;
    }
    CFIndex index = -1;
    NSInteger lineCount = [lines count];
    CGPoint *origins = (CGPoint*)malloc(lineCount * sizeof(CGPoint));
    if (lineCount != 0)
    {
        CTFrameGetLineOrigins(_ctFrame, CFRangeMake(0, 0), origins);
        
        for (int i = 0; i < lineCount; i++)
        {
            
            CGPoint baselineOrigin = origins[i];
            baselineOrigin.y = CGRectGetHeight(_label1.frame) - baselineOrigin.y;
            
            CTLineRef line = (__bridge CTLineRef)[lines objectAtIndex:i];
            CGFloat ascent, descent;
            CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, NULL);
            
            CGRect lineFrame = CGRectMake(baselineOrigin.x, baselineOrigin.y - ascent, lineWidth, ascent + descent);
            if (CGRectContainsPoint(lineFrame, touchPoint))
            {
                index = CTLineGetStringIndexForPosition(line, touchPoint);
            }else if (lineFrame.origin.y <touchPoint.y)
            {
                index = CTLineGetStringIndexForPosition(line, touchPoint);
            }
        }
    }
    free(origins);
    return index;
}

- (IMLabel *)label1 {
    if (!_label1) {
        self.label1 = [[IMLabel alloc]init];
        _label1.numberOfLines=0;
        _label1.font=[UIFont systemFontOfSize:TEXTFONT];
        _label1.backgroundColor=DEBUG_COLOR;
//        _label1.linesSpacing=LINESPACE;
        _label1.firstLineHeadIndent=_label1.font.pointSize*2;
        
    }
    return _label1;
}
- (IMLabel *)label2 {
    if (!_label2) {
        self.label2 = [[IMLabel alloc]init];
        _label2.numberOfLines=2;
        _label2.font=[UIFont systemFontOfSize:TEXTFONT];
        _label2.backgroundColor=DEBUG_COLOR;
        _label2.linesSpacing=LINESPACE;
        _label2.firstLineHeadIndent=_label2.font.pointSize*2;
    }
    return _label2;
}
- (IMLabel *)label3 {
    if (!_label3) {
        self.label3 = [[IMLabel alloc]init];
        _label3.numberOfLines=3;
        _label3.font=[UIFont systemFontOfSize:TEXTFONT];
        _label3.backgroundColor=DEBUG_COLOR;
        _label3.linesSpacing=LINESPACE;
        _label3.firstLineHeadIndent=_label3.font.pointSize*2;
    }
    return _label3;
}
- (IMLabel *)label4 {
    if (!_label4) {
        self.label4 = [[IMLabel alloc]init];
        _label4.numberOfLines=1;
        _label4.font=[UIFont systemFontOfSize:TEXTFONT];
        _label4.backgroundColor=DEBUG_COLOR;
        _label4.linesSpacing=10;
        _label4.wordSpacing=0;
        _label4.firstLineHeadIndent=_label4.font.pointSize*2+_label4.wordSpacing*2;
    }
    return _label4;
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
