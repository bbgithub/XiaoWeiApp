//
//  WlwHelp.h
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/30.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define NAVGATIONBARCOLOR (RGBACOLOR(0xfa,0xfa,0xfa,1.0))
#define DIVIDER_COLOR (RGBACOLOR(0xd8,0xd8,0xd8,1.0))
#define BACKGROUND_RGBCOLOR (RGBACOLOR(0xeb, 0xeb, 0xeb, 1.0f))
#define HEADSECTION_BK_COLOR (RGBACOLOR(0xf7,0xf7,0xf7,1.0f))
#define HEADSECTION_FONT_COLOR (RGBACOLOR(0x81,0x81,0x81,1.0f))
#define VIEWBACKCOLOR (RGBACOLOR(0xf2, 0xf2, 0xf2, 1.0f))
#define MIDDLESEPERATECOLOR  (RGBACOLOR(0xe1, 0xe1, 0xe1, 1.0f))
#define BOTTOMSEPERATECOLOR  (RGBACOLOR(0xfa, 0x84, 0x00, 1.0f))
#define NAVBARTITLE          (RGBACOLOR(0x64, 0x38, 0x05, 1.0f))
#define CELLTITLECOLOR          (RGBACOLOR(0x33, 0x33, 0x33, 1.0f))
#define ORANGECOLOR           (RGBACOLOR(0xee, 0x77, 0x00, 1.0))

//weixin app_id  app_secret
#define APP_ID @"wx0e1eb09dca9cf656"
#define APP_SECRET @"d4624c36b6795d1d99dcf0547af5443d"
//UMAppKey
#define UMAPP_KEY @"570f0929e0f55a4f89000858"
//Fir ID
#define FIRID @""
#define REFRESH @"refresh"

#define MAX_PAGE_COUNT 2
#define TEXT_FONT  13.f
#define LITTLE_TEXT_FONT 12.f
#define ORDER_FONT 14.f
#define CELL_FONT 15.f

#define USERID @"348081"
#define LOGINSTATUS @"LOGINSTATUS"

#define NOCATEDETAILTIP    @"抱歉，此分类里没有商品列表"
#define ADDCARTSUCCESS     @"成功加入购物车"
#define SENDSMSTIP         @"验证码已成功发送,请注意查收!"
#define CANCELORDERTIP        @"取消订单成功"
#define ADDRELATEDGOODSTOCART  @"ADDRELATEDGOODSTOCART"
//微信支付成功发送通知
#define WPAYSUCCESS        @"WPAYSUCCESS"
//购物车数量发生变化时候，给购物车发送通知
#define COUNTCATRNUMBER    @"COUNTCATRNUMBER"
//跳转到首页通知
#define GOTOHOMEVC         @"GOTOHOMEVC"
//跳转到购物车通知
#define GOTOCARTVC         @"GOTOCARTVC"
//支付完成后，更新优惠券数量的通知
#define UPDATECONSUMECOUNT @"updateConsumeCount"
//登录时需要短信验证时发送的通知
#define NEEDLOGINWITHSMSCHECK @"loginWithSmsCheck"
//获取优惠券数量的通知
#define GETCOUPONCOUNTCHANGED @"GetCouponCountChanged"
//危险支付完成通知
#define DISMISSBACKTOORDERDETAIL @"backToOrderDetail"
//货到付款方式提交订单后，回退到订单界面
#define GOTOOPPORTUNITY @"goToOpportunityVC"
//跳转到相关商品详情页通知
#define RELATEDGOODSDETAIL @"RELATEDGOODSDETAIL"

#define GOODSIMGPRE    @"http://7xwabt.com1.z0.glb.clouddn.com/"

#define NODATACODE  4

