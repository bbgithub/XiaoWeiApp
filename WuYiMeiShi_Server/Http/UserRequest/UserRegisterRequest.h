//
//  UserRegisterRequest.h
//  wuyimeishi
//
//  Created by 物恋网 on 16/6/20.
//  Copyright © 2016年 wlw. All rights reserved.
//  注册

#import "WlwAbstractRequest.h"
#import "UserModel.h"
@interface UserRegisterRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *password_repet;
@property (nonatomic, strong) NSString *checkCode;
@end
