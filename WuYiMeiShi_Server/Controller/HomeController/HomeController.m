//
//  HomeController.m
//  wuyimeishi
//
//  Created by 物恋网 on 16/7/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "HomeController.h"
#import "DingingHallRequest.h"
#import "PullTableView.h"
#import "PPStarPage.h"
#import "UIScrollView+EmptyDataSet.h"
#import "DingHallList.h"
#import "DingHallModel.h"
#import "GoodsTableViewCell.h"
@interface HomeController()<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) PullTableView *tableView;
@property (nonatomic, strong) PPStarPage *page;
@property (nonatomic, strong) NSMutableArray *dataSource;//tableview数据源
@property (nonatomic, assign) BOOL isNeedClear;
@property (nonatomic, assign) BOOL isNoMoreData;
@end

@implementation HomeController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgationTitle:@"小微布艺"];
    _dataSource = [[NSMutableArray alloc] init];
    _tableView = [[PullTableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.pullDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    self.page = [[PPStarPage alloc] init];
    self.page.start = @(0);
    self.page.count = @(MAX_PAGE_COUNT);
   // [self requestServer];
}

-(void)argumentForCanvas:(id)argumentData{
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

-(void)setLeftNavgationBtn
{
    
}


-(void)requestServer
{
    DingingHallRequest *request = [[DingingHallRequest alloc] initWithModelClass:[DingHallList class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        [self dismissLoadMore];
        if (error) {
            if ([[(DingHallList *)sender code] integerValue] == 10) {
                 _isNoMoreData = YES;
                [_tableView reloadData];
                return;
            }
            [self.view makeToast:msg];
            return;
        }
        NSArray *data = [(DingHallList *)sender data];
        if (data.count < MAX_PAGE_COUNT) {
           _isNoMoreData = YES;
        }else{
            _isNoMoreData = NO;
        }
        if (_isNeedClear) {
            _dataSource =[NSMutableArray arrayWithArray:data];
        }else{
            [_dataSource addObjectsFromArray:data];
        }
        [_tableView reloadData];
        
    }];
    UserModel *user = [AppData shareAppData].userModel;
    request.page = self.page;
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DynamicTableViewCell";
    GoodsTableViewCell *cell = (GoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    DingHallModel *data = [_dataSource objectAtIndex:indexPath.row];
    [cell setCellData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 215;
    return 120;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DingHallModel *data = [_dataSource objectAtIndex:indexPath.row];
    [self pushCanvas:@"PackageController" withArgument:data];
    
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"您所在的城市还未开通小微布艺";
    
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
    [self addDingHall];
}

#pragma mark _增加食堂
-(void)addDingHall
{
    [self pushCanvas:@"CreateDingHallController" withArgument:nil];
}

@end
