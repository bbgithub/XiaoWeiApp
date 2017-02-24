//
//  CartModel.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/6.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "Jastor.h"

@interface CartModel : Jastor
@property (nonatomic, strong) NSNumber *goods_id;
@property (nonatomic, strong) NSNumber *cart_id;
@property (nonatomic, strong) NSString *product_img;
@property (nonatomic, strong) NSNumber *product_id;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *style_id;
@property (nonatomic, strong) NSNumber *min_price;
@property (nonatomic, strong) NSArray *attributeValues;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSNumber *buy_num;

+(Class)attributeValues_class;

@end
