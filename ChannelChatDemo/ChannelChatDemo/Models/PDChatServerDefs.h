//
//  PDChatServerDefs.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#ifndef PDChatServerDefs_h
#define PDChatServerDefs_h
// 消息发送状态
typedef enum {
    PDMessageDeliveryState_Pending = 0,  // 待发送
    PDMessageDeliveryState_Delivering,   // 正在发送
    PDMessageDeliveryState_Delivered,    // 已发送，成功
    PDMessageDeliveryState_Failure,      // 发送失败
    PDMessageDeliveryState_ServiceFaid   // 发送服务器失败(可能其它错,待扩展)
}PDMessageDeliveryState;

// 消息状态
typedef enum {
    PDMessageStatus_unRead = 0,          // 消息未读
    PDMessageStatus_read,                // 消息已读
    PDMessageStatus_back                 // 消息撤回
}PDMessageStatus;
#endif /* PDChatServerDefs_h */
