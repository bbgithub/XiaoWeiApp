//
//  GetOrderListRequest.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/9.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "GetOrderListRequest.h"

@implementation GetOrderListRequest

-(NSString *)genRequestUrl
{
    return  @"/orders/list";
}

@end
