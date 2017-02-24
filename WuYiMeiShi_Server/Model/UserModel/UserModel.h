//
//  UserModel.h
//  wuyimeishi
//
//  Created by 物恋网 on 16/6/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractModel.h"

@interface UserModel : WlwAbstractModel
@property (nonatomic, strong) NSNumber *_id;
//用户名
@property (nonatomic, strong) NSString *user_name;
//单位名
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSNumber *cStatus;
@end
