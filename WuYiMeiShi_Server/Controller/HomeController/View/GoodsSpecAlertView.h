//
//  GoodsSpecAlertView.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ProductSelected) (id sender);
@interface GoodsSpecAlertView : UIView
@property (nonatomic, copy) ProductSelected productSelect;
-(id)initWithAttributesList:(NSArray *)atributeList Produces:(NSArray *)products;
-(void)hide;
-(void)showInView:(UIView *)view;
-(void)setProductSelect:(ProductSelected)productSelect;
@end
