//
//  Utils.h
//  JinMiLian
//
//  Created by dm on 16/3/30.
//  Copyright © 2016年 taigu. All rights reserved.
//

/*!
 @author DM, 16-03-30 14:03:26
 
 @brief <#Description#>
 */
//typedef NS_ENUM(NSUInteger, UILabelResizeType) {
//    UILabelResizeTypeHorizontal,
//    UILabelResizeTypeVertical,
//};

/*时间格式定义*/
#define yyyy_MM_dd_HH_mm_ss @"yyyy-MM-dd HH:mm:ss"
#define yyyy_MM_dd @"yyyy-MM-dd"
#define yyyy_MM_dd_hh_mm_ss @"yyyy-MM-dd hh:mm:ss"
#define yyyyYearMMMonthddDay_EEEE_HH_mm @"yyyy年MM月dd日 EEEE HH:mm"  //xxxx年xx月xx日 星期x xx:xx
#define yyyyYearMMMonthddDay_EEEE_aaa_HH_mm @"yyyy年MM月dd日 EEEE aaa HH:mm"
#define yyyy_MM_dd_A_mm_ss @"yyyy/MM/dd   a h:mm "

/*文字字体*/
#define kPingFangSC_Regular @"PingFangSC-Regular"  //苹方
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface Utils : NSObject
#pragma mark - 手机号/密码/验证码校验
+(BOOL)phoneNumberCheck:(NSString*)phoneNumber;
+(BOOL)passWordCheck:(NSString*)passWord;
+(BOOL)codeCheck:(NSString*)code;
+(BOOL)nickName:(NSString*)nickName; //昵称（仅包含汉字、大小写字母、下划线、横线）

/*生成随机整数
 *包括from 包括to
 */
+(NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to;

#pragma mark - UI相关
///创建UILabel
+(UILabel *)creatText:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font;

//+(UILabel *)creatText:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font direction:(UILabelResizeType)direction;
///创建UIView
+(UIView *)creatView:(UIColor *)backColor;

///
+(UIButton *)creatBtn:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font backColor:(UIColor *)backColor;
///创建UIButton
+(UIButton *)creatBtn:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font backColor:(UIColor *)backColor addTarget:(id)target action:(SEL)action;
///创建
+(UIButton *)creatBtn:(UIImage *)iamge backColor:(UIColor *)backColor addTarget:(id)target action:(SEL)action;

+(UIImageView *)creatImageView:(NSString *)iamgeName backColor:(UIColor *)backColor;
//创建line
+(UILabel *)creatLine:(CGRect)rect;
///随机颜色
+(UIColor *)randomColor;

///字符串大小
+ (CGSize)sizeString:(NSString *)string font:(UIFont *)font;

#pragma mark - 获取当前控制器
+ (UIViewController*) currentViewController;

#pragma mark - 跳转到指定页面
+ (void)popToViewController:(Class)controllerClass;

#pragma mark - 字符串相关操作
#pragma mark  去除字符串两边空格
+ (NSString*)removeAllSpaceCharacterInString:(NSString*)string;
#pragma mark url参数编码
+ (NSString *)encodeParameter:(NSString *)originalPara;

+ (NSString *)compareCurrentTimeWithTime:(NSString *)endTime;
#pragma mark - 时间相关
#pragma mark  时间格式转换
/*date -> string*/
+ (NSString*)dateToString:(NSDate*)date format:(NSString*)format;

+ (NSString *)AMPMFromRongweiTime:(NSString *)fromTime;

#pragma mark ss->hh:mm:ss
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

#pragma mark NSDate转毫秒时间戳
+ (NSInteger)getDateTimeTOMilliSeconds:(NSDate *)datetime;
#pragma mark 时间戳转时间
+ (NSString*)timeSpToTime:(NSString*)timeSp WithFormatter:(NSString*)timeFormatter;
#pragma mark - 获取当前时间
+(NSString*)currentTimeTextWithFormatter:(NSString*)formate;

#pragma mark  年龄计算
+ (NSString*)calculateAge:(NSString*)birthDayStr;

#pragma mark 时间差计算
+ (NSDateComponents*)timeDifferenceBetweenStartDate:(NSDate*)startDate endDate:(NSDate*)endDate;


+ (NSString *)timeFormateFromDetailsToNomalWithString:(NSString *)detailsStr;
#pragma mark -
//图片添加切图信息
+ (NSURL *)imageWithString:(NSString *)imgStr suffixWH:(NSInteger)widthHeight;



/**
 *  将若干view等宽布局于容器containerView中
 *
 *  @param views         viewArray
 *  @param containerView 容器view
 *  @param LRpadding     距容器的左右边距
 *  @param viewPadding   各view的左右边距
 */
+ (void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding;
+ (NSString *)chatTimeWithFormateTimeStr:(NSString *)tagertTimeStr andCompareTimeStr:(NSString *)compareStr;
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//+ (double)calculateStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end ;
+ (NSString *)getWeekDayFordate:(long long)data;
+ (NSString *)dayTimeWithNsdate:(NSDate *)date;
+ (NSString *)activityDateFormate:(NSString *)activityDateStr;
+ (NSString *)chatTimeStr:(long long)timestamp;


/**
 为控件创建局部圆角
 
 @param corners 需圆角位置
 @param radii 半径
 @param target 圆角对象
 */
+ (void)cornerRadiusForCorners:(UIRectCorner)corners withRadii:(CGFloat)radii target:(UIView*)target;

/**
 发布动态

 @param isLifeCircle 是否为生活圈
 @param isPic YES:照片  NO：视频
 @param controller 控制器
 @param channelId 频道id
 */
//+(void)pubDynamicOrLifeCircle:(BOOL)isLifeCircle andisPic:(BOOL)isPic andController:(UIViewController *)controller andChannelId:(NSString *)channelId andType:(CONDITIONS_TYPE)type;
+ (UIImage *)getVideoThumbImage:(NSString *)path;


/*通过通知对textField输入字数做限制*/
+ (void)textFiledEditChanged:(NSNotification *)obj maxLength:(NSInteger)maxLength;

/**
 限制输入框内字符输入最大数量
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxTextLength:(NSInteger)maxTextLength;

//+(void)showAlertWithTitle:(NSString*)title detailText:(NSString*)detailText rightButtonTitle:(NSString*)rightButtonTitle handler:(void (^)(SIAlertView *alertView))handler isSameTopic:(BOOL)isSameTopic;
#pragma mark - 字符串转表情符
//+ (NSMutableAttributedString *)isContantEmojiWithString:(NSString *)contentText font:(UIFont*)font;
+ (NSString *)ret32bitString;
#pragma mark - 权限检测
+(void)checkCameraRightAndRamind;

+(NSString*)safeSubstringWithLength:(NSInteger)length string:(NSString*)str;
@end
