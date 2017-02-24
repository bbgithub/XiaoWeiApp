//
//  CartListCell.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/6.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CartModel;
@interface CartListCell : UITableViewCell
-(void)setCellData:(CartModel *)data;
@end
