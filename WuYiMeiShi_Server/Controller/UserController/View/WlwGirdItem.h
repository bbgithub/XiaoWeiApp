//
//  WlwGirdItem.h
//  legwork360
//
//  Created by @"ZL" on 16/6/17.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@interface WlwGirdItem : Jastor
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *edu;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *service;

@property (nonatomic, strong) NSNumber *sort;

@property (nonatomic, strong) NSString *list;

@property (nonatomic, strong) NSNumber *mid;
@end
