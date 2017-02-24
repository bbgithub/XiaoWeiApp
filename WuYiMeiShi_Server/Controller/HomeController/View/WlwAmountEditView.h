//
//  WlwAmountEditView.h
//  legwork360
//
//  Created by 物恋网 on 16/12/7.
//  Copyright © 2016年 wlw. All rights reserved.
//  数量编辑器

#import <UIKit/UIKit.h>
typedef void (^AmountChange) (int sender);
@interface WlwAmountEditView : UIView
@property (nonatomic, copy) AmountChange amountChanged;

-(void)setAmountChanged:(AmountChange)amountChanged;
-(id)initWithMaxNum:(NSInteger)maxNum;

@property (nonatomic, strong) UILabel *amountLab;

@end
