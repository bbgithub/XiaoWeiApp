//
//  UIColor+HexColors.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/30.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColors)

+(UIColor *)colorWithHexString:(NSString *)hexString;
+(NSString *)hexValuesFromUIColor:(UIColor *)color;

@end
