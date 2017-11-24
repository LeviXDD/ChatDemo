//
//  InputView.m
//  WeChat
//
//  Created by Zhou Renhai on 16/1/5.
//  Copyright © 2016年 renhai. All rights reserved.
//

#import "InputView.h"
#import "UIImage+Extension.h"
#import "HWEmotionKeyboard.h"
#import "UITextView+Extension.h"
#import "HWEmotionTextView.h"
#import "RHChatToolKeyBoard.h"
//#import "SGPhotoThumbnailViewController.h"
//#import "WechatShortVideoController.h"
#import "HWEmotion.h"
#import "HWEmotionTool.h"
#import "UIImage+GIF.h"
//#import "QRCodeReaderViewController.h"
typedef enum{
    InputStatus_default,//默认无弹出键盘
    InputStatus_sound,  //发送语音
    InputStatus_text,   //输入文字
    InputStatus_emoji,  //选择表情
    InputStatus_extra   //选择图片或视频
}InputStatus;

@interface InputView ()<ButtonAudioRecorderDelegate,UITextViewDelegate>
{
    NSArray                 *_photoGroups;
}
@property (nonatomic,assign) NSInteger currentStatus;
@property (nonatomic,strong) HWEmotionKeyboard *emotionKeyboard;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firleading;
@property (weak, nonatomic) IBOutlet UIImageView *limitGitImageView;  //gif动画，显示剩余时间
@property (weak, nonatomic) IBOutlet UIView *limitView;  //覆盖在输入面板上，不让用户点击输入相关内容
@property (weak, nonatomic) IBOutlet UIView *inputView; //输入面板，包括语音、输入框、键盘切换等

@end

@implementation InputView
-(void)chageNSLayoutCons{
    self.firleading.constant+=31;
}
+(id)inputViewWithChannelID:(NSString *)channelld{
    InputView * instance = [[[NSBundle mainBundle] loadNibNamed:@"InputView" owner:nil options:nil] lastObject];
    instance.channelID = channelld;
    return instance;
}
+(id)inputView{
    
    InputView * instance = [[[NSBundle mainBundle] loadNibNamed:@"InputView" owner:nil options:nil] lastObject];
    [instance initControls];
    
    return instance;
}

-(void)dealloc{
    NSLog(@"键盘已销毁");
}

-(void)startLimitSpeechIsSameChannel:(BOOL)isSameChannel{
//    if (isSameChannel) {
//        [self.limitGitImageView setImage:[UIImage sd_animatedGIFNamed:@"tp_5secTimeLimit"]];
//        self.limitView.hidden = NO;
//        self.limitGitImageView.hidden = NO;
//        self.textView.placeholder = @"";
//        //    @weakify(self);
//        //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5. target:self selector:@selector(timerStop) userInfo:nil repeats:NO];
//        //    [timer fire];
//        [self performSelector:@selector(stopSpeechLimit) withObject:nil afterDelay:4.5f];
//    } else {
//        self.limitView.hidden = NO;
//        [self.limitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTipWithAttentionChannel:)]];
//    }
}

