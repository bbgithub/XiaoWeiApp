//
//  WlwLogInController.m
//  HouseWork
//
//  Created by @"ZL" on 16/7/8.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwLogInController.h"
#import "WlwLocationManager.h"
#import "WlwFormViewWithLeftName.h"
#import "UserLoginRequest.h"
#import "UserModel.h"
//#import "WXApi.h"
//#import "AFNetworking.h"
//#import "WeiXinLogInRequest.h"
@interface WlwLogInController()
//账号
@property (nonatomic, strong) WlwFormViewWithLeftName *account;
//密码
@property (nonatomic, strong) WlwFormViewWithLeftName *passwd;
@end

@implementation WlwLogInController

-(void)argumentForCanvas:(id)argumentData{
    if ([argumentData isKindOfClass:[NSString class]]) {
        [self.view makeToast:argumentData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgationTitle:@"登录"];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBindUserMobileWithWxOpenId) name:CHECKWXOPIDBINDMOBILE object:nil];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setBackgroundColor:[UIColor clearColor]];
    [registerBtn setFrame:CGRectMake(0, 0, 44, 35)];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    /*这里可以加按钮背景*/
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *registerItem = [[UIBarButtonItem alloc] initWithCustomView:registerBtn];
    self.navigationItem.rightBarButtonItem = registerItem;
    
    
    _account = [[WlwFormViewWithLeftName alloc] initWithLeftName:@"账号" rightImage:nil];
    _account.textfiled.keyboardType = UIKeyboardTypePhonePad;
    [_account setTextPlaceHold:@"请输入手机号" textMaxLength:11];
    [self.view addSubview:_account];
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(25);
        make.height.equalTo(@44);
    }];
    UIView *accountSeperateView = [[UIView alloc] init];
    accountSeperateView.backgroundColor = DIVIDER_COLOR;
    [self.view addSubview:accountSeperateView];
    [accountSeperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(_account.mas_bottom);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@(1/[WlwHelp deviceScale]));
    }];
    
    _passwd = [[WlwFormViewWithLeftName alloc] initWithLeftName:@"密码" rightImage:nil];
    [_passwd.textfiled setSecureTextEntry:YES];
    [_passwd setTextPlaceHold:@"请输入密码" textMaxLength:30];
    [self.view addSubview:_passwd];
    [_passwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(accountSeperateView.mas_bottom);
        make.height.equalTo(@44);
    }];
    
    UIView *passwdSeperateView = [[UIView alloc] init];
    passwdSeperateView.backgroundColor = DIVIDER_COLOR;
    [self.view addSubview:passwdSeperateView];
    [passwdSeperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_passwd.mas_bottom);
        make.right.equalTo(self.view);
        make.height.equalTo(@(1/[WlwHelp deviceScale]));
    }];
    
    UIButton *forgetPasswdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswdBtn.backgroundColor = [UIColor clearColor];
    forgetPasswdBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
    [forgetPasswdBtn setTitleColor:RGBACOLOR(0x63, 0x63, 0x63, 1.0) forState:UIControlStateNormal];
    [forgetPasswdBtn setTitle:@" 忘记密码 " forState:UIControlStateNormal];
    [forgetPasswdBtn addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswdBtn];
    [forgetPasswdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwd.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    UIButton *lonInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lonInBtn.backgroundColor = RGBACOLOR(0x4B,0xC1,0xD2,1.0);
    [lonInBtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    [lonInBtn setTitle:@"登 录" forState:UIControlStateNormal];
    lonInBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT+2];
    [lonInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lonInBtn.layer.masksToBounds = YES;
    lonInBtn.layer.cornerRadius = 6.f;
    [self.view addSubview:lonInBtn];
    [lonInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forgetPasswdBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@40);
    }];
    
    if (1)//[WXApi isWXAppInstalled])
    {
    
        UILabel *thridLab = [WlwHelp getLabel:@"使用第三方账号登录" withFontSize:13.f withFrame:CGRectZero withColor:RGBACOLOR(0x63, 0x63, 0x63, 1.0)];
        thridLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:thridLab];
        [thridLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view).offset(-120);
