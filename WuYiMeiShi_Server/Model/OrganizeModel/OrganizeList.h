//
//  OrganizeList.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractModel.h"

@interface OrganizeList : WlwAbstractModel
@property (nonatomic, strong) NSArray *data;
+(Class)data_class;
@end
