//
//  UserLogInController.m
//  wuyimeishi
//
//  Created by 物恋网 on 16/6/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "UserLogInController.h"
#import "UserRegisterRequest.h"
#import "GetCheckCodeRequest.h"
#import "GetHeaderTokenRequest.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "AppData.h"
#import "UserLoginRequest.h"
#import "MD5Utils.h"
@interface UserLogInController ()
//用户名
@property(nonatomic, strong) JVFloatLabeledTextField *textfieldUsername;
//密码
@property (nonatomic, strong) JVFloatLabeledTextField *textfieldPassword;
@property (nonatomic, strong) UILabel *organizelab;
@end

@implementation UserLogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUi];
    // Do any additional setup after loading the view.
}

-(void)setLeftNavgationBtn
{
}


-(void)argumentForCanvas:(id)argumentData{
    if ([argumentData isKindOfClass:[UserModel class]]) {
        UserModel *data = argumentData;
        [self.view makeToast:@"注册成功,请登录"];
//        _textfieldUsername.text = data.name;
    }
    if ([argumentData isKindOfClass:[NSString class]]) {
        _organizelab.text = argumentData;
    }
}

-(void)setUi{
    [self setNavgationTitle:@"登录"];
    self.view.backgroundColor = [UIColor whiteColor];
    // -uisFormView
    UIView *formView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:formView];
    formView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([WlwHelp heighOftopLayoutGuideUnderNaviagtionController] + [WlwHelp sizeMagicWith:29]);
        make.left.equalTo(self.view).offset(-1 / [WlwHelp deviceScale]);
        make.right.equalTo(self.view).offset(1 / [WlwHelp deviceScale]);
        make.height.equalTo(@100);
    }];
    
    
    
    // -横线
    UIView *spacerView0 = [[UIView alloc] initWithFrame:CGRectZero];
    spacerView0.backgroundColor = [UIColor clearColor];
    [formView addSubview:spacerView0];
    [spacerView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(formView).offset([WlwHelp sizeMagicWith:45 / 2]);
        make.top.equalTo(formView).offset(0);
        make.height.equalTo(@(1 / [WlwHelp deviceScale]));
        make.right.equalTo(formView.mas_right);
    }];

    
    // -账号
    UIImageView *icoUser = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_loginuser"]];
    [formView addSubview:icoUser];
    [icoUser setContentHuggingPriority:600 forAxis:UILayoutConstraintAxisHorizontal];
    [icoUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(formView).offset([WlwHelp paddingBigForTableView]);
        make.top.equalTo(spacerView0.mas_bottom).offset([WlwHelp paddingBigForTableView]);
    }];
    
    // 账号输入框
    static CGFloat kJVFieldFontSize = TEXT_FONT;
    static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;
    static CGFloat kButtonHeight = 44.0f;
    
    JVFloatLabeledTextField *textfieldUsername = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    textfieldUsername.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"用户名", @"")
                                    attributes:@{NSForegroundColorAttributeName : RGBACOLOR(0xad, 0xad, 0xad, 1.0)}];
    textfieldUsername.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    textfieldUsername.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    textfieldUsername.floatingLabelTextColor = [UIColor brownColor];
    //    textfieldUsername.clearButtonMode = UITextFieldViewModeWhileEditing;
    [formView addSubview:textfieldUsername];
    [textfieldUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icoUser.mas_right).offset([WlwHelp paddingBigForTableView]);
        make.centerY.equalTo(icoUser.mas_centerY);
        make.right.equalTo(formView).offset(-[WlwHelp paddingBigForTableView]);
        make.height.equalTo(@(kButtonHeight));
    }];
    
    // -横线
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectZero];
    spacerView.layer.backgroundColor = [ORANGECOLOR CGColor];
    [formView addSubview:spacerView];
    [spacerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(formView).offset([WlwHelp sizeMagicWith:45 / 2]);
        make.top.equalTo(formView).offset(50);
        make.height.equalTo(@(1 / [WlwHelp deviceScale]));
        make.right.equalTo(formView.mas_right);
    }];
    // -密码
    UIImageView *icoPwd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_loginpw"]];
    [formView addSubview:icoPwd];
    [icoPwd setContentHuggingPriority:600 forAxis:UILayoutConstraintAxisHorizontal];
    [icoPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(formView).offset([WlwHelp paddingBigForTableView]);
        make.bottom.equalTo(formView).offset(-[WlwHelp paddingBigForTableView]);
    }];
    
    JVFloatLabeledTextField *textfieldPassword = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    [textfieldPassword setSecureTextEntry:YES];
    textfieldPassword.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"密码", @"")
                                    attributes:@{NSForegroundColorAttributeName : RGBACOLOR(0xad, 0xad, 0xad, 1.0)}];
    textfieldPassword.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    textfieldPassword.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    textfieldPassword.floatingLabelTextColor = [UIColor brownColor];
    textfieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [formView addSubview:textfieldPassword];
    [textfieldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icoUser.mas_right).offset([WlwHelp paddingBigForTableView]);
        make.centerY.equalTo(icoPwd.mas_centerY);
        make.right.equalTo(formView).offset(-[WlwHelp paddingBigForTableView]);
        make.height.equalTo(@(kButtonHeight));
    }];
    
    // -uisLoginButton
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    loginBtn.tintColor = [UIColor whiteColor];
    loginBtn.backgroundColor = ORANGECOLOR;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 4.f;
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(pressLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset([WlwHelp paddingForTableView]);
        make.right.equalTo(self.view).offset(-[WlwHelp paddingForTableView]);
        make.top.equalTo(textfieldPassword.mas_bottom).offset(20);
        make.height.equalTo(@44);
    }];
    
    // -uisForgotPwd
    UIButton *forgetPwdBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [forgetPwdBtn setAttributedTitle:[WlwHelp attributeStringForCellSubTitleWithString:@"忘记密码?"] forState:UIControlStateNormal];
    [self.view addSubview:forgetPwdBtn];
    [forgetPwdBtn addTarget:self action:@selector(pressForgetPwdButton) forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(loginBtn.mas_right);
        make.top.equalTo(loginBtn.mas_bottom).offset([WlwHelp paddingForTableView]);
    }];
    
