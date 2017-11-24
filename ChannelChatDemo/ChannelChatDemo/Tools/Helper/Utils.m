//
//  Utils.m
//  JinMiLian
//
//  Created by dm on 16/3/30.
//  Copyright © 2016年 taigu. All rights reserved.
//

#import "Utils.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#define XZRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@implementation Utils
#pragma mark - 手机号/密码校验
+ (BOOL)phoneNumberCheck:(NSString*)phoneNumber{
    return phoneNumber.length == 11;
}
+ (BOOL)passWordCheck:(NSString*)passWord{
    return (passWord.length >= 6 && passWord.length <= 14);
}

+ (BOOL)codeCheck:(NSString*)code{
    return code.length == 6;
}

+ (BOOL)nickName:(NSString*)nickName{
    NSString *      regex = @"^[a-zA-Z0-9\u4e00-\u9fa5_-]+$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:nickName];
}
/*!
 @author DM, 16-03-30 14:03:11
 
 @brief   UIView * vline = [[UIView alloc] initWithFrame:CGRectMake(0,10,0.5,40)];
 vline.center = topView.center;
 vline.backgroundColor = [UIColor grayColor];
 [topView addSubview:vline];
 
 */

/*生成随机整数
 *包括from 包括to
 */
+ (NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to{
     return (NSInteger)(from + (arc4random() % (to - from + 1)));
}


//+ (UILabel *)creatLine:(CGRect)rect  {
//
//
//    UILabel * text = [UILabel new];
//    text.text = @"";
//    [text sizeToFit];
//    text.backgroundColor = MainColor;
//    text.frame = rect;
//
//    return text;
//}




+ (UILabel *)creatText:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font  {
    
    UILabel * text = [UILabel new];
    text.text = title;
    text.textColor = textColor;
    [text sizeToFit];
    text.backgroundColor = [UIColor clearColor];
    text.font = font;
    return text;
    
    
}

//+ (NSMutableAttributedString *)getString:(NSString *)string subString:(NSString *)subString color:(UIColor *)color font:(UIColor *)font {
//    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
//    
//    CGSize size = [self sizeString:subString font:font];
//    
//    [str addAttribute:NSForegroundColorAttributeName
//                value:color
//                range:size];
//    
//    return str;
//}
//
//+ (NSMutableAttributedString *)getString:(NSString *)string subString:(NSString *)subString font:(UIColor *)font {
//    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
//    
//    [str addAttribute:NSFontAttributeName
//                value:color
//                range:NSMakeRange(0,5)];
//    
//    return str;
//}


+ (CGSize)sizeString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT)
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    
    return rect.size;
}


+ (UIView *)creatView:(UIColor *)backColor {
    
    UIView * view = [UIView new];
    view.backgroundColor = backColor;
    return view;
}



+ (UIButton *)creatBtn:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font backColor:(UIColor *)backColor{
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = backColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    btn.titleLabel.font = font;
    return btn;
}


+ (UIButton *)creatBtn:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font backColor:(UIColor *)backColor addTarget:(id)target action:(SEL)action{
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
     btn.backgroundColor = backColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
     btn.titleLabel.font = font;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+ (UIButton *)creatBtn:(UIImage *)iamge backColor:(UIColor *)backColor addTarget:(id)target action:(SEL)action{
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = backColor;
    [btn setImage:iamge forState:UIControlStateNormal];
    [btn setImage:iamge forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}



+ (UIImageView *)creatImageView:(NSString *)iamgeName backColor:(UIColor *)backColor {
    
    UIImageView * iamgeView = [UIImageView new];
    iamgeView.backgroundColor = backColor;

    iamgeView.image = [UIImage imageNamed:iamgeName];
    return iamgeView;
}


+ (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}

+ (UIViewController*) findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        return vc;
    }
}

