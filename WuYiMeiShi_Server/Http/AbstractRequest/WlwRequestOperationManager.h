//
//  WlwRequestOperationManager.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/31.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WlwAbstractRequest.h"
@interface WlwRequestOperationManager : NSObject

-(void)performWithRequest:(WlwAbstractRequest *)request View:(UIView *)view;

@end
