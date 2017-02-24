//
//  WlwMeTableViewCell.h
//  legwork360
//
//  Created by 物恋网 on 16/6/22.
//  Copyright © 2016年 wlw. All rights reserved.
//  个人中心cell

#import <UIKit/UIKit.h>
@class WlwGirdItem;
@interface WlwMeTableViewCell : UITableViewCell
-(void)setCellData:(WlwGirdItem *)user;
@property (nonatomic, strong) UILabel *bindPhoneLab;
@end
