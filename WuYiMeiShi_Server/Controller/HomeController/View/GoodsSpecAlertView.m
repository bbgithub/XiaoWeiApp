//
//  GoodsSpecAlertView.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/10.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "GoodsSpecAlertView.h"
#import "AttributesList.h"
#import "AttributeNameValue.h"
#import "AttributesValue.h"
#import "ProductModel.h"
#import "HZSizeView.h"
#import "masonry.h"
#import "AttributeBtn.h"
#import "WlwAmountEditView.h"
#import <UIImageView+WebCache.h>
@interface GoodsSpecAlertView()
@property (nonatomic, strong) UIImageView *productImgView;
@property (nonatomic, strong) UILabel *productPriceLab;
@property (nonatomic, strong) NSArray *produces;
@property (nonatomic, strong) NSArray *atributeList;
@property (strong, nonatomic) NSMutableArray *buttonArray;//所有按钮
@property (strong, nonatomic) NSMutableArray *conditionArray;//当前选中按钮
@property (nonatomic, strong) ProductModel *selectedProduct;//当前选中的产品
@end
@implementation GoodsSpecAlertView


-(id)initWithAttributesList:(NSArray *)atributeList Produces:(NSArray *)products
{
    self = [super init];
    if (self) {
        self.produces = products;
        ProductModel *minPriceProduct = [self.produces objectAtIndex:0];
        self.atributeList = atributeList;
        _buttonArray = [NSMutableArray new];
        _conditionArray = [NSMutableArray new];
        self.backgroundColor =RGBACOLOR(0x00, 0x00, 0x00, 0.5);
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
       // [self addGestureRecognizer:tap];
        UIView *contentView = [[UIButton alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
        }];
        _productImgView = [[UIImageView alloc] init];
        _productImgView.layer.masksToBounds = YES;
        _productImgView.layer.cornerRadius = 2.f;
        [contentView addSubview:_productImgView];
        [_productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(-10);
            make.left.equalTo(contentView).offset(10);
            make.width.height.equalTo(@85);
        }];
        _productPriceLab = [WlwHelp getLabel:@"" withFontSize:LITTLE_TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0xf5, 0x55, 0x49, 1.0)];
        
        [contentView addSubview:_productPriceLab];
        [_productPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_productImgView.mas_right).offset(10);
            make.centerY.equalTo(_productImgView);
        }];
        _productPriceLab.text = [NSString stringWithFormat:@"¥%.2f",[minPriceProduct.price floatValue]];
        [_productImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GOODSIMGPRE,minPriceProduct.product_img]] placeholderImage:nil];
        
        HZSizeView *view1 = [[HZSizeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) attributes:[atributeList objectAtIndex:0]];
        [view1 setAttributeSelect:^(id sender) {
              [self conditionWhenButtonSelectedWithButton:sender];
            //重刷所有按钮是否置灰
            for (AttributeBtn *btn in _buttonArray) {
                [self reviewButton:btn withConditions:_conditionArray fromArray:(NSMutableArray *)self.produces];
            }
        }];
        [_buttonArray addObjectsFromArray:view1.btnList];
        [contentView addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(_productImgView.mas_bottom).offset(10);
            make.height.equalTo(@(view1.fHeight));
        }];
        
        HZSizeView *view2 = [[HZSizeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) attributes:[atributeList objectAtIndex:1]];
        [view2 setAttributeSelect:^(id sender) {
             [self conditionWhenButtonSelectedWithButton:sender];
            //重刷所有按钮是否置灰
            for (AttributeBtn *btn in _buttonArray) {
                [self reviewButton:btn withConditions:_conditionArray fromArray:(NSMutableArray *)self.produces];
            }

        }];
        [_buttonArray addObjectsFromArray:view2.btnList];
        [self addSubview:view2];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(view1.mas_bottom);
            make.height.equalTo(@(view2.fHeight));
        }];
        
        //重刷所有按钮是否置灰
        for (AttributeBtn *btn in _buttonArray) {
            [self reviewButton:btn withConditions:_conditionArray fromArray:(NSMutableArray *)self.produces];
        }
        
        UILabel *buyNumLab = [WlwHelp getLabel:@"购买数量" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
        [contentView addSubview:buyNumLab];
        [buyNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view2.mas_bottom).offset(15);
            make.left.equalTo(contentView).offset(10);
            make.bottom.equalTo(contentView).offset(-20);
        }];
        
        WlwAmountEditView *editView = [[WlwAmountEditView alloc] initWithMaxNum:99999];
        [editView setAmountChanged:^(int sender) {
            if (self.selectedProduct) {
                self.selectedProduct.buyNum = sender;
            }
        }];
        [contentView addSubview:editView];
        [editView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(buyNumLab);
            make.right.equalTo(contentView).offset(-10);
            make.height.equalTo(@30);
        }];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [contentView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(10);
            make.right.equalTo(contentView).offset(-10);
        }];

    }
    return self;
}

-(void)hide
{
    [self removeFromSuperview];
    
}
-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.top.equalTo(view).offset(0);
    }];
}


