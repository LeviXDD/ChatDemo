//
//  PDNetworkStatusManager.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/8/19.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "PDNetworkStatusManager.h"

@implementation PDNetworkStatusManager
#pragma mark----网络检测
+(PDNetworkStatus)netWorkState;
{
    UIApplication *app = [UIApplication sharedApplication];
    
//    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
//    int type = 0;
//    for (id child in children) {
//        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
//            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
//        }
//    }
    PDNetworkStatus status;
//    switch (type) {
//        case 1:  //2G
//            status = PDNetworkStatusWWAN2G;
//            break;
//
//        case 2:  //3G
//            status = PDNetworkStatusWWAN3G;
//            break;
//
//        case 3: //4G
//            status = PDNetworkStatusWWAN4G;
//            break;
//
//        case 4:  //未连接
//            status = PDNetworkStatusNotReachable;
//            break;
//
//        case 5:  //WIFI
            status = PDNetworkStatusWifi;
//            break;
//
//        default:  //未知
//            status = PDNetworkStatusUnknown;
//            break;
//    }
    return status;
}
//#pragma mark---网络断开时弹出提示框
//+(void)showWarningView
//{
//    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络断开，请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
//    [alter show];
//}
//#pragma mark---alertView点击事件
//+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0) {
//        NSLog(@"取消");
//    }else{
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
//}

@end