//提示用户扫码进入
-(void)userTipWithAttentionChannel:(id)sender{
//    PDUser *user = [PDUser sharedInstance];
//    if (![user isLogin]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:Channel_ReLogin object:nil];
//
//        return ;
//    }
////    NSString *tipMessage = [NSString stringWithFormat:@"你还没有加入频道\n请到该频道现场向店内工作人员或频道管理员索取二维码扫码加入\n%@",self.channelAddress];
//    NSString *tipMessage = @"你还没有加入频道\n请到该频道现场向店内工作人员或频道管理员索取二维码扫码加入";
//    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提醒" andMessage:tipMessage andLocation:[NSString stringWithFormat:@"地址：%@",self.channelAddress]];
//    alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
//
//    [alertView addButtonWithTitle:@"我知道了"
//                             type:SIAlertViewButtonTypeCancel
//                          handler:^(SIAlertView *alert) {
//                              [alert dismissAnimated:YES];
//                              //                              [UIColor yellowColor]
//                          }];
//    [alertView addButtonWithTitle:@"我要现在扫码"
//                             type:SIAlertViewButtonTypeDefault
//                          handler:^(SIAlertView *alert) {
//
////                              [self openScan];
//                              __weak QRCodeReaderViewController *readerVc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"取消"];
//                              readerVc.title = @"加入频道";
//                              [readerVc setCompletionWithBlock:^(NSString *resultAsString) {
//                                  [readerVc dismissViewControllerAnimated:YES completion:^{
//                                      NSLog(@"%@", resultAsString);
//                                      if (resultAsString != nil) {
//                                          [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_JOIN_CHANNEL object:resultAsString];
//                                      }
//                                  }];
//                              }];
//                              [[Utils currentViewController] presentViewController:readerVc animated:YES completion:nil];
//                              [alert dismissAnimated:YES];
//                          }];
//    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
//    [alertView show];

//    [Utils showAlertWithTitle:@"提醒" detailText:tipMessage rightButtonTitle:@"我要现在扫码" handler:^(SIAlertView *alertView) {
//        //        [self openScan];[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"QRCODE_SCAN_TYPE"];
//        
//    } isSameTopic:NO];
}

-(void)stopSpeechLimit{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopSpeechLimit) object:nil];
    self.limitView.hidden = YES;
    self.limitGitImageView.hidden = YES;
    self.textView.placeholder = @"聊天内容";
}

-(void)stopSpeechLimitIsSameChannel:(BOOL)isSameChannel{
    if (isSameChannel) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopSpeechLimit) object:nil];
        self.limitView.hidden = YES;
        self.limitGitImageView.hidden = YES;
        self.textView.placeholder = @"聊天内容";
    } else {
        self.limitView.hidden = YES;
    }
}

-(void)setIsSameTopic:(BOOL)isSameTopic{
//    _isSameTopic = isSameTopic;
//    if (_isSameTopic) {
//        _textView.backgroundColor = [UIColor hx_colorWithHexString:@"808080"];
//        _inputView.backgroundColor = [UIColor hx_colorWithHexString:@"999999"];
//        _toolKeyboard.backgroundColor = [UIColor blackColor];
//        _toolKeyboard.isSameTopic = isSameTopic;
//        [self.sendSoundButton setTitleColor:[UIColor pd_textWhiteColor] forState:UIControlStateNormal];
//        [self.sendSoundButton setBackgroundImage:[UIImage imageWithColor:[UIColor hx_colorWithHexRGBAString:@"#727374"] size:self.sendSoundButton.size] forState:UIControlStateNormal];
////        [self.sendSoundButton setChangeBackgroundImage:[UIImage imageWithColor:[UIColor hx_colorWithHexRGBAString:@"#727374"] size:self.sendSoundButton.size]];
//    } else {
//        _toolKeyboard.isSameTopic = isSameTopic;
//        [self.sendSoundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.sendSoundButton setBackgroundImage:[UIImage imageNamed:@"chat_voice_up.png"] forState:UIControlStateNormal];
////        [self.sendSoundButton setChangeBackgroundImage:[UIImage imageNamed:@"chat_voice_down.png"]];
//    }
}
                      

