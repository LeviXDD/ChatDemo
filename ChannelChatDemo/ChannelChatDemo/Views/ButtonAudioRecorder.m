//
//  ButtonRecord.m
//  O了
//
//  Created by 卢鹏达 on 14-1-14.
//  Copyright (c) 2014年 roya. All rights reserved.
//

#define HUD_IMG_TAG 600             //指示器imageview的tag
#define HUD_LABEL_TAG 800           //指示器label的tag
#define HUD_CUSTOMVIEW_WIDTH 130    //指示器自定义视图宽
#define HUD_CUSTOMVIEW_HEIGHT 120   //指示器自定义视图高
#define HUD_IMG_WIDTH 81            //指示器imageview的宽
#define HUD_IMG_HEIGHT 90           //指示器imageview的高
#define HUD_LABEL_FONT_SIZE 12      //指示器字体大小
#define RECORDER_DURATION 60        //默认录音最大时长

#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "ButtonAudioRecorder.h"

@interface ButtonAudioRecorder()<AVAudioRecorderDelegate>{
    MBProgressHUD *_progressHUD;        ///<指示器
    NSTimer *_timer;                    ///<定时器
    AVAudioRecorder *_recorder;         ///<录音 AVAudioRecorder
    BOOL _sendFlag;                     ///<YES发送，NO没有发送
    
    NSString *_originTitle;             ///<原始titile
    NSString *_changeTitle;             ///<改动title
    NSString *_upChangeTitle;           ///<上滑改动title
    
    UIImage *_originImage;              ///<原始Image
    UIImage *_changeImage;              ///<改动Image
    UIImage *_upChangeImage;            ///<上滑改动Image
    
    UIImage *_originBackgroundImage;    ///<原始groundImage
    UIImage *_changeBackgroundImage;    ///<改动groundImage
    UIImage *_upChangeBackgroundImage;  ///<上滑改动groundImage
    
    BOOL _volumeAnimation;              ///<音量变化
    
    NSTimeInterval recordTime;
}

@end

