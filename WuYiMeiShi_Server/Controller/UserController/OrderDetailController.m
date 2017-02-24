//
//  OrderDetailController.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 17/1/9.
//  Copyright © 2017年 wlw. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderEntity.h"
#import "GetOrderDetailRequest.h"
#import "CartListCell.h"
#import "CartList.h"
#import "CartModel.h"
@interface OrderDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;//tableview数据源
@property (nonatomic, strong) UILabel *totalMoney;
@property (nonatomic, strong) OrderEntity *orderEntity;
@end

@implementation OrderDetailController


-(void)argumentForCanvas:(id)argumentData
{
    if ([argumentData isKindOfClass:[OrderEntity class]]) {
        self.orderEntity = argumentData;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationTitle:@"订单详情"];
    _dataSource = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];

    GetOrderDetailRequest *request = [[GetOrderDetailRequest alloc] initWithModelClass:[CartList class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        self.dataSource =  [NSMutableArray arrayWithArray:[(CartList *)sender data]];
        [self.tableView reloadData];
    }];
    request.order_id = self.orderEntity._id;
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];
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
