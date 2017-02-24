//
//  WlwTextView.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/8.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WlwTextView : UIView
@property (nonatomic, strong) UITextView *textView;
//限制输入框能输入的最大长度
@property (nonatomic, assign) NSInteger maxLength;

-(id)initWithPlaceHoldString:(NSString *)placeHoldStr;

@end
