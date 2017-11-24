//
//  NSArray+IndexArray.h
//  Winsley
//
//  Created by 海涛 on 17/1/11.
//  Copyright © 2017年 . All rights reserved.
//

#import "NSArray+IndexArray.h"

@implementation NSArray(indexArray)
- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (NSDictionary*)gx_safeDictionaryAtIndex:(NSUInteger)index{
    NSDictionary* dictionary = nil;
    
    if (index < self.count){
        id obj = [self objectAtIndex:index];
        if ([obj isKindOfClass:[NSDictionary class]]){
            dictionary = obj;
        }
    }
    
    if (!dictionary) {
        dictionary = [NSDictionary dictionary];
    }
    return dictionary;
}
@end
