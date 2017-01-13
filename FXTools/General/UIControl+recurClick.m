//
//  UIControl+recurClick.m
//  主要解决按钮的重复点击问题
//
//  Created by King on 16/9/2.
//  Copyright © 2016年 King. All rights reserved.
//

#import "UIControl+recurClick.h"
#import <objc/runtime.h>


@implementation UIControl (recurClick)
- (NSTimeInterval)fx_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
- (void)setFx_acceptEventInterval:(NSTimeInterval)fx_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(fx_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)load
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(fx_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}
- (void)fx_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.fx_ignoreEvent) return;
    if (self.fx_acceptEventInterval > 0)
    {
        self.fx_ignoreEvent = YES;
        
        [self performSelector:@selector(fxClickTest) withObject:@(NO) afterDelay:self.fx_acceptEventInterval];
    }
    [self fx_sendAction:action to:target forEvent:event];
}

- (void)fxClickTest
{
    self.fx_ignoreEvent = NO;
}
- (void)setFx_ignoreEvent:(BOOL)fx_ignoreEvent
{
    
    objc_setAssociatedObject(self, BandNameKey, [NSNumber numberWithBool:fx_ignoreEvent], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fx_ignoreEvent
{
    
    return [objc_getAssociatedObject(self, BandNameKey) boolValue];
}

@end
