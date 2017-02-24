//
//  ProductModel.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "Jastor.h"

@interface ProductModel : Jastor
@property (nonatomic, strong) NSNumber *_id;
@property (nonatomic, strong) NSArray *attributes;
@property (nonatomic, strong) NSNumber *goods_id;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *product_img;
@property (nonatomic, strong) NSNumber *stock;
@property (nonatomic, assign) NSInteger buyNum;
+(Class)attributes_class;
@end
