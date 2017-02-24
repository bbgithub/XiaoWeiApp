//
//  NotifyRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/17.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface NotifyRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *channelId;
@end
