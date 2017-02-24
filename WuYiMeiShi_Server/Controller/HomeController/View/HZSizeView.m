//
//  HZSizeView.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "HZSizeView.h"
#import "AttributesValue.h"
#import "AttributeNameValue.h"
#import "Masonry.h"
#import "AttributeBtn.h"
static const CGFloat kSpaceHorizontal = 10;   //按钮之间的水平方向间隔
static const CGFloat kSpaceVertical = 13;   //按钮之间的垂直方向间隔

@interface HZSizeView()
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UIButton *btnPreSelect;
@end
@implementation HZSizeView

-(id)initWithFrame:(CGRect)frame attributes:(AttributeNameValue *)atribute;
{
    self = [super initWithFrame:frame];
    if (self) {
        _btnList = [[NSMutableArray alloc] init];
        _lblName = [WlwHelp getLabel:atribute.attribute_name withFontSize:TEXT_FONT+1 withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
        [self addSubview:_lblName];
        [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(10);
            make.height.equalTo(@30);
        }];
        _fHeight = 70;
        NSArray *arrItem = atribute.attributeValues;
        
        CGFloat left = 5;   //当前btn到左侧边界的距离
        CGFloat top = 5;    //当前btn到lblName的距离
        NSInteger iRow = 0; //btn的行数
        
        for (int i = 0; i < arrItem.count; i++)
        {
            AttributesValue *data = [arrItem objectAtIndex:i];
            CGFloat width = [self widthForText:data.goods_attr fontSize:13]; //当前btn的width
            if (left + width > self.bounds.size.width)
            {
                iRow ++;
                left = 5;
                top = (30+kSpaceVertical)*iRow;
            }
            
            AttributeBtn *btn = [[AttributeBtn alloc] initWithFrame:CGRectMake(left, top+40, width, 30)];
            [btn setTitle:data.goods_attr forState:UIControlStateNormal];
            [btn setBackgroundColor:VIEWBACKCOLOR];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag = [data.attribute_id integerValue];
            btn.goodsValueId = [data._id integerValue];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.layer.cornerRadius = 6;
            [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [_btnList addObject:btn];
            left += width + kSpaceHorizontal;    //距离向后推
        }
        
        _fHeight = 40 + top + 30 + kSpaceVertical; //self的实际高度
    }
    return self;
}

- (CGFloat)fHeight
{
    return _fHeight;
}


- (CGFloat)widthForText:(NSString *)text fontSize:(float)fontSize
{
    CGSize constraint = CGSizeMake(MAXFLOAT, 30.0f);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size.width+20;
}

-(void)btnSelected:(UIButton *)btn{
    if (_btnPreSelect != btn)
    {
        [_btnPreSelect setBackgroundColor:VIEWBACKCOLOR];
        [_btnPreSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnPreSelect.selected = NO;
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnPreSelect = btn;
        
        btn.selected = YES;
        
        if (_attributeSelect)
        {
            _attributeSelect(btn);
        }
    }
    else
    {
        btn.selected = !btn.selected;
        if (btn.isSelected)
        {
            [btn setBackgroundColor:[UIColor redColor]];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [btn setBackgroundColor:VIEWBACKCOLOR];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (_attributeSelect)
        {
            _attributeSelect(btn);
        }
    }
}

-(void)setAttributeSelect:(AttributeSelected)attributeSelect
{
    if (attributeSelect) {
        _attributeSelect = nil;
        _attributeSelect = attributeSelect;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
