//
//  AddToCartRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/20.
//  Copyright © 2016年 wlw. All rights reserved.
// * @user_id  用户id
//* @product_id 产品id
//* @buy_num  购买数量

#import "WlwAbstractRequest.h"

@interface AddToCartRequest : WlwAbstractRequest
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSNumber *product_id;
@property (nonatomic, strong) NSNumber *buy_num;
@end
