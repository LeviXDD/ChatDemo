//
//  PDLocalMessageModel.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDMessage.h"
#import "PDMsgChannelModel.h"
@interface PDLocalMessageModel : NSObject
// 后期重构把这个类可能要去掉

// 是否是发送者
@property (nonatomic, assign) BOOL isSender;
// 是否是群聊
//@property (nonatomic, assign) BOOL isChatGroup;


@property (nonatomic, strong) PDMessage * message;
@property(nonatomic, strong) PDMsgChannelModel *channelModel;

// 包含voice，picture，video的路径;有大图时就是大图路径
@property (nonatomic, copy) NSString *mediaPath;
@end
