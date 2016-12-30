//
//  TestLabel.m
//  MYWORK
//
//  Created by 凡迅 on 16/10/31.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "TestLabel.h"

@implementation TestLabel
@dynamic frames;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(ceil(frame.origin.x), ceil(frame.origin.y), ceil(frame.size.width), ceil(frame.size.height))];
    if (self) {
        NSLog(@"***********  %@",NSStringFromCGRect(frame));
    }
    return self;
}

- (void)setFrames:(CGRect)frames {
    self.frame=CGRectMake(ceil(frames.origin.x), ceil(frames.origin.y), ceil(frames.size.width), ceil(frames.size.height));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
