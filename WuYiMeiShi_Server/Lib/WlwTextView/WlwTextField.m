//
//  WlwTextField.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/8.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwTextField.h"
#import "Masonry.h"
@implementation WlwTextField
-(id)initWithPlaceHoldString:(NSString *)placeHoldStr{
    self  = [super init];
    if (self) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = placeHoldStr;
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.layer.masksToBounds = YES;
        _textField.font = [UIFont systemFontOfSize:TEXT_FONT];
        _textField.layer.cornerRadius = 3.f;
        _textField.layer.borderWidth = (1/[WlwHelp deviceScale]);
        _textField.layer.borderColor = [DIVIDER_COLOR CGColor];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (temp.length > _maxLength) {
        textField.text = [temp substringToIndex:_maxLength];
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length > _maxLength) {
        textField.text = [textField.text substringToIndex:_maxLength];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > _maxLength) {
        textField.text = [textField.text substringToIndex:_maxLength];
    }
    
}
@end