-(void)setChannelID:(NSString *)channelID{
    _channelID = channelID;
    //    InputView * instance = [[[NSBundle mainBundle] loadNibNamed:@"InputView" owner:nil options:nil] lastObject];
    [self initControls];
}
- (void)initControls{
    self.limitGitImageView.hidden = YES;
    self.limitView.hidden = YES;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.height.mas_equalTo(288+44);
        make.height.mas_equalTo(328+44);
    }];
    self.textView.layer.cornerRadius = 2.0;
    self.textView.clipsToBounds = YES;
    self.textView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 20);
    self.textView.placeholder = @"聊天内容";
    
    [self.sendSoundButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self.sendSoundButton setChangeTitle:@"松开 发送"];
    [self.sendSoundButton setUpChangeTitle:@"松开 取消"];
    self.sendSoundButton.delegate = self;
    
    [self.addButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
    [self.addButton setImage:[[UIImage alloc]init] forState:UIControlStateSelected];
    self.addButton.layer.cornerRadius = 3;
    self.addButton.clipsToBounds = YES;
    [self.addButton addTarget:self action:@selector(switchToolsKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    self.isSameTopic = NO;
    
    self.textView.delegate = self;
    [self.emojiButton addTarget:self action:@selector(switchEmojiKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.soundButton addTarget:self action:@selector(switchSoundKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    self.currentStatus = InputStatus_default;
    
    
    //  后台执行：
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    // something
    
    
    
    
    
    //初始化extra键盘
    if (!_toolKeyboard) {
        RHChatToolKeyBoard *toolKB = [[RHChatToolKeyBoard alloc] init];
        toolKB.width = self.width;
        toolKB.height = 135;
        toolKB.isSameTopic = self.isSameTopic;
        toolKB.channelID=self.channelID;
        toolKB.backgroundColor = [UIColor whiteColor];
        [self addSubview:toolKB];
        self.toolKeyboard = toolKB;
        
        [_toolKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_top).offset(44);
            make.height.mas_equalTo(216 + 44);
        }];
    }
    
    //初始化表情键盘
    if (!_emotionKeyboard) {
        HWEmotionKeyboard *emotionKB = [[HWEmotionKeyboard alloc] init];
        // 键盘的宽度
        emotionKB.width = self.width;
        emotionKB.height = 216 + 44;;
        [self addSubview:emotionKB];
        self.emotionKeyboard = emotionKB;
        [self.emotionKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_top).offset(44);
            make.height.mas_equalTo(216 + 44);
        }];
    }
    //    });
    //    [self startObserver];
}

/*
 -(RHChatToolKeyBoard *)toolKeyboard{
 if (!_toolKeyboard) {
 RHChatToolKeyBoard *toolKB = [[RHChatToolKeyBoard alloc] init];
 toolKB.width = self.width;
 toolKB.height = 216 + 44;
 toolKB.backgroundColor = [UIColor whiteColor];
 [self addSubview:toolKB];
 self.toolKeyboard = toolKB;
 
 [_toolKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.right.mas_equalTo(0);
 make.top.mas_equalTo(self.mas_top).offset(44);
 make.height.mas_equalTo(216 + 44);
 }];
 }
 
 return _toolKeyboard;
 }
 
 -(HWEmotionKeyboard *)emotionKeyboard
 {
 if (!_emotionKeyboard) {
 HWEmotionKeyboard *emotionKB = [[HWEmotionKeyboard alloc] init];
 // 键盘的宽度
 emotionKB.width = self.width;
 emotionKB.height = 216 + 44;;
 [self addSubview:emotionKB];
 self.emotionKeyboard = emotionKB;
 [self.emotionKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.right.mas_equalTo(0);
 make.top.mas_equalTo(self.mas_top).offset(44);
 make.height.mas_equalTo(216 + 44);
 }];
 }
 return _emotionKeyboard;
 }
 */
- (void)startObserver{
    [RHNotificationCenter removeObserver:self];
    
    [RHNotificationCenter addObserver:self selector:@selector(willShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    //    [RHNotificationCenter addObserver:self selector:@selector(willChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //    [RHNotificationCenter addObserver:self selector:@selector(willHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [RHNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:HWEmotionDidSelectNotification object:nil];
    [RHNotificationCenter addObserver:self selector:@selector(sendMessageNotifyHandler) name:NOTIFY_EMOTION_SENDMESSAGE object:nil];
    
    [RHNotificationCenter addObserver:self selector:@selector(closeKeyboard) name:NOTIFY_CLOSE_KEYBOARD object:nil];
}

- (void)stopObserver{
    [RHNotificationCenter removeObserver:self];
}
- (void)hideatsomeAndExtra{
    [self.atbtn setHidden:YES];
}
- (void)hideVoiceAndExtra{
    
    [self updateConstraintsIfNeeded];
    [self.soundButton setHidden:YES];
    [self.addButton setHidden:YES];
    [self.atbtn setHidden:YES];
    [self.soundButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-40);
    }];
    
    [self.addButton removeFromSuperview];
    [self.emojiButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.right).offset(-10);
    }];
    //开始刷新界面
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(startEditInput)]) {
        [self.delegate startEditInput];
    }
    self.currentStatus = InputStatus_text;
    [self.emojiButton setImage:[UIImage imageNamed:@"default_icon"] forState:UIControlStateNormal];
