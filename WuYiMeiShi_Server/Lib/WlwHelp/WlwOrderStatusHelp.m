//
//  WlwOrderStatusHelp.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/4/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwOrderStatusHelp.h"

/**
 * 订单支付状态-支付中（部分付款）
 */
static NSString *const ORDER_PAY_STATUS_PAYMENTPROCESS = @"PAYMENTPROCESS";
/**
 * 订单支付状态-已退款
 */
static NSString *const ORDER_PAY_STATUS_REFUNDMENT = @"REFUNDMENT";
/**
 * 订单支付状态-未支付
 */
static NSString *const ORDER_PAY_STATUS_WAITPAYMENT = @"WAITPAYMENT";
/**
 * 订单支付状态-已支付
 */
static NSString *const ORDER_PAY_STATUS_PAID = @"PAID";

/**
 * 订单状态-消费者已提交，可被店铺接受、可被消费者取消、可被店铺拒绝
 */
static NSString *const ORDER_STATUS_SUBMIT = @"SUBMITTED";
/**
 * 订单状态-店铺已接受，可被店铺发货
 */
static NSString *const ORDER_STATUS_ACCEPT = @"ACCEPTED";
/**
 * 订单状态-店铺已发货，可被消费者确认收货，可被消费者拒收
 */
static NSString *const  ORDER_STATUS_DELIVER = @"DELIVERED";
/**
 * 订单状态-消费者已收货，流程结束
 */
static NSString *const  ORDER_STATUS_FINISH = @"FINISHED";
/**
 * 订单状态-消费者已取消，消费者只能在店铺未对订单执行任何操作前取消订单。可能需要在原单填写相关备注。
 */
static NSString *const  ORDER_STATUS_CANCEL = @"CANCELLED";
/**
 * 订单状态-消费者已拒绝，流程结束。可能需要在原单填写相关备注。
 */
static NSString *const  ORDER_STATUS_C_REJECTED = @"REJECTED";
/**
 * 订单状态-店铺设置已签收，当消费者未确认收货时，店铺设置客户已签收
 */
static NSString *const  ORDER_STATUS_SIGNED = @"SIGNED";


@implementation WlwOrderStatusHelp

+(BOOL)isShowConfirmBtn:(NSString *)status
{
    if ([ORDER_STATUS_DELIVER isEqualToString:status] || [ORDER_STATUS_SIGNED isEqualToString:status]) {
        return YES;
    } else {
        return NO;
    }
}
+(BOOL)isShowCancelBtn:(NSString *)status payStatus:(NSString *)payStatus
{
    if ([ORDER_PAY_STATUS_WAITPAYMENT isEqualToString:payStatus] && (![ORDER_STATUS_CANCEL isEqualToString :status])) {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL)isShowPayBtn:(NSString *)status payStatus:(NSString *)payStatus
{
    if ([ORDER_PAY_STATUS_WAITPAYMENT isEqualToString:payStatus] && ![ORDER_STATUS_CANCEL isEqualToString:status]) {
        return YES;
    } else {
        return NO;
    }
}

+(NSString *)showOrderStatus:(NSString *)status payStatus:(NSString *)payStatus
{
    if ([ORDER_STATUS_ACCEPT isEqualToString:status]) {
        return @"店铺已接受";
    } else if ([ORDER_STATUS_C_REJECTED isEqualToString:status]) {
        return @"消费者已拒绝";
    } else if ([ORDER_STATUS_CANCEL isEqualToString:status]) {
        return @"消费者已取消";
    } else if ([ORDER_STATUS_DELIVER isEqualToString:status]) {
        return @"店铺已发货";
    } else if ([ORDER_STATUS_FINISH isEqualToString:status]) {
        return @"消费者已收货";
    } else if ([ORDER_STATUS_SIGNED isEqualToString:status]) {
        return @"店铺设置已签收";
    } else if ([ORDER_STATUS_SUBMIT isEqualToString:status] && [ORDER_PAY_STATUS_WAITPAYMENT isEqualToString:payStatus]) {
        return @"消费者已提交";
    } else if ([ORDER_STATUS_SUBMIT isEqualToString:status] && [ORDER_PAY_STATUS_PAID isEqualToString:payStatus]) {
        return @"已支付待处理";
    } else {
        return @"未知状态";
    }
}


+(NSString *)showPayStatus:(NSString *)payStatus
{
    if ([ORDER_PAY_STATUS_WAITPAYMENT isEqualToString:payStatus]) {
        return @"未支付";
    } else if ([ORDER_PAY_STATUS_PAID isEqualToString:payStatus]) {
        return @"已支付";
    } else {
        return @"未知状态";
    }
}

@end
