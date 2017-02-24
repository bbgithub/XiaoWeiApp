//
//  AttributesList.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractModel.h"

@interface AttributesList : WlwAbstractModel
@property (nonatomic, strong) NSArray *data;
+(Class)data_class;
@end
