//
//  WlwAbstractRequest.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/30.
//  Copyright © 2016年 wlw. All rights reserved.
//  请求接口的父类，所有请求都要继承WlwAbstractRequest类

#import <Foundation/Foundation.h>
#import <objc/message.h>
@interface WlwAbstractRequest : NSObject
typedef void(^CompleteRequestBlock)(id sender, NSString *msg, NSError *error);


/**
 *  用来接收控制层传入的对象模型
 */
@property (nonatomic, strong) Class model;
/**
 *  http／https请求回调
 */
@property (nonatomic, copy) CompleteRequestBlock completeRequestBlock;
/**
 *  http／https情趣参数
 *
 *  @return
 */
-(NSDictionary* )genRequestParagram;

-(NSString *)genRequestUrl;
/**
 *  http/https请求方法，PUT GET POST DELETE
 *
 *  @return 请求方法
 */
-(NSString *)genRequestMethod;
/**
 *  封装http请求头
 *
 *  @return
 */
-(NSDictionary *)genRequestHeader;
/**
 * 网络请求成功回调函数
 *
 *  @param response 后台返回的数据流或者解析出来的字典
 */
-(void)analyseSuccessResponse:(id)response;
/**
 *  网络异常回调函数
 *
 *  @param response
 */
-(void)analyseFailtureResponse:(id)response;
/**
 *  初始化一个request
 *
 *  @param className Model层的model
 *  @param block
 *
 *  @return
 */
-(id)initWithModelClass:(Class)className completeRequestBlock:(CompleteRequestBlock)block;

/**
 *  时间:6月23号
 *  刘敦辉新增方法
 *  用途:用于请求参数列表页直接遍历属性生成字典
 *
 *  @return 字典
 */
- (NSMutableDictionary *)createDictionayFromModelProperties;

@end
