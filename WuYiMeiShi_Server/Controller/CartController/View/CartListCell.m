//
//  CartListCell.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/6.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "CartListCell.h"
#import "CartModel.h"
#import "Masonry.h"
#import <UIImageView+WebCache.h>

@interface CartListCell()
@property (nonatomic, strong) UIImageView *goodsImgView;
@property (nonatomic, strong) UILabel *goodsNameLab;

@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *attributesLab;
@property (nonatomic, strong) UILabel *buyNumLab;
@property (nonatomic, strong) UIView *seperateView;

@end

@implementation CartListCell

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
    if (_attributesLab == nil) {
        _attributesLab = [WlwHelp getLabel:@"" withFontSize:12.f withFrame:CGRectZero withColor:RGBACOLOR(0x99, 0x99,0x99, 1.0)];
        [self.contentView addSubview:_attributesLab];
        [_attributesLab mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    if (_buyNumLab == nil) {
        _buyNumLab = [WlwHelp getLabel:@"" withFontSize:12.f withFrame:CGRectZero withColor:ORANGECOLOR];
        [self.contentView addSubview:_buyNumLab];
        [_buyNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(_priceLab);
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

-(void)setCellData:(CartModel *)data
{
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GOODSIMGPRE,data.product_img]] placeholderImage:nil];
    _goodsNameLab.text = data.goods_name;
    _priceLab.text = [NSString stringWithFormat:@"¥%.2f",[data.price floatValue]];
    _attributesLab.text = [WlwHelp stringWithCommaFromArray:data.attributeValues];
    _buyNumLab.text = [NSString stringWithFormat:@"X %@",data.buy_num];

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
