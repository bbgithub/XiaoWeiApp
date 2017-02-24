//
//  WlwLocationManager.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/1.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
typedef void (^WlwLocateSuccess)(id sender);
typedef void (^WlwLocateFail)(id sender);
typedef void (^ReverseGeoSuccess)(id sender);
typedef void (^ReverseGeoFail)(id sender);
@interface WlwLocationManager : NSObject
@property (nonatomic, copy) WlwLocateSuccess locateSuccessBlock;
@property (nonatomic, copy) WlwLocateFail locateFailBlock;
@property (nonatomic, copy) ReverseGeoSuccess reverseGeoSuccessBlock;
@property (nonatomic, copy) ReverseGeoFail reverseGeoFailBlock;
- (void)startLocationService;
-(void)startReverseGeoService:(BMKUserLocation *)location;
-(void)setLocateSuccessBlock:(WlwLocateSuccess)locateSuccessBlock;
-(void)setLocateFailBlock:(WlwLocateFail)locateFailBlock;
-(void)setReverseGeoSuccessBlock:(ReverseGeoSuccess)reverseGeoSuccessBlock;
-(void)setReverseGeoFailBlock:(ReverseGeoFail)reverseGeoFailBlock;

-(void)startReverseGeoServiceWithCoordinate2D:(CLLocationCoordinate2D)pt;
@end
