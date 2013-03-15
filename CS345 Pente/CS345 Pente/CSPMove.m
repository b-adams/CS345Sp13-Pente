//
//  CSPMove.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPMove.h"

@implementation CSPMove
- (id)initWithPlayer:(CSPPlayerID)who
                 atX:(int)initialX
                andY:(int)initialY
{
    self = [super init];
    if (self) {
        [self setY:initialY];
        [self setX:initialX];
        [self setPlayer:who];
    }
    return self;
}

- (id)init
{
    return [self initWithPlayer:CS345NOBODY atX:-1 andY:-1];
}

+ (id)moveWithPlayer:(CSPPlayerID)who
                 atX:(int)initialX
                andY:(int)initialY
{
    return nil;
}

+ (id)moveWithPlayer:(CSPPlayerID)who
          atLocation:(id <CSPCoordinateInterface>)location
{
    return nil;
}

- (id)initWithX:(int)initialX
           andY:(int)initialY
{
    return nil;
}

+ (id)coordinateWithX:(int)initialX
                 andY:(int)initialY
{
    return nil;
}

@end
