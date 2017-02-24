//
//  WlwTextView.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/8.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwTextView.h"
#import "Masonry.h"
@interface WlwTextView()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *placeHoldLab;
@end

@implementation WlwTextView

-(id)initWithPlaceHoldString:(NSString *)placeHoldStr{
    self  = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = DIVIDER_COLOR;
        [self addSubview:topLineView];
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@(1/([WlwHelp deviceScale])));
        }];
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = DIVIDER_COLOR;
        [self addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(1/([WlwHelp deviceScale])));
        }];
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(topLineView.mas_bottom);
            make.bottom.equalTo(bottomLineView.mas_top);
        }];
        _placeHoldLab = [WlwHelp getLabel:placeHoldStr withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x99, 0x99, 0x99, 1.0)];
        [self addSubview:_placeHoldLab];
        [_placeHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(10);
        }];
    }
    return self;
}


- (void) textViewDidChange:(UITextView*)ttextview
{
    _placeHoldLab.hidden = ttextview.text.length > 0;
    //该判断用于联想输入
    if(ttextview == _textView)
    {
        if (_textView.text.length > _maxLength)
        {
            _textView.text = [_textView.text substringToIndex:_maxLength];
        }
        
    }
    
}

-(BOOL)textView:(UITextView *)ttextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(ttextView == self.textView)
    {
        if([[_textView text] length]>_maxLength){
            return NO;
        }
        
        //判断是否为删除字符，如果为删除则让执行
        
        char c=[text UTF8String][0];
        if (c=='\000') {
            return YES;
        }
        
        if([[_textView text] length]==_maxLength) {
            if(![text isEqualToString:@"\b"]) return NO;
        }
        
        return YES;
    }
    return YES;
    
}

@end
