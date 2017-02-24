//
//  WlwRequestOperationManager.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/31.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwRequestOperationManager.h"

#import "AFNetworking.h"
#import "MBProgressHUD.h"
@implementation WlwRequestOperationManager

#define WLWAPISERVER  ([NetworkUtils getServerURL])
-(NSString *)apiBaseURL
{
    return SERVERURL;
}

-(void)fillRequestHeaderForManager:(AFHTTPSessionManager *)manager ofRequest: (WlwAbstractRequest *)request
{
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *headValueDictionary = [request genRequestHeader];
    
    [headValueDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];

    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

-(void)performWithRequest:(WlwAbstractRequest *)request View:(UIView *)view;
{
    if (view !=nil) {
       
        MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
        if (hud == nil) {
            MBProgressHUD *hud = [[MBProgressHUD alloc] init];
            [view addSubview:hud];
            hud.labelText = @"正在努力加载...";
            [hud show:YES];
            hud.tag = -10000;
        }
    }
    SDKLOG(@"%@\r\n%@",[NSString stringWithFormat:@"%@%@",self.apiBaseURL,request.genRequestUrl] ,request.genRequestParagram);
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",
                                                                                                     @"text/json",
                                                                                                     @"text/javascript",
                                                                                                     @"text/html", nil];
    [self fillRequestHeaderForManager:manager ofRequest:request];
    // list all needed data
    NSString *httpMthod = request.genRequestMethod;
    if ([httpMthod isEqualToString:@"POST"]) {
        [manager POST:[NSString stringWithFormat:@"%@%@",self.apiBaseURL,request.genRequestUrl] parameters:request.genRequestParagram progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }  success:^(NSURLSessionDataTask *operation, id responseObject) {
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            [request analyseSuccessResponse:responseObject];
            
        }failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            [request analyseFailtureResponse:error];
        }];
    }
    if ([httpMthod isEqualToString:@"GET"]) {
        [manager GET:self.apiBaseURL parameters:request.genRequestParagram progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }  success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            
            [request analyseSuccessResponse:responseObject];
        } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            [request analyseFailtureResponse:error];
        }];
    }
}
@end
