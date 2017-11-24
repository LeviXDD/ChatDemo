//
//  NSString+Category.h
//  Chanel
//
//  Created by andy on 2016/10/15.
//  Copyright © 2016年 AventLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSMutableAttributedString(Category)
- (NSAttributedString*)formatMentionedUser;
@end

@interface NSString(Category)
- (NSString*)replaceSingleQuotation;
- (BOOL)isMentionByNickName:(NSString*)nickName;
- (NSMutableArray*)getMentionArray;
+ (NSString *)md5:(NSString *)str;
@end
