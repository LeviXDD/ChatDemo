//
//  PDSendMessageHelper.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "PDSendMessageHelper.h"
#import "PDMessage.h"

#import "PDChatServerDefs.h"
#import "PDMsgChannelModel.h"
@implementation PDSendMessageHelper
+ (NSInteger)currentMessageTime
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSInteger iTime     = (NSInteger)(time * 1000);
    return iTime;
}

+ (PDMessageFrame *)createVoiceMessageWithTimeStamp:(NSString*)timeStamp
                                               from:(NSString *)from
                                           userIcon:(NSString*)userIcon
                                    localSourcePath:(NSString*)localSourcePath
                                        voiceLength:(NSInteger)voiceLength
                                          sourceUrl:(NSString*)sourceUrl
                                           isSender:(BOOL)isSender
                                      sendingStatus:(PDMessageDeliveryState)sendingStatus
                                               uuid:uuid
                                             isSite:(BOOL)isSite{
    PDMessage *message    = [[PDMessage alloc] init];
    message.from          = from;
    message.voiceLength  = voiceLength;
    message.deliveryState = sendingStatus;
    message.userIcon = userIcon;
    message.sendTimeStamp = timeStamp;
    message.contentType = MES_CHATCONTENT_TYPE_AUDIO;
    message.sourceLocalPath = localSourcePath;
    message.content = @"[语音]";
    message.sourceUrl = sourceUrl;
    message.isSite = isSite;
//    message.type = PD_CHATTYPE_VOICE;
    message.uuid = uuid;
    PDLocalMessageModel *model = [[PDLocalMessageModel alloc] init];
    model.isSender = isSender;
    model.message = message;
    PDMessageFrame *modelF = [[PDMessageFrame alloc] init];
    modelF.model = model;
//    if (isSender) {
//        message.from = [PDMessageWCDBAPI nickNameForSelf];
//    }

    return modelF;
}

/*生成文字消息体*/
+ (PDMessageFrame *)createMessageFrameWithContentType:(MES_CHATCONTENT_TYPE )contentType
                                            locaMsgId:(NSString*)localMsgId
                               content:(NSString *)content
                             timeStamp:(NSString*)timeStamp
                                  from:(NSString *)from
                                    to:(NSString *)to
                              userIcon:(NSString*)userIcon
                              isSender:(BOOL)isSender
                                uuid:(NSString*)uuid
              sendingStatus:(PDMessageDeliveryState)sendingStatus
{
    PDMessage *message    = [[PDMessage alloc] init];
    message.to            = to;
    message.from          = from;
//    message.fileKey       = fileKey;
    // 我默认了一个本机的当前时间，其实没用到，成功后都改成服务器时间了
//    message.date          = [self currentMessageTime];
    message.deliveryState = sendingStatus;
    message.userIcon = userIcon;
    message.localMsgId = localMsgId;
    message.content = content;
    message.sendTimeStamp = timeStamp;
    message.contentType = contentType;
    message.uuid = uuid;
    PDLocalMessageModel *model = [[PDLocalMessageModel alloc] init];
    model.isSender        = isSender;
    model.message = message;
    PDMessageFrame *modelF = [[PDMessageFrame alloc] init];
    modelF.model = model;
    return modelF;
}

+ (PDMessageFrame *)createPictureMessageWithSendTimeStamp:(NSString*)sendTimeStamp
                                                                locaMsgId:(NSString*)localMsgId
                                                                                from:(NSString *)from
                                                                           userIcon:(NSString*)userIcon
                                                                          imageUrl:(NSString*)imageUrl
                                                                 imageLocalKey:(NSString*)imageLocalKey
                                                                           isSender:(BOOL)isSender
                                                                    sendingStatus:(PDMessageDeliveryState)sendingStatus
                                                                    uuid:(NSString *)uuid
                                                    isSite:(BOOL)isSite
{
    PDMessage *message    = [[PDMessage alloc] init];
    message.uuid = uuid;
    message.sendTimeStamp = sendTimeStamp;
    message.from          = from;
    message.localImageKey = imageLocalKey;
    message.sourceUrl = imageUrl;
    message.userIcon = userIcon;
    message.content = @"[图片]";
    message.localMsgId = localMsgId;
    message.contentType = MES_CHATCONTENT_TYPE_PIC;
    message.isSite = isSite;
//    message.type = PD_CHATTYPE_PIC;
    
    PDLocalMessageModel *model = [[PDLocalMessageModel alloc] init];
    model.isSender        = isSender;
    message.deliveryState = sendingStatus;
    model.message = message;
    
    PDMessageFrame *modelF = [[PDMessageFrame alloc] init];
    modelF.model = model;
    
//    if (isSender) {
//        message.from = [PDMessageWCDBAPI nickNameForSelf];
//    }

    return modelF;
}

