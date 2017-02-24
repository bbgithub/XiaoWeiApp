//
//  CreatePackageRequest.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//  创建套餐

#import "WlwAbstractRequest.h"

@interface CreatePackageRequest : WlwAbstractRequest
//食堂id
@property (nonatomic, strong) NSString *dingHallId;
//套餐名
@property (nonatomic, strong) NSString *packageName;
//套餐价格
@property (nonatomic, strong) NSString *packagePrice;

@property (nonatomic, strong) NSString *itemListString;

@end
