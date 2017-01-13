//
//  SHLUILabel.h
//  MyLabel
//
//  Created by showhillLee on 14-3-16.
//  Copyright (c) 2014年 showhilllee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface IMLabel : UILabel

@property(nonatomic,assign) CGFloat wordSpacing;
@property(nonatomic,assign) CGFloat paragraphSpacing;
@property(nonatomic,assign) CGFloat firstLineHeadIndent;
@property(nonatomic,assign) CGFloat linesSpacing;
@property(nonatomic,strong) NSDictionary *labelDic;
@property(nonatomic,assign)NSTextAlignment alignment;
- (double)getAttributedStringHeightWidthValue:(double)width;

@end
