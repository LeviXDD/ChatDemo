//
//  RHChatToolKeyBoard.m
//  Chanel
//
//  Created by archermind on 16/3/29.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import "RHChatToolKeyBoard.h"

@interface RHChatToolKeyBoard ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation RHChatToolKeyBoard

-(NSArray *)titleArray{
        _titleArray = @[@"照片",@"小视频"];
        return _titleArray;
}

-(void)setIsSameTopic:(BOOL)isSameTopic{
    _titleArray = @[@"照片",@"小视频",@"AR红包"];
    _imageArray = @[@"icon_picture",@"icon_fun_video",@"sendPacket"];
}

-(NSArray *)imageArray{
    return  @[@"tp_selectPic",@"tp_selectVideo"];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
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
@end
