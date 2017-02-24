//
//  GetCartListRequest.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "GetCartListRequest.h"

@implementation GetCartListRequest
-(NSString *)genRequestUrl
{
    return  @"/carts/getCartList";
}

@end
