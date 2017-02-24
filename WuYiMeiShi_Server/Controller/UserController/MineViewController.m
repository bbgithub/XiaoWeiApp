//
//  MineViewController.m
//  HouseWork
//
//  Created by @"ZL" on 16/8/2.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "MineViewController.h"
#import "WlwLogInController.h"
#import "WlwGirdItem.h"
#import "WlwMeTableViewCell.h"
#import "GetHeaderTokenRequest.h"
#import "TokenModel.h"
#import "QNUploadManager.h"
#import "UIImage+ImageCompress.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NotifyRequest.h"
@interface MineViewController()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic , strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nickNameLab;
@property (nonatomic, strong) UILabel *vendorNameLab;
@end
@implementation MineViewController




-(void)viewDidLoad{
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    NSMutableArray *array_0 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i++) {
        if (i == 0) {
            WlwGirdItem *item = [[WlwGirdItem alloc] init];
            item.imgName = @"me_order";
            item.title = @"我的订单";
            [array_0 addObject:item];
            continue;
        }
    }
    [_dataSource addObject:array_0];
    NSMutableArray *array_1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            WlwGirdItem *item = [[WlwGirdItem alloc] init];
            item.imgName = @"me_pwd";
            item.title = @"修改密码";
            [array_1 addObject:item];
            continue;
        }
        if (i == 1) {
            WlwGirdItem *item = [[WlwGirdItem alloc] init];
            item.imgName = @"eeeee";
            item.title = @"退出登录";
            [array_1 addObject:item];
            continue;
        }

    }
    [_dataSource addObject:array_1];
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
        make.edges.equalTo(self.view);
    }];
    
    

    
    // 头像
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 205)];
    headerView.backgroundColor = RGBACOLOR(0x3e,0xc3,0xd5,1.0);
    
    UILabel *mineLab = [WlwHelp getLabel:@"" withFontSize:17.f withFrame:CGRectZero withColor:[UIColor whiteColor]];
    mineLab.font = [UIFont boldSystemFontOfSize:17.f];
    [headerView addSubview:mineLab];
    [mineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).offset(30);
        make.centerX.equalTo(headerView);
    }];
    
    self.headerImageView = [[UIImageView alloc] init];
    self.headerImageView.image = [UIImage imageNamed:@"ico_avator"];
   // self.headerImageView.backgroundColor = RGBACOLOR(0xf8, 0xf8, 0xff, 1.0);
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 35.f;
    [headerView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headerView).offset(20);
//        make.bottom.equalTo(headerView).offset(-10);
        make.center.equalTo(headerView);
        make.height.width.equalTo(@70);
    }];
//    _headerImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImgTouched)];
//    [_headerImageView addGestureRecognizer:headerTap];
    // 昵称
    
    _nickNameLab = [WlwHelp getLabel:@"" withFontSize:16.f withFrame:CGRectZero withColor:[UIColor whiteColor]];
    _nickNameLab.font = [UIFont boldSystemFontOfSize:16.f];
    [headerView addSubview:_nickNameLab];
    [_nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.left.equalTo(self.headerImageView.mas_right).offset(20);
        make.centerX.equalTo(headerView);
        make.top.equalTo(self.headerImageView.mas_bottom).offset(10);
    }];
    
    // 手机号
    _vendorNameLab = [WlwHelp getLabel:@"" withFontSize:12.f withFrame:CGRectZero withColor:NAVGATIONBARCOLOR];
    _vendorNameLab.backgroundColor = [UIColor whiteColor];
    _vendorNameLab.layer.masksToBounds = YES;
    _vendorNameLab.layer.cornerRadius = 2.f;
    [headerView addSubview:_vendorNameLab];
    [_vendorNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
       // make.left.equalTo(self.headerImageView.mas_right).offset(20);
       // make.bottom.equalTo(self.headerImageView).offset(-10);
        make.top.equalTo(_nickNameLab.mas_bottom).offset(10);
    }];
    tableView.tableHeaderView = headerView;
}

-(void)setLeftNavgationBtn{}
//
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NotifyRequest *request = [[NotifyRequest alloc] initWithModelClass:[WlwAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
    }];
    request.channelId =  [AppData shareAppData].channenId;
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [_dataSource objectAtIndex:section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [_dataSource objectAtIndex:indexPath.section];

    WlwGirdItem *data = [array objectAtIndex:indexPath.row];
    NSString *identifier = @"WlwMeTableViewCell";
    
    WlwMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[WlwMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setCellData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}

#pragma mark _TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [_dataSource objectAtIndex:indexPath.section];
    
    WlwGirdItem *data = [array objectAtIndex:indexPath.row];
    if ([data.title isEqualToString:@"修改密码"]) {
        [self pushCanvas:@"ChangePasswdController" withArgument:nil];
    }
    if([data.title isEqualToString:@"我的收藏"]){
        [self pushCanvas:@"MyFavoriteController" withArgument:nil];
    }
    if ([data.title isEqualToString:@"我的订单"]) {
        [self pushCanvas:@"MyOrderController" withArgument:nil];
    }
    if ([data.title isEqualToString:@"我的评论"]) {
        [self pushCanvas:@"MyCommentController" withArgument:nil];
    }
    if ([data.title isEqualToString:@"我的保险"]) {
        [self pushCanvas:@"MyInsuranceViewController" withArgument:nil];
    }
    if ([data.title isEqualToString:@"退出登录"]) {
        [self logOut];
    }
}
#pragma mark _退出登录
-(void)logOut
{
   [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATUS object:@NO];
}

-(void)headerImgTouched
{
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 2:
                    // 取消
                    return;
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = NO;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *tempImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    _headerImageView.image = tempImg;
    NSData *scaleData = [UIImage compressImage:tempImg compressRatio:0.8];
    
   /* GetHeaderTokenRequest *request = [[GetHeaderTokenRequest alloc] initWithModelClass:[TokenModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return ;
        }
        TokenModel *token = sender;
        NSString *headerUri = [ZLHelp uniqueImgNameString];
        
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putData:scaleData key:headerUri token:token.data
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      NSLog(@"%@", info);
                      NSLog(@"%@", resp);
                      
                  } option:nil];
        [self uploadHeader:headerUri];
        
    }];
    ZLRequestOperationManager *manager = [[ZLRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];*/
}

-(void)uploadHeader:(NSString *)avator
{
   /* UpdateHeaderRequest *request = [[UpdateHeaderRequest alloc] initWithModelClass:[ZLAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        [self.view makeToast:@"修改头像成功"];
    }];
    request.user_id = USER_ID;
    request.avatar = avator;
    ZLRequestOperationManager *manager = [[ZLRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];*/
}


@end
