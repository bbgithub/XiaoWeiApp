//
//  PackageController.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//  套餐控制器

#import "PackageController.h"
#import "WlwFormViewWithLeftName.h"
#import "PullTableView.h"
#import "PPStarPage.h"
#import "UIScrollView+EmptyDataSet.h"
#import "PackageRequest.h"
#import "PackageList.h"
#import "DingHallModel.h"
#import "PackageEntity.h"
#import "SingleModel.h"
#import "GetGoodsDetailRequest.h"
#import "GetGoodsAttributeRequest.h"

#import "AttributesList.h"
#import "GoodsDetailModel.h"
#import "ProductModel.h"
#import "AttributesValue.h"
#import "GoodsSpecAlertView.h"
#import "KDCycleBannerView.h"
#import "AttributeBtn.h"
#import "AddToCartRequest.h"
@interface PackageController()<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,KDCycleBannerViewDataSource,KDCycleBannerViewDelegate>

@property (nonatomic, strong) PullTableView *tableView;
@property (nonatomic, strong) PPStarPage *page;
@property (nonatomic, strong) NSMutableArray *dataSource;//tableview数据源
@property (nonatomic, assign) BOOL isNeedClear;
@property (nonatomic, assign) BOOL isNoMoreData;
@property (nonatomic, strong) DingHallModel *dingHallModel;

@property (nonatomic, strong) GoodsDetailModel *goodsDetail;
@property (nonatomic, strong) NSArray *attributesList;
@property (nonatomic, strong) KDCycleBannerView *bannerView;
@property (nonatomic, strong) UILabel *attributesValueLab;
@property (nonatomic, strong) ProductModel *selectedProduct;//当前选中的产品
@property (nonatomic, assign) NSInteger selectedAttributesNum;//当前选中的属性个数
@end

@implementation PackageController

-(void)argumentForCanvas:(id)argumentData{
    if ([argumentData isKindOfClass:[DingHallModel class]]) {
        self.dingHallModel = argumentData;
    }
    if ([argumentData isKindOfClass:[NSString class]]) {
        if ([argumentData isEqualToString:REFRESH]) {
            _isNeedClear = YES;
            PPStarPage *tmp = [[PPStarPage alloc] init];
            tmp.start = [[NSNumber alloc] initWithInt:0];
            tmp.count = [[NSNumber alloc] initWithInt:MAX_PAGE_COUNT];
            self.page = tmp;
            [self requestServer];
        }
    }

}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavgationTitle:@"商品详情"];
   
    [self requestServer];
    
   // [self requestGoodsAttributes];
}


