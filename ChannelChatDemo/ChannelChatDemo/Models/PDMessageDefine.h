//
//  PDMessageDefine.h
//  Chanel
//
//  Created by 徐兆阳 on 17/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark ------------------------------通知类型-----------------------------
#define NOTIFICATION_POST_NEW_MSG  @"NOTIFICATION_POST_NEW_MSG"
#define NOTIFICATION_POST_NEW_ORDER_GODDIE  @"NOTIFICATION_POST_NEW_ORDER_GODDIE"   // 财神消失
#define NOTIFICATION_POST_NEW_MSG_REDPACKET  @"NOTIFICATION_POST_NEW_MSG_REDPACKET"   // 新红包消息
#define NOTIFICATION_POST_CLEAR_MSG  @"NOTIFICATION_POST_CLEAR_MSG"
#define NOTIFICATION_POST_CLEAR_MSG  @"NOTIFICATION_POST_CLEAR_MSG"

#define QUEUE_CON_MSGPRODUCE  "QUEUE_CON_MSGPRODUCE"
#pragma mark ------------------------------======-----------------------------


#pragma mark ------------------------------固定的ChannelId-----------------------------   设置原因: 生活圈、小城故事在首页是以入口形式存在没有channelId
#define STATIC_CHANNELID_LIVECIRCEL  @"STATIC_CHANNELID_LIVECIRCEL"  // 生活圈在频道中固定的ID
#define STATIC_CHANNELID_NO_SAMTOPIC  @"STATIC_CHANNELID_NO_SAMTOPIC"  // 同频入口在频道中固定的ID
#define STATIC_CHANNELID_SIMCITY  @"STATIC_CHANNELID_SIMCITY"             // 小城故事在频道中固定的ID
#pragma mark ------------------------------============-----------------------------


#pragma mark ------------------------------聊天室类型-----------------------------
typedef enum : NSInteger {
     MES_CHAT_TYPE_SIGLE = 1,            // 单聊
     MES_CHAT_TYPE_GROUP                // 群聊
} MES_CHAT_TYPE;                               // 聊天类型
#pragma mark ------------------------------======--------------------------------



#pragma mark ------------------------------聊天消息类型-----------------------------
typedef enum : NSInteger {
    MES_CHATCONTENT_TYPE_TEXT =1,        //文本
    MES_CHATCONTENT_TYPE_PIC ,               // 图片
    MES_CHATCONTENT_TYPE_AUDIO,           // 音频
    MES_CHATCONTENT_TYPE_VIDEO,           // 视频
    MES_CHATCONTENT_TYPE_REDPACK,      // 红包
    MES_CHATCONTENT_TYPE_SYS,               // 系统消息
    MES_CHATCONTENT_TYPE_NOTICEBOARD = 100 //公告牌
} MES_CHATCONTENT_TYPE;                         // 聊天内容的类型
#pragma mark ------------------------------======---------------------------------


#pragma mark ------------------------------公告牌类型-----------------------------
typedef enum : NSInteger {
    NOTICEBOARD_TYPE_COMMEN_FIRST,
    NOTICEBOARD_TYPE_COMMEN_CATCHDOLL,
    NOTICEBOARD_TYPE_SAMETOPIC_FIRST,
    NOTICEBOARD_TYPE_SIMCITY_FIRST,
    NOTICEBOARD_TYPE_SIMCITY_EXIT
} NOTICEBOARD_TYPE;
#pragma mark ------------------------------======--------------------------------


