//
//  PayRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/12.
//  Copyright © 2016年 wlw. All rights reserved.
//var data = {


#import "WlwAbstractRequest.h"

@interface PayRequest : WlwAbstractRequest
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *out_trade_no;
@property (nonatomic, strong) NSNumber *amount;
@end