+ (PDMessageFrame *)createVedioMessageWithSendTimeStamp:(NSString*)sendTimeStamp
                                                locaMsgId:(NSString*)localMsgId
                                                     from:(NSString *)from
                                                 userIcon:(NSString*)userIcon
                                                 localSourcePath:(NSString*)localSourcePath
                                            sourceUrl:(NSString*)sourceUrl
                                                 isSender:(BOOL)isSender
                                            sendingStatus:(PDMessageDeliveryState)sendingStatus
                                                     uuid:(NSString *)uuid
                                                 isSite:(BOOL)isSite
{
    PDMessage *message    = [[PDMessage alloc] init];
    message.uuid = uuid;
    message.sendTimeStamp = sendTimeStamp;
    message.from          = from;
    message.sourceLocalPath = localSourcePath;
    message.sourceUrl = sourceUrl;
    message.userIcon = userIcon;
    message.content = @"[视频]";
    message.localMsgId = localMsgId;
    message.contentType = MES_CHATCONTENT_TYPE_VIDEO;
    message.isSite = isSite;
//    message.type = PD_CHATTYPE_VIDEO;
    
    PDLocalMessageModel *model = [[PDLocalMessageModel alloc] init];
    model.isSender        = isSender;
    message.deliveryState = sendingStatus;
    model.message = message;
    
    PDMessageFrame *modelF = [[PDMessageFrame alloc] init];
    modelF.model = model;
    
//    if (isSender) {
//        message.from = [PDMessageWCDBAPI nickNameForSelf];
//    }
    
    return modelF;
}


+ (PDMessageFrame *)createSystemMessageWithSendContent:(NSString *)content
                                                   uuid:(NSString *)uuid
                                              sendTime:(NSString *)sendTime
{
    PDMessage *message    = [[PDMessage alloc] init];
    message.uuid = uuid;
    message.content = content;
    message.contentType = MES_CHATCONTENT_TYPE_SYS;
//    message.type = PD_CHATTYPE_SYS;
    message.sendTimeStamp = sendTime;
    PDLocalMessageModel *model = [[PDLocalMessageModel alloc] init];
    model.message = message;
    
    PDMessageFrame *modelF = [[PDMessageFrame alloc] init];
    modelF.model = model;
    
    return modelF;
}

