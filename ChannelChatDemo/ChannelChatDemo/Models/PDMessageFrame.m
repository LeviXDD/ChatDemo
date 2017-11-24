//
//  PDMessageFrame.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "PDMessageFrame.h"
#import "ChatMessageModel.h"
#import "PDLocalMessageModel.h"
#import "NSString+Extension.h"
#import "PDChatInfoDefs.h"
//#import "ICMediaManager.h"
#import "SDImageCache.h"
#import "HWEmotion.h"
#import "HWEmotionAttachment.h"
#import "UILabel+fastLab.h"
#import "SDWebImageManager.h"
#define APP_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define APP_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation PDMessageFrame
-(void)noticeBoard{
    CGFloat noticeBoardTopPadding = 15;
    CGFloat noticeBoardRightPadding = 30;
    CGFloat width = APP_WIDTH - noticeBoardRightPadding*2;
    CGFloat noticeBoardHeight = 0.0;
    switch (_model.message.channelType) {
        case PDChannelTypeSimCity:
        {
            noticeBoardHeight = width/1.6;
            self.noticeBoardF = CGRectMake(noticeBoardRightPadding, noticeBoardTopPadding, width, noticeBoardHeight);
        }
            break;
            
        case PDChannelTypeSameTopic:
        {
            noticeBoardHeight = width/1.6;
            self.noticeBoardF = CGRectMake(noticeBoardRightPadding, noticeBoardTopPadding, width, noticeBoardHeight);
        }
            break;
            
        case PDChannelTypeMine:
        {
            switch (self.model.message.noticeBoardType) {
                case NOTICEBOARD_TYPE_COMMEN_CATCHDOLL:
                    noticeBoardHeight = 270;
                    self.noticeBoardF = CGRectMake(noticeBoardRightPadding, noticeBoardTopPadding, width, noticeBoardHeight);
                    break;
                    
                case NOTICEBOARD_TYPE_COMMEN_FIRST:
                    noticeBoardHeight = width/1.;
                    self.noticeBoardF = CGRectMake(noticeBoardRightPadding, noticeBoardTopPadding, width, noticeBoardHeight);
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case PDChannelTypeAttention:
        {
            switch (self.model.message.noticeBoardType) {
                case NOTICEBOARD_TYPE_COMMEN_CATCHDOLL:
                    noticeBoardHeight = 270;
                    self.noticeBoardF = CGRectMake(noticeBoardRightPadding, noticeBoardTopPadding, width, noticeBoardHeight);
                    break;
                    
                case NOTICEBOARD_TYPE_COMMEN_FIRST:
                    noticeBoardHeight = width/1.;
                    self.noticeBoardF = CGRectMake(noticeBoardRightPadding, noticeBoardTopPadding, width, noticeBoardHeight);
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    self.cellHight = noticeBoardHeight + noticeBoardTopPadding*2;
}
-(void)setModel:(PDLocalMessageModel *)model{
    _model = model;
    
    switch (model.message.contentType) {
        case MES_CHATCONTENT_TYPE_NOTICEBOARD:
            [self noticeBoard];
            return;
            break;
            
        default:
            break;
    }
    
    CGFloat headToView    = 10;
    CGFloat headToBubble  = 6;
    CGFloat headWidth     = 35;
    CGFloat cellMargin    = 10;
    CGFloat bubblePadding = 10;
    CGFloat chatLabelMax  = APP_WIDTH - headWidth - 100;
    CGFloat arrowWidth    = 7;      // 气泡箭头
    CGFloat topViewH      = 10;
    CGFloat cellMinW      = 60;     // cell的最小宽度值,针对文本
    
    if (model.message.contentType == MES_CHATCONTENT_TYPE_SYS) { // 系统通知消息
        CGSize sysMSGSize = [model.message.content sizeWithMaxWidth:MAXFLOAT andFont:SenderNameFont];
        _systemMSGF = CGRectMake((SCREEN_WIDTH-sysMSGSize.width)/2.0-7, CGRectGetMaxY(_timeLabelF)+10, sysMSGSize.width+14, sysMSGSize.height+10);
        _cellHight  = CGRectGetMaxY(_systemMSGF)+20;
        return;
    }
    
    CGSize timeSize  = CGSizeZero;
    if (model.message.showTimeStr.length) {
        timeSize = [model.message.showTimeStr sizeWithMaxWidth:MAXFLOAT andFont:SenderNameFont];
        _timeLabelF = CGRectMake((SCREEN_WIDTH-timeSize.width)/2.0  ,10,timeSize.width+10,timeSize.height+10);
        cellMargin = CGRectGetMaxY(_timeLabelF) + cellMargin;
    }
    
    if (model.isSender) {
        cellMinW = timeSize.width + arrowWidth + bubblePadding*2;
        CGFloat headX = APP_WIDTH - headToView - headWidth;
        _headImageViewF = CGRectMake(headX, cellMargin, headWidth, headWidth);

        CGSize nameLabelSize = [model.message.from sizeWithMaxWidth:chatLabelMax andFont:SenderNameFont];
        _nameLabelF = CGRectMake(CGRectGetMinX(_headImageViewF) - headToBubble - nameLabelSize.width - arrowWidth, cellMargin, nameLabelSize.width, nameLabelSize.height);
        if (model.message.contentType == MES_CHATCONTENT_TYPE_TEXT) { // 文字
             model.message.attributContent = [self isContantEmojiWithString:model.message.content];
            // 计算attributeStr Frame
            CGSize chateLabelSize;
            if (model.message.attributContent) {
                UILabel *tempLab = [UILabel fastLabWithTitle:@"" andTitleFont:MessageFont andTitleColor:[UIColor clearColor]];
                tempLab.numberOfLines = 0;
                tempLab.attributedText =model.message.attributContent;
                chateLabelSize = [tempLab sizeThatFits:CGSizeMake(chatLabelMax, MAXFLOAT)];
            }else{
                chateLabelSize = [model.message.content sizeWithMaxWidth:chatLabelMax andFont:MessageFont];
            }
            CGSize bubbleSize     = CGSizeMake(chateLabelSize.width + bubblePadding * 2 + arrowWidth, chateLabelSize.height + bubblePadding * 2);
            CGSize topViewSize    = CGSizeMake(cellMinW+bubblePadding*2, topViewH);
            _bubbleViewF          = CGRectMake(CGRectGetMinX(_headImageViewF) - headToBubble - bubbleSize.width, cellMargin+topViewH+nameLabelSize.height, bubbleSize.width, bubbleSize.height);
            CGFloat x             = CGRectGetMinX(_bubbleViewF)+bubblePadding;
            _chatLabelF           = CGRectMake(x, _bubbleViewF.origin.y + bubblePadding, chateLabelSize.width, chateLabelSize.height);
        }
        else if (model.message.contentType == MES_CHATCONTENT_TYPE_PIC) { // 图片
            CGSize imageSize = CGSizeMake(40, 40);
            UIImage *image;//   = [UIImage imageWithContentsOfFile:[[ICMediaManager sharedManager] imagePathWithName:model.mediaPath.lastPathComponent]];
            if (model.message.localImageKey) {
                image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:model.message.localImageKey];
            }
            if (image) {
                imageSize          = [self handleImage:image.size];
            } else {
                //先从缓存中取图片
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:model.message.sourceUrl]];
                SDImageCache* cache = [SDImageCache sharedImageCache];
                //此方法会先从memory中取。
                UIImage *cacheImage = [cache imageFromDiskCacheForKey:key];
                if (cacheImage) {  //如果缓存中有图片
                    imageSize          = [self handleImage:cacheImage.size];  //获取缓存图片的大小
                } else {
                     imageSize = CGSizeMake(130, 190);  //给出默认图片大小
                }
            }
            imageSize.width        = imageSize.width > timeSize.width ? imageSize.width : timeSize.width;
            CGFloat bubbleX        = CGRectGetMinX(_headImageViewF)-headToBubble-imageSize.width;
            _bubbleViewF           = CGRectMake(bubbleX, cellMargin+topViewH+nameLabelSize.height, imageSize.width, imageSize.height);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _picViewF              = CGRectMake(x,  _bubbleViewF.origin.y, imageSize.width, imageSize.height);
        }
        else if (model.message.contentType == MES_CHATCONTENT_TYPE_AUDIO) { // 语音消息
            CGFloat bubbleViewMinW     = 60;
            CGFloat perSecondWidth = 10;
            CGFloat bubbleViewMaxWidth = 200;
            CGFloat voiceViewTrueW = bubbleViewMinW+perSecondWidth*model.message.voiceLength;
            CGFloat bubbleViewW = voiceViewTrueW>bubbleViewMaxWidth?bubbleViewMaxWidth:voiceViewTrueW;
            _bubbleViewF = CGRectMake(CGRectGetMinX(_headImageViewF) - headToBubble - bubbleViewW, cellMargin+topViewH+nameLabelSize.height, bubbleViewW, 40);
//            _topViewF               = CGRectMake(CGRectGetMinX(_bubbleViewF), cellMargin, bubbleViewW - arrowWidth, topViewH);
            _durationLabelF         = CGRectMake(CGRectGetMinX(_bubbleViewF)+ bubblePadding , 10+_bubbleViewF.origin.y, 50, 20);
            _voiceIconF = CGRectMake(CGRectGetMaxX(_bubbleViewF) - 22, 10 + _bubbleViewF.origin.y, 11, 16.5);// - 20
        }
        else if (model.message.contentType == MES_CHATCONTENT_TYPE_VIDEO) { // 视频信息
            CGSize imageSize       = CGSizeMake(150, 150);
            UIImage *videoImage = model.message.sourceLocalPath?[Utils getVideoThumbImage:model.message.sourceLocalPath]:nil;
            if (videoImage) {
                float scale        = videoImage.size.height/videoImage.size.width;
                imageSize = CGSizeMake(150, 140*scale);
            }
            CGSize bubbleSize = CGSizeMake(imageSize.width, imageSize.height);
            _bubbleViewF = CGRectMake(CGRectGetMinX(_headImageViewF)-headToBubble-bubbleSize.width, cellMargin+topViewH+nameLabelSize.height, bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(imageSize.width-arrowWidth, topViewH);
            _picViewF              = CGRectMake(CGRectGetMinX(_bubbleViewF), CGRectGetMinY(_bubbleViewF), imageSize.width, imageSize.height);
        } else if (model.message.contentType == MES_CHATCONTENT_TYPE_REDPACK){  //红包信息
            CGSize bubbleSize     = CGSizeMake(250 + arrowWidth, 70 + bubblePadding * 2);
            _bubbleViewF          = CGRectMake(CGRectGetMinX(_headImageViewF) - headToBubble - bubbleSize.width, cellMargin+topViewH+nameLabelSize.height, bubbleSize.width, bubbleSize.height);
        }
        CGFloat activityX = _bubbleViewF.origin.x-40;
        CGFloat activityY = (_bubbleViewF.origin.y + _bubbleViewF.size.height)/2 - 5;
        CGFloat activityW = 40;
        CGFloat activityH = 40;
        _activityF        = CGRectMake(activityX, activityY, activityW, activityH);
        _retryButtonF     = _activityF;
    } else {    // 接收者
        _headImageViewF   = CGRectMake(headToView, cellMargin, headWidth, headWidth);
        CGSize nameSize       = CGSizeMake(0, 0);
        cellMinW = nameSize.width + 6 + timeSize.width; // 最小宽度
        CGSize nameLabelSize = [model.message.from sizeWithMaxWidth:chatLabelMax andFont:SenderNameFont];
        _nameLabelF = CGRectMake(CGRectGetMaxX(_headImageViewF) + headToBubble + arrowWidth, cellMargin, nameLabelSize.width, nameLabelSize.height);
        if (model.message.contentType == MES_CHATCONTENT_TYPE_TEXT) {
            model.message.attributContent = [self isContantEmojiWithString:model.message.content];
            CGSize chateLabelSize = CGSizeZero;
            if (model.message.attributContent) {
                UILabel *tempLab = [UILabel fastLabWithTitle:@"" andTitleFont:MessageFont andTitleColor:[UIColor clearColor]];
                tempLab.numberOfLines = 0;
                tempLab.attributedText =model.message.attributContent;
                chateLabelSize = [tempLab sizeThatFits:CGSizeMake(chatLabelMax, MAXFLOAT)];
            }else{
                chateLabelSize = [model.message.content sizeWithMaxWidth:chatLabelMax andFont:MessageFont];
            }
            CGSize topViewSize    = CGSizeMake(cellMinW+bubblePadding*2, topViewH);
            CGSize bubbleSize = CGSizeMake(chateLabelSize.width + bubblePadding * 2 + arrowWidth, chateLabelSize.height + bubblePadding * 2);
            _bubbleViewF  = CGRectMake(CGRectGetMaxX(_headImageViewF) + headToBubble, cellMargin+topViewH+nameLabelSize.height, bubbleSize.width, bubbleSize.height);
            CGFloat x     = CGRectGetMinX(_bubbleViewF) + bubblePadding + arrowWidth;
//            _topViewF     = CGRectMake(CGRectGetMinX(_bubbleViewF)+arrowWidth, cellMargin, topViewSize.width, topViewSize.height);
            _chatLabelF   = CGRectMake(x, _bubbleViewF.origin.y+bubblePadding, chateLabelSize.width, chateLabelSize.height);
        }
        else if (model.message.contentType == MES_CHATCONTENT_TYPE_PIC) {
            CGSize imageSize = CGSizeMake(40, 40);
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:model.message.sourceUrl]];
            SDImageCache* cache = [SDImageCache sharedImageCache];
            //此方法会先从memory中取。
            UIImage *cacheImage = [cache imageFromDiskCacheForKey:key];
            if (cacheImage) {  //如果缓存中有图片
                imageSize          = [self handleImage:cacheImage.size];  //获取缓存图片的大小
            } else {
                imageSize = CGSizeMake(130, 190);  //给出默认图片大小
            }

//            UIImage *image   = [UIImage imageWithContentsOfFile:[[ICMediaManager sharedManager] imagePathWithName:model.mediaPath.lastPathComponent]];
//            if (image) {
//                imageSize = [self handleImage:image.size];
//            }
            imageSize.width        = imageSize.width > cellMinW ? imageSize.width : cellMinW;
            CGSize topViewSize     = CGSizeMake(imageSize.width-arrowWidth, topViewH);
            CGSize bubbleSize      = CGSizeMake(imageSize.width, imageSize.height);
            CGFloat bubbleX        = CGRectGetMaxX(_headImageViewF)+headToBubble;
            _bubbleViewF           = CGRectMake(bubbleX, cellMargin+topViewH+nameLabelSize.height, bubbleSize.width, bubbleSize.height);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
//            _topViewF              = CGRectMake(x+arrowWidth, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, _bubbleViewF.origin.y, imageSize.width, imageSize.height);
            
        }
        else if (model.message.contentType == MES_CHATCONTENT_TYPE_AUDIO) {   // 语音
            CGFloat bubbleViewMinW     = 60;
            CGFloat perSecondWidth = 10;
            CGFloat bubbleViewMaxWidth = 200;
            CGFloat voiceViewTrueW = bubbleViewMinW+perSecondWidth*model.message.voiceLength;
            CGFloat bubbleViewWWithNotRedView = voiceViewTrueW>bubbleViewMaxWidth?bubbleViewMaxWidth:voiceViewTrueW;
            CGFloat bubbleViewW = bubbleViewWWithNotRedView + 20; // 加上一个红点的宽度
            CGFloat voiceToBull = 5;
            
            _bubbleViewF = CGRectMake(CGRectGetMaxX(_headImageViewF) + headToBubble, cellMargin+topViewH+nameLabelSize.height, bubbleViewW, 40);
//            _topViewF    = CGRectMake(CGRectGetMinX(_bubbleViewF)+arrowWidth, cellMargin, bubbleViewW-arrowWidth, topViewH);
            _voiceIconF = CGRectMake(CGRectGetMinX(_bubbleViewF)+arrowWidth+bubblePadding, 10 + _bubbleViewF.origin.y, 11, 16.5);
            
            NSString *duraStr = [NSString stringWithFormat:@"%ld''  ",(long)self.model.message.voiceLength];
            CGSize durSize = [duraStr sizeWithMaxWidth:chatLabelMax andFont:[UIFont systemFontOfSize:14]];
            _durationLabelF = CGRectMake(CGRectGetMaxX(_bubbleViewF) - voiceToBull - durSize.width, 10 + _bubbleViewF.origin.y, durSize.width, durSize.height);
            _redViewF = CGRectMake(CGRectGetMaxX(_bubbleViewF) + 6, CGRectGetMinY(_bubbleViewF) + _bubbleViewF.size.height*0.5-4, 8, 8);
        }
        else if (model.message.contentType == MES_CHATCONTENT_TYPE_VIDEO) {   // 视频
            CGSize imageSize       = CGSizeMake(150, 150);
            CGSize bubbleSize = CGSizeMake(imageSize.width, imageSize.height+topViewH);
            _bubbleViewF = CGRectMake(CGRectGetMaxX(_headImageViewF)+headToBubble, cellMargin+topViewH+nameLabelSize.height , bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(imageSize.width-arrowWidth, topViewH);
            _picViewF              = CGRectMake(CGRectGetMinX(_bubbleViewF), CGRectGetMinY(_bubbleViewF), imageSize.width, imageSize.height);
        } else if (model.message.contentType == MES_CHATCONTENT_TYPE_REDPACK) {
            CGSize bubbleSize = CGSizeMake(250 + arrowWidth, 70 + bubblePadding * 2);
            _bubbleViewF  = CGRectMake(CGRectGetMaxX(_headImageViewF) + headToBubble, cellMargin+topViewH+nameLabelSize.height, bubbleSize.width, bubbleSize.height);
            CGFloat x     = CGRectGetMinX(_bubbleViewF) + bubblePadding + arrowWidth;
        }
    }
    _cellHight = MAX(CGRectGetMaxY(_bubbleViewF), CGRectGetMaxY(_headImageViewF)) + 10;
}

// 缩放，临时的方法
- (CGSize)handleImage:(CGSize)retSize
{
    CGFloat scaleH = 0.22;
    CGFloat scaleW = 0.38;
    CGFloat height = 0;
    CGFloat width = 0;
    if (retSize.height / APP_HEIGHT + 0.16 > retSize.width / APP_WIDTH) {
        height = APP_HEIGHT * scaleH;
        width = retSize.width / retSize.height * height;
    } else {
        width = APP_WIDTH * scaleW;
        height = retSize.height / retSize.width * width;
    }
    return CGSizeMake(width, height);
}

#pragma mark -- 带表情判断
-(NSMutableAttributedString *)isContantEmojiWithString:(NSString *)contentText{
    if ( STRING_ISNIL(contentText)) {
        return nil;
    }
    NSString *pattern = @"\\[[a-z0-9-_]+\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *matches = [regex matchesInString:contentText options:0 range:NSMakeRange(0, contentText.length)];
    
    if (!matches.count) return nil; // 纯文本
    
    NSMutableArray *emojiStrArray=[[NSMutableArray alloc]initWithCapacity:1];
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:0];
    NSUInteger lastIdx = 0;
    
    for (NSTextCheckingResult* match in matches){
        NSRange range = match.range;
        if (range.location > lastIdx){
            NSString  *temp = [contentText substringWithRange:NSMakeRange(lastIdx, range.location - lastIdx)];
            [resultStr appendString:temp];
            [emojiStrArray addObject:temp];
        }
        NSString *text = [contentText substringWithRange:[match rangeAtIndex:0]];
        [emojiStrArray addObject:text];
        NSString *atName = [NSString stringWithFormat:@"@%@",text];
        [resultStr appendString:atName];
        lastIdx = range.location + range.length;
    }
    //看不懂这一步
    if (lastIdx < contentText.length){
        NSString  *temp = [contentText substringFromIndex:lastIdx];
        [resultStr appendString:temp];
        [emojiStrArray addObject:temp];
    }

    
    //段落属性
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentLeft;
    style.lineSpacing = 5.0f;
    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc]initWithString:@"" attributes:@{ NSParagraphStyleAttributeName : style}];

    
    for (NSString *string in emojiStrArray) {
        if([string isEqualToString:@""])
        {
            continue;
        }
        NSString *itemStr  = [NSString stringWithFormat:@"%@",string];
        
        BOOL isEmotion = false;
        if (itemStr.length>=9 && [[itemStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"["] &&[[itemStr substringWithRange:NSMakeRange(itemStr.length-1, 1)] isEqualToString:@"]"]&&[[itemStr substringWithRange:NSMakeRange(1, 6)] isEqualToString:@"emoji_"]) {
            NSString *itemStrF =  [itemStr substringFromIndex:7];
            NSString *itemStrT = [itemStrF substringToIndex:itemStrF.length -1 ];
            NSLog(@"emoji --%@",itemStrT);
            NSScanner* scan = [NSScanner scannerWithString:itemStrT];
            int val;
            if ( [scan scanInt:&val] && [scan isAtEnd]) {// 纯数字
                HWEmotion *emotion = [[HWEmotion alloc]init];
                emotion.png = [NSString stringWithFormat:@"emoji_%@",itemStrT];
                HWEmotionAttachment *attch = [[HWEmotionAttachment alloc] init];
                // 传递模型
                attch.emotion = emotion;
                // 设置图片的尺寸，因为新增的一套图标尺寸和原来的图标边缘空白不一样，为了使得最后的视觉效果一样大小，在这里做特殊控制。
                CGFloat attchWH = 21;
                CGFloat offset = -4;
                if ([[emotion.png substringFromIndex:6] intValue]>=100 ||
                    [[emotion.png substringToIndex:2] isEqualToString:@"m_"]) {
                    attchWH = 28;
                    offset = -9;
                }
                // 根据附件创建一个属性文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
                [atrString appendAttributedString:imageStr];
                isEmotion = true;
            }
        }
        
        if (!isEmotion) {
            //段落属性
            NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.lineSpacing = 5.0f;
            NSMutableAttributedString *subStr =[[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:MessageFont,NSForegroundColorAttributeName:XZRGB(0x282724)}];
            [atrString appendAttributedString: subStr];
            CGRect rect = [subStr boundingRectWithSize:CGSizeMake(255, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        }
    }
    
    
    return atrString;
}

@end
