//
//  PackageEntity.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "PackageEntity.h"
#import "SingleModel.h"
@implementation PackageEntity
+(Class)list_class
{
    return [SingleModel class];
}
@end
