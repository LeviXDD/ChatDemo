//
//  HWEmotionKeyboard.h
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//  表情键盘（整体）: HWEmotionListView + HWEmotionTabBar

#import <UIKit/UIKit.h>

#define NOTIFY_EMOTION_SENDMESSAGE @"NOTIFY_EMOTION_SENDMESSAGE"

@interface HWEmotionKeyboard : UIView
@property (nonatomic, assign) NSInteger currentEmojiSexType;

-(void)loadData;
@end
