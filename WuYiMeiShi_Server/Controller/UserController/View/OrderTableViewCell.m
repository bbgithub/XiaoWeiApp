//
//  OrderTableViewCell.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/9.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "Masonry.h"
#import "OrderEntity.h"
@interface OrderTableViewCell()
@property (nonatomic, strong) UILabel *orderNo;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *priceKeyLab;
@property (nonatomic, strong) UILabel *priceValueLab;
@property (nonatomic, strong) UIView *seperateView;
@end

@implementation OrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUi];
    }
    return self;
}

-(void)setUi
{
    if (_orderNo == nil) {
        _orderNo = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x63, 0x63, 0x63, 1.0)];
        [self.contentView addSubview:_orderNo];
        [_orderNo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
        }];
    }
    if (_timeLab == nil) {
        _timeLab = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT-1 withFrame:CGRectZero withColor:RGBACOLOR(0x63, 0x63, 0x63, 1.0)];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(_orderNo);
        }];
    }
    if (_priceKeyLab == nil) {
        _priceKeyLab = [WlwHelp getLabel:@"订单总额:" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x63, 0x63, 0x63, 1.0)];
        [self.contentView addSubview:_priceKeyLab];
        [_priceKeyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(_orderNo.mas_bottom).offset(10);
        }];
    }
    if (_priceValueLab == nil) {
        _priceValueLab = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:ORANGECOLOR];
        [self.contentView addSubview:_priceValueLab];
        [_priceValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceKeyLab.mas_right).offset(2);
            make.centerY.equalTo(_priceKeyLab);
        }];
    }
    if (_seperateView == nil) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = DIVIDER_COLOR;
        [self.contentView addSubview:_seperateView];
        [_seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@(1/[WlwHelp deviceScale]));
        }];
    }
}

-(void)setCellData:(OrderEntity *)data
{
    _orderNo.text = data.order_no;
    _priceValueLab.text = [NSString stringWithFormat:@"¥%.2f",[data.total_price floatValue]];
    _timeLab.text = [WlwHelp dateFormatWithMontnAndTime:data.create_time];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
