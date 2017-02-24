//
//  WlwAbstractRequest.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/30.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractRequest.h"
#import "WlwAbstractModel.h"
#import "NSObject+Property.h"
#import "MD5Utils.h"
@implementation WlwAbstractRequest

-(id)initWithModelClass:(Class)className completeRequestBlock:(CompleteRequestBlock)block
{
    self = [super init];

    self.model = className;
    if (block) {
        _completeRequestBlock = nil;
        _completeRequestBlock = block;
    }
    return self;
}

-(NSDictionary* )genRequestParagram
{
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    paraDic = [self createDictionayFromModelProperties];
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithDictionary:paraDic];
    return resultDic;
}

-(NSString *)genRequestUrl
{
    return nil;
}
-(NSString *)genRequestMethod
{
    return @"POST";
}
-(NSString*) getUUID
{
    return[OpenUDID value];
}

-(NSString*) getVerName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    //    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleInfoDictionaryVersion"];
    // app build版本
    //    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    //    app_Version = @"6";
    return app_Version;
}



-(NSString*) getMasterSecret
{
    return [[NSString alloc] initWithFormat:@"%@",[self getUUID]];
}

-(NSString*) genRequestToken:(NSDictionary*)param andMasterSecret:(NSString*)masterSecret
{
    if(IS_NSSTRING_EMPTY(masterSecret) || param == nil){
        return nil;
    }else{
        NSMutableString *stringBuilder = [[NSMutableString alloc] initWithString:masterSecret];
        NSArray *keyArray = [param allKeys];
        keyArray = [keyArray sortedArrayUsingSelector:@selector(compare:)];
        for(NSString *key in keyArray){
            id obj = [param objectForKey:key];
            obj = [WlwHelp objToJson:obj];
            [stringBuilder appendString:key];
            [stringBuilder appendString:[NSString stringWithFormat:@"%@",obj]];
        }
        NSString *md5Result = [MD5Utils md5HexDigest:stringBuilder];
        return md5Result;
    }
}

- (NSDictionary *)genRequestHeader
{
    NSMutableDictionary* ret = [[NSMutableDictionary alloc] init];

   
    [ret setObject:[self getUUID] forKey:@"imei"];
    NSDictionary *params = [self genRequestParagram];
    NSString *masterSecdic = [self getMasterSecret];
    [ret setObject:[self genRequestToken:params andMasterSecret:masterSecdic] forKey:@"token"];
    return ret;

}

-(void)analyseSuccessResponse:(id)response
{
    SDKLOG(@"%@",response);
    if ([response isKindOfClass:[NSDictionary class]]) {
        id data = [response objectForKey:@"data"];
        
        if (data == nil) {
            WlwAbstractModel *baseModel = [[self.model alloc] init];
            NSString *code = [response objectForKey:@"code"];
            baseModel.code =code;
            NSString *msg = [response objectForKey:@"msg"];
            baseModel.msg = msg;
            if ([baseModel.code integerValue]!=200) {
                
                NSError *error = [[NSError alloc] init];
                if (_completeRequestBlock) {
                    _completeRequestBlock(baseModel,baseModel.msg,error);
                }
            }else{
                if (_completeRequestBlock) {
                    _completeRequestBlock(baseModel,baseModel.msg,nil);
                }
            }
            return;
            
        }
        if ([data isKindOfClass:[NSDictionary class]])
        {
            if (self.model) {
                WlwAbstractModel *baseModel = [[self.model alloc] initWithDictionary:data];
                NSString *code = [response objectForKey:@"code"];
                baseModel.code =code;
                NSString *msg = [response objectForKey:@"msg"];
                baseModel.msg = msg;
                
                if ([baseModel.code integerValue]!=200) {
                    
                    NSError *error = [[NSError alloc] init];
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,error);
                    }
                }else{
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,nil);
                    }
                }
            }
        }else if ([data isKindOfClass:[NSArray class]]){
            if (self.model) {
                WlwAbstractModel *baseModel = [[self.model alloc] initWithDictionary:response];
                if ([baseModel.code integerValue]!=200) {
                    
                    NSError *error = [[NSError alloc] init];
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,error);
                    }
                }else{
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,nil);
                    }
                }
                
            }
        }else if ([data isKindOfClass:[NSString class]]){
            WlwAbstractModel *baseModel = [[self.model alloc] initWithDictionary:response];
            if ([baseModel.code integerValue]!=200) {
                
                NSError *error = [[NSError alloc] init];
                if (_completeRequestBlock) {
                    _completeRequestBlock(baseModel,baseModel.msg,error);
                }
            }else{
                if (_completeRequestBlock) {
                    _completeRequestBlock(baseModel,baseModel.msg,nil);
                }
            }
        }

    }
}

-(void)analyseFailtureResponse:(id)response
{
    NSError *error = response;
    //    NSString *errorMessage = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    if (_completeRequestBlock) {
        _completeRequestBlock(nil,@"网络异常",error);
    }
}

- (NSMutableDictionary *)createDictionayFromModelProperties
{
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    // class:获取哪个类的成员属性列表
    // count:成员属性总数
    // 拷贝属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        // 属性名
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        // 属性值
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        // 设置KeyValues
        if (propertyValue) [propsDic setObject:propertyValue forKey:propertyName];
    }
    // 需手动释放 不受ARC约束
    free(properties);
    return propsDic;
}



@end
