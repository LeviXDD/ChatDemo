//
//  PDMessage.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDChatServerDefs.h"
#import "PDMessageDefine.h"
//#import "PDRedPacketModel.h"
//#import "PDPostGameModel.h"
//@interface PDRedPacketModel : NSObject
//@property(nonatomic, strong) NSString *sendRedPacketId;
//@property(nonatomic, strong) NSString *sendPeople;
//@property(nonatomic, strong) NSString *totalAmount;
//@property(nonatomic, strong) NSString *description;
//@property(nonatomic, strong) NSString *arFlag;
//@property(nonatomic, strong) NSString *startTime;
//@property(nonatomic, strong) NSString *channelId;
//@property(nonatomic, strong) NSString *totalNum;
//@property(nonatomic, strong) NSString *needSignin;
//@end

@interface PDMessage : NSObject
//消息来源用户id
@property(nonatomic, strong) NSString *userId;
//是否在频道现场
@property(nonatomic, assign) BOOL isSite;
// 消息来源用户名
@property (nonatomic, copy) NSString *senderName;
//用户头像
@property(nonatomic, copy) NSString *userIcon;
// 消息来源用户id
@property (nonatomic, copy) NSString *from;
// 消息目的地群组id
@property (nonatomic, copy) NSString *to;
// 消息ID
@property (nonatomic, copy) NSString *messageId;
// 消息唯一标识
@property (nonatomic, copy) NSString *uuid;
// 消息发送状态
@property (nonatomic, assign) PDMessageDeliveryState deliveryState;
//聊天内容类型
@property(nonatomic, assign) MES_CHATCONTENT_TYPE contentType;
//频道类型
@property(nonatomic, assign) PDChannelType channelType;
//公告牌类型
@property(nonatomic, assign) NOTICEBOARD_TYPE noticeBoardType;
// 语音消息时长
@property (nonatomic, assign) NSInteger voiceLength;
// 本地消息标识:(消息+时间)的MD5
@property (nonatomic, copy) NSString *localMsgId;
// 消息文本内容
@property (nonatomic, copy) NSString *content;
//红包消息
//@property(nonatomic, strong) PDRedPacketModel *redPacketModel;
//游戏消息
//@property(nonatomic, strong) PDPostGameModel *gameModel;

@property (nonatomic, copy) NSAttributedString *attributContent;
// 音频文件的fileKey
//@property (nonatomic, copy) NSString *fileKey;
// 发送消息对应的type类型:1,2,3    100(公告牌)
//@property (nonatomic, copy) NSString *type;
// 时长，宽高，首帧id
@property (nonatomic, strong) NSString *lnk;
//自己发送的图片，以key形式存储到本地，使用SDImageCache取出
@property(nonatomic, strong) NSString *localImageKey;
//图片url
//@property(nonatomic, copy) NSString *imageUrl;
//文件本地存储路径（图片、视频、音频）
@property(nonatomic, copy) NSString *sourceLocalPath;
//文件云端路径
@property(nonatomic, copy) NSString *sourceUrl;
//消息时间戳
@property(nonatomic, strong) NSString *sendTimeStamp;

//消息时间戳
@property(nonatomic, strong) NSString *serverTimeStamp;

//确认图片是否已经被缓存 默认为NO
@property(nonatomic, assign) BOOL isImageCached;
// (0:未读 1:已读 2:撤回)
@property (nonatomic, assign) PDMessageStatus status;
// 展示的时间信息（nil 就是不显示）
@property (nonatomic, assign) NSString *showTimeStr;

@end
