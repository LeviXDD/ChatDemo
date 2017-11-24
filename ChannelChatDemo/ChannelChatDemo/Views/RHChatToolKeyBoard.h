//
//  RHChatToolKeyBoard.h
//  Chanel
//
//  Created by archermind on 16/3/29.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ToolsPhotos,
    ToolsVideos,
    TooisRedPacket,
    ToolsMeets,
    ToolsRed,
    ToolsCards,
    ToolsGames,
    ToolsVCards
}ToolsType;

@interface RHChatToolKeyBoard : UIView
@property(nonatomic,retain)NSString *channelID;
@property(nonatomic, assign) BOOL isSameTopic;
@property (nonatomic,copy)void(^toolButtonSelected)(NSInteger buttonTag);


@end