@implementation ButtonAudioRecorder
#pragma mark - 生命周期
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化
        [self initial];
    }
    return self;
}
- (void)awakeFromNib
{
    //初始化
    [self initial];
}
#pragma mark 初始化
- (void)initial
{
    self.recorderDuration=RECORDER_DURATION;
    _originImage=self.imageView.image;
    _originTitle=self.titleLabel.text;
    _originBackgroundImage=self.currentBackgroundImage;
    self.adjustsImageWhenHighlighted=NO;
    
    
    
    
    //按下
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    //内部松开
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    //外部松开
    [self addTarget:self action:@selector(touchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    //进入内部
    [self addTarget:self action:@selector(touchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    //进入外部
    [self addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    //触摸取消事件
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
}
#pragma mark - 重写Button方法
#pragma 重写高亮的方法
- (void)setHighlighted:(BOOL)highlighted{}
#pragma mark title方法重写
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    if (state==UIControlStateNormal) {
        if (_originTitle==nil) {
            _originTitle=title;
        }
        if (_changeTitle==nil) {
            _changeTitle=title;
        }
        if (_upChangeTitle==nil) {
            _upChangeTitle=title;
        }
    }
}
#pragma mark image方法重写
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    if (state==UIControlStateNormal) {
        if(_originImage==nil){
            _originImage=image;
        }
        if (_changeImage==nil) {
            _changeImage=image;
        }
        if (_upChangeImage==nil) {
            _upChangeImage=image;
        }
    }
}
#pragma mark backgroundImage方法重写
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [super setBackgroundImage:image forState:state];
    if (state==UIControlStateNormal) {
//        if(_originBackgroundImage==nil){
            _originBackgroundImage=image;
//        }
//        if (_changeBackgroundImage==nil) {
            _changeBackgroundImage=image;
//        }
//        if (_upChangeBackgroundImage==nil) {
            _upChangeBackgroundImage=image;
//        }
    }
}
#pragma mark - 类公有方法
#pragma mark 设置改动标题
- (void)setChangeTitle:(NSString *)title
{
    _changeTitle=title;
    if ([_upChangeTitle isEqualToString:_originTitle]) {
        _upChangeTitle=_changeTitle;
    }
}
#pragma mark 设置上滑改动标题
- (void)setUpChangeTitle:(NSString *)title
{
    _upChangeTitle=title;
}
#pragma mark 设置改动图片
- (void)setChangeImage:(UIImage *)image
{
    _changeImage=image;
    if ([_upChangeImage isEqual:_originImage]) {
        _upChangeImage=_changeImage;
    }
}
#pragma mark 设置上滑改动图片
- (void)setUpChangeImage:(UIImage *)image
{
    _upChangeImage=image;
}
#pragma mark 设置改动背景图片
- (void)setChangeBackgroundImage:(UIImage *)backgroundImage
{
    _changeBackgroundImage=backgroundImage;
    if ([_upChangeBackgroundImage isEqual:_originBackgroundImage]) {
        _upChangeBackgroundImage=_changeBackgroundImage;
    }
}
#pragma mark 设置上滑改动背景图片
- (void)setUpChangeBackgroundImage:(UIImage *)backgroundImage
{
    _upChangeBackgroundImage=backgroundImage;
}
#pragma mark - 自定义Target方法
#pragma mark 按下不动，开始录音
- (void)touchDown:(UIButton *)button
{   
  if([[[NSUserDefaults standardUserDefaults] objectForKey:@"isavaudioalLow"] intValue]==1)
      [self allocButtAudio:button];
  else{
    
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    
    if ([avSession respondsToSelector:@selector(requestRecordPermission:)]) {
        
        [avSession requestRecordPermission:^(BOOL available) {
            
            if (available) {
                //completionHandler
                [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isavaudioalLow"];
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"无法录音" message:@"请在“设置-隐私-麦克风”选项中允许【频道】访问你的麦克风" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                });
            }
        }];
        
    }
  }
       // ;
    
}
-(void)allocButtAudio:(UIButton *)button{
    _sendFlag=NO;
    _volumeAnimation=YES;
    [button setTitle:_changeTitle forState:UIControlStateNormal];
    [button setImage:_changeImage forState:UIControlStateNormal];
    [button setBackgroundImage:_changeBackgroundImage forState:UIControlStateNormal];
    //设置AVAudioRecorder
    [self initialRecord];
    //指示器设置
    [self initialProgressHUD];
    //注册进入后台监听事件
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}
#pragma mark 进入内部
- (void)touchDragEnter:(UIButton *)button
{
    [button setTitle:_changeTitle forState:UIControlStateNormal];
    [button setImage:_changeImage forState:UIControlStateNormal];
    [button setBackgroundImage:_changeBackgroundImage forState:UIControlStateNormal];
    [self progressHUDLabel:@"手指上滑，取消发送" warning:YES];
    [self progressHUDImageView:[UIImage imageNamed:@"voice_0.png"] animation:YES];
}
#pragma mark 进入外部
- (void)touchDragExit:(UIButton *)button
{
    [button setTitle:_upChangeTitle forState:UIControlStateNormal];
    [button setImage:_upChangeImage forState:UIControlStateNormal];
    [button setBackgroundImage:_upChangeBackgroundImage forState:UIControlStateNormal];
    [self progressHUDLabel:@"松开手指，取消发送" warning:YES];
    [self progressHUDImageView:[UIImage imageNamed:@"record_revocation"] animation:NO];
}
#pragma mark 内部松开，发送语音
- (void)touchUpInside:(UIButton *)button
{
    if (!_sendFlag) {
        //发送语音
        [self sendAudioMessageWithSendFlag:YES timeout:NO];
    }
}
#pragma mark 外部松开,取消发送语音
- (void)touchUpOutside:(UIButton *)button
{
    if (!_sendFlag) {
        //取消发送语音
        [self sendAudioMessageWithSendFlag:NO timeout:NO];
    }
}
#pragma mark 触摸取消事件
- (void)touchCancel:(UIButton *)sender
{
    if (!_sendFlag) {
        [self sendAudioMessageWithSendFlag:NO timeout:NO];
    }
}
#pragma mark 程序进入后台
//- (void)applicationWillResignActive:(NSNotification *)notification
//{
//    if (!_sendFlag) {
//        [self sendAudioMessageWithSendFlag:NO timeout:NO];
//    }
//}
#pragma mark - AVAudioRecorderDelegate委托事件
#pragma mark 录音结束
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (!_sendFlag) {
        [self sendAudioMessageWithSendFlag:YES timeout:YES];
    }
}
#pragma mark - 类私有方法
#pragma mark AVAudioRecorder设置
- (void)initialRecord
{
    //录音权限设置，IOS7必须设置，得到AVAudioSession单例对象
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //设置类别,此处只支持支持录音
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    //启动音频会话管理,此时会阻断后台音乐的播放
    [audioSession setActive:YES error:nil];
    //录音参数设置设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    //录音文件保存的URL
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    NSString *catchPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    //AAC大写的话，android收到播放不出来，问题暂且不清楚
//    NSString *audioRecordFilePath=[catchPath stringByAppendingPathComponent:[NSString stringWithFormat:@"andron_voice/%@.AAC", cfuuidString]];
    
    NSString *audioRecordFilePath=[catchPath stringByAppendingPathComponent:[NSString stringWithFormat:@"andron_voice/%@.aac", cfuuidString]];
    //判断目录是否存在不存在则创建
    NSString *audioRecordDirectories = [audioRecordFilePath stringByDeletingLastPathComponent];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:audioRecordDirectories]) {
        [fileManager createDirectoryAtPath:audioRecordDirectories withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSURL *url = [NSURL fileURLWithPath:audioRecordFilePath];
    NSError *error=nil;
    //初始化AVAudioRecorder
    _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    if (error != nil) {
        //NSLog(@"初始化录音Error: %@",error);
    }else{
        if ([_recorder prepareToRecord]) {
            //录音最长时间
            [_recorder recordForDuration:self.recorderDuration-1];
            _recorder.delegate=self;
            [_recorder record];
            
            //开启音量检测
            _recorder.meteringEnabled = YES;
            //开启定时器，音量监测
            _timer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(volumeMeters:) userInfo:nil repeats:YES];
        }
    }
}
#pragma mark 实时监测音量变化
- (void)volumeMeters:(NSTimer *)timer
{
    if (_volumeAnimation) {
        //刷新音量数据
        [_recorder updateMeters];
        //获取音量的平均值  [recorder averagePowerForChannel:0];
        //音量的最大值  [recorder peakPowerForChannel:0];
        double lowPassResults = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
        if (0<lowPassResults<=0.14) {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_0.png"] animation:YES];
        }else if (0.14<lowPassResults<=0.28) {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_0.png"] animation:YES];
        }else if (0.28<lowPassResults<=0.42) {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_1.png"] animation:YES];
        }else if (0.42<lowPassResults<=0.56) {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_1.png"] animation:YES];
        }else if (0.56<lowPassResults<=0.7) {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_2.png"] animation:YES];
        }else if (0.7<lowPassResults<=0.84) {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_2.png"] animation:YES];
        }else if (0.84<lowPassResults<=0.98) {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_3.png"] animation:YES];
        }else {
            [self progressHUDImageView:[UIImage imageNamed:@"voice_3.png"] animation:YES];
        }
    }
}
#pragma mark 指示器设置
- (void)initialProgressHUD
{
    CGFloat marginImgLb=10.f;
    CGFloat marginLb=5.f;
    NSString *stringAlert=@"手指上滑，取消发送";
    UIFont *fontLabel=[UIFont systemFontOfSize:HUD_LABEL_FONT_SIZE];
    CGFloat labelHeight=[stringAlert sizeWithFont:fontLabel].height+2*marginLb;
    _progressHUD=[MBProgressHUD showHUDAddedTo:self.window animated:YES];
    //隐藏时从父视图中移除
    _progressHUD.removeFromSuperViewOnHide=YES;
    //允许显示自定义视图
    _progressHUD.mode=MBProgressHUDModeCustomView;
    //_progressHUD.opacity=0.6;
    //外框架view
    UIView *customView=[[UIView alloc]init];
    customView.bounds=CGRectMake(0, 0, HUD_CUSTOMVIEW_WIDTH, HUD_CUSTOMVIEW_HEIGHT);
    _progressHUD.customView=customView;
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(_progressHUD.customView.center);
        make.width.height.equalTo(@130);
    }];
    //imageview
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"voice_0.png"]];
    imageView.tag=HUD_IMG_TAG;
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageView.bounds=CGRectMake(0, 0, HUD_IMG_WIDTH, HUD_IMG_HEIGHT);
    imageView.center=CGPointMake(HUD_CUSTOMVIEW_WIDTH*0.5, HUD_IMG_HEIGHT*0.5);
    //label
    UILabel *label=[[UILabel alloc]init];
    label.tag=HUD_LABEL_TAG;
    label.font=fontLabel;
    label.textAlignment=NSTextAlignmentCenter;
    label.text=stringAlert;
    //圆角
    label.clipsToBounds = YES;
    label.layer.cornerRadius=labelHeight/2;
    label.backgroundColor=[UIColor clearColor]/*[UIColor hx_colorWithHexRGBAString:@"A03738"]*/;
    label.textColor=[UIColor whiteColor];
    label.frame=CGRectMake(0, HUD_IMG_HEIGHT+marginImgLb, HUD_CUSTOMVIEW_WIDTH, labelHeight);
    //添加到view中
    [customView addSubview:imageView];
    [customView addSubview:label];
    
}
#pragma mark 设置指示器的label
- (void)progressHUDLabel:(NSString *)text warning:(BOOL)warning
{
    UIView *customView=_progressHUD.customView;
    UILabel *label=(UILabel *)[customView viewWithTag:HUD_LABEL_TAG];
    if (warning) {
        label.backgroundColor=[UIColor colorWithRed:1 green:0.08 blue:0.02 alpha:0.6];
    }else{
        label.backgroundColor=[UIColor clearColor];
    }
    label.text=text;
}
#pragma mark 设置指示器的imageView
- (void)progressHUDImageView:(UIImage *)image animation:(BOOL)animation
{
    _volumeAnimation=animation;
    UIView *customView=_progressHUD.customView;
    UIImageView *imageView=(UIImageView *)[customView viewWithTag:HUD_IMG_TAG];
    [imageView setImage:image];
}
#pragma mark 发送语音信息
/**
 *  发送语言信息
 *
 *  @param sendflag    YES发送，NO取消发送
 *  @param timeoutFlag YES超时，NO没有超时
 */
