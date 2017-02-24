//
//  WlwAbstractModel.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/30.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "Jastor.h"

@interface WlwAbstractModel : Jastor
//返回码 200为成功
@property (nonatomic, strong) NSString *code;
//返回消息，用于界面提示
@property (nonatomic, strong) NSString *msg;

@end
