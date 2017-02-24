//
//  WlwAbstractController.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/31.
//  Copyright © 2016年 wlw. All rights reserved.
//  父类视图控制器

#import <UIKit/UIKit.h>
#import "WlwRequestOperationManager.h"
#import "UIView+Toast.h"
#import "Masonry.h"
#import "NSString+Ext.h"
@interface WlwAbstractController : UIViewController
/**
 **传递到当前视图的参数函数*
 *
 *  @param argumentData
 */
- (void)argumentForCanvas:(id)argumentData;
/**
 *  设置导航栏左边的按钮
 */
-(void)setLeftNavgationBtn;
/**
 *  设置导航栏标题
 *
 *  @param title
 */
-(void)setNavgationTitle:(NSString *)title;
/**
 *
 *
 *  @param canvasName   控制器名字
 *  @param argumentData 给下一级控制器传参
 *
 *  @return
 */
-(WlwAbstractController *)pushCanvas:(NSString *) canvasName withArgument:(id)argumentData;
/**
 *   返回到上一级控制器
 *
 *  @param argument 给上一级控制器传参数
 *
 *  @return
 */
- (WlwAbstractController *)popCanvasWithArgment:(id)argument;
- (WlwAbstractController *)popToCanvas:(NSString *) canvasName withArgument:(id)argumentData;
/**
 *   返回到根视图控制器
 *
 *  @param argumentData
 *
 *  @return
 */
- (WlwAbstractController *)popToRootCanvasWithArgment:(id)argumentData;
- (WlwAbstractController *)popToRootCanvasWithArgment:(id)argumentData afterSeconds:(int)seconds;
//向后退几级界面
- (WlwAbstractController *)popToCanvasWithGrade:(NSInteger)grade  withArgument:(id)argumentData;
@end
