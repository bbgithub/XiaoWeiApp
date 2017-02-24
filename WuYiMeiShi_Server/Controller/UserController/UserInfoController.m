//
//  UserInfoController.m
//  wuyimeishi
//
//  Created by 物恋网 on 16/7/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "UserInfoController.h"
#import "UIImage+ImageCompress.h"
#import "GetHeaderTokenRequest.h"
#import "TokenModel.h"
#import "QNUploadManager.h"
#import "UserUpdateHeaderRequest.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFHTTPSessionManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PayRequest.h"
#import "PayResult.h"
@interface UserInfoController()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *shopHeadImgView;
@end


@implementation UserInfoController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationTitle:@"我的"];
   //13 self.title = @"我的";
    [self setUi];
}

-(void)setLeftNavgationBtn
{
    
}


-(void)setUi{
    UIView *headerFormView = [[UIView alloc] init];
    headerFormView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerFormView];
    [headerFormView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@110);
    }];
    _shopHeadImgView = [[UIImageView alloc] init];
    _shopHeadImgView.layer.masksToBounds = YES;
    _shopHeadImgView.layer.cornerRadius = 35.f;
    _shopHeadImgView.backgroundColor = DIVIDER_COLOR;
    [headerFormView addSubview:_shopHeadImgView];
    _shopHeadImgView.image = [UIImage imageNamed:@"editHeader"];
    _shopHeadImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImgTouched)];
    [_shopHeadImgView addGestureRecognizer:headerTap];
    [_shopHeadImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerFormView).offset(10);
        make.centerY.equalTo(headerFormView);
        make.height.width.equalTo(@70);
    }];
    UserModel *user = [AppData shareAppData].userModel;
//    [_shopHeadImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURLPREFIX,user.header]] placeholderImage:nil];
}

-(void)headerImgTouched
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
    request.out_trade_no = @"20161215144720098765";
    request.amount = @(0.01);
    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
    [manager performWithRequest:request View:self.view];

//    UIActionSheet *sheet;
//    
//    // 判断是否支持相机
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
//    }
//    else {
//        
//        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
//    }
//    
//    sheet.tag = 255;
//    
//    [sheet showInView:self.view];
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

-(void)upLoadToUrlString:(NSString *)url parameters:(NSDictionary *)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType
{
    
    //1.获取单例的网络管理对象
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.根据style 的类型 去选择返回值得类型
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //3.设置相应数据支持的类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        SDKLOG(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        SDKLOG(@"%@",error);
    }];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *tempImg = [info objectForKey:UIImagePickerControllerOriginalImage];
      _shopHeadImgView.image = tempImg;
    NSData *scaleData = [UIImage compressImage:tempImg compressRatio:0.8];
    [self upLoadToUrlString:[NSString stringWithFormat:@"%@/upload/image",SERVERURL] parameters:nil fileData:scaleData name:@"files" fileName:@"meixiaoxin.jpg" mimeType:@"image/jpg"];
  
//    GetHeaderTokenRequest *request = [[GetHeaderTokenRequest alloc] initWithModelClass:[TokenModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
//        if (error) {
//            [self.view makeToast:msg];
//        }
//        TokenModel *token = sender;
//        NSString *headerUri = [WlwHelp uniqueImgNameString];
//        
//        QNUploadManager *upManager = [[QNUploadManager alloc] init];
//        [upManager putData:scaleData key:headerUri token:token.token
//                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                      NSLog(@"%@", info);
//                      NSLog(@"%@", resp);
//                      
//                  } option:nil];
//        UserUpdateHeaderRequest *upHeaderRequest = [[UserUpdateHeaderRequest alloc] initWithModelClass:[WlwAbstractModel class] completeRequestBlock:^(id sender, NSString *msg, NSError *error) {
//            if (error) {
//                [self.view makeToast:msg];
//                return;
//            }
//            [self.view makeToast:@"头像更新成功"];
//        }];
//        UserModel *user = [AppData shareAppData].userModel;
//        upHeaderRequest.userid = user._id;
//        upHeaderRequest.header= headerUri;
//        WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
//        [manager performWithRequest:upHeaderRequest View:nil];
//        
//    }];
//    WlwRequestOperationManager *manager = [[WlwRequestOperationManager alloc] init];
//    [manager performWithRequest:request View:nil];
}

@end
