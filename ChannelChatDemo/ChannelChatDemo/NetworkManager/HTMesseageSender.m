//
//  HTMesseageSender.m
//  ChannelChatDemo
//
//  Created by 海涛 黎 on 2017/11/24.
//  Copyright © 2017年 Levi. All rights reserved.
//

#import "HTMesseageSender.h"
#import "PDMessage.h"
#import "PDLocalMessageModel.h"
@implementation HTMesseageSender
+(void)sendMsgWithUserId:(NSString*)userId message:(PDLocalMessageModel*)message success:(void(^)(BOOL success,PDLocalMessageModel *message))success failure:(void(^)(NSError *error,PDLocalMessageModel *message))failure{
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
            success(YES,message);
        }];
    } else {
    }
}
@end
