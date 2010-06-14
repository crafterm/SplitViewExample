//
//  NSArray+FirstObject.m
//  Trends
//
//  Created by Marcus Crafter on 6/02/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "NSArray+FirstObject.h"


@implementation NSArray (FirstObject)

- (BOOL)empty {
    return [self count] == 0;
}

- (id)firstObject {
    if ([self empty]) {
        return nil;
    }
    return [self objectAtIndex:0];
}

- (id)lastObject {
    if ([self empty]) {
        return nil;
    }
    
    return [self objectAtIndex:([self count] - 1)];
}

@end
