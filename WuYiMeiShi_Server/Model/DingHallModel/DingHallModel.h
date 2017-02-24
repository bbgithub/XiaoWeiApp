//
//  DingHallModel.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//  食堂model

#import "Jastor.h"

@interface DingHallModel : Jastor
@property (nonatomic, strong) NSNumber *_id;
//商品名称
@property (nonatomic, strong) NSString *goods_name;
//商品封面
@property (nonatomic, strong) NSString *goods_cover;
//最低价
@property (nonatomic, strong) NSNumber *min_price;
@end
