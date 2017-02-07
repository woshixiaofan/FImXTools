//
//  EPHighlightLabel.m
//  FXTools
//
//  Created by 小凡 on 2017/2/7.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import "EPHighlightLabel.h"
@interface EPHighlightLabel()

@property (unsafe_unretained) bool hasMenuController;

@end
@implementation EPHighlightLabel

- (id)initWithFrame:(CGRect)frame {
    if ( (self = [super initWithFrame:frame]) ) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willHideMenu)
                                                     name:UIMenuControllerWillHideMenuNotification
                                                   object:nil];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wasTapped:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(copy:)) {
        return YES;
    }
    else {
        return [super canPerformAction:action withSender:sender];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)resignFirstResponder {
    if ([super resignFirstResponder]) {
        self.hasMenuController = false;
        return YES;
    }
    return NO;
}


- (void)copy:(id)sender {
    [self resignFirstResponder];
}

- (void)willHideMenu {
    if (self.hasMenuController) {
        [self resignFirstResponder];
    }
}

- (void)wasTapped:(id)sender {
    if([self isFirstResponder]) {
        self.hasMenuController = false;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuVisible:NO animated:YES];
        [menu update];
        [self resignFirstResponder];
    }
    else if([self becomeFirstResponder]) {
        self.hasMenuController = true;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuVisible:NO animated:YES];
        [menu setTargetRect:self.bounds inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
