//
//  UINavigationController+FXFullScreenPopGesture.m
//  MYWORK
//
//  Created by 凡迅 on 2016/12/8.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "UINavigationController+FXFullScreenPopGesture.h"
#import <objc/runtime.h>

@interface FXFullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation FXFullScreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    return YES;
}
@end
@implementation UINavigationController (FXFullScreenPopGesture)
+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(fx_pushViewController:animated:));
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)fx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.fx_popGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fx_popGestureRecognizer];
        
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        self.fx_popGestureRecognizer.delegate = [self js_fullScreenPopGestureRecognizerDelegate];
        [self.fx_popGestureRecognizer addTarget:internalTarget action:internalAction];
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        [self fx_pushViewController:viewController animated:animated];
    }
}

- (FXFullScreenPopGestureRecognizerDelegate *)js_fullScreenPopGestureRecognizerDelegate {
    FXFullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[FXFullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIPanGestureRecognizer *)fx_popGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (panGestureRecognizer == nil) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

@end
