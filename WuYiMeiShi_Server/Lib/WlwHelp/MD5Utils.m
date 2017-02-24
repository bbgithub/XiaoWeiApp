//
//  MD5Utils.m
//  weibu
//
//  Created by shenxin on 13-4-27.
//  Copyright (c) 2013年 shenxin. All rights reserved.
//

#import "MD5Utils.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5Utils
//md5 32位 加密 （小写）
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
@end
