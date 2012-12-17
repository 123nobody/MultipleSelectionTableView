//
//  NSDictionary+NSDictionary_AllSortedKeys.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-17.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "NSDictionary+NSDictionary_AllSortedKeys.h"

@implementation NSDictionary (NSDictionary_AllSortedKeys)

- (NSArray *)allSortedKeys
{
    NSArray *keys = [self allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    return sortedKeys;
}

@end