- (void)sendAudioMessageWithSendFlag:(BOOL)sendflag timeout:(BOOL)timeoutFlag
{
    //获取录音时长
    double longTime=timeoutFlag?self.recorderDuration:_recorder.currentTime;
    //停止录音
    [_recorder stop];
    //录音权限设置
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:NO withFlags:AVAudioSessionSetActiveFlags_NotifyOthersOnDeactivation error:nil];
    //button状态切换
    [self setTitle:_originTitle forState:UIControlStateNormal];
    [self setImage:_originImage forState:UIControlStateNormal];
    [self setBackgroundImage:_originBackgroundImage forState:UIControlStateNormal];
    //停止运行计时器
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    //发送语音
    NSMutableDictionary *dicAudioInfo=[[NSMutableDictionary alloc]init];
    if (sendflag) {             //发送语音
        if (longTime<1) {
            [self progressHUDLabel:@"说话时间太短" warning:NO];
            [self progressHUDImageView:[UIImage imageNamed:@"record_shorttime.png"] animation:NO];
            //0.5秒后隐藏指示器
            [_progressHUD hide:YES afterDelay:0.5];
            _progressHUD.userInteractionEnabled=NO;
            //删除录音文件
            [_recorder deleteRecording];
            sendflag=NO;
        }else{
            [_progressHUD hide:YES];
            [dicAudioInfo setValue:_recorder.url.path forKey:AudioRecorderPath];
            [dicAudioInfo setValue:[_recorder.url.path lastPathComponent] forKey:AudioRecorderName];
            [dicAudioInfo setValue:[NSString stringWithFormat:@"%.0f",(longTime*10+0.5)/10] forKey:AudioRecorderDuration];
        }
    }else{                  //取消发送
        [_recorder deleteRecording];
        [_progressHUD hide:YES];
    }
    //调用委托
    [self.delegate buttonAudioRecorder:self didFinishRcordWithAudioInfo:dicAudioInfo sendFlag:sendflag];
    //移除监听器
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _timer=nil;
    _recorder=nil;
    _progressHUD=nil;
    _sendFlag=YES;
}
@end