#define COMMON_VIEW_XOFFSET (14)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_7  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 || [[[UIDevice currentDevice] systemVersion] floatValue] <= 8.0 )
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OBJECT_NULL(object) (object == nil)
#define IS_NSSTRING_EMPTY(object)  !([object isKindOfClass:[NSString class]] && [(NSString *)object length])
#define IS_NSSTIRNG_CONTAIN(sourStr, str) ([sourStr rangeOfString:str].location != NSNotFound)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define __BASE64( text )        [WlwHelp base64StringFromText:text]
#define __TEXT( base64 )        [WlwHelp textFromBase64String:base64]
#define PLACEHOLDIMAGE          [UIImage imageNamed:@"imgPlaceHold"]
#define RIGHTARROWIMAGE         [UIImage imageNamed:@"in"]
#define IS_LOGIN  ([WlwAppData getUserId] && [[WlwAppData getUserId] integerValue] != -1)
#define USERID @"348081"
@interface WlwHelp : NSObject
+ (CGSize)getLabelSizeByContent:(NSInteger)width withFontSize:(CGFloat)fontSize withContent:(NSString *)content;

+(NSString*)getRealSn:(NSString*)sn withType:(NSInteger)type;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (NSAttributedString *)attributeStringForCellTitleWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellTitleHasLineHightWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellLighterBlackTitleWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellTitleGrayWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellTitleRedWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellTitleSmallWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleHasLineHightWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleSmallWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleSmallHasLineHightWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleSmall10WithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleSmall10HasLineHightWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleExtraSmallWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForCellSubTitleRedWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringForButtonOfLabelStyleWithString:(NSString *)string;



+ (NSString *)replaceStr:(NSString *)regexPattern withReplacedStr:(NSMutableString *)str withPlaceStr:(NSString *)pstr;

+ (NSString *)telephoneWithReformat:(NSString *)str;

+ (BOOL)isValidateDigit:(NSString *)digit;

+ (BOOL)isValidateMobile:(NSString *)mobile; //NOTE:修改成了可以通过199开头的号码
+ (BOOL)isValidateMobileEvenStartWith199:(NSString *)mobile;
+ (BOOL) isValidateContentLengthUnder140:(NSString *)content;
+ (BOOL) isValidateContentLengthUnderLimit:(NSString *)content maxCount:(int) max;
+ (void)showToast:(NSString *)msg;

+ (UIButton *)getStrethButton:(NSString *)normal andHighLight:(NSString *)highLight withEdgeInsets:(UIEdgeInsets)edge;

+ (UIImage *)getStrenthImage:(NSString *)imageName withXoffset:(NSInteger)CapWidth withYoffset:(NSInteger)CapHeight;

+ (UIButton *)getButtonWithColor:(UIColor *)normal andHightLight:(UIColor *)highLight;

+ (CGFloat)getDividerHeight;

+ (CGSize)getLabelSizeByContentWithFontSize:(CGFloat)fontSize withContent:(NSString *)content;

+ (UILabel *)getLabel:(NSString *)content withFontSize:(CGFloat)fontSize withFrame:(CGRect)frame withColor:(UIColor *)color;

+ (id)jsonToObj:(NSString *)json WithClassName:(Class)className;
+ (id)jsonToObj:(NSString *)json;
+ (id)objToJson:(id)obj;

+ (Boolean)isPureInt:(NSString *)string;

+ (UIBarButtonItem *)getButtonItem:(NSString *)name withHighName:(NSString *)high withSelector:(SEL)selector andTarget:(id)target;

+ (UIBarButtonItem *)getButtonItemWithTitle:(NSString *)title withSelectore:(SEL)selector andTarget:(id)target;

+(UIImage*) getStrenthImage:(NSString *)imageName withUIEdgeInsets:(UIEdgeInsets)rect;

+ (void)setSearchBackground:(UISearchBar *)search;

+ (void)setSeachCancel:(UISearchBar *)search;

+ (UIImage *)createImageWithColor:(UIColor *)color;

+(NSInteger)getUnitLevelById:(NSInteger)index withConversion:(NSString*)conversion;

+ (NSString *)getImageNameByStoreType:(NSString *)storeType;

// 尺寸相关的helper
+ (float)sizeMagicWith:(float)number; //这个方法就是用来日后检查到底多少地方用了magic数字
+ (float)heighOftopLayoutGuideUnderNaviagtionController;

+ (float)paddingForTableView;

