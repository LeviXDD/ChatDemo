//
//  InputView.h
//  WeChat
//
//  Created by Zhou Renhai on 16/1/5.
//  Copyright © 2016年 renhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWEmotionTextView.h"
#import "ButtonAudioRecorder.h"
#import "HWEmotionKeyboard.h"
#import "RHChatToolKeyBoard.h"

@protocol InputViewDelegate <NSObject>
@optional
-(void)heightChanged:(CGFloat)height;
-(void)mentionSomebody;
-(void)sendMessage:(NSString*)content;
- (void)buttonAudioRecorder:(ButtonAudioRecorder *)audioRecorder didFinishRcordWithAudioInfo:(NSDictionary *)audioInfo sendFlag:(BOOL)flag;
-(void)startEditInput;
@end

@interface InputView : UIView
@property (weak, nonatomic) id<InputViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet HWEmotionTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *emojiButton;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (weak, nonatomic) IBOutlet ButtonAudioRecorder *sendSoundButton;
@property (nonatomic,strong) RHChatToolKeyBoard *toolKeyboard;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (nonatomic,assign) NSInteger lengthLimit;
@property(nonatomic,weak)IBOutlet UIButton *atbtn;
@property(nonatomic,retain)NSString *channelID;
@property(nonatomic, assign) BOOL isSameTopic;  //是否属于同频
@property(nonatomic, strong) NSString *channelAddress;

+(id)inputView;
+(id)inputViewWithChannelID:(NSString *)channelld;
- (void)openKeyboard;
- (void)closeKeyboard;
- (void)hideVoiceAndExtra;
- (void)hideatsomeAndExtra;
- (void)startObserver;
-(void)chageNSLayoutCons;
- (void)stopObserver;
- (void)setInputPlaceHolder:(NSString*)placeholder;
- (void)appendContent:(NSString*)content;
- (void)inputEmotion:(HWEmotion*)emotion;
- (void)startLimitSpeechIsSameChannel:(BOOL)isSameChannel;  //限制发言
-(void)stopSpeechLimitIsSameChannel:(BOOL)isSameChannel;  //结束发言限制

@end
