//
//  NSString+Ext.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/5.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)
- (CGSize) sizeForFont:(UIFont *)font
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary* attribs = @{NSFontAttributeName:font};
        return ([self sizeWithAttributes:attribs]);
    }
    return ([self sizeWithFont:font]);
    // return
}

- (CGSize) sizeForFont:(UIFont*)font
     constrainedToSize:(CGSize)constraint
         lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        
        CGSize boundingBox = [self boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
        size = [self sizeWithFont:font constrainedToSize:constraint lineBreakMode:lineBreakMode];
    }
    
    return size;
}

@end
