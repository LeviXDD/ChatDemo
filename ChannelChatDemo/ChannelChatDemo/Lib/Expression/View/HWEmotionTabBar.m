//
//  HWEmotionTabBar.m
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWEmotionTabBar.h"

@interface HWEmotionTabBar()
@property (nonatomic, weak) HWEmotionTabBarButton *selectedBtn;
@end

@implementation HWEmotionTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//       [self setupBtn:@"Emoji" buttonType:HWEmotionTabBarButtonTypeAdd];
       // [self setupBtn:@"Emoji" buttonType:HWEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"" buttonType:HWEmotionTabBarButtonTypeQiDai1];
        
//        [self setupBtn:@"期待" buttonType:HWEmotionTabBarButtonTypeQiDai2];
        
        [self setupBtn:@"" buttonType:HWEmotionTabBarButtonTypeQiDai2];
//        [self setupBtn:@"期待" buttonType:HWEmotionTabBarButtonTypeQiDai2];
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (HWEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(HWEmotionTabBarButtonType)buttonType
{
    // 创建按钮
    HWEmotionTabBarButton *btn = [[HWEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:btn];
    
//    [btn setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    // 设置背景图片
    NSString *image = @"btnicon_male";
    NSString *image2=@"btnicon_female";
    if(buttonType ==HWEmotionTabBarButtonTypeQiDai2){
//        [btn setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0 alpha:1.0]];
//        PDUser *user = [PDUser sharedInstance];
//        if([user.sex intValue]==1)
            [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//        else
//            [btn setImage:[UIImage imageNamed:image2] forState:UIControlStateNormal];
    }
    else if (buttonType ==HWEmotionTabBarButtonTypeQiDai1){
//        [btn setTitle:@"默认" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"default_icon"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    }
    
    
//    NSString *selectImage = @"compose_emotion_table_mid_selected";
//    if (self.subviews.count == 1) {
//        image = @"compose_emotion_table_left_normal";
//        selectImage = @"compose_emotion_table_left_selected";
//    } else if (self.subviews.count == 4) {
//        image = @"compose_emotion_table_right_normal";
//        selectImage = @"compose_emotion_table_right_selected";
//    }
    
//    if(buttonType == HWEmotionTabBarButtonTypeAdd){
//    
//    }else if (buttonType == HWEmotionTabBarButtonTypeEmoji){
//    
//    }else{
//        [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
//    }
    
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    
    CGFloat btnW = 50;//self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIView *sub =self.subviews[i];
        if(![sub isKindOfClass:[UIImageView class]]&&![sub isEqual:[self.subviews lastObject]]){
        HWEmotionTabBarButton *btn = self.subviews[i];
        btn.top = 0;
        btn.width = btnW;
        btn.left = i * btnW;
        btn.height = btnH;
            
        }
        
    }
}

- (void)setDelegate:(id<HWEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 选中“默认”按钮
//    [self btnClick:(HWEmotionTabBarButton *)[self viewWithTag:HWEmotionTabBarButtonTypeEmoji]];
    [self btnClick:(HWEmotionTabBarButton *)[self viewWithTag:HWEmotionTabBarButtonTypeAdd]];
    
}

/**
 *  按钮点击
 */
- (void)btnClick:(HWEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
//    btn.enabled = NO;
    self.selectedBtn = btn;
    for(UIView *vc in self.subviews)
    {
        if([vc isKindOfClass:[HWEmotionTabBarButton class]]){
            [vc setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0 alpha:1.0]];
        }
    }
    [btn setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    
    
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(int)btn.tag];
    }
}

@end
