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
    int coordX = [self x] + directionOffsetX(whichDirection);
    int coordY = [self y] + directionOffsetY(whichDirection);

    return [[self class] coordinateWithX:coordX
                                    andY:coordY];
}

@end

int directionOffsetX(CSPDirectionID dir)
{
    switch(dir)
    {
        case CSDID_NorthWest:
        case CSDID_West:
        case CSDID_SouthWest:
            return -1; break;
            
        case CSDID_SouthEast:
        case CSDID_East:
        case CSDID_NorthEast:
            return 1; break;
            
        default:
            return 0; break;
    }
   
}
int directionOffsetY(CSPDirectionID dir)
{
    switch(dir)
    {
        case CSDID_NorthWest:
        case CSDID_North:
        case CSDID_NorthEast:
            return 1; break;
            
        case CSDID_SouthEast:
        case CSDID_South:
        case CSDID_SouthWest:
            return -1; break;
            
        default:
            return 0; break;
    }
}