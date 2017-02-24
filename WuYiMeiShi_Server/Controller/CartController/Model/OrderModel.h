//
//  OrderModel.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/7.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "WlwAbstractModel.h"

@interface OrderModel : WlwAbstractModel
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSNumber *amount;

@end
