//
//  GetGoodsDetailRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/5.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface GetGoodsDetailRequest : WlwAbstractRequest

@property (nonatomic, strong) NSString *goods_id;

@end
