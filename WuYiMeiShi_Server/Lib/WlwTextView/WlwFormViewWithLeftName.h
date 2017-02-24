//
//  WlwFormViewWithLeftName.h
//  legwork360
//
//  Created by 物恋网 on 16/6/28.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WlwFormViewWithLeftName : UIView
@property (nonatomic, strong) UITextField *textfiled;
@property (nonatomic, strong) UILabel *contentLab;
-(id)initWithLeftName:(NSString *)leftName rightImage:(NSString *)imageName;

-(void)setTextPlaceHold:(NSString *)placeHold textMaxLength:(NSInteger)maxLength;

-(void)setContentLabName:(NSString *)contentName placeHoldName:(NSString *)placeHold;
@end
