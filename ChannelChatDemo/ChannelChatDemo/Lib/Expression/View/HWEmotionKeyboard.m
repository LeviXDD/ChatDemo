//
//  HWEmotionKeyboard.m
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionTabBar.h"
#import "HWEmotion.h"
#import "MJExtension.h"
#import "HWEmotionTool.h"

@interface HWEmotionKeyboard() <HWEmotionTabBarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) HWEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) HWEmotionListView *recentListView;
@property (nonatomic, strong) HWEmotionListView *defaultListView;
//@property (nonatomic, strong) HWEmotionListView *emojiListView;
//@property (nonatomic, strong) HWEmotionListView *lxhListView;
@property (nonatomic, strong) HWEmotionListView *qiDaiListView1;
//@property (nonatomic, strong) HWEmotionListView *qiDaiListView2;
/** tabbar */
@property (nonatomic, weak) HWEmotionTabBar *tabBar;
@end

@implementation HWEmotionKeyboard

#pragma mark - 懒加载

//- (HWEmotionListView *)qiDaiListView1{
//    if (!_qiDaiListView1) {
//        NSString *strEmojiPath = @"EmotionIcons/emoji/default.plist";
//        self.qiDaiListView1 = [[HWEmotionListView alloc] init];
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:strEmojiPath ofType:nil];
//        self.qiDaiListView1.emotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//    }
//
//    return _qiDaiListView1;
//}
////
////- (HWEmotionListView *)qiDaiListView2{
////    if (!_qiDaiListView2) {
////        _qiDaiListView2 = [[HWEmotionListView alloc] init];
////    }
////    return _qiDaiListView2;
////}
//
//
//- (HWEmotionListView *)recentListView
//{
//    if (!_recentListView) {
//        self.recentListView = [[HWEmotionListView alloc] init];
//        // 加载沙盒中的数据
//        self.recentListView.emotions = [HWEmotionTool recentEmotions];
//    }
//    return _recentListView;
//}
//
//- (HWEmotionListView *)defaultListView
//{
//    PDUser *user = [PDUser sharedInstance];
//    if (user.sex == nil) {
//        user.sex = @"0";
//        [user saveToLocal];
//    }
//    self.currentEmojiSexType = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentEmojiSexType"] integerValue];
//    
//    NSLog(@"user sex:%@",user.sex);
//    if (!_defaultListView || [user.sex integerValue] != self.currentEmojiSexType) {
//        self.currentEmojiSexType = [user.sex integerValue];
//        [[NSUserDefaults standardUserDefaults] setInteger:self.currentEmojiSexType forKey:@"currentEmojiSexType"];
//        
//        NSString *strEmojiPath = @"EmotionIcons/emoji/woman_emoji.plist";
//        if (self.currentEmojiSexType == 1) {
//            strEmojiPath = @"EmotionIcons/emoji/man_emoji.plist";
//        }
//        
//        self.defaultListView = [[HWEmotionListView alloc] init];
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:strEmojiPath ofType:nil];
//        self.defaultListView.emotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//    }
//    return _defaultListView;
//}

-(void)loadEmojiData{
    NSString *strEmojiPath = @"EmotionIcons/emoji/default.plist";
    NSString *path = [[NSBundle mainBundle] pathForResource:strEmojiPath ofType:nil];
    self.qiDaiListView1.emotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
     self.recentListView.emotions = [HWEmotionTool recentEmotions];
}
-(HWEmotionListView *)qiDaiListView1{
    if (!_qiDaiListView1) {
        _qiDaiListView1 = [[HWEmotionListView alloc] init];
        }
    return _qiDaiListView1;
}
-(HWEmotionListView *)recentListView{
    if (!_recentListView) {
        _recentListView = [[HWEmotionListView alloc] init];
        // 加载沙盒中的数据
       
    }
    return _recentListView;
}
#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{

    self.currentEmojiSexType = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentEmojiSexType"] integerValue];
        
        NSString *strEmojiPath = @"EmotionIcons/emoji/woman_emoji.plist";
        if (self.currentEmojiSexType == 1) {
            strEmojiPath = @"EmotionIcons/emoji/man_emoji.plist";
        }
        
        self.defaultListView = [[HWEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:strEmojiPath ofType:nil];
        self.defaultListView.emotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    
    
  
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        HWEmotionTabBar *tabBar = [[HWEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        self.tabBar.backgroundColor=[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        UIImageView *imageline=[[UIImageView alloc]initWithFrame:CGRectMake(50, 0, 0.5, 40)];
        [imageline setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:237.0/255.0 alpha:1.0]];
        [self.tabBar addSubview:imageline];
        
        
        UIImageView *imageline2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [imageline2 setBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1.0]];
        [self.tabBar addSubview:imageline2];
        
        
        
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
//        sendBtn.layer.cornerRadius = 5.0f;
        [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sendBtn.clipsToBounds = YES;
        [sendBtn setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0]];
        [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:sendBtn];
//        self.sendBtn = sendBtn;
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tabBar.mas_right).with.offset(0);
            make.top.equalTo(self.tabBar.mas_top).with.offset(1);
            //            make.bottom.mas_equalTo(10);
            make.width.mas_equalTo(53);
            make.height.mas_equalTo(39);
        }];
        
        // 表情选中的通知
//        [RHNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:HWEmotionDidSelectNotification object:nil];
    }
    return self;
}
- (void)sendMessage{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_EMOTION_SENDMESSAGE object:nil];
}
- (void)emotionDidSelect
{
    self.recentListView.emotions = [HWEmotionTool recentEmotions];
}

- (void)dealloc
{
//    [RHNotificationCenter removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 40;
    self.tabBar.left = 0;
    self.tabBar.top = self.height - self.tabBar.height;
    

    // 2.表情内容
    self.showingListView.left = self.showingListView.top = 0;
    self.showingListView.width = self.width;
//    self.showingListView.height = self.tabBar.y;
    self.showingListView.height = self.height;
    
    [self.tabBar setHidden:NO];
}

-(void)loadData{
    [self loadEmojiData];
}
#pragma mark - HWEmotionTabBarDelegate
- (void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    [self.tabBar removeFromSuperview];
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case HWEmotionTabBarButtonTypeQiDai2: { // 最近
            // 加载沙盒中的数据
//            self.recentListView.emotions = [HWEmotionTool recentEmotions];
            [self addSubview:self.defaultListView];
            [self.defaultListView addSubview:self.tabBar];
            
            break;
        }
            
//        case HWEmotionTabBarButtonTypeEmoji: { // 默认
//            [self addSubview:self.emojiListView];
//            
//            break;
//        }
//            
//        case HWEmotionTabBarButtonTypeQiDai1: { // Emoji
//            [self addSubview:self.recentListView];
//            break;
//        }
//            
        case HWEmotionTabBarButtonTypeQiDai1: { // Lxh
            [self addSubview:self.qiDaiListView1];
            [self.qiDaiListView1 addSubview:self.tabBar];
            break;
        }
//
//        case HWEmotionTabBarButtonTypeQiDai3: { // Lxh
//            [self addSubview:self.qiDaiListView1];
//            break;
//        }
//            
//        case HWEmotionTabBarButtonTypeQiDai4: { // Lxh
//            [self addSubview:self.qiDaiListView2];
//            break;
//        }
        default: {
            self.recentListView.emotions = [HWEmotionTool recentEmotions];
            [self addSubview:self.qiDaiListView1];
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}

@end
