//
//  WlwHelp.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/30.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwHelp.h"
#import "UIColor+WlwColor.h"
#import "UIColor+HexColors.h"
#import "Jastor.h"
//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>
#import <objc/runtime.h>
#import "AppData.h"
//空字符串
#define     LocalStr_None           @""
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation WlwHelp

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (Boolean)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (void)setSearchBackground:(UISearchBar *)search {
    for (UIView *sub in search.subviews) {
        if ([sub isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *) sub;
            textField.backgroundColor = [UIColor whiteColor];
            textField.layer.cornerRadius = 5.0f;
            textField.layer.masksToBounds = YES;
            textField.background = nil;
            break;
        }
    }
    search.backgroundColor = RGBACOLOR(0xd5, 0xd5, 0xd5, 1.0);
}

+ (void)setSeachCancel:(UISearchBar *)search {
    NSArray *subViews = search.subviews;
    for (UIView *cc in subViews) {
        if ([cc isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *) cc;
            UIImage *image = [WlwHelp createImageWithColor:[UIColor clearColor]];
            [button setBackgroundImage:image forState:UIControlStateNormal];
            button.titleLabel.textColor = [UIColor darkGrayColor];
            button.titleLabel.text = @"";
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.layer.shadowOffset = CGSizeZero;
            [button setBackgroundImage:image forState:UIControlStateHighlighted];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
    }
}

+ (NSAttributedString *)attributeStringForCellTitleWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"000000"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellTitleHasLineHightWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"000000"];
    NSParagraphStyle *paragraphStyle = [WlwHelp paragraphStyle];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color,
                            NSParagraphStyleAttributeName : paragraphStyle
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellLighterBlackTitleWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellTitleGrayWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"666666"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellTitleRedWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"ff0000"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellTitleSmallWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:15.0];
    UIColor *color = [UIColor colorWithHexString:@"000000"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.0];
    UIColor *color = [UIColor colorWithHexString:@"6c7a81"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleHasLineHightWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.0];
    UIColor *color = [UIColor colorWithHexString:@"6c7a81"];
    NSParagraphStyle *paragraphStyle = [WlwHelp paragraphStyle];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color,
                            NSParagraphStyleAttributeName : paragraphStyle
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleSmallWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.0];
    UIColor *color = [UIColor colorWithHexString:@"6c7a81"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleSmallHasLineHightWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.0];
    UIColor *color = [UIColor colorWithHexString:@"6c7a81"];
    NSParagraphStyle *paragraphStyle = [WlwHelp paragraphStyle];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color,
                            NSParagraphStyleAttributeName : paragraphStyle
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleSmall10WithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:10.0];
    UIColor *color = [UIColor colorWithHexString:@"6c7a81"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleSmall10HasLineHightWithString:(NSString *)string {
    
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:10.0];
    UIColor *color = [UIColor colorWithHexString:@"6c7a81"];
    NSParagraphStyle *paragraphStyle = [WlwHelp paragraphStyle];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color,
                            NSParagraphStyleAttributeName : paragraphStyle
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleExtraSmallWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:8.0];
    UIColor *color = [UIColor colorWithHexString:@"6c7a81"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForCellSubTitleRedWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.0];
    UIColor *color = [UIColor colorWithHexString:@"ff0000"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForButtonOfLabelStyleWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:13.0];
    
    UIColor *color = [UIColor colorWithHexString:@"4e4e4e"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForLabelUserNameWithString:(NSString *)string //用于 我页面 中头像下方的名字
{
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.0];
    UIColor *color = [UIColor colorWithHexString:@"ffffff"];
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
    
}

+ (NSAttributedString *)attributeStringForLabelStoreNameWithString:(NSString *)string //用于 我页面 中头像名字下方的店
{
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:12.0];
    UIColor *color = [UIColor colorWithHexString:@"000000"];
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
    
}

+ (NSAttributedString *)attributeStringForBorderdBrandLabelWithString:(NSString *)string //用于供应商详情页 主营品牌 品牌名称label
{
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:13.0];
    UIColor *color = [UIColor colorWithHexString:@"333333"];
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSMutableParagraphStyle *)paragraphStyle {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineHeightMultiple = 1.6;
    return style;
}

