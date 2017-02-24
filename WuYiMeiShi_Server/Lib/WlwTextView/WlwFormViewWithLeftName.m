//
//  WlwFormViewWithLeftName.m
//  legwork360
//
//  Created by 物恋网 on 16/6/28.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwFormViewWithLeftName.h"
#import "Masonry.h"
#import "NSString+Ext.h"
@interface WlwFormViewWithLeftName()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, assign) NSInteger maxLength;
@end

@implementation WlwFormViewWithLeftName
-(id)initWithLeftName:(NSString *)leftName rightImage:(NSString *)imageName;
{
    self  = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if (leftName) {
            _lab = [WlwHelp getLabel:leftName withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
            [self addSubview:_lab];
            CGSize size = [leftName sizeForFont:[UIFont systemFontOfSize:TEXT_FONT] constrainedToSize:CGSizeMake(MAXFLOAT, 30) lineBreakMode:NSLineBreakByCharWrapping];
            [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(10);
                make.centerY.equalTo(self);
                make.width.equalTo(@(size.width));
            }];
        }
        if (_textfiled == nil) {
            _textfiled = [[UITextField alloc] init];
            _textfiled.backgroundColor = [UIColor clearColor];
            _textfiled.textAlignment =NSTextAlignmentLeft;
            _textfiled.delegate = self;
            _textfiled.font = [UIFont systemFontOfSize:TEXT_FONT];
            [self addSubview:_textfiled];
            [_textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_lab.mas_right).offset(10);
                make.top.bottom.equalTo(self);
                make.right.equalTo(self);
            }];
        }
        if (imageName) {
            _imgView = [[UIImageView alloc] init];
            _imgView.image = [UIImage imageNamed:imageName];
            [self addSubview:_imgView];
            [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-10);
                make.centerY.equalTo(self);
                make.width.equalTo(@(_imgView.image.size.width));
                make.height.equalTo(@(_imgView.image.size.height));
            }];
        }
        if (_contentLab == nil) {
            _contentLab = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
            [self addSubview:_contentLab];
            [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_lab.mas_right).offset(5);
                make.top.bottom.equalTo(self);
                if (imageName) {
                    make.right.equalTo(_imgView.mas_left).offset(-5);
                }else{
                    make.right.equalTo(self);
                }
            }];
        }

    }
    return self;
}

-(void)setTextPlaceHold:(NSString *)placeHold textMaxLength:(NSInteger)maxLength;
{
    _contentLab.hidden = YES;
    _textfiled.hidden = NO;
    _textfiled.placeholder = placeHold;
    self.maxLength = maxLength;
    
}

-(void)setContentLabName:(NSString *)contentName placeHoldName:(NSString *)placeHold
{

    _contentLab.hidden = NO;
    _textfiled.hidden = YES;
    if (placeHold) {
        _contentLab.text = placeHold;
        _contentLab.textColor = RGBACOLOR(0x99, 0x99, 0x99, 1.0);
    }else{
        _contentLab.text = contentName;
        _contentLab.textColor = RGBACOLOR(0x33, 0x33, 0x33, 1.0);
    }
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