-(void)setUI{
    UIScrollView *scrollerView = [[UIScrollView alloc] init];
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.userInteractionEnabled = YES;
    scrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _bannerView = [[KDCycleBannerView alloc] init];
    _bannerView.backgroundColor = [UIColor whiteColor];
    _bannerView.userInteractionEnabled = YES;
    _bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2.25);
    _bannerView.datasource = self;
    _bannerView.delegate = self;
    _bannerView.continuous = YES; //是否连续显示
    _bannerView.autoPlayTimeInterval = 5; //时间间隔
    [scrollerView addSubview:_bannerView];
    
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [scrollerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bannerView.mas_bottom).offset(10);
        make.left.right.equalTo(scrollerView);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    UILabel *goodsNameLab = [WlwHelp getLabel:self.goodsDetail.goods_name withFontSize:TEXT_FONT+1 withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
    goodsNameLab.numberOfLines = 0;
    [topView addSubview:goodsNameLab];
    [goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(10);
        make.left.equalTo(topView).offset(10);
        make.right.lessThanOrEqualTo(topView).offset(-10);
    }];
    ProductModel *minPriceProduct = [self.goodsDetail.products objectAtIndex:0];
    ProductModel *maxPriceProduct = [self.goodsDetail.products objectAtIndex:(self.goodsDetail.products.count -1)];
    UILabel *priceLab = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0xf5, 0x55, 0x49, 1.0)];
    [topView addSubview:priceLab];
    priceLab.text = [NSString stringWithFormat:@"¥%.2f~%.2f",[minPriceProduct.price floatValue],[maxPriceProduct.price floatValue]];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.top.equalTo(goodsNameLab.mas_bottom).offset(10);
        make.bottom.equalTo(topView).offset(-10);
    }];
    ////////////////////////商品属性规格
    UIView *attributesView = [[UIView alloc] init];
    attributesView.userInteractionEnabled = YES;
    attributesView.backgroundColor = [UIColor whiteColor];
    [scrollerView addSubview:attributesView];
    [attributesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.right.equalTo(scrollerView);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    _attributesValueLab = [WlwHelp getLabel:@"请选择商品属性规格" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x66, 0x66, 0x66, 1.0)];
    _attributesValueLab.numberOfLines = 0;
    [attributesView addSubview:_attributesValueLab];
    [_attributesValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(attributesView).offset(10);
        make.centerY.equalTo(attributesView);
        make.top.equalTo(attributesView).offset(10);
        make.bottom.equalTo(attributesView).offset(-10);
        make.right.lessThanOrEqualTo(attributesView).offset(-10);
    }];
    
    UITapGestureRecognizer *attributesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAttributes)];
    [attributesView addGestureRecognizer:attributesTap];
    
    ///////////商品评价
    UIView *commentView = [[UIView alloc] init];
    commentView.userInteractionEnabled = YES;
    commentView.backgroundColor = [UIColor whiteColor];
    [scrollerView addSubview:commentView];
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(attributesView.mas_bottom).offset(10);
        make.left.right.equalTo(scrollerView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.bottom.equalTo(scrollerView).offset(-10);
    }];
    
    UILabel *commentLab = [WlwHelp getLabel:@"商品评价" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x66, 0x66, 0x66, 1.0)];
    [commentView addSubview:commentLab];
    [commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentView).offset(10);
        make.top.equalTo(commentView).offset(10);
        make.centerY.equalTo(commentView);
        make.bottom.equalTo(commentView).offset(-10);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    UIButton *addToShopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addToShopCartBtn.backgroundColor = ORANGECOLOR;
    [addToShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addToShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    addToShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT+1];
    [addToShopCartBtn addTarget:self action:@selector(addToShopCart) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addToShopCartBtn];
    [addToShopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.top.equalTo(bottomView);
        make.width.equalTo(@88);
    }];
}


#pragma mark _请求详情接口
-(void)requestServer
{
    GetGoodsDetailRequest *request = [[GetGoodsDetailRequest alloc] initWithModelClass:[GoodsDetailModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        self.goodsDetail = sender;
        [self requestGoodsAttributes];
    }];
    request.goods_id = [NSString stringWithFormat:@"%@",self.dingHallModel._id];
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];
}


-(void)requestGoodsAttributes
{
    GetGoodsAttributeRequest *request = [[GetGoodsAttributeRequest alloc] initWithModelClass:[AttributesList class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        NSArray *data =  [(AttributesList *)sender data];
        self.attributesList = data;
        [self setUI];
    }];
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];

}

