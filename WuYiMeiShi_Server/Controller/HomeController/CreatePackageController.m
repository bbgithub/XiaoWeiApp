//
//  CreatePackageController.m
//  WuYiMeiShi_Server
//
//  Created by 物恋网 on 16/7/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "CreatePackageController.h"
#import "WlwFormViewWithLeftName.h"
#import "SingleModel.h"
#import "CreatePackageRequest.h"
#import "DingHallModel.h"
@interface CreatePackageController()
@property (nonatomic, strong) WlwFormViewWithLeftName *packageNameformView;

@property (nonatomic, strong) WlwFormViewWithLeftName *singleNameformView1;
@property (nonatomic, strong) WlwFormViewWithLeftName *singleNameformView2;
@property (nonatomic, strong) WlwFormViewWithLeftName *singleNameformView3;

@property (nonatomic, strong) WlwFormViewWithLeftName *packagePriceformView;
@property (nonatomic, strong) DingHallModel *dingHallModel;
@end

@implementation CreatePackageController

-(void)argumentForCanvas:(id)argumentData{
    if ([argumentData isKindOfClass:[DingHallModel class]]) {
        self.dingHallModel = argumentData;
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavgationTitle:@"创建套餐"];
    [self setUI];
}


-(void)setUI
{
    _packageNameformView =[[WlwFormViewWithLeftName alloc] initWithLeftName:@"套餐名称:" rightImage:nil];
    [self.view addSubview:_packageNameformView];
    [_packageNameformView setTextPlaceHold:@"请输入套餐名称(限20字之内)" textMaxLength:20];
    [_packageNameformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@35);
    }];
    
    _singleNameformView1 =[[WlwFormViewWithLeftName alloc] initWithLeftName:@"菜名:" rightImage:nil];
    [self.view addSubview:_singleNameformView1];
    [_singleNameformView1 setTextPlaceHold:@"请输入菜名(限10字之内)" textMaxLength:10];
    [_singleNameformView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_packageNameformView.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@35);
    }];
    
    _singleNameformView2 =[[WlwFormViewWithLeftName alloc] initWithLeftName:@"菜名:" rightImage:nil];
    [self.view addSubview:_singleNameformView2];
    [_singleNameformView2 setTextPlaceHold:@"请输入菜名(限10字之内)" textMaxLength:10];
    [_singleNameformView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_singleNameformView1.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@35);
    }];
    
    _singleNameformView3 =[[WlwFormViewWithLeftName alloc] initWithLeftName:@"菜名:" rightImage:nil];
    [self.view addSubview:_singleNameformView3];
    [_singleNameformView3 setTextPlaceHold:@"请输入菜名(限10字之内)" textMaxLength:10];
    [_singleNameformView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_singleNameformView2.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@35);
    }];
    
    _packagePriceformView =[[WlwFormViewWithLeftName alloc] initWithLeftName:@"价格:" rightImage:nil];
    [self.view addSubview:_packagePriceformView];
    _packagePriceformView.textfiled.keyboardType = UIKeyboardTypeNumberPad;
    [_packagePriceformView setTextPlaceHold:@"请输入套餐价格" textMaxLength:10];
    [_packagePriceformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_singleNameformView3.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@35);
    }];

    
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [createBtn addTarget:self action:@selector(createPackage) forControlEvents:UIControlEventTouchUpInside];
    createBtn.backgroundColor = ORANGECOLOR;
    createBtn.layer.masksToBounds = YES;
    createBtn.layer.cornerRadius = 4.f;
    [createBtn setTitle:@"创建" forState:UIControlStateNormal];
    createBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:createBtn];
    [createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_packagePriceformView.mas_bottom).offset(20);
        make.width.equalTo(@70);
        make.height.equalTo(@40);
    }];

}
#pragma mark_创建套餐
-(void)createPackage{
    if (_packageNameformView.textfiled.text.length == 0) {
        [self.view makeToast:@"套餐名不能为空"];
        return;
    }
    if (_singleNameformView1.textfiled.text.length == 0 && _singleNameformView2.textfiled.text.length == 0 && _singleNameformView3.textfiled.text.length == 0) {
        [self.view makeToast:@"菜名不能为空"];
        return;
    }
    if (_packagePriceformView.textfiled.text.length == 0) {
        [self.view makeToast:@"套餐价格不能为空"];
        return;
    }
    NSMutableString *itmeList = [[NSMutableString alloc] init];
    if (_singleNameformView1.textfiled.text.length > 0) {
        SingleModel *data = [[SingleModel alloc] init];
        data.itemName = _singleNameformView1.textfiled.text;
        NSString *res = [WlwHelp objToJson:data];
        [itmeList appendString:res];
        [itmeList appendString:@","];
        
    }
    if (_singleNameformView2.textfiled.text.length > 0) {
        SingleModel *data = [[SingleModel alloc] init];
        data.itemName = _singleNameformView2.textfiled.text;
        NSString *res = [WlwHelp objToJson:data];
        [itmeList appendString:res];
        [itmeList appendString:@","];
        
    }
    if (_singleNameformView3.textfiled.text.length > 0) {
        SingleModel *data = [[SingleModel alloc] init];
        data.itemName = _singleNameformView3.textfiled.text;
        NSString *res = [WlwHelp objToJson:data];
        [itmeList appendString:res];
        [itmeList appendString:@","];
        
    }
    if (itmeList.length > 0) {
       NSString *itemListString =  [itmeList substringToIndex:([itmeList length]-1)];
        CreatePackageRequest *request = [[CreatePackageRequest alloc] initWithModelClass:[WlwAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
            if (error) {
                [self.view makeToast:msg];
                return;
            }
        }];
        request.dingHallId = _dingHallModel._id;
        request.packageName =_packageNameformView.textfiled.text;
        request.packagePrice = [NSString stringWithFormat:@"%.2f",[_packagePriceformView.textfiled.text floatValue]];
        request.itemListString = itemListString;
        WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
        [manager performWithRequest:request View:self.view];

    }
    
}

@end
