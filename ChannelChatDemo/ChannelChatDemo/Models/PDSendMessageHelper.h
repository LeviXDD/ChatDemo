//
//  PDSendMessageHelper.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDMessageFrame.h"
#import "PDLocalMessageModel.h"
@class PDProdecedModel;

//NSString *const PDChatTypeText        = @"PDChatTypeText";
//NSString *const PDChatTypeVoice       = @"PDChatTypeVoice";
//NSString *const PDChatTypePic         = @"PDChatTypePic";
//NSString *const PDChatTypeVideo       = @"PDChatTypeVideo";

@interface PDSendMessageHelper : NSObject
/**
 *  创建一条本地消息
 *
 *  @param type    消息类型
 *  @param content 文本消息内容
 *
 *  @return 一条消息的ICMessageFrame
 */
+ (PDMessageFrame *)createMessageFrameWithContentType:(MES_CHATCONTENT_TYPE )contentType
                                            locaMsgId:(NSString*)localMsgId
                                              content:(NSString *)content
                                            timeStamp:(NSString*)timeStamp
                                                 from:(NSString *)from
                                                   to:(NSString *)to
                                             userIcon:(NSString*)userIcon
                                             isSender:(BOOL)isSender
                                                 uuid:(NSString*)uuid
                                        sendingStatus:(PDMessageDeliveryState)sendingStatus;


/**
 生成本地图片消息体

 @param sendTimeStamp 发送时间
 @param from 发送者
 @param userIcon 发送用户头像
 @param imageUrl 发送图片的Url
 @param imageLocalKey 发送图片本地存储的key（通过SDImageCache进行存储）
 @param isSender 是否为发送者本人
 @param sendingStatus 消息体发送状态
 @return 消息体
 */
+ (PDMessageFrame *)createPictureMessageWithSendTimeStamp:(NSString*)sendTimeStamp
                                                locaMsgId:(NSString*)localMsgId
                                                     from:(NSString *)from
                                                 userIcon:(NSString*)userIcon
                                                 imageUrl:(NSString*)imageUrl
                                            imageLocalKey:(NSString*)imageLocalKey
                                                 isSender:(BOOL)isSender
                                            sendingStatus:(PDMessageDeliveryState)sendingStatus
                                                     uuid:(NSString *)uuid
                                                   isSite:(BOOL)isSite;

//生成语音消息体
+ (PDMessageFrame *)createVoiceMessageWithTimeStamp:(NSString*)timeStamp
                                                 from:(NSString *)from
                                             userIcon:(NSString*)userIcon
                                    localSourcePath:(NSString*)localSourcePath
                                        voiceLength:(NSInteger)voiceLength
                                             sourceUrl:(NSString*)sourceUrl
                                             isSender:(BOOL)isSender
                                        sendingStatus:(PDMessageDeliveryState)sendingStatus
                                               uuid:uuid
                                             isSite:(BOOL)isSite;

//生成视频消息体
+ (PDMessageFrame *)createVedioMessageWithSendTimeStamp:(NSString*)sendTimeStamp
                                              locaMsgId:(NSString*)localMsgId
                                                   from:(NSString *)from
                                               userIcon:(NSString*)userIcon
                                        localSourcePath:(NSString*)localSourcePath
                                              sourceUrl:(NSString*)sourceUrl
                                               isSender:(BOOL)isSender
                                          sendingStatus:(PDMessageDeliveryState)sendingStatus
                                                   uuid:(NSString *)uuid
                                                 isSite:(BOOL)isSite;

//生成公告消息体

//生成系统信息消息体
+ (PDMessageFrame *)createSystemMessageWithSendContent:(NSString *)content
                                                  uuid:(NSString *)uuid
                                              sendTime:(NSString *)sendTime;

//创建红包消息体
+ (PDMessageFrame *)createRedPacketMsgFrameModelWithMsgModel:(PDProdecedModel*)model isSite:(BOOL)isSite;
//构建公告牌消息体
+ (PDMessageFrame *)createNoticeBoardFrameModelWithMsgModel:(PDProdecedModel*)model;
// 坐标转换到窗口中的位置
+ (CGRect)photoFramInWindow:(UIButton *)photoView;
@end
