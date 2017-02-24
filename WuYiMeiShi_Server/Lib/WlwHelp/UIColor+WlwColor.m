//
//  UIColor+WlwColor.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/30.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "UIColor+WlwColor.h"
static NSString *const kMainHightlightBackgroundColor = @"4BC1D2"; //主要选中色背景色

static NSString *const kMainHightlightForgroundColor = @"ffffff"; //主要选中色前景色

static NSString *const kMainVCScreenBackgroundColor = @"f5f5f5"; //VC 的主要背景色

static NSString *const kMainTableCellBackgroundColor = @"fafafa"; // tableviewcell 的主要背景色
static NSString *const kMainTabelViewBorderColor = @"d8d8d8";

static NSString *const kMainTextBlackL1Color = @"333333";
static NSString *const kMainTextGrayL1Color = @"6c7a81";
static NSString *const kMainTextGrayL2Color = @"adadad";

@implementation UIColor (WlwColor)

+(UIColor *) SCZGNavBarColor
{
    return [UIColor colorWithHexString:kMainHightlightBackgroundColor];
}

+(UIColor *) SCZGNavBarTitleColor
{
    return [UIColor colorWithHexString:kMainHightlightForgroundColor];
}
+ (UIColor *)SCZGVCScreenBackgroundColor
{
    return [UIColor colorWithHexString:kMainVCScreenBackgroundColor];
}
+ (UIColor *)SCZGMainTableViewCellBackgroundColor
{
    return [UIColor colorWithHexString:kMainTableCellBackgroundColor];
}

+ (UIColor *)SCZGMainTextBlackL1Color
{
    return [UIColor colorWithHexString:kMainTextBlackL1Color];
}

+ (UIColor *)SCZGMainTabelViewBorderColor
{
    return [UIColor colorWithHexString:kMainTabelViewBorderColor];
}

+ (UIColor *)SCZGMainTextGrayL1Color
{
    return [UIColor colorWithHexString:kMainTextGrayL1Color];
}
+ (UIColor *)SCZGFormPlaceHolderColor
{
    return [UIColor colorWithHexString:kMainTextGrayL2Color];
}

+ (UIColor *)SCZGButtonBlueColor
{
    return [UIColor colorWithHexString:@"00b7d1"];
}

+ (UIColor *)SCZGButtonRedColor
{
    return [UIColor colorWithHexString:@"ff0000"];
}

@end