//    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//    [registerBtn setAttributedTitle:[WlwHelp attributeStringForCellSubTitleWithString:@"立即注册"] forState:UIControlStateNormal];
//    [self.view addSubview:registerBtn];
//    [registerBtn addTarget:self action:@selector(pressRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
//    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(loginBtn.mas_left);
//        make.top.equalTo(loginBtn.mas_bottom).offset([WlwHelp paddingForTableView]);
//    }];

    _textfieldUsername = textfieldUsername;
    _textfieldPassword = textfieldPassword;
}

#pragma mark _登录
-(void)pressLoginButton:(id)sender{
    _textfieldUsername.text = @"13989826414";
    _textfieldPassword.text = @"123456";
    if (_textfieldUsername.text.length == 0) {
        [self.view makeToast:@"用户名不能为空"];
        return;
    }
    if (_textfieldPassword.text.length == 0) {
        [self.view makeToast:@"密码不能为空"];
        return;
    }
    if (_textfieldPassword.text.length < 6) {
        [self.view makeToast:@"密码长度不能小于6位"];
        return;
    }
    for (int i = 0; i < 1; i++) {
        UserLoginRequest *request = [[UserLoginRequest alloc] initWithModelClass:[UserModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
            if (error) {
                [self.view makeToast:msg];
                return;
            }
            UserModel *data = sender;
            [AppData shareAppData].userModel = data;
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSTATUS object:@YES];
            
        }];
        request.name = _textfieldUsername.text;
        request.password = _textfieldPassword.text;
        WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
        [manager performWithRequest:request View:self.view];
 
    }
}
#pragma mark _注册
-(void)pressRegisterButton:(id)sender{
    [self pushCanvas:@"UserRegisterController" withArgument:nil];
}

#pragma mark _选择医院名称
-(void)selectOrganize
{
    [self pushCanvas:@"OrganizeListController" withArgument:nil];
}

-(void)pressForgetPwdButton
{
    
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
