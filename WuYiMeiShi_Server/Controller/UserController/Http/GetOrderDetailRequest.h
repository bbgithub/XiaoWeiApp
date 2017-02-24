//
//  GetOrderDetailRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/9.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface GetOrderDetailRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *order_id;
@end
