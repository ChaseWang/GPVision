//
//  GPDefine.h
//  GPVision
//
//  Created by wangtao on 2016/12/31.
//  Copyright © 2016年 wangtao. All rights reserved.
//

#ifndef GPDefine_h
#define GPDefine_h
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RS_CURRENT_LANGUAGE_TABLE  [[NSUserDefaults standardUserDefaults] objectForKey:@"LanguageSwtich"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"LanguageSwtich"]:@"zh-Hans"

#define APP_FONT_Medium @"PingFangSC-Medium"
#define APP_FONT_Regular @"PingFangSC-Regular"

#define scale(x) ceil((x)*(SCREEN_WIDTH/375.0)/2) //4.7inch scale

#define QTRectMake(x,y,w,h) CGRectMake(scale(x), scale(y), scale(w), scale(h))

#define PHONE_STATUSBAR_HEIGHT 20
#define PHONE_NAVIGATIONBAR_HEIGHT 44.0f
#define PHONE_CONTENT_HEIGHT (SCREEN_HEIGHT - PHONE_STATUSBAR_HEIGHT - PHONE_NAVIGATIONBAR_HEIGHT)

#define PATH @"http://m.zngirls.com"

#endif /* GPDefine_h */