//构建红包本地消息体
//+ (PDMessageFrame *)createRedPacketMsgFrameModelWithMsgModel:(PDProdecedModel*)model isSite:(BOOL)isSite{
//    PDMessageFrame *frameModel = [[PDMessageFrame alloc] init];
//
//    PDMessage *messageModel = [[PDMessage alloc] init];
//    BOOL isSender = [model.msMSGModel.fromUserId isEqualToString:[[PDUser sharedInstance] userId]];
//    messageModel.from = model.msMSGModel.fromUserName;
//    messageModel.to = @"";
//    messageModel.deliveryState = PDMessageDeliveryState_Delivered;
//    messageModel.userIcon = model.msMSGModel.fromUserIcon;
//    messageModel.localMsgId = model.msMSGModel.messageId;
//    messageModel.content = @"";
//    messageModel.sendTimeStamp = model.msMSGModel.insertDBTime;
//    messageModel.contentType = MES_CHATCONTENT_TYPE_REDPACK;
//    messageModel.uuid = model.msMSGModel.uuid;
//    messageModel.isSite = isSite;
////    if (isSender) {
////        messageModel.from = [PDMessageWCDBAPI nickNameForSelf];
////    }
//    NSString *redPacketContent = model.msMSGModel.sendContents;
//    PDRedPacketModel *redPacketModel = [PDRedPacketModel mj_objectWithKeyValues:redPacketContent];
//    messageModel.redPacketModel = redPacketModel;
//
//    PDLocalMessageModel *localMsgModel = [[PDLocalMessageModel alloc] init];
//    localMsgModel.isSender        = isSender;
//    localMsgModel.message = messageModel;
//    frameModel.model = localMsgModel;
//    return frameModel;
//}
//
////构建公告牌消息体
//+ (PDMessageFrame *)createNoticeBoardFrameModelWithMsgModel:(PDProdecedModel*)model{
//    PDMessageFrame *modelFrame = [[PDMessageFrame alloc] init];
//
//    PDLocalMessageModel *localModel = [PDLocalMessageModel new];
//    localModel.channelModel = [self dbChannelModelToLocalChannelModel:model.msChannelModel];
//    PDMessage *message = [PDMessage new];
//    message.contentType = MES_CHATCONTENT_TYPE_NOTICEBOARD;
//    message.noticeBoardType = (NOTICEBOARD_TYPE)model.msMSGModel.noticeBoardType;
//    message.channelType = (PDChannelType)[model.msChannelModel.channelType integerValue];
//    message.sendTimeStamp = model.msMSGModel.insertDBTime;
//    message.uuid = model.msMSGModel.uuid;
//    if ((NOTICEBOARD_TYPE)model.msMSGModel.noticeBoardType == NOTICEBOARD_TYPE_COMMEN_CATCHDOLL) {
//        NSString *gameContent = model.msMSGModel.sendContents;
//        PDPostGameModel *gameModel = [PDPostGameModel mj_objectWithKeyValues:gameContent];
//        message.gameModel = gameModel;
//    }
//    localModel.message = message;
//
//    //触发frameModel的setter方法，计算frame
//    modelFrame.model = localModel;
//    return modelFrame;
//}
//
//+(PDMsgChannelModel*)dbChannelModelToLocalChannelModel:(PDMessageChannelModel*)dbChannelModel{
//    PDMsgChannelModel *localChannelModel = [[PDMsgChannelModel alloc] init];
//    localChannelModel.channelId = dbChannelModel.channelId;
//    localChannelModel.channelName = dbChannelModel.channelName;
//    localChannelModel.lon = dbChannelModel.lon;
//    localChannelModel.lat = dbChannelModel.lat;
//    localChannelModel.channelImg = dbChannelModel.channelImg;
//    localChannelModel.personNum = dbChannelModel.personNum;
//    localChannelModel.chatName = dbChannelModel.chatName;
//    localChannelModel.channelType = dbChannelModel.channelType;
//    localChannelModel.myChannelType = dbChannelModel.myChannelType;
//    localChannelModel.roleType = dbChannelModel.roleType;
//    localChannelModel.chatType = dbChannelModel.chatType;
//    localChannelModel.sameTopicFlag = dbChannelModel.sameTopicFlag;
//    localChannelModel.validDistance = dbChannelModel.validDistance;
//    return localChannelModel;
//}

// 图片按钮在窗口中得位置
+ (CGRect)photoFramInWindow:(UIButton *)photoView
{
    return [photoView convertRect:photoView.bounds toView:[UIApplication sharedApplication].keyWindow];
}

// 放大后的图片按钮在窗口中的位置
+ (CGRect)photoLargerInWindow:(UIButton *)photoView
{
    //    CGSize imgSize     = photoView.imageView.image.size;
    CGSize  imgSize    = photoView.currentBackgroundImage.size;
    CGFloat appWidth   = [UIScreen mainScreen].bounds.size.width;
    CGFloat appHeight  = [UIScreen mainScreen].bounds.size.height;
    CGFloat height     = imgSize.height / imgSize.width * appWidth;
    CGFloat photoY     = 0;
    if (height < appHeight) {
        photoY         = (appHeight - height) * 0.5;
    }
    return CGRectMake(0, photoY, appWidth, height);
}
@end
