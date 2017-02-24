//
//  DingingHallRequest.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "DingingHallRequest.h"

@implementation DingingHallRequest
-(NSDictionary* )genRequestParagram
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *page = [NSString stringWithFormat:@"%d,%d",[self.page.start intValue],[self.page.count intValue]];
    [dic setObject:page forKey:@"page"];
    return dic;
}

-(NSString *)genRequestUrl
{
    return  @"/goods/goodsList";
}
@end
