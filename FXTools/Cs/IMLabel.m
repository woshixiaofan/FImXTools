//
//  SHLUILabel.m
//  MyLabel
//
//  Created by showhillLee on 14-3-16.
//  Copyright (c) 2014年 showhilllee. All rights reserved.
//

#import "IMLabel.h"
#import <CoreText/CoreText.h>

@interface IMLabel ()
{
    NSMutableAttributedString *attributedString;
}
@end

@implementation IMLabel

- (id)initWithFrame:(CGRect)frame
{
    if(self =[super initWithFrame:CGRectMake(ceil(frame.origin.x), ceil(frame.origin.y), ceil(frame.size.width), ceil(frame.size.height))])
    {
        self.text = @"";
    }
    return self;
}

- (void) initAttributedString
{
    NSString *labelString = self.text?:@"";
    attributedString =[[NSMutableAttributedString alloc]initWithString:labelString];
    [attributedString setAttributes:self.coreTextAttributes range:NSMakeRange(0, attributedString.length)];
}

- (NSDictionary *)coreTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.linesSpacing;
    paragraphStyle.firstLineHeadIndent = self.firstLineHeadIndent;
    paragraphStyle.alignment = self.alignment?:NSTextAlignmentJustified;
    NSDictionary *dic = @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor?:[UIColor blackColor],NSKernAttributeName:@(self.wordSpacing),NSUnderlineStyleAttributeName :[NSNumber numberWithInt:NSUnderlineStyleNone]};
    return dic;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _alignment=textAlignment;
}

- (void) setText:(NSString *)text {
    [super setText:text];
    [self initString];
}
- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:numberOfLines];
}

- (double)getAttributedStringHeightWidthValue:(double)width
{
    [attributedString setAttributes:self.labelDic?self.labelDic:self.coreTextAttributes range:NSMakeRange(0, attributedString.length)];
    self.attributedText=attributedString;
    double rect = [attributedString boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    if (self.firstLineHeadIndent)
    {
        rect -= self.font.lineHeight;
    }
    if (self.numberOfLines)
    {
        rect=MIN((self.font.lineHeight+self.linesSpacing)*self.numberOfLines, rect);
    }
    if (rect==(self.font.lineHeight+self.linesSpacing)) {
        return ceil(rect)-self.linesSpacing;
    }
    return ceil(rect);
}

- (void)initString {
    NSString *labelString = self.text?:@"";
    if (self.firstLineHeadIndent) {
        attributedString =[[NSMutableAttributedString alloc]initWithString:[labelString stringByAppendingString:@"\n"]];
    }else{
        attributedString =[[NSMutableAttributedString alloc]initWithString:labelString];
    }
}
@end
