//
//  CreateDingHallController.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "CreateDingHallController.h"
#import "WlwFormViewWithLeftName.h"
#import "CreateDingingHallRequest.h"
@interface CreateDingHallController()
@property (nonatomic, strong) WlwFormViewWithLeftName *dingHallNameformView;
@end

@implementation CreateDingHallController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavgationTitle:@"创建食堂"];
    [self setUI];
}

-(void)setUI
{
    _dingHallNameformView =[[WlwFormViewWithLeftName alloc] initWithLeftName:@"食堂名称:" rightImage:nil];
    [self.view addSubview:_dingHallNameformView];
    [_dingHallNameformView setTextPlaceHold:@"请输入食堂名称(限20字之内)" textMaxLength:20];

    [_dingHallNameformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@35);
    }];
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [createBtn addTarget:self action:@selector(createDingHall) forControlEvents:UIControlEventTouchUpInside];
    createBtn.backgroundColor = ORANGECOLOR;
    createBtn.layer.masksToBounds = YES;
    createBtn.layer.cornerRadius = 4.f;
    [createBtn setTitle:@"创建" forState:UIControlStateNormal];
    createBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:createBtn];
    [createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_dingHallNameformView.mas_bottom).offset(20);
        make.width.equalTo(@70);
        make.height.equalTo(@40);
    }];
}

-(void)createDingHall{
//    if (_dingHallNameformView.textfiled.text.length == 0) {
//        [self.view makeToast:@"食堂名称不能为空"];
//        return;
//    }
//    CreateDingingHallRequest *request = [[CreateDingingHallRequest alloc] initWithModelClass:[WlwAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
//        if (error) {
//            [self.view makeToast:msg];
//            return;
//        }
//        [self popCanvasWithArgment:REFRESH];
//    }];
//    UserModel *user = [AppData shareAppData].userModel;
//    request.organization =user.organization;
//    request.name =_dingHallNameformView.textfiled.text;
//    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
//    [manager performWithRequest:request View:self.view];
}

@end
