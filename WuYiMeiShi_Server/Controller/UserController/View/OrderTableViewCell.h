//
//  OrderTableViewCell.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/9.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderEntity;
@interface OrderTableViewCell : UITableViewCell
-(void)setCellData:(OrderEntity *)data;
@end
