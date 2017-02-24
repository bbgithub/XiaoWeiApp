//
//  UserRegisterController.m
//  wuyimeishi
//
//  Created by 物恋网 on 16/6/20.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "UserRegisterController.h"
#import "GetCheckCodeRequest.h"
#import "WlwAbstractModel.h"
#import "UserRegisterRequest.h"
#import "MD5Utils.h"
@interface UserRegisterController ()
//密码
@property (nonatomic, strong) UITextField *passwdTextField;
//再次输入密码
@property (nonatomic, strong) UITextField *passwd_repetTextField;
//手机号
@property (nonatomic, strong) UITextField *mobileTextField;
//验证码
@property (nonatomic, strong) UITextField *checkCodeTextField;
@property (nonatomic, strong) UIButton *verifyBtn;
@property (nonatomic, assign) int countdownTime;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation UserRegisterController


-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationTitle:@"注册"];
    // Do any additional setup after loading the view.
    self.countdownTime = 90;
    [self setUi];
}

-(void)setUi
{
    UILabel *phoneLab = [WlwHelp getLabel:@"手 机 号:" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
    [self.view addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(30);
        make.width.equalTo(@60);
    }];
    
    _mobileTextField = [[UITextField alloc] init];
    _mobileTextField.placeholder = @"  请输入手机号";
    _mobileTextField.font = [UIFont systemFontOfSize:TEXT_FONT];
    _mobileTextField.layer.masksToBounds = YES;
    _mobileTextField.layer.cornerRadius = 2.f;
    _mobileTextField.layer.borderWidth = 1.f/[WlwHelp deviceScale];
    _mobileTextField.layer.borderColor = ORANGECOLOR.CGColor;
    [self.view addSubview:_mobileTextField];
    [_mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLab.mas_right).offset(5);
        make.centerY.equalTo(phoneLab);
        make.height.equalTo(@35);
        make.width.equalTo(@(230*(SCREEN_WIDTH/320)));
    }];
    
    _verifyBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_verifyBtn setBackgroundColor:ORANGECOLOR];
    _verifyBtn.titleLabel.font = [UIFont systemFontOfSize:LITTLE_TEXT_FONT];
    [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyBtn addTarget:self action:@selector(pressSendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verifyBtn];
    [_verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(_mobileTextField);
        make.height.equalTo(@35);
        make.width.equalTo(@100);
    }];
    
    UILabel *checkCodeLab = [WlwHelp getLabel:@"验 证 码:" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
    [self.view addSubview:checkCodeLab];
    [checkCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(_mobileTextField.mas_bottom).offset(20);
        make.width.equalTo(@60);
    }];
    
    _checkCodeTextField = [[UITextField alloc] init];
    _checkCodeTextField.placeholder = @"  请输入验证码";
    _checkCodeTextField.font = [UIFont systemFontOfSize:TEXT_FONT];
    _checkCodeTextField.layer.masksToBounds = YES;
    _checkCodeTextField.layer.cornerRadius = 2.f;
    _checkCodeTextField.layer.borderWidth = 1.f/[WlwHelp deviceScale];
    _checkCodeTextField.layer.borderColor = ORANGECOLOR.CGColor;
    [self.view addSubview:_checkCodeTextField];
    [_checkCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(checkCodeLab.mas_right).offset(5);
        make.centerY.equalTo(checkCodeLab);
        make.height.equalTo(@35);
        make.width.equalTo(@(230*(SCREEN_WIDTH/320)));
    }];
    
    UILabel *passwdLab = [WlwHelp getLabel:@"设置密码:" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
    [self.view addSubview:passwdLab];
    [passwdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(_checkCodeTextField.mas_bottom).offset(20);
        make.width.equalTo(@60);
    }];
    
    _passwdTextField = [[UITextField alloc] init];
    [_passwdTextField setSecureTextEntry:YES];
    _passwdTextField.placeholder = @"  请输入密码";
    _passwdTextField.font = [UIFont systemFontOfSize:TEXT_FONT];
    _passwdTextField.layer.masksToBounds = YES;
    _passwdTextField.layer.cornerRadius = 2.f;
    _passwdTextField.layer.borderWidth = 1.f/[WlwHelp deviceScale];
    _passwdTextField.layer.borderColor = ORANGECOLOR.CGColor;
    [self.view addSubview:_passwdTextField];
    [_passwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwdLab.mas_right).offset(5);
        make.centerY.equalTo(passwdLab);
        make.height.equalTo(@35);
        make.width.equalTo(@(230*(SCREEN_WIDTH/320)));
    }];
    
    
    UILabel *passwd_repetLab = [WlwHelp getLabel:@"确认密码:" withFontSize:TEXT_FONT withFrame:CGRectZero withColor:RGBACOLOR(0x33, 0x33, 0x33, 1.0)];
    [self.view addSubview:passwd_repetLab];
    [passwd_repetLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(_passwdTextField.mas_bottom).offset(20);
        make.width.equalTo(@60);
    }];
    
    _passwd_repetTextField = [[UITextField alloc] init];
    [_passwd_repetTextField setSecureTextEntry:YES];
    _passwd_repetTextField.placeholder = @"  请再次输入您的密码";
    _passwd_repetTextField.font = [UIFont systemFontOfSize:TEXT_FONT];
    _passwd_repetTextField.layer.masksToBounds = YES;
    _passwd_repetTextField.layer.cornerRadius = 2.f;
    _passwd_repetTextField.layer.borderWidth = 1.f/[WlwHelp deviceScale];
    _passwd_repetTextField.layer.borderColor = ORANGECOLOR.CGColor;
    [self.view addSubview:_passwd_repetTextField];
    [_passwd_repetTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwd_repetLab.mas_right).offset(5);
        make.centerY.equalTo(passwd_repetLab);
        make.height.equalTo(@35);
        make.width.equalTo(@(230*(SCREEN_WIDTH/320)));
    }];
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    registerBtn.tintColor = [UIColor whiteColor];
    registerBtn.backgroundColor = ORANGECOLOR;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 4.f;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(pressRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(_passwd_repetTextField.mas_bottom).offset(25);
        make.height.equalTo(@40);
    }];
}