//    self.currentStatus = InputStatus_default;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText {
    
    NSString *fulltext = [self.textView fullText];
    if ([replacementText isEqualToString:@"\n"]) {
        if ([fulltext isEqualToString:@""]) {
            return NO;
        }
        
        if ([self.delegate respondsToSelector:@selector(sendMessage:)]) {
            [self.delegate sendMessage:fulltext];
        }
        
        self.textView.text = @"";
        
        // 发送完消息 把inputView的高度改回来
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
        
        return NO;
    }
    
    if (self.lengthLimit > 0 && self.textView.fullText.length + replacementText.length > self.lengthLimit) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最多可输入%ld个字符",self.lengthLimit]];
        return NO;
    }
    
    //提醒某人
    if ([replacementText isEqualToString:@"@"] && [self.delegate respondsToSelector:@selector(mentionSomebody)]) {
        [self.delegate mentionSomebody];
    }
    return YES;
}
-(IBAction)atsomecliclick:(id)sender{
    if ([self.delegate respondsToSelector:@selector(mentionSomebody)]) {
        [self.delegate mentionSomebody];
    }
}
- (void)appendContent:(NSString*)content{
    [self.textView insertText:content];
}
#pragma mark - 文本高度控制
//-(void)textViewDidChange:(UITextView *)textView{
//
//    //获取ContentSize
//    CGFloat contentH = textView.contentSize.height;
//
//    // 大于33，超过一行的高度/ 小于68 高度是在三行内
//    if (contentH > 33 && contentH < 68 ) {
//        //    self.inputViewHeightConstraint.constant = contentH + 18;
//
//        [self.inputView updateConstraintsIfNeeded];
//        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(contentH + 18);
//        }];
//        [UIView animateWithDuration:0.25 animations:^{
//            [self.inputView layoutIfNeeded];
//        }];
//    }else if(contentH <= 33)
//    {
//
//        [self.inputView updateConstraintsIfNeeded];
//        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(44);
//        }];
//        [UIView animateWithDuration:0.25 animations:^{
//            [self.inputView layoutIfNeeded];
//        }];
//
//    }
//
//    NSString *text = textView.text;
//    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    if(text.length > 0)
//    {
//        self.inputView.addButton.enabled = YES;
//    }else
//    {
////        self.inputView.addButton.enabled = NO;
//    }
//    if(text.length > 140)
//    {
//        textView.text = [text substringToIndex:140];
//    }
//}

#pragma mark -- 键盘切换

