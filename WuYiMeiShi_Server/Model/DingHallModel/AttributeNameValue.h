//
//  AttributeNameValue.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "Jastor.h"

@interface AttributeNameValue : Jastor
@property (nonatomic, strong) NSNumber *_id;
@property (nonatomic, strong) NSArray *attributeValues;
//属性名称
@property (nonatomic, strong) NSString *attribute_name;

+(Class)attributeValues_class;
@end