+ (float)sizeMagicWith:(float)number; {
    return number;
}

+ (float)heighOftopLayoutGuideUnderNaviagtionController {
    // TODO: iOS6.0 应该要返回不同的值
    if(IS_OS_7_OR_LATER){
        return 64.0f;
    }else{
        return 0.0;
    }
}

+ (float)paddingForTableView {
    return 10;
}

+ (float)paddingBigForTableView {
    return 25 / 2;
}

+ (float)innerPaddingForTableView {
    return 8;
}

+ (float)innerPaddingSmallForTableView {
    return 5;
}

+ (float)paddingRightForTableView {
    return 66 / 2; //当tableviewCell设置accessoryType的时候 contentView距离最右边的距离
}

+ (float)deviceScale {
    return [[UIScreen mainScreen] scale];
}

+ (UIButton *)barButtonWihtImageNamed:(NSString *)imageName {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setClipsToBounds:YES];
    [rightButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightButton setFrame:CGRectMake(0, 0, 30, 30)];
    return rightButton;
}

+ (UIButton *)barButtonWihtTitle:(NSString *)title {
    UIButton *rightBarButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightBarButton sizeToFit];
    return rightBarButton;
}


+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSInteger)getUnitLevelById:(NSInteger)index withConversion:(NSString *)conversion {
    NSInteger ret = 0;
    if ([@"1*1*1" isEqualToString:conversion]) {
        ret = 0;
    } else if (IS_NSSTIRNG_CONTAIN(conversion, @"1*1*")) {
        if (index == 0) {
            ret = 0;
        } else {
            ret = 2;//[[NSNumber alloc] initWithInt:2];
        }
    } else {
        if (index == 0) {
            ret = 0;
            //            item.unit_level = [[NSNumber alloc] initWithInt:0];
        } else if (index == 1) {
            ret = 1;
            //            item.unit_level = [[NSNumber alloc] initWithInt:1];
        } else {
            ret = 2;
            //            item.unit_level = [[NSNumber alloc] initWithInt:2];
        }
    }
    return ret;
}

+ (UIImage *)getStrenthImage:(NSString *)imageName withXoffset:(NSInteger)CapWidth withYoffset:(NSInteger)CapHeight {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:CapWidth topCapHeight:CapHeight];
    return image;
}


+ (UIButton *)getButtonWithColor:(UIColor *)normal andHightLight:(UIColor *)highLight {
    UIButton *ret = [UIButton buttonWithType:UIButtonTypeCustom];
    [ret setBackgroundImage:[WlwHelp createImageWithColor:normal] forState:UIControlStateNormal];
    [ret setBackgroundImage:[WlwHelp createImageWithColor:highLight] forState:UIControlStateHighlighted];
    [ret setBackgroundImage:[WlwHelp createImageWithColor:highLight] forState:UIControlStateSelected];
    [ret setBackgroundImage:[WlwHelp createImageWithColor:highLight] forState:UIControlStateDisabled];
    return ret;
}

+ (CGFloat)getDividerHeight {
    CGFloat height = 1.0f;
    UIScreen *screen = [UIScreen mainScreen];
    height = height / screen.scale;
    return height;
}

+ (CGSize)getLabelSizeByContentWithFontSize:(CGFloat)fontSize withContent:(NSString *)content {
    UIFont *fontName = [UIFont systemFontOfSize:fontSize];
    //定义字体大小
    CGSize sizeName = [content
                       sizeWithFont:fontName];
    return sizeName;
}

+ (UILabel *)getLabel:(NSString *)content withFontSize:(CGFloat)fontSize withFrame:(CGRect)frame withColor:(UIColor *)color {
    UILabel *ret = [[UILabel alloc] initWithFrame:frame];
    ret.text = content;
    ret.lineBreakMode =NSLineBreakByTruncatingTail;
    ret.textAlignment = NSTextAlignmentLeft;
    ret.backgroundColor = [UIColor clearColor];
    ret.font = [UIFont systemFontOfSize:fontSize];
    ret.textColor = color;
    return ret;
}

