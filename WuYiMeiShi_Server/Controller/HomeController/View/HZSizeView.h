//
//  HZSizeView.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AttributeSelected) (id sender);
@class AttributeNameValue;
@interface HZSizeView : UIView
@property (nonatomic, copy) AttributeSelected attributeSelect;
@property (nonatomic, assign) CGFloat fHeight;
@property (nonatomic, strong) NSMutableArray *btnList;
-(id)initWithFrame:(CGRect)frame attributes:(AttributeNameValue *)atribute;
-(void)setAttributeSelect:(AttributeSelected)attributeSelect;
@end
