//
//  PDHeadImageView.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDHeadImageView : UIView
@property (nonatomic, weak) UIImageView *imageView;

- (void)setColor:(UIColor *)color bording:(CGFloat)bording;
@end
