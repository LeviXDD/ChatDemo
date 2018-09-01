//
//  NJMessageFrameModel.m
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ChatMessageFrameModel.h"
#import "ChatMessageModel.h"
#import "NSString+Extension.h"
#import "HWEmotion.h"
#import "HWEmotionAttachment.h"
//#import "RegexKitLite.h"
#import "NSString+FilePath.h"
@implementation ChatMessageFrameModel
-(void)setMessage:(ChatMessageModel *)message
{
    _message = message;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat padding = 10;
    
    CGFloat timeX = 0;
    CGFloat timeY = 20;
    CGFloat timeH = 20;
    CGFloat timeW = screenWidth;
    
    int messageType = [message.messageType intValue];
    if ( messageType != 10&&messageType!=27)
    {
        _cellHeight = 30;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
        
        //频道提醒消息
        if (messageType == 100) {
            _cellHeight = 340;
            _tipF = CGRectMake((screenWidth-320)/2, 5, 320, 220);
        }else if(messageType == 38){
            _cellHeight = (SCREEN_WIDTH - 76) * 1.39 + 10;
            _tipF = CGRectMake((SCREEN_WIDTH-320)/2, 5, 320, 220);
        }
        return;
    }
    
    // 1.时间
    if (NO == message.hiddenTime) { // 是否需要计算时间的frame
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 2.头像
    CGFloat iconH = 35;
    CGFloat iconW = 35;
    CGFloat iconY = CGRectGetMaxY(_timeF) ;
    
    CGFloat iconX = 0;
    if (NJMessageModelTypeMe == _message.type) {// 自己发的
        // x = 屏幕宽度 - 间隙 - 头像宽度
        iconX = screenWidth - padding - iconW;
    }else
    {
        // 别人发的
        iconX = padding;
    }
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 图像
    if (message.TextType == 2)  {
        UIImageView *testV = [UIImageView new];
        __block  CGFloat imageW = 140;
        __block  CGFloat imageH = 140;
        CGFloat imageY = iconY +20;
        CGFloat imageX = 0;
        if (NJMessageModelTypeMe == _message.type) {
            // 自己发的
            // x = 头像x - 间隙 - 文本的宽度
            imageX = iconX - padding - imageW;
            _nameF = CGRectMake(iconX - padding - 100, iconY, 100, 15);
        }else
        {
            // 别人发的
            // x = 头像最大的X + 间隙
            imageX = CGRectGetMaxX(_iconF) + padding;
            _nameF = CGRectMake(imageX, iconY, 100, 15);
        }
        
        _imageF = CGRectMake(imageX, imageY, imageW, imageH);
        
        // 4.行高
        CGFloat maxIconY = CGRectGetMaxY(_iconF) ;
        CGFloat maxImageY = CGRectGetMaxY(_imageF) ;
        
        _cellHeight = MAX(maxIconY, maxImageY) + padding;
        return;
    }else if(message.TextType == 3){
        int voiceLength = _message.fileLength.intValue;
        // 声音长度最大为60，最小长度是70
        CGFloat textW = voiceLength / 60.0 *(SCREEN_WIDTH - ( iconH + 4 * padding))*0.8 + 30;
        if (voiceLength <= 2) {
            textW = 50;
        }
        //        CGFloat textH = NJEdgeInsetsWidth * 2;
        CGFloat textH = 20 * 2;
        
        CGFloat textY = iconY + 20;
        CGFloat textX = 0;
        if (NJMessageModelTypeMe == _message.type) {
            // 自己发的
            // x = 头像x - 间隙 - 文本的宽度
            textX = iconX - padding - textW;
            _nameF = CGRectMake(iconX - padding - 100, iconY, 100, 15);
        }else
        {
            // 别人发的
            // x = 头像最大的X + 间隙
            textX = CGRectGetMaxX(_iconF) + padding;
            _nameF = CGRectMake(textX, iconY, 100, 15);
        }
        //  _nameF = CGRectMake(textX, iconY, 100, 15);
        _textF = CGRectMake(textX, textY, textW, textH);
        
        // 4.行高
        CGFloat maxIconY = CGRectGetMaxY(_iconF);
        CGFloat maxTextY = CGRectGetMaxY(_textF);
        
        _cellHeight = MAX(maxIconY, maxTextY) + padding;
        CGFloat playSoundImageViewH = 20;
        CGFloat playSoundImageViewX = 40;
        CGFloat playSoundImageViewY = 10;
        CGFloat playSoundImageViewW = 20;
        if (_message.isMe) {
            playSoundImageViewX = _textF.size.width - 40;
        }else{
            playSoundImageViewX = 20;
        }
        _playSoundImageViewF = CGRectMake(playSoundImageViewX, playSoundImageViewY, playSoundImageViewW, playSoundImageViewH);
        
        CGFloat soundProgressH = _textF.size.height;
        CGFloat soundProgressX = 0;
        CGFloat soundProgressY = _textF.origin.y;
        CGFloat soundProgressW = soundProgressH;
        if (_message.isMe) {
            soundProgressX = CGRectGetMinX(_textF) - 35;
        }else{
            soundProgressX = CGRectGetMaxX(_textF) + 5;
        }
        
        soundProgressX -= 10;
        _soundProgressF = CGRectMake(soundProgressX, soundProgressY, soundProgressW, soundProgressH);
        
        return;
        
    }else if(message.TextType == 4){
        CGFloat videoW = 150;
        CGFloat videoH = 150;
        CGFloat videoY = iconY + 20;
        CGFloat videoX = 0;
        if (_message.isMe) {
            videoX = iconX - padding - videoW;
            _nameF = CGRectMake(iconX - padding - 100, iconY, 100, 15);
        }else{
            videoX = CGRectGetMaxX(_iconF) + padding;
            _nameF = CGRectMake(videoX, iconY, 100, 15);
        }
        
        //  _nameF = CGRectMake(videoX, iconY, 100, 15);
        _playVideoF = CGRectMake(videoX, videoY, videoW, videoH);
        // 4.行高
        CGFloat maxIconY = CGRectGetMaxY(_iconF);
        CGFloat maxImageY = CGRectGetMaxY(_playVideoF);
        
        _cellHeight = MAX(maxIconY, maxImageY) + padding;
        return;
        
    }
    else if (message.TextType==5){
        CGFloat imageW = screenWidth-52*2-20;
        CGFloat imageH = 90;
        CGFloat imageY = iconY + 20;
        CGFloat imageX = 0;
        if (NJMessageModelTypeMe == _message.type) {
            // 自己发的
            // x = 头像x - 间隙 - 文本的宽度
            imageX = iconX - padding - imageW;
            _nameF = CGRectMake(iconX - padding - 100, iconY, 100, 15);
        }else
        {
            // 别人发的
            // x = 头像最大的X + 间隙
            imageX = CGRectGetMaxX(_iconF) + padding;
            _nameF = CGRectMake(imageX, iconY, 100, 15);
        }
        
        _textF = CGRectMake(imageX, imageY + 10, imageW, imageH);
        // 4.行高
        CGFloat maxIconY = CGRectGetMaxY(_iconF) ;
        CGFloat maxImageY = CGRectGetMaxY(_textF) ;
        
        _cellHeight = MAX(maxIconY, maxImageY) + padding;
        return;
    }
    
    // 3.正文
    CGSize maxSize = CGSizeMake(255, MAXFLOAT);
#warning iOS客户端在回车发送的时候在text中会默认包含'\n'字符，需要将其去掉，否则在显示的时候计算的高度过高
    NSString *userSendText = [_message.text substringWithRange:NSMakeRange(_message.text.length - 1, 1)];
    if ([userSendText isEqualToString:@"\n"]) {
        _message.text = [_message.text substringWithRange:NSMakeRange(0, _message.text.length - 1)];
    }
    CGSize textSize = [_message.text sizeWithFont:NJTextFont maxSize:maxSize];
    
    NSArray *returnArray = [_message.text componentsSeparatedByString:@"\r"];
    NSArray *newLineArray = [_message.text componentsSeparatedByString:@"\n"];
    NSInteger newLineCount = returnArray.count + newLineArray.count - 2;
    textSize.height = textSize.height + newLineCount * 25;
    
    CGFloat textW = 20 * 2;
    CGFloat textH = 15 +  20 * 2;
   
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:1];
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:0];
    NSString *pattern = @"\\[[a-z0-9-_]+\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *matches = [regex matchesInString:_message.text options:0 range:NSMakeRange(0, _message.text.length)];
    NSUInteger lastIdx = 0;
    
    for (NSTextCheckingResult* match in matches) {
        NSRange range = match.range;
        if (range.location > lastIdx)
        {
            NSString  *temp = [_message.text substringWithRange:NSMakeRange(lastIdx, range.location - lastIdx)];
            [resultStr appendString:temp];
            [array addObject:temp];
        }
        
        NSString *text = [_message.text substringWithRange:[match rangeAtIndex:0]];
        [array addObject:text];
        NSString *atName = [NSString stringWithFormat:@"@%@",text];
        [resultStr appendString:atName];
        lastIdx = range.location + range.length;
        
    }
    
    if (lastIdx < _message.text.length)
    {
        NSString  *temp = [_message.text substringFromIndex:lastIdx];
        [resultStr appendString:temp];
        [array addObject:temp];
    }
    
    if(array.count == 1)
    {
        textW = textSize.width + NJEdgeInsetsLeftRight * 2;
        textH = 20 + NJEdgeInsetsTopBottom * 2 + newLineCount * 20;
        
    }else
    {
        //        textW = 5 * 2;
        //        textH = 15 +  5 * 2;
        //段落属性
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentLeft;
        style.lineSpacing = 5.0f;
        NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc]initWithString:@"" attributes:@{ NSParagraphStyleAttributeName : style}];
        for (NSString *string in array) {
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
                    //                    NSString *a=[emotion.png substringFromIndex:6];
                    if ([[emotion.png substringFromIndex:6] intValue]>=100 ||
                        [[emotion.png substringToIndex:2] isEqualToString:@"m_"]) {
                        attchWH = 28;
                        offset = -9;
                    }
                    
                    // 根据附件创建一个属性文字
                    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
                    [atrString appendAttributedString:imageStr];
                    
                    isEmotion = true;
                    
                    textW = textW + attch.bounds.size.width;

                }
            }
            if (!isEmotion) {
                //                NSAttributedString *subStr = [[NSAttributedString alloc]initWithString:string];
                //段落属性
                NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                style.lineSpacing = 5.0f;
                NSMutableAttributedString *subStr =[[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
                //
                [atrString appendAttributedString: subStr];
                
                CGRect rect = [subStr boundingRectWithSize:CGSizeMake(255, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                
                textW = textW + ceilf(rect.size.width);
            }
            
            if(textW<=255)
                textH = 28 + NJEdgeInsetsTopBottom * 2 + newLineCount * 20;
        }
//        [atrString setAttributes:@{ NSParagraphStyleAttributeName : style} range:NSMakeRange (0, atrString.length)];
        _message.textAttributedString = atrString;
    }
    CGFloat textY = iconY + 20;
    CGFloat textX = 0;
    CGSize theSize;
    if (_message.textAttributedString) {
//        theSize = [_message.textAttributedString boundingRectWithSize:CGSizeMake(255, 10000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        theSize = [self sizeLabelToFit:_message.textAttributedString width:255 height:10000];
    }else{
        theSize = [_message.text boundingRectWithSize: CGSizeMake(255, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size;
    }
    textW = theSize.width;
    textH = theSize.height;
    CGFloat textImageX ;
    CGFloat textImageY ;
    if (NJMessageModelTypeMe == _message.type) {
        // 自己发的
        // x = 头像x - 间隙 - 文本的宽度
        textX = iconX - padding - textW -14-7;
        _nameF = CGRectMake(iconX - padding - 100, iconY, 100, 15);
        textY += 10;
        
        textImageX = textX - 14;
        textImageY = textY - 10 ;
        _resendF = CGRectMake(textImageX - 40, textY, 40, textH);

    }else
    {
        // 别人发的
        // x = 头像最大的X + 间隙
        textImageX = CGRectGetMaxX(_iconF) + padding;
        textX = textImageX + 14+7;
        _nameF = CGRectMake(textImageX, iconY, 100, 15);
        _resendF = CGRectMake(textX  + textW, textY,40, textH);
        textY += 10;
        textImageY =  textY - 10;
    }

    _textF = CGRectMake(textX, textY, textW, textH);
    _textImageVF = CGRectMake(textImageX, textImageY, textW+35, textH + 20);
    // 4.行高
    CGFloat maxIconY = CGRectGetMaxY(_iconF);
    CGFloat maxTextY = CGRectGetMaxY(_textImageVF);
    
    _cellHeight = MAX(maxIconY, maxTextY)+padding;
}

-(CGSize)sizeLabelToFit:(NSAttributedString *)aString width:(CGFloat)width height:(CGFloat)height {
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tempLabel.attributedText = aString;
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    CGSize size = tempLabel.frame.size;
    size = CGSizeMake(ceil(size.width),ceil(size.height));
    return size;
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}
@end