////////
//构造被点击按钮条件数组
- (void)conditionWhenButtonSelectedWithButton:(AttributeBtn *)button {
    if (button.selected) {
        if (!_conditionArray.count) {
            [_conditionArray addObject:button];
            SDKLOG(@"%@按钮被点击，添加到条件组",[button titleForState:UIControlStateNormal]);
        } else {
            NSMutableArray *temp = [NSMutableArray new];
            [temp addObject:button];
            for (UIButton *btn in _conditionArray) {
                if (![self button:(AttributeBtn *)btn isInSameRowWithButton:button]) {
                    [temp addObject:btn];
                }
            }
            _conditionArray = temp;
        }
    } else {
        NSMutableArray *temp = [NSMutableArray new];
        for (UIButton *btn in _conditionArray) {
            if (btn != button) {
                [temp addObject:btn];
            }
        }
        _conditionArray = temp;
    }
    if (_conditionArray.count == self.atributeList.count) {//当三项都选择的时候，给出具体库存
        [self calculateReminderWithConditionArray];
    }else{
        
    }
}


- (BOOL)button:(AttributeBtn *)button isInSameRowWithButton:(AttributeBtn *)toButton {
    if(toButton.tag == button.tag)
        return YES;
    else
        return NO;
}



/////
//将条件数组过滤掉同一组的条件
- (NSMutableArray *)filterConditions:(NSMutableArray *)conditions forButton:(AttributeBtn *)button {
    if (!button) {
        return conditions;
    }
    NSMutableArray *result = [NSMutableArray new];
    for (AttributeBtn *btn in conditions) {
        if (![self button:btn isInSameRowWithButton:button]) {
            [result addObject:btn];
        }
    }
    return result;
}

- (void)noConditionWhenReviewButton:(AttributeBtn *)button withGooldsArray:(NSMutableArray *)goodsArray{
    button.enabled = NO;
 
    [button setBackgroundColor:RGBACOLOR(0xf2, 0xf2, 0xf2, 0.3f)];
  
    for (int i = 0; i < goodsArray.count; i++) {
        if (button.enabled) {
            break;
        }
        ProductModel *temp = [goodsArray objectAtIndex:i];
        for (int j = 0; j < temp.attributes.count; j++) {
            NSInteger attributeid = [[temp.attributes objectAtIndex:j] integerValue];
            if(button.goodsValueId == attributeid){
                button.enabled = YES;
                if (button.isSelected) {
                    [button setBackgroundColor:[UIColor redColor]];
                }else{
                    [button setBackgroundColor:VIEWBACKCOLOR];
                }
                break;
            }
                
        }
    }
}
-(BOOL)isInProductAttributes:(ProductModel *)product AttributeBtn:(AttributeBtn *)button
{
    //根据选中的属性 可以过滤掉一些商品了
    BOOL ret = NO;
    for (int j = 0; j < product.attributes.count; j++) {
        NSInteger attributeid = [[product.attributes objectAtIndex:j] integerValue];
        if(button.goodsValueId == attributeid){
            ret = YES;
        }
    }
    return ret;
}


- (NSMutableArray *)resultWhenSelectOneButton:(AttributeBtn *)button fromArray:(NSMutableArray *)fromArray {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < fromArray.count; i++) {
        ProductModel *product = [fromArray objectAtIndex:i];
        if ([self isInProductAttributes:product AttributeBtn:button]) {
           // 根据选中的属性 可以过滤掉一些商品了
            [resultArray addObject:product];
        }
    }
    return resultArray;
}

- (void)reviewButton:(AttributeBtn *)button withConditions:(NSMutableArray *)conditions fromArray:(NSMutableArray *)products {
    NSMutableArray *filteredConditions = [self filterConditions:conditions forButton:button];
    button.enabled = YES;
    if (button.isSelected) {
        [button setBackgroundColor:[UIColor redColor]];
    }else{
        [button setBackgroundColor:VIEWBACKCOLOR];
    }

    if (!filteredConditions.count) {
        [self noConditionWhenReviewButton:button withGooldsArray:products];
    } else {
       // NSMutableDictionary *targetDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        NSMutableArray *targetArray = [NSMutableArray arrayWithArray:products];
        for (int i = 0; i < filteredConditions.count; i++) {
            AttributeBtn *btn = (AttributeBtn *)filteredConditions[i];
            NSMutableArray *remainderArray = [self resultWhenSelectOneButton:btn fromArray:targetArray];
            targetArray = remainderArray;
            if (i == filteredConditions.count - 1) {
                if (targetArray.count) {
                    [self noConditionWhenReviewButton:button withGooldsArray:targetArray];
                } else{
                    button.enabled = NO;
                    [button setBackgroundColor:RGBACOLOR(0xf2, 0xf2, 0xf2, 0.3f)];
                }
            }
        }
    }
}



-(void)calculateReminderWithConditionArray
{
    NSMutableArray *targetArray = [NSMutableArray arrayWithArray:self.produces];
    for (int i = 0; i < _conditionArray.count; i++) {
        AttributeBtn *btn = (AttributeBtn *)_conditionArray[i];
        NSMutableArray *remainderArray = [self resultWhenSelectOneButton:btn fromArray:targetArray];
        targetArray = remainderArray;
        if (i == _conditionArray.count - 1) {
            ProductModel *product =  [targetArray objectAtIndex:0];
            self.selectedProduct = product;
            SDKLOG(@"%@",product);
            _productPriceLab.text = [NSString stringWithFormat:@"¥%.2f",[product.price floatValue]];
            [_productImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GOODSIMGPRE,product.product_img]] placeholderImage:nil];
            
        }
    }

}

-(void)setProductSelect:(ProductSelected)productSelect
{
    if (productSelect) {
        _productSelect = nil;
        _productSelect = productSelect;
    }
}
#pragma mark _close
-(void)closeView
{
    [self hide];
    if (_productSelect) {
        _productSelect([NSArray arrayWithObjects:self.selectedProduct,_conditionArray,nil]);
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
