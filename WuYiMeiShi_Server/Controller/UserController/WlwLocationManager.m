//
//  WlwLocationManager.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/1.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface WlwLocationManager ()<CLLocationManagerDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>{
     CLLocationManager *_locationManager;
     BMKLocationService* _locService;
     BMKGeoCodeSearch *_geoService;
}
@end
@implementation WlwLocationManager

-(void)dealloc{
    _locService.delegate = nil;
    _locService = nil;
    _geoService.delegate = nil;
    _geoService = nil;
}
/**
 *用户位置更新后，会调用此函数netW
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    //将经度显示到label上
//    [WlwAppData shareAppData].longitude = [NSString stringWithFormat:@"%lf", userLocation.location.coordinate.longitude];
//    //将纬度现实到label上
//    [WlwAppData shareAppData].latitude = [NSString stringWithFormat:@"%lf", userLocation.location.coordinate.latitude];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
  //  [_locService stopUserLocationService];
    if (_locateSuccessBlock) {
        _locateSuccessBlock(userLocation);
    }
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    SDKLOG(@"%@",error);
    if (_locateFailBlock) {
        _locateFailBlock(nil);
    }
}
/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        if (_reverseGeoSuccessBlock) {
            _reverseGeoSuccessBlock(result.addressDetail);
        }
    }
    else {
        if (_reverseGeoFailBlock) {
            _reverseGeoFailBlock(@"抱歉，未找到");
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (_locateFailBlock) {
        _locateFailBlock(error);
    }
}
//开始定位
- (void)startLocationService {
    
    if (_locService == nil) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
 
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9) {
        _locService.allowsBackgroundLocationUpdates = YES;
    }
    [_locService startUserLocationService];
}
//开始反地理编码
-(void)startReverseGeoService:(BMKUserLocation *)location;
{
    if (_geoService == nil) {
        _geoService = [[BMKGeoCodeSearch alloc]init];
        _geoService.delegate = self;
    }
   // 发起反向地理编码检索
    CLLocationCoordinate2D pt = location.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geoService reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
      SDKLOG(@"反geo检索发送成功");
    }
    else
    {
      SDKLOG(@"反geo检索发送失败");
    }
}

-(void)startReverseGeoServiceWithCoordinate2D:(CLLocationCoordinate2D)pt
{
    if (_geoService == nil) {
        _geoService = [[BMKGeoCodeSearch alloc]init];
        _geoService.delegate = self;
    }
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geoService reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        SDKLOG(@"反geo检索发送成功");
    }
    else
    {
        SDKLOG(@"反geo检索发送失败");
    }

}

-(void)setLocateSuccessBlock:(WlwLocateSuccess)locateSuccessBlock
{
    if (locateSuccessBlock) {
        _locateSuccessBlock = nil;
        _locateSuccessBlock = locateSuccessBlock;
    }
}

-(void)setLocateFailBlock:(WlwLocateFail)locateFailBlock
{
    if (locateFailBlock) {
        _locateFailBlock = nil;
        _locateFailBlock = locateFailBlock;
    }
}

-(void)setReverseGeoSuccessBlock:(ReverseGeoSuccess)reverseGeoSuccessBlock
{
    if (reverseGeoSuccessBlock) {
        _reverseGeoSuccessBlock = nil;
        _reverseGeoSuccessBlock = reverseGeoSuccessBlock;
    }
}

-(void)setReverseGeoFailBlock:(ReverseGeoFail)reverseGeoFailBlock
{
    if (reverseGeoFailBlock) {
        _reverseGeoFailBlock = nil;
        _reverseGeoFailBlock = reverseGeoFailBlock;
    }
}
     
@end
