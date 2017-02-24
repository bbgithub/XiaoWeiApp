//
//  CartViewController.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/12/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "CartViewController.h"
#import "GetCartListRequest.h"
#import "CartList.h"
#import "CartModel.h"
#import "UIScrollView+EmptyDataSet.h"
#import "CartListCell.h"
@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;//tableview数据源
@property (nonatomic, strong) UILabel *totalMoney;
@property (nonatomic, strong) NSString *orderAmount;

@end

@implementation CartViewController

-(void)setLeftNavgationBtn
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestCartList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationTitle:@"购物车"];
    _dataSource = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
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
    [addToShopCartBtn setTitle:@"去结算" forState:UIControlStateNormal];
    addToShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT+1];
    [addToShopCartBtn addTarget:self action:@selector(goBill) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addToShopCartBtn];
    [addToShopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.top.equalTo(bottomView);
        make.width.equalTo(@88);
    }];
    
    _totalMoney = [WlwHelp getLabel:@"" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:ORANGECOLOR];
    [bottomView addSubview:_totalMoney];
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(10);
    }];
}

-(void)calcuteTotalMoney
{
    double money = 0.f;
    for (int i = 0; i < _dataSource.count; i++) {
        CartModel *temp = [_dataSource objectAtIndex:i];
        money+=[temp.price doubleValue] *[temp.buy_num integerValue];
    }
    self.orderAmount= [NSString stringWithFormat:@"%.2f",money];
    _totalMoney.text = [NSString stringWithFormat:@"总价:%.2f",money];
}

#pragma mark _请求购物车列表
-(void)requestCartList
{
    GetCartListRequest *request = [[GetCartListRequest alloc] initWithModelClass:[CartList class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            if ([[(CartList *)sender code] integerValue] == 10) {
                [_dataSource removeAllObjects];
                [_tableView reloadData];
                return;
            }

            [self.view makeToast:msg];
            return;
        }
        _dataSource = [NSMutableArray arrayWithArray:[(CartList *)sender data]];
        [self calcuteTotalMoney];
        [_tableView reloadData];
    }];
    UserModel *user =  [AppData shareAppData].userModel;
    request.user_id = user._id;
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];
}

-(void)goBill
{
    if (_dataSource.count == 0 || _dataSource==nil) {
        return;
    }
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (int i = 0; i < _dataSource.count; i++) {
         CartModel *data = [_dataSource objectAtIndex:i];
        [list addObject:[NSString stringWithFormat:@"%@",data.product_id]];
    }
    NSString *productIds = [WlwHelp stringWithCommaFromArray:list];
    [self pushCanvas:@"ConfirmGoodsController" withArgument:[NSArray arrayWithObjects:productIds,self.orderAmount,self.dataSource, nil]];
}

#pragma mark _tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CartListCell";
    CartListCell *cell = (CartListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CartListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CartModel *data = [_dataSource objectAtIndex:indexPath.row];
    [cell setCellData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 215;
    return 120;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"购物车空空如也";
    
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
    NSString *text = @"小微一站式平台";
    
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
    // Do something
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
