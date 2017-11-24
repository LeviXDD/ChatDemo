//
//  HTToast.h
//  LaiCiMai
//
//  Created by 海涛 黎 on 2017/11/1.
//  Copyright © 2017年 ShengJiTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTToast : NSObject
+(void)showMessage:(NSString*)msg;
+(void)showErrorWithMessage:(NSString*)errorMsg;
@end