- (void)switchSoundKeyboard{
    if (self.soundButton.selected) {
        self.currentStatus = InputStatus_sound;
        self.sendSoundButton.hidden = NO;
//        self.soundButton.selected = YES;
        [self.textView resignFirstResponder];
        
        [self showKeyboardSound];
    } else {
        self.currentStatus = InputStatus_default;
        self.sendSoundButton.hidden = YES;
//        self.soundButton.selected = NO;
        [self.textView becomeFirstResponder];
        
//        self.firleading.constant=41;;
//        _atbtn.hidden=NO;
    }
    self.soundButton.selected = !self.soundButton.selected;
//    if (self.currentStatus != InputStatus_sound) {
//        
//        self.currentStatus = InputStatus_sound;
//        self.sendSoundButton.hidden = NO;
//        self.soundButton.selected = YES;
//        [self.textView resignFirstResponder];
//        
//        [self showKeyboardSound];
//        
//    }else{
//        self.currentStatus = InputStatus_default;
//        self.sendSoundButton.hidden = YES;
//        self.soundButton.selected = NO;
//        [self.textView becomeFirstResponder];
//        
//        self.firleading.constant=41;;
//        _atbtn.hidden=NO;
//    }
}

- (void)switchEmojiKeyboard{
    self.sendSoundButton.hidden = YES;
    self.soundButton.selected = NO;
    [_emotionKeyboard loadData];
    if (self.currentStatus != InputStatus_emoji&&self.currentStatus!=InputStatus_extra) {
        self.currentStatus = InputStatus_emoji;
        [self.emojiButton setImage:[UIImage imageNamed:@"add_expression"] forState:UIControlStateNormal];
        [self showKeyboardEmoji];
    }else
    {
        
        [self.emojiButton setImage:[UIImage imageNamed:@"default_icon"] forState:UIControlStateNormal];
        self.currentStatus = InputStatus_default;
        [self.textView becomeFirstResponder];
    }
}

- (void)switchToolsKeyboard{
    
    self.sendSoundButton.hidden = YES;
    self.soundButton.selected = NO;
    if (self.currentStatus != InputStatus_extra) {
        self.currentStatus = InputStatus_extra;
        
        [self showKeyboardTools];
    }else
    {
        
        self.currentStatus = InputStatus_default;
        [self.textView becomeFirstResponder];
    }
}

// 显示语音键盘
- (void)showKeyboardSound
{
    if ([self.delegate respondsToSelector:@selector(startEditInput)]) {
        [self.delegate startEditInput];
    }
    if (self.textView.isFirstResponder) {
        [self.textView endEditing:YES];
    }
    
    //准备刷新界面
    [self updateConstraintsIfNeeded];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
    self.firleading.constant=10;
//    _atbtn.hidden=YES;
    //开始刷新界面
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    }];
}

// 显示表情键盘
- (void)showKeyboardEmoji
{
    if ([self.delegate respondsToSelector:@selector(startEditInput)]) {
        [self.delegate startEditInput];
    }
    if (self.textView.isFirstResponder) {
        [self.textView endEditing:YES];
    }
    
    //准备刷新界面
    [self updateConstraintsIfNeeded];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(258 + 44);
    }];
    
//    PDUser *user = [PDUser sharedInstance];
    if(self.emotionKeyboard.currentEmojiSexType != 1){
        [self.emotionKeyboard removeFromSuperview];
        self.emotionKeyboard = nil;
        
        HWEmotionKeyboard *emotionKB = [[HWEmotionKeyboard alloc] init];
        // 键盘的宽度
        emotionKB.width = self.width;
        emotionKB.height = 216 + 44;;
        [self addSubview:emotionKB];
        self.emotionKeyboard = emotionKB;
        [self.emotionKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_top).offset(44);
            make.height.mas_equalTo(216 + 44);
        }];
    }
    
    [self bringSubviewToFront:self.emotionKeyboard];
    
    //开始刷新界面
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    }];
}

// 显示工具键盘，如图片、视频
- (void)showKeyboardTools
{
    if ([self.delegate respondsToSelector:@selector(startEditInput)]) {
        [self.delegate startEditInput];
    }
    if (self.textView.isFirstResponder) {
        [self.textView endEditing:YES];
    }
    
    //准备刷新界面
    [self updateConstraintsIfNeeded];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(258 + 44);
    }];
    [self bringSubviewToFront:self.toolKeyboard];
    
    //开始刷新界面
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)openKeyboard{
    [self.textView becomeFirstResponder];
    //    [self switchEmojiKeyboard];
}

