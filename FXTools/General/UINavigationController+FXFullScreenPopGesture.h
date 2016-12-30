//
//  UINavigationController+FXFullScreenPopGesture.h
//  MYWORK
//
//  Created by 凡迅 on 2016/12/8.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (FXFullScreenPopGesture)
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fx_popGestureRecognizer;

@end
