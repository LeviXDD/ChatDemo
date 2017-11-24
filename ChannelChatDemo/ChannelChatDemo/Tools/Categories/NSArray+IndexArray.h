//
//  NSArray+IndexArray.h
//  Winsley
//
//  Created by 海涛 on 17/1/11.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(indexArray)
- (id)objectAtIndexCheck:(NSUInteger)index;
- (NSDictionary*)gx_safeDictionaryAtIndex:(NSUInteger)index;

@end
