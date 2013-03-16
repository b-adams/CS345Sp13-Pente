//
//  CSPLocation.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPLocation.h"

@implementation CSPLocation
-(NSString*) description
{
    return [NSString stringWithFormat:@"X:%ld Y:%ld", [self x], [self y]];
}
- (id)initWithX:(NSUInteger)initialX andY:(NSUInteger)initialY
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
+(id) coordinateWithX:(NSUInteger)initialX andY:(NSUInteger)initialY
{
    return [[[self class] alloc] initWithX:initialX andY:initialY];
}

- (id <CSPCoordinateInterface>)coordinateInDirection:(CSPDirectionID)whichDirection
{
    NSUInteger coordX = [self x] + directionOffsetX(whichDirection);
    NSUInteger coordY = [self y] + directionOffsetY(whichDirection);

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
