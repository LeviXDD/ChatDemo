//
//  UILabel+fastLab.m
//  Chanel
//
//  Created by 徐兆阳 on 17/3/1.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "UILabel+fastLab.h"

@implementation UILabel (fastLab)


+(instancetype)fastLabWithTitle:(NSString *)title andTitleFont:(UIFont *)font andTitleColor:(UIColor *)color{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = title;
    lab.font = font;
    lab.textColor = color;
    return lab;
}
@end
