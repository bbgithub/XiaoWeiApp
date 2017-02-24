//
//  NSObject+Property.h
//  TextRuntime
//
//  Created by LDH on 14/10/22.
//  Copyright © 2014年 刘敦辉. All rights reserved.
//  通过解析字典自动生成属性代码

#import <Foundation/Foundation.h>

@interface NSObject (Property)

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;


@end