#pragma mark - 跳转到指定页面
+ (void)popToViewController:(Class)controllerClass{
    if (controllerClass == nil) {
        [[Utils currentViewController].navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    NSMutableArray *vcArr = [NSMutableArray array];
    for (UIViewController *vc in [Utils currentViewController].navigationController.viewControllers) {
        if ([vc isKindOfClass:controllerClass]) {
            [vcArr addObject:vc];
        }
    }
    if (vcArr.count > 0) {
        UIViewController *vc = vcArr.firstObject;
        [[Utils currentViewController].navigationController popToViewController:vc animated:YES];
    } else {
        [[Utils currentViewController].navigationController popToRootViewControllerAnimated:YES];
    }
}

//字符串相关操作
#pragma mark - 去除字符串两边空格
+ (NSString*)removeAllSpaceCharacterInString:(NSString*)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - 时间格式转换
/*date -> string*/
+ (NSString*)dateToString:(NSDate*)date format:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = format;
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}

+ (NSString *)AMPMFromRongweiTime:(NSString *)fromTime{
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter3 setDateFormat:yyyy_MM_dd_HH_mm_ss];
    NSDate *date1 = [dateFormatter3 dateFromString:fromTime];
    NSLog(@"date1 : %@", date1); // Here returning (null)**
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:yyyy_MM_dd_A_mm_ss];
    return  [dateFormatter stringFromDate:date1];
}

#pragma mark yyyy-MM-dd HH:mm:ss -> yyyy-MM-dd
+ (NSString *)timeFormateFromDetailsToNomalWithString:(NSString *)detailsStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:yyyy_MM_dd_HH_mm_ss];
    NSDate *currentDate = [dateFormatter dateFromString:detailsStr];
    
    [dateFormatter setDateFormat:yyyy_MM_dd];
    return  [dateFormatter stringFromDate:currentDate];

}
#pragma mark ss->hh:mm:ss
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    if ([str_hour integerValue] > 1) {
//        return @"";   //小于一小时返回空字符串
    }
    //format of time
    
    NSString *format_time = [NSString string];
    if ([str_hour integerValue] == 0) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    } else {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }
    return format_time;
    
}

#pragma mark NSDate转毫秒时间戳
+ (NSInteger)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    NSLog(@"转换的时间戳=%f",interval);
    NSInteger totalMilliseconds = interval*1000 ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}

#pragma mark 时间戳转时间
+ (NSString*)timeSpToTime:(NSString*)timeSp WithFormatter:(NSString*)timeFormatter{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeSp doubleValue]/1000.];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFormatter];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
#pragma mark -- string 转 date
//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:yyyy_MM_dd_HH_mm_ss];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    return date;
}

#pragma mark 时间差计算
+ (NSDateComponents*)timeDifferenceBetweenStartDate:(NSDate*)startDate endDate:(NSDate*)endDate{
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    return dateCom;
}

//url参数编码
+ (NSString *)encodeParameter:(NSString *)originalPara {
    if (STRING_ISNIL(originalPara)) {
        return @"";
    }
    CFStringRef encodeParaCf = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)originalPara, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
}

#pragma mark - 聊天时间lab计算
+ (NSString *)chatTimeWithFormateTimeStr:(NSString *)tagertTimeStr andCompareTimeStr:(NSString *)compareStr{
    if (STRING_ISNIL(compareStr)) {
       return [self chatTimeStr:[self timeSwitchTimestamp:tagertTimeStr andFormatter:yyyy_MM_dd_HH_mm_ss]];
    }
    
    NSDate *targetTimeDate = [self dateFromString:tagertTimeStr];
    NSDate *compareTimeDate = [self dateFromString:compareStr];
    double intervalTime = [targetTimeDate timeIntervalSinceReferenceDate] - [compareTimeDate timeIntervalSinceReferenceDate];
    BOOL canShow =  intervalTime<60?NO:YES;
    
    if (canShow) {
       return [self chatTimeStr:[self timeSwitchTimestamp:tagertTimeStr andFormatter:yyyy_MM_dd_HH_mm_ss]];
    }else{
        return @"";
    }
}
// 活动日期格式化
+ (NSString *)activityDateFormate:(NSString *)activityDateStr{
//    NSDate *activityDate = [self dateFromString:activityDateStr];
    NSInteger activityTimeStamp = [self timeSwitchTimestamp:activityDateStr andFormatter:yyyy_MM_dd_HH_mm_ss];
    NSArray *strArr = [activityDateStr componentsSeparatedByString:@" "];
    // 上下午
    NSString *upDowTimeStr = [strArr[1] substringToIndex:2];
    NSString *upDayStr = [upDowTimeStr integerValue]>=12?@"下午":@"上午";
    
//    NSString *upDayStr = [self dayTimeWithNsdate:activityDate];
    NSString *weekStr = [self getWeekDayFordate:activityTimeStamp];
    
    return  [NSString stringWithFormat: @"%@ %@     %@ %@",strArr[0],weekStr,upDayStr,strArr[1]];

}

