//
//  WlwMeTableViewCell.m
//  legwork360
//
//  Created by 物恋网 on 16/6/22.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwMeTableViewCell.h"
#import "WlwGirdItem.h"
#import "Masonry.h"
@interface WlwMeTableViewCell()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *rightArrowImgView;
@property (nonatomic, strong) UIView *seperateView;
@end

@implementation WlwMeTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (_iconImgView == nil) {
            _iconImgView = [[UIImageView alloc] init];
            [self.contentView addSubview:_iconImgView];
            [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(10);
                make.centerY.equalTo(self.contentView);
                make.height.width.equalTo(@20);
            }];
        }
        if (_titleLab == nil) {
            _titleLab = [WlwHelp getLabel:@"" withFontSize:14.f withFrame:CGRectZero withColor:RGBACOLOR(0x63, 0x63, 0x63, 1.0)];
            [self.contentView addSubview:_titleLab];
            [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_iconImgView);
                make.left.equalTo(_iconImgView.mas_right).offset(10);
            }];
        }
        if (_rightArrowImgView == nil) {
            _rightArrowImgView = [[UIImageView alloc] init];
            _rightArrowImgView.image = [UIImage imageNamed:@"in"];
            [self.contentView addSubview:_rightArrowImgView];
            [_rightArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.right.equalTo(self.contentView).offset(-10);
            }];
        }
        if (_bindPhoneLab == nil) {
            _bindPhoneLab = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:ORANGECOLOR];
            [self.contentView addSubview:_bindPhoneLab];
            [_bindPhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.right.equalTo(self.rightArrowImgView.mas_left).offset(-10);
            }];
            _bindPhoneLab.hidden = YES;
        }
        if (_seperateView == nil) {
            _seperateView = [[UIView alloc] init];
            _seperateView.backgroundColor = DIVIDER_COLOR;
            [self.contentView addSubview:_seperateView];
            [_seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(10);
                make.bottom.right.equalTo(self.contentView);
                make.height.equalTo(@(1/[WlwHelp deviceScale]));
            }];
        }
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(WlwGirdItem *)user
{
    self.iconImgView.image = [UIImage imageNamed:user.imgName];
    self.titleLab.text = user.title;
    if ([user.title isEqualToString:@"绑定手机"]) {
        _bindPhoneLab.hidden = NO;
    }else{
        _bindPhoneLab.hidden = YES;
    }
}

@end
