//
//  GoodsDetailModel.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "GoodsDetailModel.h"
#import "ProductModel.h"
@implementation GoodsDetailModel
+(Class)pic_class
{
    return [NSString class];
}

+(Class)products_class
{
    return [ProductModel class];
}
@end
