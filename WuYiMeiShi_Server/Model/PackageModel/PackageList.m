//
//  PackageList.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "PackageList.h"
#import "PackageEntity.h"
@implementation PackageList
+(Class)data_class
{
    return [PackageEntity class];
}
@end
