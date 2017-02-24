//
//  WlwAmountEditView.m
//  legwork360
//
//  Created by 物恋网 on 16/12/7.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAmountEditView.h"
#import "Masonry.h"
@interface WlwAmountEditView()
//@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, assign) NSInteger maxNUm;
@end

@implementation WlwAmountEditView

-(id)initWithMaxNum:(NSInteger)maxNum
{
    self = [super init];
    if (self) {
        self.maxNUm = maxNum;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.f;
        self.layer.borderColor = DIVIDER_COLOR.CGColor;
        self.layer.borderWidth = 1/[WlwHelp deviceScale];
        UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reduceBtn addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
        [reduceBtn setImage:[UIImage imageNamed:@"ico_reduce"] forState:UIControlStateNormal];
        [self addSubview:reduceBtn];
        [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            
        }];
        UIView *seperateViewL = [[UIView alloc] init];
        seperateViewL.backgroundColor = DIVIDER_COLOR;
        [self addSubview:seperateViewL];
        [seperateViewL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(reduceBtn.mas_right).offset(10);
            make.width.equalTo(@(1/[WlwHelp deviceScale]));
        }];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setImage:[UIImage imageNamed:@"ico_add"] forState:UIControlStateNormal];
        [self addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
        }];
        
        UIView *seperateViewR = [[UIView alloc] init];
        seperateViewR.backgroundColor = DIVIDER_COLOR;
        [self addSubview:seperateViewR];
        [seperateViewR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(addBtn.mas_left).offset(-10);
            make.width.equalTo(@(1/[WlwHelp deviceScale]));
        }];
        
        _amountLab = [WlwHelp getLabel:@"0" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
        _amountLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_amountLab];
        [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(seperateViewL.mas_right);
            make.right.equalTo(seperateViewR.mas_left);
            make.width.equalTo(@60);
        }];
        
    }
    return self;
}

-(void)reduce
{
    if ([_amountLab.text integerValue] == 0 ) {
        return;
    }
     _amountLab.text = [NSString stringWithFormat:@"%d",[_amountLab.text integerValue] - 1];
    if (_amountChanged) {
        _amountChanged([_amountLab.text integerValue]);
    }
}

-(void)add
{
    if ([_amountLab.text integerValue] >= self.maxNUm ) {
        return;
    }
    _amountLab.text = [NSString stringWithFormat:@"%d",[_amountLab.text integerValue] + 1];
    if (_amountChanged) {
        _amountChanged([_amountLab.text integerValue]);
    }
}

-(void)setAmountChanged:(AmountChange)amountChanged
{
    if (amountChanged) {
        _amountChanged = nil;
        _amountChanged = amountChanged;
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
