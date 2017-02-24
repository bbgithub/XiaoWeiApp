//
//  GetCheckCodeRequest.h
//  wuyimeishi
//
//  Created by 物恋网 on 16/6/30.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"

@interface GetCheckCodeRequest : WlwAbstractRequest
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *type;
@end