- (void)closeKeyboard
{
//    self.currentStatus = InputStatus_default;
    
    if (self.textView.isFirstResponder) {
        [self.textView resignFirstResponder];
    }
    
    //    self.textView.text = @"";
    
    [self updateConstraintsIfNeeded];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        //        make.height.mas_equalTo(44);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
    }completion:^(BOOL finished) {
        
    }];
}

- (void)setInputPlaceHolder:(NSString*)placeholder{
    self.textView.placeholder = placeholder;
}

//键盘消息
//-(void)willChangeFrameNotification:(NSNotification *)notification{
//    self.currentStatus = InputStatus_default;
//
//    CGRect keyBoardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSDictionary *userInfo = notification.userInfo;
//    // 动画的持续时间
//    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGFloat height = -keyBoardF.size.height;
//
//    [self updateConstraintsIfNeeded];
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(height);
//        make.height.mas_equalTo(44);
//    }];
//    [UIView animateWithDuration:duration animations:^{
//        [self layoutIfNeeded];
//
//    }completion:^(BOOL finished) {
//    }];
//}

-(void)willShowNotification:(NSNotification *)notification{
//    self.currentStatus = InputStatus_default;
    CGRect keyBoardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat height = -keyBoardF.size.height;
    [UIView animateWithDuration:duration animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(height);
            make.height.mas_equalTo(44);
        }];
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self updateConstraintsIfNeeded];
        if ([self.delegate respondsToSelector:@selector(heightChanged:)]) {
            [self.delegate heightChanged:keyBoardF.size.height];
        }
    }];
}

//-(void)willHideNotification:(NSNotification *)notification{
//
//    self.currentStatus = InputStatus_default;
//
//    CGRect keyBoardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSDictionary *userInfo = notification.userInfo;
//    // 动画的持续时间
//    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGFloat height = -keyBoardF.size.height;
//
//    [self updateConstraintsIfNeeded];
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(0);
//        //        make.height.mas_equalTo(44);
//    }];
//
//    [UIView animateWithDuration:duration animations:^{
//        [self layoutIfNeeded];
//
//    }completion:^(BOOL finished) {
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(44);
//        }];
//    }];
//}

- (void)inputEmotion:(HWEmotion*)emotion{
    //- (void)emotionDidSelect:(NSNotification *)notification
    //{
    //    HWEmotion *emotion = notification.userInfo[HWSelectEmotionKey];
    if (self.lengthLimit > 0 && self.textView.fullText.length + emotion.chs.length > self.lengthLimit) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最多可输入%ld个字符",self.lengthLimit]];
        return;
    }
    if([emotion.chs isEqualToString:@"-100del"]){
        [self.textView deleteBackward];
    }
    else
        [self.textView insertEmotion:emotion];
    
    NSRange range = NSMakeRange(self.textView.fullText.length - 1, 1);
    [self.textView scrollRangeToVisible:range];
}

- (void)sendMessageNotifyHandler{
    NSString *fulltext = [self.textView fullText];
    if (fulltext.length == 0) {
        return;
    }
    self.textView.text = nil;
    if ([self.delegate respondsToSelector:@selector(sendMessage:)]) {
        [self.delegate sendMessage:fulltext];
        
        self.textView.text = nil;
        
        // 发送完消息 把inputView的高度改回来
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
    }
}

#pragma mark -- 录音结束
- (void)buttonAudioRecorder:(ButtonAudioRecorder *)audioRecorder didFinishRcordWithAudioInfo:(NSDictionary *)audioInfo sendFlag:(BOOL)flag
{
    if ([self.delegate respondsToSelector:@selector(buttonAudioRecorder:didFinishRcordWithAudioInfo:sendFlag:)]) {
        [self.delegate buttonAudioRecorder:audioRecorder didFinishRcordWithAudioInfo:audioInfo sendFlag:flag];
    }
}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//}

@end
