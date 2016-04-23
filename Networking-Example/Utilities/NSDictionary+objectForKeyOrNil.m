//
//  NSDictionary+objectForKeyOrNil.m
//  Networking-Example
//
//  Created by Saleh AlDhobaie on 4/24/16.
//  Copyright © 2016 Saleh AlDhobaie. All rights reserved.
//

#import "NSDictionary+objectForKeyOrNil.h"

@implementation NSDictionary (objectForKeyOrNil)

- (id)objectForKeyOrNil:(id)key {
    id val = [self objectForKey:key];
    if ([val isEqual:[NSNull null]]) {
        return nil;
    }
    
    return val;
}


@end
