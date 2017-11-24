//
//  NSString+Category.m
//  Chanel
//
//  Created by andy on 2016/10/15.
//  Copyright © 2016年 AventLabs. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSMutableAttributedString (Category)
- (NSAttributedString*)formatMentionedUser{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@[\u4e00-\u9fa5_a-zA-Z0-9_]+ " options:kNilOptions error:nil];
    
    NSRange range = NSMakeRange(0,self.length);
    
    [regex enumerateMatchesInString:self.mutableString options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSRange subStringRange = [result rangeAtIndex:0];
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexString:@"ff8400"] range:subStringRange];
    }];

    return self;
}
@end

@implementation NSString(Category)
- (BOOL)isMentionByNickName:(NSString*)nickName{

    NSString *filterStr = [NSString stringWithFormat:@"@%@ ",nickName];
    if ([self containsString:filterStr]) {
        return TRUE;
    }
    return FALSE;
}
- (NSMutableArray*)getMentionArray{
    NSMutableArray *mentionArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@[\u4e00-\u9fa5_a-zA-Z0-9_]+ " options:kNilOptions error:nil];
    
    NSRange range = NSMakeRange(0,self.length);
    [regex enumerateMatchesInString:self options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSRange mentionRange = [result rangeAtIndex:0];
        NSRange newRange = NSMakeRange(mentionRange.location+1, mentionRange.length-2);
        
        NSDictionary *dict = @{@"start":[@(mentionRange.location) stringValue],
                               @"end":[@(mentionRange.location + mentionRange.length) stringValue],
                               @"userId":[self substringWithRange:newRange]};
        [mentionArray addObject:dict];
        
    }];
    
    return mentionArray;
}
- (NSString*)replaceSingleQuotation{
    NSString *resultStr = [self stringByReplacingOccurrencesOfString:@"\'" withString:@"\'\'"];
//    NSLog(@"%@ ----------> %@",self,resultStr);
    return resultStr;
}
//md5 32位 加密 （小写）
#pragma mark - 32位 小写
+(NSString *)md5:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

@end
