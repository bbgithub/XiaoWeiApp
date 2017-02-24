//
//  OrganizeListController.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/19.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "OrganizeListController.h"
#import "OrganizeListRequest.h"
#import "WlwAbstractModel.h"
#import "OrganizeList.h"
#import "OrganizeModel.h"
@interface OrganizeListController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@end


@implementation OrganizeListController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavgationTitle:@"选择医院名称"];
    for (int i = 0; i < 1; i++) {
        OrganizeListRequest *request = [[OrganizeListRequest alloc] initWithModelClass:[OrganizeList class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
            if (error) {
                [self.view makeToast:msg];
                return;
            }
                    NSArray *data = [(OrganizeList *)sender data];
                    self.dataSource = data;
                    [self setUi];
            
        }];
        WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
        [manager performWithRequest:request View:self.view];
    }
   
}

-(void)setUi
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -datasource UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.dataSource.count;
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 根据不同的tableview返回不同的cell
    NSString *identifier = @"SHOPLISTCELL";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // config cell
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    OrganizeModel *data = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = data.organization;
    cell.textLabel.textColor = RGBACOLOR(0x66, 0x66, 0x66, 1.0);
    cell.textLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
    return cell;
}

#pragma mark -delegate UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 50;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrganizeModel *data = [_dataSource objectAtIndex:indexPath.row];
    [self popCanvasWithArgment:data.organization];
}

@end
