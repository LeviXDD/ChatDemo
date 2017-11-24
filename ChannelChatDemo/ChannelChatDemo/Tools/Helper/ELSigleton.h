//
//  ELSigleton.h
//  EndLive
//
//  Created by 徐兆阳 on 16/11/18.
//  Copyright © 2016年 xzy. All rights reserved.
//



// .h文件
#define WMSingletonH(name) + (instancetype)shared##name;

// .m文件
#define WMSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}


