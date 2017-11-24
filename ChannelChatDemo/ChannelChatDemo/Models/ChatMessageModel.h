//
//  NJMessageModel.h
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    NJMessageModelTypeMe = 0,
    NJMessageModelTypeOther
}NJMessageModelType;

@interface ChatMessageModel : NSObject
/**
 *  正文
 */
@property (nonatomic, copy) NSString *text;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSMutableAttributedString *textAttributedString;
/**
 *  消息类型
 */
@property (nonatomic, assign) NJMessageModelType type;//0:是自己发的，1是别人发的
/**
 *  是否隐藏时间
 */
@property (nonatomic, assign) BOOL hiddenTime;

//@property(nonatomic,assign) int messageType;

@property(nonatomic,copy) NSString *fileUrl;
@property(nonatomic,copy) NSString *thumbnailUrl;
@property (nonatomic,copy)NSString *messageId;
@property(nonatomic,copy) NSString *fileLength;
@property (nonatomic,copy)NSString *chatType;//1是私聊、2是群聊
@property (nonatomic,copy)NSString *messageType;//10是聊天消息
@property(nonatomic,assign)int TextType; // 1，文字，2图片等
@property (nonatomic,assign)BOOL isMe;

@property(nonatomic ,assign)BOOL isSite;
@property (nonatomic,copy)NSString *voiceLength;
@property (nonatomic,assign)BOOL isSuccess;
@property (nonatomic,copy)NSString *localPath;
@property (nonatomic,copy)NSString *httpPath;
@property (nonatomic,copy)NSString *userIcon;
@property (nonatomic,copy)NSString *fromUserId;
@property (nonatomic,copy)NSString *fromUserName;

@property (nonatomic,copy)NSString *chatId;
@property(nonatomic,copy)NSString *channelId;
@property(nonatomic,copy)NSString *rpId;
@property(nonatomic,copy)NSString *rpType;
@property(nonatomic,copy)NSString *needSignin;
@property(nonatomic,copy)NSString *arFlag;
@property (nonatomic,copy)NSString *descriptioninfo;
@property (nonatomic,copy)NSString *totalAmount;
@property (nonatomic,copy)NSString *totalNum;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,copy)NSString *channelName;
@property (nonatomic,copy)NSString *informMessage;
@property (nonatomic,copy)NSString *amount;
@property (nonatomic,copy)NSString *wayDesc;
@property (nonatomic,copy)NSString *reason;
@property (nonatomic,copy)NSString *order;
@property (nonatomic,copy)NSString *withDrawsTime;
@property (nonatomic,copy)NSString *completeTime;
@property (nonatomic,copy)NSString *wayType;
@property (nonatomic,copy)NSString *timeforreturn;//退款时间
@property (nonatomic,copy)NSString *targetUserId;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)chatMessageWithDict:(NSDictionary *)dict;

@end
