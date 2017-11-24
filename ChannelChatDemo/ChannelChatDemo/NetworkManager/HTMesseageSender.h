//
//  HTMesseageSender.h
//  ChannelChatDemo
//
//  Created by 海涛 黎 on 2017/11/24.
//  Copyright © 2017年 Levi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PDLocalMessageModel;
@interface HTMesseageSender : NSObject
+(void)sendMsgWithUserId:(NSString*)userId message:(PDLocalMessageModel*)message success:(void(^)(BOOL success,PDLocalMessageModel *message))success failure:(void(^)(NSError *error,PDLocalMessageModel *message))failure;
@end
