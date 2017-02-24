//
//  AppData.m
//  wuyimeishi
//
//  Created by 物恋网 on 16/7/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "AppData.h"

@implementation AppData
+(instancetype)shareAppData
{
    static AppData *appData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appData = [[self alloc] init];
    });
    return appData;
}
@end
