//
//  CSPMove.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPMove.h"

@implementation CSPMove
-(NSString*) description
{
    char playerLetter;
    switch([self player])
    {
        case CSPID_PlayerWhite: playerLetter='W'; break;
        case CSPID_PlayerBlack: playerLetter='B'; break;
        default: playerLetter='.'; break;
    }
    return [NSString stringWithFormat:@"P:%c X:%ld Y:%ld",
            playerLetter, [self x], [self y]];
}
- (id)initWithPlayer:(CSPPlayerID)who
                 atX:(NSUInteger)initialX
                andY:(NSUInteger)initialY
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
    return [self initWithPlayer:CSPID_NOBODY atX:-1 andY:-1];
}

+ (id)moveWithPlayer:(CSPPlayerID)who
                 atX:(NSUInteger)initialX
                andY:(NSUInteger)initialY
{
    return [[self alloc] initWithPlayer:who
                                    atX:initialX
                                   andY:initialY];
}

+ (id)moveWithPlayer:(CSPPlayerID)who
          atLocation:(id <CSPCoordinateInterface>)location
{
    return [[self class] moveWithPlayer:who
                                    atX:[location x]
                                   andY:[location y]];
    return nil;
}
@end
