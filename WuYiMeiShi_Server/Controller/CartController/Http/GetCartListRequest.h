//
//  GetCartListRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface GetCartListRequest : WlwAbstractRequest
@property (nonatomic, strong) NSNumber *user_id;
@end
