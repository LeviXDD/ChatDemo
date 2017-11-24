//
//  PDMessage.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "PDMessage.h"

@implementation PDMessage
-(NSString *)showTimeStr{
    if (!_showTimeStr) {
        _showTimeStr = [NSString string];
    }return _showTimeStr;
}
@end
