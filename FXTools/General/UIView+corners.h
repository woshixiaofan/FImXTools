//
//  UIView+corners.h
//  FXTools
//
//  Created by 凡迅 on 2017/1/3.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 半角位置

 - CONNERTYPE_All: 全角
 - CONNERTYPE_BottomLeft: 左下
 - CONNERTYPE_BottomRight: 右下
 - CONNERTYPE_TopLeft: 左上
 - CONNERTYPE_TopRight: 右上
 - CONNERTYPE_BottomLeftAndBottomRight: 左下和右下
 - CONNERTYPE_BottomLeftAndTopLeft: 左下和左上
 - CONNERTYPE_BottomLeftAndTopRight: 左下和右上
 - CONNERTYPE_TopLeftAndTopRight: 左上和右上
 - CONNERTYPE_TopLeftAndTopBottomRight: 左上和右下
 - CONNERTYPE_BottomRightAndTopRight: 右下和右上
 - CONNERTYPE_BottomLeftAndBottomRightAndTopRight: 缺左上
 - CONNERTYPE_TopLeftAndBottomRightAndTopRight: 缺左下
 - CONNERTYPE_TopLeftAndBottomLeftAndBottomRight: 缺右上
 - CONNERTYPE_TopLeftAndBottomLeftAndTopRight: 缺右下
 */
typedef NS_ENUM(NSInteger,CONNERTYPE)
{
    CONNERTYPE_All=0,
    CONNERTYPE_BottomLeft=1,
    CONNERTYPE_BottomRight,
    CONNERTYPE_TopLeft,
    CONNERTYPE_TopRight,
    CONNERTYPE_BottomLeftAndBottomRight,
    CONNERTYPE_BottomLeftAndTopLeft,
    CONNERTYPE_BottomLeftAndTopRight,
    CONNERTYPE_TopLeftAndTopRight,
    CONNERTYPE_TopLeftAndTopBottomRight,
    CONNERTYPE_BottomRightAndTopRight,
    CONNERTYPE_BottomLeftAndBottomRightAndTopRight,
    CONNERTYPE_TopLeftAndBottomRightAndTopRight,
    CONNERTYPE_TopLeftAndBottomLeftAndBottomRight,
    CONNERTYPE_TopLeftAndBottomLeftAndTopRight,
};
@interface UIView (corners)


/**
 设置View 半角位置

 @param type CONNERTYPE
 @param redius 半角弧度
 */
- (void)setConnerType:(CONNERTYPE)type cornerRedius:(double)redius;
@end
