//
//  Header.h
//  MYWORK
//
//  Created by 凡迅 on 16/4/15.
//  Copyright © 2016年 JNDL. All rights reserved.
//
#import "UIViewAdditions.h"
#import "UIColor+HexString.h"

#ifndef Header_h
#define Header_h

#define UM_AppKey       @"569862c5e0f55a128300180e"
#define UM_Login_URL    @"http://www.imread.com"
#define QQ_AppID        @"1102561792"
#define QQ_AppKey       @"o07YQK7K8uvJ5znu"
#define WX_AppID        @"wx03d6c06f644af38f"
#define WX_AppSecret    @"996b69e04fd23a68abaff1f7e5885f4c"
#define XL_AppKey       @"2053392206"
#define XL_AppSecret    @"3a22c4deeb5a487af62917c4c29f5e19"
#define XL_url          @"https://m.imread.com/mall/page.9.3/login"
#define GDT_APPKEY      @"1105114629"

#define IOS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]
#define K_BarColor      [UIColor colorWithHexString:@"#fc487b"]
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define WIDTH           [UIScreen mainScreen].bounds.size.width
#define HEIGHT          [UIScreen mainScreen].bounds.size.height
#define KLEFT           15
#define KSPACE          10











#define TEXT            @"意外穿越到武道世界，这里，强大的武者能排山倒海18667167309毁天灭地！资质平凡的叶希文，却意外得到神秘的武神空间！任何武学都可以在空间中推演，别人修行几十年，他只需要一年！\n只要有足够的灵石，什么天才在他的面前都是浮云！修为猛进，看他血战扬名！强大的武者能排山倒海，毁天灭地！资质平凡的叶希文，却意外得到神秘的武神空间！任何武学都可以在空间中推演，别人修行几十年，他只需要一年！只要有足够的灵石"


#if 01
#define DEBUG_COLOR     [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.3]
#else
#define DEBUG_COLOR     [UIColor clearColor]
#endif


#endif /* Header_h */
