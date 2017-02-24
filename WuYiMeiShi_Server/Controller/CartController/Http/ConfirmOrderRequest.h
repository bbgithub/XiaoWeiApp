//
//  ConfirmOrderRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/6.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface ConfirmOrderRequest : WlwAbstractRequest
@property (nonatomic, strong) NSNumber *user_id;
//产品ID数组
@property (nonatomic, strong) NSString *productIds;
@property (nonatomic, strong) NSString *orderAmount;
@property (nonatomic, strong) NSNumber *receive_id;

@end
