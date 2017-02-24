//
//  GoodsTableViewCell.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/4.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "DingHallModel.h"
#import "Masonry.h"
#import <UIImageView+WebCache.h>
@interface GoodsTableViewCell()
@property (nonatomic, strong) UIImageView *goodsImgView;
@property (nonatomic, strong) UILabel *goodsNameLab;
@property (nonatomic, strong) UILabel *soureLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIView *seperateView;
@end

@implementation GoodsTableViewCell

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
    if (_goodsImgView == nil) {
        _goodsImgView = [[UIImageView alloc] init];
        _goodsImgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_goodsImgView];
        [_goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
            make.width.equalTo(@90);
            make.height.equalTo(@100);
        }];
    }
    if (_goodsNameLab == nil) {
        _goodsNameLab = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33,0x33, 1.0)];
        _goodsNameLab.numberOfLines = 0;
        [self.contentView addSubview:_goodsNameLab];
        [_goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_goodsImgView.mas_right).offset(10);
            make.top.equalTo(_goodsImgView).offset(10);
            make.right.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
    }
    if (_soureLab == nil) {
        _soureLab = [WlwHelp getLabel:@"小微" withFontSize:12.f withFrame:CGRectZero withColor:RGBACOLOR(0x99, 0x99,0x99, 1.0)];
        [self.contentView addSubview:_soureLab];
        [_soureLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_goodsImgView.mas_right).offset(10);
            make.top.equalTo(_goodsNameLab.mas_bottom).offset(10);
        }];
    }
    if (_priceLab == nil) {
        _priceLab = [WlwHelp getLabel:@"" withFontSize:13.f withFrame:CGRectZero withColor:ORANGECOLOR];
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_goodsImgView.mas_right).offset(10);
            make.bottom.equalTo(_goodsImgView).offset(-10);
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

-(void)setCellData:(DingHallModel *)data
{
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GOODSIMGPRE,data.goods_cover]] placeholderImage:nil];
    _goodsNameLab.text = data.goods_name;
    _priceLab.text = [NSString stringWithFormat:@"¥%.2f",[data.min_price floatValue]];
    
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