-(void)selectAttributes
{
    GoodsSpecAlertView *alertView = [[GoodsSpecAlertView alloc] initWithAttributesList:self.attributesList Produces:self.goodsDetail.products];
    [alertView setProductSelect:^(id sender) {
        if ([(NSArray *)sender count] == 0) {
            _attributesValueLab.text = @"请选择商品属性规格";
            self.selectedAttributesNum = 0;
            return;
        }
        self.selectedProduct = [sender objectAtIndex:0];
        NSArray *data = [sender objectAtIndex:1];
        self.selectedAttributesNum = data.count;
        if (data.count > 0) {
            NSMutableString *res = [[NSMutableString alloc] initWithString:@"已选择"];
            for (int i = 0; i < data.count; i++) {
                UIButton *btn = [data objectAtIndex:i];
                [res appendString:btn.titleLabel.text];
                if (i != data.count -1) {
                    [res appendString:@","];
                }
            }
            _attributesValueLab.text = res;
        }else{
            _attributesValueLab.text = @"请选择商品属性规格";
        }
    }];
    [alertView showInView:self.view];
}
#pragma mark - PullTableView delegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    _isNeedClear = YES;
    _tableView.pullTableIsRefreshing = YES;
    PPStarPage *tmp = [[PPStarPage alloc] init];
    tmp.start = [[NSNumber alloc] initWithInt:0];
    tmp.count = [[NSNumber alloc] initWithInt:MAX_PAGE_COUNT];
    self.page = tmp;
    [self requestServer];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    _isNeedClear = NO;
    if(_isNoMoreData){
        _tableView.pullTableIsLoadingMore = YES;
        [self performSelector:@selector(dismissLoadMore) withObject:self afterDelay:1];
    }else{
        _tableView.pullTableIsRefreshing = YES;
        self.page.start = [NSNumber numberWithInteger:self.dataSource.count];
        [self requestServer];
    }
}

-(void)dismissLoadMore
{
    _tableView.pullTableIsRefreshing = NO;
    _tableView.pullTableIsLoadingMore = NO;
}

#pragma tableView
#pragma mark _tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PackageEntity *packageEntity = [self.dataSource objectAtIndex:section];
    return [packageEntity.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DynamicTableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = VIEWBACKCOLOR;
    }
    
    PackageEntity *packageEntity = [self.dataSource objectAtIndex:indexPath.section];
    SingleModel *data = [packageEntity.list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = RGBACOLOR(0x66, 0x66, 0x66, 1.0);
    cell.textLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
    cell.textLabel.text = data.itemName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 215;
    return 50;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"您还没有套餐记录";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:TEXT_FONT],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"点击添加";
//
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:LITTLE_TEXT_FONT],
//                                 NSForegroundColorAttributeName:ORANGECOLOR,
//                                 NSParagraphStyleAttributeName: paragraphStyle};
//
//    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *text = @"点击添加";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:LITTLE_TEXT_FONT],
                                 NSForegroundColorAttributeName:ORANGECOLOR,
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"noData"];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return VIEWBACKCOLOR;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    return nil;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}




#pragma delegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}


- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}


- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    return YES;
}


- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
{
    
    
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
  
}

#pragma mark - KDCycleBannerViewgetArrayBySupplierIndex

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView {
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < self.goodsDetail.pic.count; i++) {
        [res addObject:[NSString stringWithFormat:@"%@%@",GOODSIMGPRE,[self.goodsDetail.pic objectAtIndex:i]]];
    }
    return res;
    
}

- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index {
    return UIViewContentModeScaleAspectFit;
}

- (UIImage *)placeHolderImageOfZeroBannerView
{
    return [UIImage imageNamed:@"ban.jpg"];
}
//- (UIImage *)placeHolderImageOfBannerView:(KDCycleBannerView *)bannerView atIndex:(NSUInteger)index
//{
//    return [UIImage imageNamed:@"ban"];
//
//}

#pragma mark - KDCycleBannerViewDelegate

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index {
    //    NSLog(@"didScrollToIndex:%ld", (long)index);
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index
{
   
    
}

#pragma mark_加入购物车
-(void)addToShopCart
{
    ProductModel *data = [self.goodsDetail.products objectAtIndex:0];
    if (self.selectedAttributesNum == data.attributes.count) {
        AddToCartRequest *request = [[AddToCartRequest alloc] initWithModelClass:[WlwAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
            if (error) {
                [self.view makeToast:msg];
                return;
            }
            [self.view makeToast:@"成功加入购物车"];
        }];
        UserModel *user =  [AppData shareAppData].userModel;
        request.user_id = user._id;
        request.product_id = self.selectedProduct._id;
        request.buy_num = @(self.selectedProduct.buyNum);
        WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
        [manager performWithRequest:request View:self.view];

        
    }else{
        [self.view makeToast:@"请选择商品属性规则"];
    }
}



@end
