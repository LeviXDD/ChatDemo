//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view with:(float)sec
{
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];//[[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.layer.cornerRadius = 2.;
    hud.bezelView.color= [UIColor hx_colorWithHexString:@"#21262D"];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont fontWithName:kPingFangSC_Regular size:16];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.userInteractionEnabled = YES;
    //    hud.contentColor = [UIColor blackColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    //     设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    //     再设置模式
    
    [hud hideAnimated:YES afterDelay:2.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view with:2.5];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view with:2.5];
}

+ (void)showSuccess:(NSString *)success  andDes:(NSInteger)des{
    [self show:success icon:nil view:nil with:des];
}
#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [Utils currentViewController].view;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.layer.cornerRadius = 2.;
    hud.bezelView.color= [UIColor hx_colorWithHexString:@"#21262D"];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont fontWithName:kPingFangSC_Regular size:16];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
//    hud.contentColor = [UIColor blackColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:2.5];
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        [self showSuccess:success toView:nil];
    });
}

+ (void)showError:(NSString *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
    //回调或者说是通知主线程刷新，
        [self showError:error toView:nil];
    });
}

+ (void)showMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
         [self showMessage:message toView:nil];
    });
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
