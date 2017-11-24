//
//  NJMessageFrameModel.h
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatMessageModel;
#define NJTextFont [UIFont systemFontOfSize:16]
//#define NJEdgeInsetsWidth 15
#define NJEdgeInsetsTopBottom 5
#define NJEdgeInsetsLeftRight 15

@interface ChatMessageFrameModel : NSObject
/**
 *  数据模型
 */
@property (nonatomic, strong) ChatMessageModel *message;

/**
 *  时间的frame
 */
@property (nonatomic, assign) CGRect timeF;

/**
 *  tip的frame
 */
@property (nonatomic, assign) CGRect tipF;
/**
 *  头像frame
 */
@property (nonatomic, assign) CGRect iconF;
/**
 *  正文frame
 */
@property (nonatomic, assign) CGRect textF;
@property (nonatomic, assign) CGRect textImageVF;
@property (nonatomic, assign) CGRect nameF;
@property (nonatomic, assign) CGRect resendF;

//图片的frame
@property (nonatomic, assign) CGRect imageF;

@property (nonatomic, assign) CGRect soundF;

@property (nonatomic, assign) CGRect playSoundF;

@property (nonatomic, assign) CGRect soundProgressF;
/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic,assign)CGRect playSoundImageViewF;

@property (nonatomic,assign)CGRect playVideoF;
@property(nonatomic ,strong)NSMutableArray *HWEmotionArray;

@end
