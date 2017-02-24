//
//  CartList.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/6.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "WlwAbstractModel.h"

@interface CartList : WlwAbstractModel
@property (nonatomic, strong) NSArray *data;

+(Class)data_class;
@end