// 日期转上午下午
+ (NSString *)dayTimeWithNsdate:(NSDate *)date{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.AMSymbol = @"上午";
    format.PMSymbol = @"下午";
    format.dateFormat = @"aaa";
    return  [format stringFromDate:date];
}
// 日期转周几
+ (NSString *)getWeekDayFordate:(long long)data
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}


+ (NSString *)compareCurrentTimeWithTime:(NSString *)endTime{
    //设置转换格式
    NSDate *date=[self dateFromString:endTime];
    NSDate * currentDate = [NSDate date];
    long dd = (long)[date timeIntervalSince1970] - [currentDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",(long)dd];

}
// 时间转时间戳
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}
+ (NSString *)chatTimeStr:(long long)timestamp
{
    // 创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    
    // 获取当前时间的年、月、日。利用日历
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    // 获取消息发送时间的年、月、日
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYear = components.year;
    CGFloat msgMonth = components.month;
    CGFloat msgDay = components.day;
    
    // 进行判断
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        //今天
        dateFmt.dateFormat = @"HH:mm";
    }else if (currentYear == msgYear && currentMonth == msgMonth && currentDay-1 == msgDay ){
        //昨天
        dateFmt.dateFormat = @"昨天 HH:mm";
    }else{
        //昨天以前
        dateFmt.dateFormat = @"MM-dd HH:mm";
    }
    // 返回处理后的结果
    return [dateFmt stringFromDate:msgDate];
}

#pragma mark - 获取当前时间
+(NSString*)currentTimeTextWithFormatter:(NSString*)formate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formate];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

#pragma mark - 年龄计算
+ (NSString*)calculateAge:(NSString*)birthDayStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birthDayStr];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    if (age == 0) {
        age = 1;
    }
    return [NSString stringWithFormat:@"%d",age];
}