/**
 *  获取验证码
 *
 *  @param sender
 */
-(void)pressSendButton:(id)sender{
    [self.view endEditing:YES];
    NSString *mobile = self.mobileTextField.text;
    if(![WlwHelp isValidateMobile:mobile]){
        [self.view makeToast:@"请输入正确的手机号"];
        return ;
    }
    GetCheckCodeRequest *request = [[GetCheckCodeRequest alloc] initWithModelClass:[WlwAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return ;
        }
        [self.view makeToast:@"短信验证码发送成功,请注意查收"];
        [self disableButtonForOnMinute];
    }];
    request.mobile = mobile;
    request.type = @"register";
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:nil];
}


#pragma mark uiupdate
-(void)uiuToggleButtonState:(BOOL)shouldDisabled
{
    if(shouldDisabled) {
        self.verifyBtn.userInteractionEnabled = NO;
        [self.verifyBtn layoutIfNeeded];
        NSString *initTitle = [NSString stringWithFormat:@"%@(%i)",@"重新发送",self.countdownTime];
        [self.verifyBtn setTitle:initTitle forState:UIControlStateNormal];
    } else {
        [self.verifyBtn layoutIfNeeded];
        [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.verifyBtn.userInteractionEnabled = YES;
    }
}

-(void) disableButtonForOnMinute
{
    self.verifyBtn.userInteractionEnabled = NO;
    [self.verifyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@110);
    }];
    [UIView animateWithDuration:0.4 animations:^{
        [self uiuToggleButtonState :YES];
    }];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self  selector:@selector(countdown:) userInfo:nil repeats:YES];
    [self.timer fire];
    
}

-(void)countdown:(NSTimer *)timer
{
    if(self.countdownTime <= 0) {
        [timer invalidate];
        self.countdownTime = 90;
        [self.verifyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
        }];
        [UIView animateWithDuration:0.4 animations:^{
            [self uiuToggleButtonState:NO];
        }];
        return;
    }
    self.countdownTime -= 1;
    NSString *initTitle = [NSString stringWithFormat:@"%@(%i)",@"重新发送",self.countdownTime];
    [self.verifyBtn setTitle:initTitle forState:UIControlStateNormal];
}

-(void)pressRegisterButton:(id)sender{
    if (_mobileTextField.text.length == 0) {
        [self.view makeToast:@"手机号不能为空"];
        return;
    }
    if(![WlwHelp isValidateMobile:_mobileTextField.text]){
        [self.view makeToast:@"请输入正确的手机号"];
        return ;
    }

    if (_checkCodeTextField.text.length == 0) {
        [self.view makeToast:@"请输入验证码"];
        return;
    }
    if (_passwdTextField.text.length == 0) {
        [self.view makeToast:@"密码不能为空"];
        return;
    }
    if (![_passwd_repetTextField.text isEqualToString:_passwdTextField.text]) {
        [self.view makeToast:@"两次输入的密码不一致"];
        return;
    }
    if (_passwdTextField.text.length <6) {
        [self.view makeToast:@"密码的长度至少为6个字符"];
        return;
    }
    UserRegisterRequest *request = [[UserRegisterRequest alloc] initWithModelClass:[UserModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
        if (error) {
            [self.view makeToast:msg];
            return;
        }
        UserModel *user = sender;
        SDKLOG(@"%@",user);
        [self popCanvasWithArgment:user];
        
    }];
    request.name =_mobileTextField.text;
    request.password =  [MD5Utils md5HexDigest:_passwdTextField.text];
    request.password_repet = [MD5Utils md5HexDigest:_passwd_repetTextField.text];
    request.checkCode = _checkCodeTextField.text;
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:nil];
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
