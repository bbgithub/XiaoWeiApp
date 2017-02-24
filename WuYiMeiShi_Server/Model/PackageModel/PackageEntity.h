//
//  PackageEntity.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "Jastor.h"

@interface PackageEntity : Jastor
@property (nonatomic, strong) NSString *packageName;
@property (nonatomic, strong) NSString *packagePrice;
@property (nonatomic, strong) NSArray *list;

+(Class)list_class;
@end