+ (NSURL *)imageWithString:(NSString *)imgStr suffixWH:(NSInteger)widthHeight{
    if (STRING_ISNOTNIL(imgStr)) {
        NSURL * URL =[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/2/w/%ld/h/%ld",imgStr,widthHeight*2,widthHeight*2]];
        return URL;
    } else {
        return nil;
    }
}

/**
 *  将若干view等宽布局于容器containerView中
 *
 *  @param views         viewArray
 *  @param containerView 容器view
 *  @param LRpadding     距容器的左右边距
 *  @param viewPadding   各view的左右边距
 */
//+ (void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding
//{
//    UIView *lastView;
//    for (UIView *view in views) {
//        [containerView addSubview:view];
//        if (lastView) {
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.bottom.equalTo(containerView);
//                make.left.equalTo(lastView.mas_right).offset(viewPadding);
//                make.width.equalTo(lastView);
//            }];
//        }else
//        {
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(containerView).offset(LRpadding);
//                make.top.bottom.equalTo(containerView);
//            }];
//        }
//        lastView=view;
//    }
//    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(containerView).offset(-LRpadding);
//    }];
//}
#pragma mark - 判断是否在现场
//+ (double)calculateStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end {
//
//    double meter = 0;
//
//    double startLongitude = start.longitude;
//    double startLatitude = start.latitude;
//    double endLongitude = end.longitude;
//    double endLatitude = end.latitude;
//
//    double radLatitude1 = startLatitude * M_PI / 180.0;
//    double radLatitude2 = endLatitude * M_PI / 180.0;
//    double a = fabs(radLatitude1 - radLatitude2);
//    double b = fabs(startLongitude * M_PI / 180.0 - endLongitude * M_PI / 180.0);
//
//    double s = 2 * asin(sqrt(pow(sin(a/2),2) + cos(radLatitude1) * cos(radLatitude2) * pow(sin(b/2),2)));
//    s = s * EARTH_RADIUS;
//
//    meter = round(s * 10000) / 10000; //返回距离单位是米
//    return meter;
//}


/**
 为控件创建局部圆角

 @param corners 需圆角位置
 @param radii 半径
 @param target 圆角对象
 */
+ (void)cornerRadiusForCorners:(UIRectCorner)corners withRadii:(CGFloat)radii target:(UIView*)target{
    UIBezierPath *pswMaskPath = [UIBezierPath bezierPathWithRoundedRect:target.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *pswMaskLayer = [[CAShapeLayer alloc] init];
    pswMaskLayer.frame = target.bounds;
    pswMaskLayer.path = pswMaskPath.CGPath;
    target.layer.mask = pswMaskLayer;
}

//#pragma mark - 发布动态 生活圈
//+ (void)pubDynamicOrLifeCircle:(BOOL)isLifeCircle andisPic:(BOOL)isPic andController:(UIViewController *)controller andChannelId:(NSString *)channelId andType:(CONDITIONS_TYPE)type{
//
//    __block PDPubActivityViewController *vc = [[PDPubActivityViewController alloc]init];
//    vc.conditionType = type;
//
//    if (isPic) { // 发布图片
//        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4  delegate:nil pushPhotoPickerVc:YES];
//        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//            vc.pubPicArr = [photos mutableCopy];
//            vc.pubPicAssetArr = [assets mutableCopy];
//            [vc lloadCollectionViewDataWithUIChanged];
//        }];
//
//        [controller presentViewController:imagePickerVc animated:YES completion:nil];
//        vc.type = isLifeCircle?PDPUBTYPE_LIFE:PDPUBTYPE_ACT;
//        vc.sourceType =SOURCE_TYPE_PIC;//isPic?SOURCE_TYPE_PIC:SOURCE_TYPE_VIDEO;
//        vc.channelId = channelId;
//        [controller.navigationController pushViewController:vc animated:YES];
//    }else{ // 发布视频
//        WechatShortVideoController *wechatShortVideoController = [[WechatShortVideoController alloc] init];
//        wechatShortVideoController.delegate = vc;
//
//        [controller presentViewController:wechatShortVideoController animated:YES completion:nil];
//        vc.type = isLifeCircle?PDPUBTYPE_LIFE:PDPUBTYPE_ACT;
//        vc.sourceType =SOURCE_TYPE_VIDEO;//isPic?SOURCE_TYPE_PIC:SOURCE_TYPE_VIDEO;
//        vc.channelId = channelId;
//        [controller.navigationController pushViewController:vc animated:YES];
//    }
//
//
//}

//+ (UIImage *)getVideoThumbImage:(NSString *)path
//{
//    MPMoviePlayerController *mp = [[MPMoviePlayerController alloc]
//                                   initWithContentURL:[NSURL fileURLWithPath:path]];
//    UIImage *img = [mp thumbnailImageAtTime:0.0
//                                 timeOption:MPMovieTimeOptionNearestKeyFrame];
//    [mp stop];
//    return img;
//}

/*通过通知对textField输入字数做限制*/
+ (void)textFiledEditChanged:(NSNotification *)obj maxLength:(NSInteger)maxLength{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > maxLength)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > maxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

/**
 限制输入框内字符输入最大数量
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxTextLength:(NSInteger)maxTextLength
{
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textField positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < maxTextLength) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSInteger caninputlen = maxTextLength - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = string.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [string canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [string substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
//            self.countLabel.text = [NSString stringWithFormat:@"%d/%ld",MAX_LIMIT_NUMS,(long)MAX_LIMIT_NUMS];
        }
        return NO;
    }
}

#pragma mark - 字符串转表情符
//+ (NSMutableAttributedString *)isContantEmojiWithString:(NSString *)contentText font:(UIFont*)font{
//    NSString *pattern = @"\\[[a-z0-9-_]+\\]";
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
//    NSArray *matches = [regex matchesInString:contentText options:0 range:NSMakeRange(0, contentText.length)];
//
//    if (!matches.count) return [[NSMutableAttributedString alloc]initWithString:contentText]; // 纯文本
//
//    NSMutableArray *emojiStrArray=[[NSMutableArray alloc]initWithCapacity:1];
//    NSMutableString *resultStr = [NSMutableString stringWithCapacity:0];
//    NSUInteger lastIdx = 0;
//
//    for (NSTextCheckingResult* match in matches){
//        NSRange range = match.range;
//        if (range.location > lastIdx){
//            NSString  *temp = [contentText substringWithRange:NSMakeRange(lastIdx, range.location - lastIdx)];
//            [resultStr appendString:temp];
//            [emojiStrArray addObject:temp];
//        }
//        NSString *text = [contentText substringWithRange:[match rangeAtIndex:0]];
//        [emojiStrArray addObject:text];
//        NSString *atName = [NSString stringWithFormat:@"@%@",text];
//        [resultStr appendString:atName];
//        lastIdx = range.location + range.length;
//    }
//    //看不懂这一步
//    if (lastIdx < contentText.length){
//        NSString  *temp = [contentText substringFromIndex:lastIdx];
//        [resultStr appendString:temp];
//        [emojiStrArray addObject:temp];
//    }
//
//
//    //段落属性
//    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    style.alignment = NSTextAlignmentLeft;
//    style.lineSpacing = 5.0f;
//    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc]initWithString:@"" attributes:@{ NSParagraphStyleAttributeName : style}];
//
//
//    for (NSString *string in emojiStrArray) {
//        if([string isEqualToString:@""])
//        {
//            continue;
//        }
//        NSString *itemStr  = [NSString stringWithFormat:@"%@",string];
//
//        BOOL isEmotion = false;
//        if (itemStr.length>=9 && [[itemStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"["] &&[[itemStr substringWithRange:NSMakeRange(itemStr.length-1, 1)] isEqualToString:@"]"]&&[[itemStr substringWithRange:NSMakeRange(1, 6)] isEqualToString:@"emoji_"]) {
//            NSString *itemStrF =  [itemStr substringFromIndex:7];
//            NSString *itemStrT = [itemStrF substringToIndex:itemStrF.length -1 ];
//            NSLog(@"emoji --%@",itemStrT);
//            NSScanner* scan = [NSScanner scannerWithString:itemStrT];
//            int val;
//            if ( [scan scanInt:&val] && [scan isAtEnd]) {// 纯数字
//                HWEmotion *emotion = [[HWEmotion alloc]init];
//                emotion.png = [NSString stringWithFormat:@"emoji_%@",itemStrT];
//                HWEmotionAttachment *attch = [[HWEmotionAttachment alloc] init];
//                // 传递模型
//                attch.emotion = emotion;
//                // 设置图片的尺寸，因为新增的一套图标尺寸和原来的图标边缘空白不一样，为了使得最后的视觉效果一样大小，在这里做特殊控制。
//                CGFloat attchWH = 21;
//                CGFloat offset = -4;
//                if ([[emotion.png substringFromIndex:6] intValue]>=100 ||
//                    [[emotion.png substringToIndex:2] isEqualToString:@"m_"]) {
//                    attchWH = 28;
//                    offset = -9;
//                }
//                // 根据附件创建一个属性文字
//                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
//                [atrString appendAttributedString:imageStr];
//                isEmotion = true;
//            }
//        }
//
//        if (!isEmotion) {
//            //段落属性
//            NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//            style.lineSpacing = 5.0f;
//            NSMutableAttributedString *subStr =[[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font}];
//            [atrString appendAttributedString: subStr];
//            CGRect rect = [subStr boundingRectWithSize:CGSizeMake(255, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//        }
//    }
//
//    return atrString;
//}

#pragma mark - 权限检测
+(void)checkCameraRightAndRamind{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *goSetting = [UIAlertAction actionWithTitle:@"前往设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
        [alert addAction:cancel];
        [alert addAction:goSetting];
        [[Utils currentViewController] presentViewController:alert animated:YES completion:nil];
        return;
    }
}

+ (NSString *)ret32bitString{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

+(NSString*)safeSubstringWithLength:(NSInteger)length string:(NSString*)str{
    str = [str substringWithRange:NSMakeRange(0, str.length>length?length:str.length)];
    return str;
}
@end
