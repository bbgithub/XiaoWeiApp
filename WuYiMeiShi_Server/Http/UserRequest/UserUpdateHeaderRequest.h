//
//  UserUpdateHeaderRequest.h
//  wuyimeishi
//
//  Created by 物恋网 on 16/7/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface UserUpdateHeaderRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *header;
@end
