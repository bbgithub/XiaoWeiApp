//
//  CreateDingingHallRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface CreateDingingHallRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *organization;
@property (nonatomic, strong) NSString *name;
@end
