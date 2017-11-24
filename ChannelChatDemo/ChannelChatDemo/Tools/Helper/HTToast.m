//
//  HTToast.m
//  LaiCiMai
//
//  Created by 海涛 黎 on 2017/11/1.
//  Copyright © 2017年 ShengJiTong. All rights reserved.
//

#import "HTToast.h"
#import "MBProgressHUD+MJ.h"
@implementation HTToast
+(void)showMessage:(NSString *)msg{
    [MBProgressHUD showMessage:EMPTY_IF_NIL(msg)];
}

+(void)showErrorWithMessage:(NSString *)errorMsg{
    [MBProgressHUD showMessage:EMPTY_IF_NIL(errorMsg)];
}
@end
