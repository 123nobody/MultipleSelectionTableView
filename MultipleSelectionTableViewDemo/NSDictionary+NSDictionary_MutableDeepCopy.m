//
//  NSDictionary+NSDictionary_MutableDeepCopy.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-17.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "NSDictionary+NSDictionary_MutableDeepCopy.h"

@implementation NSDictionary (NSDictionary_MutableDeepCopy)

- (NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *ret = [[NSMutableDictionary alloc]initWithCapacity:self.count];
    NSArray *keys = [self allKeys];
    for (id key in keys) {
        id oneObject = [self objectForKey:key];
        id oneCopy = nil;
        
        if ([oneObject respondsToSelector:@selector(mutableDeepCopy)]) {
            oneCopy = [oneObject mutableDeepCopy];
        } else if ([oneObject respondsToSelector:@selector(mutableCopy)]) {
            oneCopy = [oneObject mutableCopy];
        }
        if (oneCopy == nil) {
            oneCopy = [oneObject copy];
        }
        [ret setObject:oneCopy forKey:key];
    }
    return ret;
}

@end