#pragma mark ------------------------------消息体类型类-----------------------------
typedef enum : NSInteger{
    MES_MESSAGE_TYPE_CHAT = 10,// 聊天消息
    MES_MESSAGE_TYPE_ADD   = 11,// 加入频道
    MES_MESSAGE_TYPE_EXIT   = 12,// 退出频道
    MES_MESSAGE_TYPE_PUB_DYNAMIC = 13,// 发布动态
    MES_MESSAGE_TYPE_DYNAMIC_COMMENT = 14,// 评论通知
    MES_MESSAGE_TYPE_DYNAMIC_LIKE = 15,// 点赞通知
    MES_MESSAGE_TYPE_ADD_ADMIN = 16,// 添加管理员通知
    MES_MESSAGE_TYPE_CANCEL_ADMIN = 17,// 取消管理员通知
    MES_MESSAGE_TYPE_MUTE = 18,// 禁言
    MES_MESSAGE_TYPE_CANCEL_MUTE = 19,// 取消禁言
    MES_MESSAGE_TYPE_SIGN_ACTIVITY = 20,// 成功报名某活动
    MES_MESSAGE_TYPE_SAY_HELLO = 21,// 打招呼
    MES_MESSAGE_TYPE_PUB_ACTIVITY = 22,// 发布某活动
    MES_MESSAGE_TYPE_ADMIN_DELEGATE = 23,// 管理员删除成员
    MES_MESSAGE_TYPE_RECOMMAND_CHANNEL  = 24, // 推荐频道
    MES_MESSAGE_TYPE_ADD_FANS = 25, //增加粉丝
    MES_MESSAGE_TYPE_DEL_DYNAMIC = 26,//管理员删除动态通知创建人
    MES_MESSAGE_TYPE_REDPACK_NOTIF = 27,//红包通知
    MES_MESSAGE_TYPE_ADD_CHANNEL_APPLY = 28,//申请加入频道消息
    MES_MESSAGE_TYPE_NO_REDPACK = 29,//无可抢红包时消息
    MES_MESSAGE_TYPE_CLEAR_CHANNEL = 30,//管理员删除频道聊天消息记录
    MES_MESSAGE_TYPE_REDPACK_REFOUND = 31,//红包退款
    MES_MESSAGE_TYPE_REDPACK_WITHDRAWS = 32,//用户提现
    MES_MESSAGE_TYPE_CHANNEL_NAME_NOTIF = 33,//后台频道名称更新通知
    MES_MESSAGE_TYPE_CHANNEL_IMG_NOTIF = 34,//后台频道封面更新通知
    MES_MESSAGE_TYPE_CHANNEL_MAX_PEOPLE_NOTIF = 35,//后台频道最大人数更新通知
    MES_MESSAGE_TYPE_CHANNEL_VISIBILITY_NOTIF = 36,//后台频道可见性更新通知
    MES_MESSAGE_TYPE_CHANNEL_STATUS_NOTIF = 37,//后台频道状态更新通知
    MES_MESSAGE_TYPE_PUB_GAME = 38,//用户发布游戏活动
    MES_MESSAGE_TYPE_ACTIVITY_NEED_VERTIFY = 39,//活动待审核
    MES_MESSAGE_TYPE_ACTIVITY_VERTIFYED = 40,//活动审核通过
    MES_MESSAGE_TYPE_ACTIVITY_LIKE = 42,//活动点赞
    MES_MESSAGE_TYPE_ACTIVITY_COMMENT = 43,//活动评论
    MES_MESSAGE_TYPE_MICCITY_DISMISSNOTICE = 44,//小城故事解散的通知
    MES_MESSAGE_TYPE_MICCITY_DISMISSED = 45,//小城故事解散了
    MES_MESSAGE_TYPE_MICCITY_CHANGED = 46,//首页小城故事需要改变
    MES_MESSAGE_TYPE_LIFECICLE_DELETE = 47, // 生活圈删除
    MES_MESSAGE_TYPE_MICCITY_CHANGED_2493 = 48 // 首页小城故事需要改变(2.493版本)
} MES_MESSAGE_TYPE; // 消息类型
#pragma mark ------------------------------======---------------------------------------


#pragma mark ------------------------------频道类型-----------------------------
typedef NS_ENUM(NSInteger, PDChannelType) {
    PDChannelTypeMine = 1,//我的频道
    PDChannelTypeRecommendation = 2,  //推荐频道
    PDChannelTypeAttention = 3, //关注的频道
    PDChannelTypeSameTopic = 4,//同频频道
    PDChannelTypeLiveCircle = 5,  //生活圈
    PDChannelTypeSimCity = 6,  //小城故事频道
    PDChannelTypeSimCityEntrance = 60  //小城故事入口
};
#pragma mark ------------------------------======---------------------------------------


@interface PDMessageDefine : NSObject



@end
