//
//  WlwAlertView.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/12.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertViewBlock)(id sender);

@interface WlwAlertView : UIAlertView
- (id)initWithTitle:(NSString *)title message:(NSString *)message confirmBlock:(AlertViewBlock)confirmBlock cancelBlock:(AlertViewBlock)cancelBlock;
@end
