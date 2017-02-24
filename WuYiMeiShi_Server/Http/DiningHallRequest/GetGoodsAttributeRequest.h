//
//  GetGoodsAttributeRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface GetGoodsAttributeRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *goods_id;
@end