+ (float)paddingBigForTableView;

+ (float)innerPaddingForTableView;

+ (float)innerPaddingSmallForTableView;

+ (float)paddingRightForTableView;

+ (float)deviceScale;

// view相关的helper
+ (UIButton *)barButtonWihtImageNamed:(NSString *)imageName;

+ (UIButton *)barButtonWihtTitle:(NSString *)title;

// 内容相关的helper
+ (NSString *)categoryStringFromCategoryCode:(int)code;
+ (NSString *)categoryStringFromCategoryCodeArray:(NSArray *)categoryCodes;

+ (NSString *)imageNameFromCategoryCode:(int)code;

+ (NSString *)humanDateStringFromServerDataString:(NSString *)serverString;

+ (NSString *)humanDateStringFromServerDataStringUseFormatYYYY_MM_DD:(NSString *)serverString;

+ (NSString *)formattedDateStringUsingFormat:(NSString *)format fromDate:(NSDate *)date;

+ (NSString *)jsonStringFromArray:(NSArray *)array;
+(NSString*)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

+ (NSString *)digitStringFromADirtyString:(NSString *) dirtyString;

+(int) randomIntBetweenZeroAndNumber:(int) number;
+ (UIImage *)getImageFileInDocumentsFolderOfName:(NSString *)name;
+ (BOOL) checkFileExsitInDocumentsFolderOfName:(NSString *)name;
+ (NSString*) sha1:(NSString*)input;

+(BOOL)isValidatePositiveInterger:(NSString *)digit;
+(BOOL)isValidatePasswordFormat:(NSString *)string;
+(BOOL)isValidateFixedLineTelephoneNumber:(NSString *)numberString; //验证中国的固定电话

+(NSString *)priceStringWithTwoDigits:(NSString *)priceString; //价格格式转化,保留两位小数
+(BOOL) isNewVersion:(int)latestVersionCode;
+(BOOL) shouldCheckForUpdate;

// 电话
+(void) makePhonecallWithNumber:(NSString *)number;

+(NSNumber *)NSNumberFromNSString:(NSString *)string;

+ (NSAttributedString *)attributeStringForButtonArrowNormalState:(NSString *)string;
+ (NSAttributedString *)attributeStringForButtonArrowSelectedState:(NSString *)string;

+ (NSAttributedString *)attributeStringForLabelDistricNote:(NSString *)string;

+ (NSAttributedString *)attributeStringForTextFieldPlaceholder:(NSString *)string;

+(UIView*)getHeadView:(CGRect)frame andContent:(NSString*)content;
+(void)addTipView:(UIView *)parentView andContent:(NSString*)content;

+(NSString *)dateFormatWithMontnAndTime:(NSString *)time;
+(NSString *)timeFormatWithYearMontnAndTime:(NSString *)time;
+(NSInteger)calculateDaysWithstartTime:(NSString *)start_time andEndTime:(NSString *)end_time;
+(long long)getNowTimeStampToSecondMinuts;
+(NSString *)stringWithCommaFromArray:(NSArray *)array;
/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;

//通过对象返回一个NSDictionary，键是属性名称，值是属性值。

+(NSDictionary*)getObjectData:(id)obj;



//将getObjectData方法返回的NSDictionary转化成JSON

+(NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;



//直接通过NSLog输出getObjectData方法返回的NSDictionary

+(NSString *)print:(id)obj;

+(NSString *)ArrayToJson:(NSMutableArray *)list;
+(void)updateVersion;
/**
 *获取指定的日期是星期几
 *
 *  @param date
 *
 *  @return
 */
+ (NSString *) getweekDayWithDate:(NSDate *) date;
/**
 *
 *
 *  @param date
 *
 *  @return ＊＊＊＊年＊＊月＊＊日
 */
+(NSString *)getyyyymmddWithDate:(NSDate *)date;

/**
 *
 *
 *  @param date
 *
 *  @return 时分秒
 */
+(NSString *)gethhmmssWithDate:(NSDate *)date;

+ (NSString *)uniqueImgNameString;

@end
