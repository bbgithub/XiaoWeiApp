//
//  GoodsTableViewCell.h
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/4.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DingHallModel;
@interface GoodsTableViewCell : UITableViewCell
-(void)setCellData:(DingHallModel *)data;
@end
