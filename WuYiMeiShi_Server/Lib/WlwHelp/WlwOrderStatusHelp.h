//
//  WlwOrderStatusHelp.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WlwOrderStatusHelp : NSObject
/**
 *  订单已发货状态或者店铺已签收状态显示确认收货按钮
 *
 *  @param status 订单状态
 *
 *  @return boolean
 */
+(BOOL)isShowConfirmBtn:(NSString *)status;

/**
 *  在订单未支付时，显示取消订单按钮
 *
 *  @param status    订单状态
 *  @param payStatus 支付状态
 *
 *  @return boolen
 */
+(BOOL)isShowCancelBtn:(NSString *)status payStatus:(NSString *)payStatus;

/**
 *  在订单未支付且未取消时，显示支付订单按钮
 *
 *  @param status
 *  @param payStatus
 *
 *  @return
 */
+(BOOL)isShowPayBtn:(NSString *)status payStatus:(NSString *)payStatus;

/**
 * 根据订单的状态码，返回对应的订单状体描述
 *
 * @param status 订单状态码
 * @return String
 */
+(NSString *)showOrderStatus:(NSString *)status payStatus:(NSString *)payStatus;

/**
 * 根据订单的支付状态码，返回对应的订单支付状体描述
 *
 * @param payStatus 付款状态，未支付 WAITPAYMENT、
 *                  已支付 PAID、
 * @return String
 */

+(NSString *)showPayStatus:(NSString *)payStatus;

@end
