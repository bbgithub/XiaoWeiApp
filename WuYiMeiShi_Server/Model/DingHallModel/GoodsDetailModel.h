//
//  GoodsDetailModel.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractModel.h"

@interface GoodsDetailModel : WlwAbstractModel

@property (nonatomic, strong) NSArray *pic;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSString *goods_name;
+(Class)pic_class;

+(Class)products_class;
@end