//            make.left.equalTo(self.view).offset(10);
//            make.right.equalTo(self.view).offset(-10);
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).offset(40);
            make.height.equalTo(@40);
        }];
        
        UIView *seperateViewleft = [[UIView alloc] init];
        seperateViewleft.backgroundColor = RGBACOLOR(0x63, 0x63, 0x63, 1.0);
        [self.view addSubview:seperateViewleft];
        [seperateViewleft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(thridLab.mas_left).offset(-15);
            make.height.equalTo(@(1/[WlwHelp deviceScale]));
            make.centerY.equalTo(thridLab);
        }];
        
        UIView *seperateViewright = [[UIView alloc] init];
        seperateViewright.backgroundColor = RGBACOLOR(0x63, 0x63, 0x63, 1.0);
        [self.view addSubview:seperateViewright];
        [seperateViewright mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(thridLab.mas_right).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.height.equalTo(@(1/[WlwHelp deviceScale]));
            make.centerY.equalTo(thridLab);
        }];

        
        
        
        UIButton *weiXinLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weiXinLoginBtn.backgroundColor = [UIColor clearColor];
        [weiXinLoginBtn addTarget:self action:@selector(wechatLoginClick) forControlEvents:UIControlEventTouchUpInside];
//        [weiXinLoginBtn setTitle:@"微信登录" forState:UIControlStateNormal];
//        weiXinLoginBtn.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT+2];
//        [weiXinLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        weiXinLoginBtn.layer.masksToBounds = YES;
//        weiXinLoginBtn.layer.cornerRadius = 6.f;
        [weiXinLoginBtn setImage:[UIImage imageNamed:@"ico_wxlogIn"] forState:UIControlStateNormal];
        
        [self.view addSubview:weiXinLoginBtn];
        [weiXinLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(lonInBtn.mas_bottom).offset(10);
//            make.left.equalTo(self.view).offset(10);
//            make.right.equalTo(self.view).offset(-10);
//            make.height.equalTo(@40);
            make.top.equalTo(thridLab.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
            make.height.width.equalTo(@44);
        }];
    }
}


- (void)checkBindUserMobileWithWxOpenId {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
//    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
//    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
//    [manager GET:userUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         NSLog(@"请求用户信息的response = %@", responseObject);
//        
//        WeiXinLogInRequest *request = [[WeiXinLogInRequest alloc] initWithModelClass:[UserModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
//            if (error) {
//                [self.view makeToast:msg];
//                return;
//            }
//            UserModel *data = sender;
//            [[ZLAppData shareAppData] saveUser:data];
//            [self dismissViewControllerAnimated:YES completion:^{
//                
//            }];
//            
//            //发送请求，如果没有绑定过手机号，则跳转到绑定手机号界面，否则返回userid
//            //        UserModel *data = [[UserModel alloc] init];
//            //
//            //        [[ZLAppData shareAppData] saveUser:data];
//        }];
//        request.code = openID;
//        request.nickname = [responseObject objectForKey:@"nickname"];
//        request.headimgurl = [responseObject objectForKey:@"headimgurl"];
//        ZLRequestOperationManager *manager = [[ZLRequestOperationManager alloc] init];
//        [manager performWithRequest:request View:self.view];
//
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
//    // 请求用户数据
//    [manager GET:userUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"请求用户信息的response = %@", responseObject);
//        // NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"获取用户信息时出错 = %@", error);
//    }];
}

//http://www.jianshu.com/p/0c3df308bcb3

/**
 1.首先获取到微信的openID，然后通过openID去后台数据库查询该微信的openID有没有绑定好的手机号.
 2.如果没有绑定,首相第一步就是将微信用户的头像、昵称等等基本信息添加到数据库；然后通过手机获取验证码;最后绑定手机号。然后就登录App.
 3.如果有，那么后台就返回一个手机号，然后通过手机登录App
 **/
