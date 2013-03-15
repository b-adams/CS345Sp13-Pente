//
//  CSPLocation.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPLocation.h"

@implementation CSPLocation
@synthesize x;
@synthesize y;

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

- (id <CSPCoordinateInterface>)coordinateInDirection:(CSPDirectionID)whichDirection
{
    int currentX = [self x];
    int currentY = [self y];
    switch(whichDirection)
    {
        case CSDID_NorthWest:
        case CSDID_North:
        case CSDID_NorthEast:
            currentY+=1;
            break;

        case CSDID_SouthEast:
        case CSDID_South:
        case CSDID_SouthWest:
            currentY-=1;
            break;

        default: break;
    }
    switch(whichDirection)
    {
        case CSDID_NorthWest:
        case CSDID_West:
        case CSDID_SouthWest:
            currentX-=1;
            break;

        case CSDID_SouthEast:
        case CSDID_East:
        case CSDID_NorthEast:
            currentX+=1;
            break;

        default: break;
    }

    return [[self class] coordinateWithX:currentX
                                    andY:currentY];
}

@end
