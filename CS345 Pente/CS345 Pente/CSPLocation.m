//
//  CSPLocation.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPLocation.h"

@implementation CSPLocation

- (id)initWithX:(int)initialX andY:(int)initialY
{
    self = [super init];
    if (self) {
        [self setX:initialX];
        [self setY:initialY];
    }
    return self;
}
- (id)init
{
    return [self initWithX:-1 andY:-1];
}
+(id) coordinateWithX:(int)initialX andY:(int)initialY
{
    return [[[self class] alloc] initWithX:initialX andY:initialY];
}
@end
