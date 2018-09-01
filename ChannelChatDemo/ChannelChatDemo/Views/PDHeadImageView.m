//
//  PDHeadImageView.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "PDHeadImageView.h"
#define XZRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@interface PDHeadImageView ()

@property (nonatomic, assign) CGFloat bordering;

@end
@implementation PDHeadImageView
- (instancetype)init
{
    if (self = [super init]) {
        [self imageView];
        self.layer.masksToBounds = YES;
        self.backgroundColor = XZRGB(0xf0f0f0);
        self.bordering = 0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


- (void)layoutSubviews
{
    self.layer.cornerRadius = 3.;
    self.imageView.width = self.frame.size.width - _bordering;
    self.imageView.height = self.frame.size.height - _bordering;
    self.imageView.layer.cornerRadius = self.layer.cornerRadius;//self.imageView.width*0.5;
    
    self.imageView.centerX = self.width*0.5;
    self.imageView.centerY = self.height*0.5;
}

- (void)setColor:(UIColor *)color bording:(CGFloat)bord
{
    self.backgroundColor = color;
    self.bordering = bord;
}

#pragma mark - Getters
- (UIImageView *)imageView
{
    if (nil == _imageView) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.layer.masksToBounds = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageV];
        _imageView = imageV;
    }
    return _imageView;
}
@end