+ (CGSize)getLabelSizeByContent:(NSInteger)width withFontSize:(CGFloat)fontSize withContent:(NSString *)content {
    UIFont *fontName = [UIFont systemFontOfSize:fontSize];
    //定义字体大小
    CGSize sizeName = [content
                       sizeWithFont:fontName constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeName;
}

/*整数验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateDigit:(NSString *)digit {
    NSString *digitRegex = @"^-?\\d+$";
    NSPredicate *digitTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", digitRegex];
    return [digitTest evaluateWithObject:digit];
}

+ (BOOL)isValidatePositiveInterger:(NSString *)digit {
    NSString *digitRegex = @"^\\d+$";
    NSPredicate *digitTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", digitRegex];
    return [digitTest evaluateWithObject:digit];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9])|(199)|(147))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    //    SDKLOG(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobileEvenStartWith199:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9])|(199)|(147))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidateContentLengthUnder140:(NSString *)content {
    BOOL result = YES;
    if (content.length <= 0 || content.length >= 141) {
        result = NO;
        return result;
    }
    
    return result;
}

+ (BOOL)isValidateContentLengthUnderLimit:(NSString *)content maxCount:(int)max {
    BOOL result = YES;
    if (content.length <= 0 || content.length > max) {
        result = NO;
        return result;
    }
    return result;
}

+ (NSString *)telephoneWithReformat:(NSString *)str {
    NSString *ret = str;
    if (IS_NSSTIRNG_CONTAIN(str, @"-")) {
        ret = [ret stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if (IS_NSSTIRNG_CONTAIN(str, @" ")) {
        ret = [ret stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if (IS_NSSTIRNG_CONTAIN(str, @"(")) {
        ret = [ret stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if (IS_NSSTIRNG_CONTAIN(str, @")")) {
        ret = [ret stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    
    return ret;
}

+ (NSString *)replaceStr:(NSString *)regexPattern withReplacedStr:(NSMutableString *)str withPlaceStr:(NSString *)pstr {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:nil];
    [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:pstr];
    return str;
}

+ (UIButton *)getStrethButton:(NSString *)normal andHighLight:(NSString *)highLight withEdgeInsets:(UIEdgeInsets)edge {
    UIButton *ret = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [WlwHelp getStrenthImage:normal withUIEdgeInsets:edge];
    [ret setBackgroundImage:image forState:UIControlStateNormal];
    image = [WlwHelp getStrenthImage:highLight withUIEdgeInsets:edge];
    [ret setBackgroundImage:image forState:UIControlStateHighlighted];
    [ret setBackgroundImage:image forState:UIControlStateSelected];
    return ret;
}

+ (UIImage *)getStrenthImage:(NSString *)imageName withUIEdgeInsets:(UIEdgeInsets)rect {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:rect];
    return image;
}

+ (UIBarButtonItem *)getButtonItem:(NSString *)name withHighName:(NSString *)high withSelector:(SEL)selector andTarget:(id)target {
    UIBarButtonItem *ret = nil;
    UIButton *button = [[UIButton alloc] init];
    UIImage *image = [UIImage imageNamed:name];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:high];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    ret = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return ret;
}

+ (UIBarButtonItem *)getButtonItemWithTitle:(NSString *)title withSelectore:(SEL)selector andTarget:(id)target {
    UIButton *rightBarButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightBarButton sizeToFit];
    [rightBarButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    return rightBarItem;
}

+ (id)jsonToObj:(NSString *)json WithClassName:(Class)className {
    if (IS_NSSTRING_EMPTY(json)) {
        return nil;
    }
    NSData *respData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableLeaves error:&error];
    id entity = nil;
    @try {
        entity = [[className alloc] initWithDictionary:rootDic];
    }
    @catch (NSException *exception) {
        SDKLOG(@"%@", exception);
    }
    @finally {
        
    }
    return entity;
}

+ (id)jsonToObj:(NSString *)json{
    if (IS_NSSTRING_EMPTY(json)) {
        return nil;
    }
    NSData *respData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableLeaves error:&error];
    return rootDic;
}

+ (id)objToJson:(id)obj {
    NSString *ret = nil;
    if (nil == obj) {
        return ret;
    }
    if (![obj isKindOfClass:[NSString class]] && ![obj isKindOfClass:[NSNumber class]]) {
        NSError *error = nil;
        if ([obj isKindOfClass:[Jastor class]]) {
            NSDictionary *dic = [obj toDictionary];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
            obj = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        } else {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
            obj = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    ret = [NSString stringWithFormat:@"%@", obj];
    return ret;
}

+ (NSString *)formattedDateStringUsingFormat:(NSString *)format fromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)jsonStringFromArray:(NSArray *)array {
    NSArray *items = array;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:items options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.8);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:fullPathToFile]) {
        NSError *error = nil;
        [fileManger removeItemAtPath:fullPathToFile error:&error];
    }
    [imageData writeToFile:fullPathToFile atomically:YES];
    return fullPathToFile;
}

+ (BOOL) checkFileExsitInDocumentsFolderOfName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:name];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    return [fileManger fileExistsAtPath:fullPathToFile];
}
+ (UIImage *)getImageFileInDocumentsFolderOfName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:name];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:fullPathToFile]) {
        return nil;
    } else {
        UIImage *image = [UIImage imageWithContentsOfFile:fullPathToFile];
        return image;
    }
}

+ (int)randomIntBetweenZeroAndNumber:(int)number {
    return arc4random_uniform(number);
    
}

+ (NSString *)digitStringFromADirtyString:(NSString *)dirtyString {
    NSString *result;
    result = [[dirtyString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    return result;
}

+ (BOOL)isValidatePasswordFormat:(NSString *)string {
    BOOL result;
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];
    s = [s invertedSet];
    NSRange r = [string rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        result = NO;
    } else {
        result = YES;
    }
    return result;
}

+ (NSString *)priceStringWithTwoDigits:(NSString *)priceString {
    NSString *result;
    // 判断是否含有.
    if ([priceString rangeOfString:@"."].location != NSNotFound) {
        result = [priceString substringWithRange:NSMakeRange(0, [priceString rangeOfString:@"."].location + 3)];
    } else {
        result = [NSString stringWithFormat:@"%@.00", priceString];
    }
    return result;
}

+ (BOOL)isValidateFixedLineTelephoneNumber:(NSString *)numberString {
    NSString *pattern = @"^(\\d{3,4}\\-?)?\\d{7,8}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSRange textRange = NSMakeRange(0, numberString.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:numberString options:NSMatchingReportProgress range:textRange];
    BOOL didValidate = NO;
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    return didValidate;
}

+ (BOOL)isNewVersion:(int)latestVersionCode {
    int applicationVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] intValue];
    return latestVersionCode > applicationVersion;
}

+(void) makePhonecallWithNumber:(NSString *)number
{
#ifndef UIMONKEYKEY
    NSString *phoneURLString = [NSString stringWithFormat:@"tel://%@", number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURLString]];
#endif
}
+(NSNumber *)NSNumberFromNSString:(NSString *)string
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterNoStyle;
    NSNumber *myNumber = [f numberFromString:string];
    return myNumber;
}

+ (NSAttributedString *)attributeStringForButtonArrowNormalState:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"666666"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForButtonArrowSelectedState:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForLabelDistricNote:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:10.0];
    UIColor *color = [UIColor colorWithHexString:@"ffffff"];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+ (NSAttributedString *)attributeStringForTextFieldPlaceholder:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0];
    UIColor *color = [UIColor colorWithHexString:@"8d8d8d"];
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color
                            };
    return [[NSAttributedString alloc] initWithString:string ?: @"" attributes:attrs];
}

+(NSString *)dateFormatWithMontnAndTime:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.sssZ"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:time];
    //输出格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

+(NSString *)timeFormatWithYearMontnAndTime:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.sssZ"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:time];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

+(NSInteger)calculateDaysWithstartTime:(NSString *)start_time andEndTime:(NSString *)end_time
{
    int secondsPerDay = 24*60*60;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.sssZ"];
    //    NSDate *startDate = [NSDate date];
    NSDate *endDate = [dateFormatter dateFromString:end_time];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *startTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *startDate = [dateFormatter dateFromString:startTime];
    
    int seconds = [endDate timeIntervalSince1970]+ secondsPerDay -[startDate timeIntervalSince1970];
    if (seconds < 0)
    {
        seconds = 0;
    }
    return seconds/secondsPerDay;
    
}

+(long long)getNowTimeStampToSecondMinuts
{
    // NSTimeInterval返回的是double类型，输出会显示为10位整数加小数点加一些其他值
    // 如果想转成int型，必须转成long long型才够大。
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
    return dTime;
}

+(NSString *)stringWithCommaFromArray:(NSArray *)array
{
    NSMutableString *rstr = [[NSMutableString alloc] init];
    for (int i = 0; i < array.count; i++) {
        
        [rstr appendString:[array objectAtIndex:i]];
        if (i != array.count-1) {
            [rstr appendString:@","];
        }
    }
    return rstr;
}

+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+(NSDictionary*)getObjectData:(id)obj
{
    
    NSMutableDictionary
    *dic = [NSMutableDictionary dictionary];
    
    unsigned
    int propsCount;
    
    objc_property_t
    *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int
        i = 0;i < propsCount; i++)
        
    {
        
        objc_property_t
        prop = props[i];
        
        
        
        NSString
        *propName = [NSString stringWithUTF8String:property_getName(prop)];
        
        id
        value = [obj valueForKey:propName];
        
        if(value
           == nil)
            
        {
            
            value
            = [NSNull null];
            
        }
        
        else
            
        {
            
            value
            = [self getObjectInternal:value];
            
        }
        
        [dic
         setObject:value forKey:propName];
        
    }
    
    return
    
    dic;
    
}



+(NSString *)print:(id)obj

{
    
    NSDictionary *dic =  [self getObjectData:obj];
    
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error != nil) {
        NSLog(@"NSArray JSONString error: %@", [error localizedDescription]);
        return nil;
    }
    else
    {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+(NSString *)ArrayToJson:(NSMutableArray *)list
{
    NSMutableString *array_to_json_Str = [[NSMutableString alloc] initWithString:@"["];
    for (int i = 0; i < list.count; i++) {
        id obj = [list objectAtIndex:i];
        NSString *objToJson = [self print:obj];
        [array_to_json_Str appendString:objToJson];
        if (i == list.count -1) {
            
        }else
        {
            [array_to_json_Str appendString:@","];
        }
    }
    [array_to_json_Str appendString:@"]"];
    return array_to_json_Str;
}





+(NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
    
}



+(id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]])
    {
        
        return obj;
        
    }
    
    if([obj
        isKindOfClass:[NSArray class]])
        
    {
        
        NSArray
        *objarr = obj;
        
        NSMutableArray
        *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int
            i = 0;i < objarr.count; i++)
            
        {
            
            [arr
             setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
            
        }
        
        return
        
        arr;
        
    }
    
    
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        
        NSDictionary
        *objdic = obj;
        
        NSMutableDictionary
        *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString
            *key in
            
            objdic.allKeys)
            
        {
            
            [dic
             setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
            
        }
        
        return
        
        dic;
        
    }
    
    return [self getObjectData:obj];
}

+ (NSString *) getweekDayWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    switch ([comps weekday]) {
        case 1:
        {
            return @"星期天";
        }
            break;
        case 2:
        {
            return @"星期一";
        }
            break;
        case 3:
        {
             return @"星期二";
        }
            break;
        case 4:
        {
             return @"星期三";
        }
            break;
        case 5:
        {
             return @"星期四";
        }
            break;
        case 6:
        {
             return @"星期五";
        }
            break;
        case 7:
        {
             return @"星期六";
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }

}

+(NSString *)getyyyymmddWithDate:(NSDate *)date
{
    NSMutableString *res = [[NSMutableString alloc] init];

    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    [res appendFormat:@"%ld年%ld月%ld日",(long)[comps year],(long)[comps month],(long)[comps day]];
    return res;
}

+(NSString *)gethhmmssWithDate:(NSDate *)date
{
    NSMutableString *res = [[NSMutableString alloc] init];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    [res appendFormat:@"%ld:%ld:%ld",(long)[comps hour],(long)[comps minute],(long)[comps second]];
    return res;
}

+(void)updateVersion
{
    //跳转到应用页
    NSString*str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",1109209293];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

+ (NSString *)uniqueImgNameString
{
    long long time = [[NSDate date] timeIntervalSince1970] *1000;
    NSString *imgName = [NSString stringWithFormat:@"%@-%lld.jpg",[AppData shareAppData].userModel._id,time];
    return imgName;
}


@end