//-(void)checkBindUserMobileWithWxOpenId
//{
//    NSString *wxOpenId = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
//    WeiXinLogInRequest *request = [[WeiXinLogInRequest alloc] initWithModelClass:[ZLAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
//        
//        UserModel *data = sender;
//        [[ZLAppData shareAppData] saveUser:data];
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
//
//        //发送请求，如果没有绑定过手机号，则跳转到绑定手机号界面，否则返回userid
////        UserModel *data = [[UserModel alloc] init];
////        
////        [[ZLAppData shareAppData] saveUser:data];
//    }];
//    request.code = wxOpenId;
//    ZLRequestOperationManager *manager = [[ZLRequestOperationManager alloc] init];
//    [manager performWithRequest:request View:self.view];
//
//  }


-(void)wechatLoginClick
{
    
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
//    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
//    // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
//    if (accessToken && openID) {
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
//        NSString *refreshUrlStr = [NSString stringWithFormat:@"%@/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", WX_BASE_URL, WXPatient_App_ID, refreshToken];
//        
//        [manager GET:refreshUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"请求reAccess的response = %@", responseObject);
//            NSDictionary *refreshDict = [NSDictionary dictionaryWithDictionary:responseObject];
//            NSString *reAccessToken = [refreshDict objectForKey:WX_ACCESS_TOKEN];
//            // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
//            if (reAccessToken) {
//                NSString *vv = [refreshDict objectForKey:WX_OPEN_ID];
//                // 更新access_token、refresh_token、open_id
//                [[NSUserDefaults standardUserDefaults] setObject:reAccessToken forKey:WX_ACCESS_TOKEN];
//                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_OPEN_ID] forKey:WX_OPEN_ID];
//                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_REFRESH_TOKEN] forKey:WX_REFRESH_TOKEN];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                // 当存在reAccessToken不为空时直接执行AppDelegate中的wechatLoginByRequestForUserInfo方法
//                [self checkBindUserMobileWithWxOpenId];
//            }
//            else {
//                [self wechatLogin];
//            }
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//              NSLog(@"用refresh_token来更新accessToken时出错 = %@", error);
//        }];
//    }
//    else {
//        [self wechatLogin];
//    }
}

-(void)wechatLogin
{
//    SendAuthReq *req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo";
//    req.state = @"ZLHouseWork";
//    [WXApi sendReq:req];

}

//-(void)OnClickLeft
//{
//    [self dissMissVc];
//}


-(void)setLeftNavgationBtn{

}

-(void)dissMissVc
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    if (_goToHomeTag) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GOTOHOMEVC object:nil];
    }
   // [[NSNotificationCenter defaultCenter] postNotificationName:GOTOHOMEVC object:nil];
}

#pragma  mark _logIn

-(void)logIn
{
    if (_account.textfiled.text.length == 0) {
        [self.view makeToast:@"账号不能为空"];
        return;
    }
    if(![WlwHelp isValidateMobile:_account.textfiled.text]){
        [self.view makeToast:@"请输入正确的手机号格式"];
        return;
    }
    if (_passwd.textfiled.text.length == 0) {
        [self.view makeToast:@"密码不能为空"];
        return;
    }
    UserLoginRequest *request = [[UserLoginRequest alloc] initWithModelClass:[UserModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        UserModel *data = sender;
        [AppData shareAppData].userModel = data;
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATUS object:@YES];
        
    }];
    request.name = _account.textfiled.text;
    request.password = _passwd.textfiled.text;
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];
    
}

#pragma mark _忘记密码
-(void)forgetPwd{
  //  [self pushCanvas:@"ForgetPasswdController" withArgument:nil];
}


#pragma mark _注册
-(void)goRegister
{
   // [self pushCanvas:@"RegisterController" withArgument:nil];

}




@end
