//
//  PDMsgChannelModel.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/8/25.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDMsgChannelModel : NSObject
@property(nonatomic,retain)NSString *channelId; // * 频道ID
@property(nonatomic,retain)NSString *channelName; // * 频道名称
@property(nonatomic,retain)NSString *lon; // * 频道坐标 经度
@property(nonatomic,retain)NSString *lat;// 纬度
@property(nonatomic,retain)NSString *channelImg;// * 频道图片
@property(nonatomic,retain)NSString *personNum; // * 频道当前推送人数
@property(nonatomic,retain)NSString *chatName;
@property(nonatomic,retain)NSString *channelType; // 频道属性
@property(nonatomic,retain)NSString *myChannelType; // 频道属性(消息渠道)
@property(nonatomic,retain)NSString *roleType; // 权限
@property(nonatomic,retain)NSString *chatType;// * 会话类型 1单聊 2 群聊
@property(nonatomic,retain)NSString *sameTopicFlag;
@property(nonatomic, strong) NSString *validDistance;
@end
