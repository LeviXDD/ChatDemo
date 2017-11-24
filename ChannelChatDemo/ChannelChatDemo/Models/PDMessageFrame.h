//
//  PDMessageFrame.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDLocalMessageModel.h"

//#define PD_CHATTYPE_TEXT  @"PD_CHATTYPE_TEXT"
//#define PD_CHATTYPE_VOICE @"PD_CHATTYPE_VOICE"
//#define PD_CHATTYPE_PIC     @"PD_CHATTYPE_PIC"
//#define PD_CHATTYPE_VIDEO @"PD_CHATTYPE_VIDEO"
//#define PD_CHATTYPE_SYS     @"PD_CHATTYPE_SYS" 

@interface PDMessageFrame : NSObject
/// 消息模型
@property (nonatomic, strong) PDLocalMessageModel *model;

// 系统消息
@property (nonatomic, assign, readonly) CGRect systemMSGF;
// 聊天时间
@property (nonatomic, assign, readonly) CGRect timeLabelF;
//用户名
@property (nonatomic, assign, readonly) CGRect nameLabelF;

//聊天信息的背景图
@property (nonatomic, assign, readonly) CGRect bubbleViewF;

//聊天信息label
@property (nonatomic, assign, readonly) CGRect chatLabelF;

//发送的菊花视图
@property (nonatomic, assign, readonly) CGRect activityF;

//重新发送按钮
@property (nonatomic, assign, readonly) CGRect retryButtonF;

// 头像
@property (nonatomic, assign, readonly) CGRect headImageViewF;

// topView   /***第一版***/
//@property (nonatomic, assign, readonly) CGRect topViewF;

//计算总的高度
@property (nonatomic, assign) CGFloat cellHight;

/// 图片
@property (nonatomic, assign) CGRect picViewF;

/// 语音图标
@property (nonatomic, assign) CGRect voiceIconF;

/// 语音时长数字
@property (nonatomic, assign) CGRect durationLabelF;

/// 语音未读红点
@property (nonatomic, assign) CGRect redViewF;

//公告牌宽度
@property(nonatomic, assign) CGRect noticeBoardF;

- (CGSize)handleImage:(CGSize)retSize;
@end
