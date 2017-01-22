//
//  UIView+corners.m
//  FXTools
//
//  Created by 凡迅 on 2017/1/3.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import "UIView+corners.h"

@implementation UIView (corners)
- (void)setConnerType:(CONNERTYPE)type cornerRedius:(double)redius {
    UIRectCorner corners;
    
    switch ( type )
    {
        case CONNERTYPE_All:
            corners = UIRectCornerAllCorners;
            break;
        case CONNERTYPE_BottomLeft:
            corners = UIRectCornerBottomLeft;
            break;
        case CONNERTYPE_BottomRight:
            corners = UIRectCornerBottomRight;
            break;
        case CONNERTYPE_TopLeft:
            corners = UIRectCornerTopLeft;
            break;
        case CONNERTYPE_TopRight:
            corners = UIRectCornerTopRight;
            break;
        case CONNERTYPE_BottomLeftAndBottomRight:
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case CONNERTYPE_BottomLeftAndTopLeft:
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
            break;
        case CONNERTYPE_BottomLeftAndTopRight:
            corners = UIRectCornerBottomLeft | UIRectCornerTopRight;
            break;
        case CONNERTYPE_TopLeftAndTopRight:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case CONNERTYPE_TopLeftAndTopBottomRight:
            corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
            break;
        case CONNERTYPE_BottomRightAndTopRight:
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        case CONNERTYPE_BottomLeftAndBottomRightAndTopRight:
            corners = UIRectCornerBottomLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        case CONNERTYPE_TopLeftAndBottomRightAndTopRight:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        case CONNERTYPE_TopLeftAndBottomLeftAndBottomRight:
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case CONNERTYPE_TopLeftAndBottomLeftAndTopRight:
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerTopRight;
            break;
            default:
            corners = UIRectCornerAllCorners;
            break;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(redius, redius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}
@end
