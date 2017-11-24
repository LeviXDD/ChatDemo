//
//  PDNetworkStatusManager.h
//  Chanel
//
//  Created by 海涛 黎 on 2017/8/19.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PDNetworkStatusUnknown,
    PDNetworkStatusNotReachable,
    PDNetworkStatusWWAN2G,
    PDNetworkStatusWWAN3G,
    PDNetworkStatusWWAN4G,
    PDNetworkStatusWifi,
    
}PDNetworkStatus;

typedef void(^netStateBlock)(PDNetworkStatus networkStatus);

@interface PDNetworkStatusManager : NSObject
+(PDNetworkStatus)netWorkState;
@end
