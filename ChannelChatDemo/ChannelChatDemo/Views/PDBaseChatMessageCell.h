//
//  PDBaseChatMessageCell.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDMessageFrame.h"
#import "PDHeadImageView.h"
//#import "UIResponder+GXRouter.h"
@class PDBaseChatMessageCell;
@protocol PDBaseChatMessageCellDelegate <NSObject>

/*消息重新发送*/
-(void)PDBaseChatMessageCellResendMessage:(PDBaseChatMessageCell*)messageCell;

/*消息被删除*/
-(void)PDBaseChatMessageCellDeleted:(PDBaseChatMessageCell*)messageCell;

//消息被点击
-(void)PDBaseChatMessageCellMessageDidClicked:(PDBaseChatMessageCell*)messageCell;

//语音消息被点击
-(void)PDBaseChatMessageCellVoiceStart:(PDBaseChatMessageCell*)messageCell animateImageView:(UIImageView *)animateImageView;

//视频消息被点击
-(void)PDBaseChatMessageCellVideoStart:(PDBaseChatMessageCell*)messageCell;

//接受的图片加载成功
-(void)messageCell:(PDBaseChatMessageCell*)messageCell receivedPicDidCached:(NSString*)receivedImageUrl;
@optional
- (void)headImageClicked:(NSString *)eId;

//图片被点击
-(void)watchBigPicWith:(PDMessageFrame *)frameModel andCell:(UITableViewCell *)mCell;

//接收的图片下载完成，重新刷新修正位置
//获取用户是否在现场判断
-(BOOL)PDBaseChatMessageCellCheackIsUserOnSite:(PDBaseChatMessageCell*)messageCell;

@end

@interface PDBaseChatMessageCell : UITableViewCell
@property (nonatomic, weak) id<PDBaseChatMessageCellDelegate> delegate;

//频道ID
@property(nonatomic, strong) NSString *channelId;

// 消息模型
@property (nonatomic, strong) PDMessageFrame *modelFrame;

//所属频道类型
@property(nonatomic, assign) PDChannelType channelType;

// 头像
@property (nonatomic, strong) PDHeadImageView *headImageView;
//昵称
@property(nonatomic, strong) UILabel *nickNameLabel;
// 内容气泡视图
@property (nonatomic, strong) UIImageView *bubbleView;
// 菊花视图所在的view
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
// 重新发送
@property (nonatomic, strong) UIButton *retryButton;
// 时间显示标签
@property (nonatomic, strong) UILabel *timeLab;

// 子类要显示菜单的视图
@property (nonatomic, strong)UIView *showMenuView;

/*复制 删除方法：为了给子类重写使用*/
-(void)delMethod;
-(void)copyMethod;

@end
