//
//  NJMessageModel.m
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ChatMessageModel.h"

@implementation ChatMessageModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)chatMessageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (BOOL)isMe{
    if (_type == NJMessageModelTypeMe) {
        return YES;
    }else{
        return NO;
    }
}





@end
