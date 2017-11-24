//
//  RHChatToolKeyBoard.m
//  Chanel
//
//  Created by archermind on 16/3/29.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import "RHChatToolKeyBoard.h"

@interface RHChatToolKeyBoard ()

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *imageArray;

@end

@implementation RHChatToolKeyBoard

-(NSArray *)titleArray{
//    PDUser *user = [PDUser sharedInstance];
//    // 先判断是不是私聊
//    if (STRING_ISNOTNIL(self.channelID)) { //私聊
//          _titleArray = @[@"照片",@"小视频"];
//    }else{
//        if (self.isSameTopic) {
            _titleArray = @[@"照片",@"小视频"];
//        } else {
//            _titleArray = @[@"照片",@"小视频",@"AR红包"/**/];
//        }
//    }
        return _titleArray;
}

-(void)setIsSameTopic:(BOOL)isSameTopic{
    _isSameTopic = isSameTopic;
    //    _isSameTopic = isSameTopic;
        if (_isSameTopic) {
            _imageArray = @[@"tp_selectPic",@"tp_selectVideo"];
            _titleArray = @[@"照片",@"小视频"/**/];
            [self removeAllSubviews];
            for (int index = 0; index<self.titleArray.count; index++) {
                [self setupToolButtonWithTitle:self.titleArray[index] image:self.imageArray[index]];
            }
            [self layoutSubviews];
        } else {
            _titleArray = @[@"照片",@"小视频",@"AR红包"/**/];
            _imageArray = @[@"icon_picture",@"icon_fun_video",@"sendPacket"];
        }
}

-(NSArray *)imageArray{
//    PDUser *user = [PDUser sharedInstance];
    // 先判断是不是私聊
//    if (STRING_ISNIL(self.channelID)) { //私聊
        if (self.isSameTopic) {
            _imageArray = @[@"tp_selectPic",@"tp_selectVideo"];
//        } else {
//            _imageArray = @[@"icon_picture",@"icon_fun_video",@"sendPacket"];
        }
//    }else{
//            _imageArray = @[@"icon_picture",@"icon_fun_video",@"sendPacket"];
//    }
    return _imageArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

-(void)setChannelID:(NSString *)channelID{
    _channelID = channelID;
    for (int index = 0; index<self.titleArray.count; index++) {
        [self setupToolButtonWithTitle:self.titleArray[index] image:self.imageArray[index]];
    }
    [self layoutSubviews];
    
}
- (void)setupToolButtonWithTitle:(NSString *)title image:(NSString *)image{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];

    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(80, -60, 0, 10)];
    if (_isSameTopic) {
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 内边距(四周)
    CGFloat inset = 10;
    NSUInteger count = self.titleArray.count;
    CGFloat btnW = (self.width - 2 * inset) / 4;
    CGFloat btnH = (self.height - inset) / 2;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.tag = i;
        btn.width = btnW;
        btn.height = btnH;
        btn.left = inset + (i % 4) * btnW;
        btn.top = inset + (i/4) * btnH;
    }
}

- (void)buttonClick:(UIButton *)btn{
    
    if (self.toolButtonSelected) {
        self.toolButtonSelected(btn.tag);
    }
}






























@end
