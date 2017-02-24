//
//  NSString+Ext.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/5.
//  Copyright © 2016年 wlw. All rights reserved.
// NSString类扩展

#import <Foundation/Foundation.h>

@interface NSString (Ext)
- (CGSize) sizeForFont:(UIFont *)font;

- (CGSize) sizeForFont:(UIFont*)font
     constrainedToSize:(CGSize)constraint
         lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
