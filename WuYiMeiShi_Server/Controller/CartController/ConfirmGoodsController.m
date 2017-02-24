//
//  ConfirmGoodsController.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/6.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "ConfirmGoodsController.h"
#import "CartListCell.h"
#import "CartModel.h"
#import "ConfirmOrderRequest.h"
#import "PayRequest.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PayResult.h"
#import "WlwAlertView.h"
#import "OrderModel.h"
@interface ConfirmGoodsController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *productIds;
@property (nonatomic, strong) NSString *orderAmount;
@property (nonatomic, strong) OrderModel *orderModel;
@end

@implementation ConfirmGoodsController

-(void)argumentForCanvas:(id)argumentData{
    if ([argumentData isKindOfClass:[NSArray class]]) {
        self.productIds = [argumentData objectAtIndex:0];
        self.orderAmount = [argumentData objectAtIndex:1];
        self.dataSource = [argumentData objectAtIndex:2];;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationTitle:@"确认商品"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [addToShopCartBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    addToShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT+1];
    [addToShopCartBtn addTarget:self action:@selector(confirmBill) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addToShopCartBtn];
    [addToShopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.top.equalTo(bottomView);
        make.width.equalTo(@88);
    }];
}

-(void)confirmBill
{
    ConfirmOrderRequest *request = [[ConfirmOrderRequest alloc] initWithModelClass:[OrderModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        self.orderModel = sender;
        WlwAlertView *alertView = [[WlwAlertView alloc] initWithTitle:@"提示" message:@"下单成功,立即去支付吗?" confirmBlock:^(id sender) {
            [self goToPay];
        } cancelBlock:^(id sender) {
            [self popCanvasWithArgment:nil];
        }];
        [alertView show];
    }];
    UserModel *user =  [AppData shareAppData].userModel;
    request.user_id = user._id;
    request.productIds = self.productIds;
    request.orderAmount = self.orderAmount;
    request.receive_id = @(1);
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];
}

-(void)goToPay
{
    PayRequest *request = [[PayRequest alloc] initWithModelClass:[PayResult class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        NSString *data = [(PayResult *)sender data];
        [[AlipaySDK defaultService] payOrder:data fromScheme:@"alipay_xiaowei" callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }];
    request.type = @(1);
    request.out_trade_no = self.orderModel.orderNo;
    request.amount = self.orderModel.amount;
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];

}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else{
        return _dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"addressCell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:12.f];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"收货人姓名:梅枭峰";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"收货人联系方式:13989826414";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"收货人地址:浙江省杭州市三墩镇灯彩街63号";
        }
        return cell;

    }else{
        static NSString *CellIdentifier = @"CartListCell";
        CartListCell *cell = (CartListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CartListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        CartModel *data = [_dataSource objectAtIndex:indexPath.row];
        [cell setCellData:data];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
         return 40;
    }else{
        return 120;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
