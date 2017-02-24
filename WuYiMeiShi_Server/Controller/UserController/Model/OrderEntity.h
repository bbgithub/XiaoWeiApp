//
//  OrderEntity.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/9.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "Jastor.h"

@interface OrderEntity : Jastor
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *order_no;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSNumber *total_price;
@end
