//
//  AppData.h
//  wuyimeishi
//
//  Created by 物恋网 on 16/7/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface AppData : NSObject
@property (nonatomic, strong) NSString *channenId;
@property (nonatomic, strong) UserModel *userModel;
+(instancetype)shareAppData;

@end
