//
//  UserLoginRequest.h
//  wuyimeishi
//
//  Created by 物恋网 on 16/7/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface UserLoginRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@end
