//
//  HWEmotionTool.m
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

// 最近表情的存储路径
#define HWRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "HWEmotionTool.h"
#import "HWEmotion.h"
#import "HWEmotionAttachment.h"
#import "NSString+Extension.h"
#import "NSString+Category.h"

@implementation HWEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HWRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)addRecentEmotion:(HWEmotion *)emotion
{
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    
    // 将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:HWRecentEmotionsPath];
}

/**
 *  返回装着HWEmotion模型的数组
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

+ (NSMutableAttributedString*)formatMessage:(NSString*)content ContentType:(NSInteger)type withCompletion:(void (^)(NSMutableAttributedString* result, CGRect rect))completion{
    dispatch_queue_t queue = dispatch_queue_create("emoji", DISPATCH_QUEUE_SERIAL);
    
    UIColor* contentColor = [UIColor lightGrayColor];//[UIColor hx_colorWithHexRGBAString:@"32353b"];
    if (type == 1) {
        contentColor = [UIColor lightGrayColor];// [UIColor hx_colorWithHexRGBAString:@"999"];
    }
    CGFloat length = 0;
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 100 + 20, MAXFLOAT);
//    NSArray *array = [content componentsSeparatedByString:@"]"];
    NSString *path1;
    NSString *path3;
//    PDUser *user = [PDUser sharedInstance];
    //    if([user.sex intValue]==1)
    path1 = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/man_emoji.plist" ofType:nil];
    //    else
    path3 = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/woman_emoji.plist" ofType:nil];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/default.plist" ofType:nil];
    NSMutableArray *HWEmotionArray=[[NSMutableArray alloc]initWithCapacity:1];

//        _HWEmotionArray=[[NSMutableArray alloc]initWithCapacity:1];
        NSArray *arr1 =   [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path1]];
        NSArray *arr3 =   [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path3]];
        NSArray *arr2 =   [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path2]];
        
        [HWEmotionArray addObjectsFromArray:arr1];
        [HWEmotionArray addObjectsFromArray:arr3];
        [HWEmotionArray addObjectsFromArray:arr2];
//    NSMutableArray *HWEmotionArray =   [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc]initWithString:@""];
    
    
    
    
    content=[content stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSArray *array = [_message.text componentsSeparatedByString:@"]"];
    //    NSArray *array3 = [_message.text componentsSeparatedByRegex:regexString];
    
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:1];
    
    //    NSMutableDictionary *markDic=[[NSMutableDictionary alloc]initWithCapacity:1];
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:0];
    
    NSString *pattern = @"\\[[a-z0-9-_]+\\]";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, content.length)];
    
    NSUInteger lastIdx = 0;
    
    for (NSTextCheckingResult* match in matches)
        
    {
        
        NSRange range = match.range;
        
        if (range.location > lastIdx)
            
        {
            
            NSString  *temp = [content substringWithRange:NSMakeRange(lastIdx, range.location - lastIdx)];
            
            [resultStr appendString:temp];
            
            [array addObject:temp];
            
        }
        
        //        NSString *link = [_message.text substringWithRange:[match rangeAtIndex:0]];
        
        NSString *text = [content substringWithRange:[match rangeAtIndex:0]];
        [array addObject:text];
        NSString *atName = [NSString stringWithFormat:@"@%@",text];
        
        [resultStr appendString:atName];
        
        //        [markDic setObject:link forKey:atName];
        
        lastIdx = range.location + range.length;
        
    }
    
    
    if (lastIdx < content.length)
        
    {
        
        NSString  *temp = [content substringFromIndex:lastIdx];
        
        [resultStr appendString:temp];
        [array addObject:temp];
        
    }
    
    
    
    for (NSString *string in array) {
        if([string isEqualToString:@""])
        {
            continue;
        }
        NSString *itemStr  = [NSString stringWithFormat:@"%@",string];
        
        BOOL isEmotion = false;
        for (HWEmotion *emotion in HWEmotionArray) {
            if ([emotion.chs isEqualToString:itemStr]) {
                HWEmotionAttachment *attch = [[HWEmotionAttachment alloc] init];
                
                // 传递模型
                attch.emotion = emotion;
                
                // 设置图片的尺寸，因为新增的一套图标尺寸和原来的图标边缘空白不一样，为了使得最后的视觉效果一样大小，在这里做特殊控制。
                if (type == 1) {
                    CGFloat attchWH = 15;
                    CGFloat offset = -3;
                    if ([[emotion.png substringToIndex:2] isEqualToString:@"f_"] ||
                        [[emotion.png substringToIndex:2] isEqualToString:@"m_"]||[[emotion.png substringFromIndex:6] intValue]>=100) {
                        attchWH = 18;
                        offset = -5;
                    }
                    attch.bounds = CGRectMake(0, offset, attchWH, attchWH);
                }
                else if(type == 2){
                    CGFloat attchWH = 35;
                    CGFloat offset = -14;
                    if ([[emotion.png substringToIndex:2] isEqualToString:@"f_"] ||
                        [[emotion.png substringToIndex:2] isEqualToString:@"m_"]||[[emotion.png substringFromIndex:6] intValue]>=100) {
                        attchWH = 40;
                        offset = -18;
                    }
                    attch.bounds = CGRectMake(0, offset, attchWH, attchWH);
                }
                else{
                    
                    CGFloat attchWH = 20;
                    CGFloat offset = -6;
                    if ([[emotion.png substringToIndex:2] isEqualToString:@"f_"] ||
                        [[emotion.png substringToIndex:2] isEqualToString:@"m_"]||[[emotion.png substringFromIndex:6] intValue]>=100) {
                        attchWH = 27;
                        offset = -12;
                    }
                    attch.bounds = CGRectMake(0, offset, attchWH, attchWH);
                    
                    
//                    attch.bounds = CGRectMake(0, -8, 20, 20);
                }

                // 根据附件创建一个属性文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
                [atrString appendAttributedString:imageStr];
                
                isEmotion = true;
                
                length = length + attch.bounds.size.width;
            }
        }
        
        if (!isEmotion) {
            NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc]initWithString:string];
            [subStr addAttribute:NSForegroundColorAttributeName
                                value:contentColor
                                range:NSMakeRange(0,subStr.length)];
            CGFloat fontSize = 12;
            if (type == 2) {
                fontSize = 15;
            }
            [subStr addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:fontSize]
                                range:NSMakeRange(0,subStr.length)];
            
            [atrString appendAttributedString: [subStr formatMentionedUser]];
            CGSize textSize = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:maxSize];
            length = length + textSize.width;
        }
    }
    
    CGFloat width = SCREEN_WIDTH - 100; // whatever your desired width is
    CGRect rect = [atrString boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    if (completion) {
        completion(atrString,rect);
    }
    return atrString;
}
@end
