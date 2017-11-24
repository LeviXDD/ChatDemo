//
//  UIImage+Extension.h
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  传入图片的名称,返回一张可拉伸不变形的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 可拉伸图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;
+ (UIImage *)imageWithColor:(UIColor *)color ;
+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)gxz_imageWithColor:(UIColor *)color;

+ (UIImage *)videoFramerateWithPath:(NSString *)videoPath;

// 压缩图片
+ (UIImage *)simpleImage:(UIImage *)originImg;

+ (UIImage *)makeArrowImageWithSize:(CGSize)imageSize
                              image:(UIImage *)image
                           isSender:(BOOL)isSender;

+ (UIImage *)addImage2:(UIImage *)firstImg
               toImage:(UIImage *)secondImg;

+ (UIImage *)addImage:(UIImage *)firstImg
              toImage:(UIImage *)secondImg;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
