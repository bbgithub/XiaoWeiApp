//
//  NSObject+Property.m
//  TextRuntime
//
//  Created by LDH on 14/10/22.
//  Copyright © 2013年 刘敦辉. All rights reserved.
//

#import "NSObject+Property.h"
#import "MJExtension.h"

@implementation NSObject (Property)

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict
{
    
    NSMutableString *strM = [NSMutableString string];
    
    // 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
                NSLog(@"%@ %@",propertyName,[value class]);
        NSString *code;
        if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSNumber *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"NSNull")]){
            code = [NSString stringWithFormat:@"/** id表示在测试时没有值与之对应 */\n@property (nonatomic, strong) id %@;",propertyName];
        }else if ([value isKindOfClass:NSClassFromString(@"NSTaggedPointerString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName]
            ;
        }
        
        [strM appendFormat:@"\n%@\n",code];
        
    }];
    
    NSLog(@"%@",strM);
}

@end
