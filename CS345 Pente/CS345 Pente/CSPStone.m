//
//  CSPStone.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPStone.h"

@implementation CSPStone
- (id)initWithPlacement:(id <CSPMoveInterface>)whoAndWhere
{
    return nil;
}

- (void)setNeighborTo:(CSPStone *)newNeighbor
          inDirection:(CSPDirectionID)whichWay
{

}

- (int)chainLengthIn:(CSPDirectionID)whichDirection
{
    return 0;
}

- (NSSet *)bookendedStonesIn:(CSPDirectionID)whichDirection
{
    return nil;
}

- (NSSet *)bookendedStones
{
    return nil;
}

@end

CSPDirectionID oppositeDirectionOf(CSPDirectionID aDirection)
{
    switch(aDirection)
    {
        case CSDID_East: return CSDID_West; break;
        case CSDID_West: return CSDID_East; break;
        case CSDID_South: return CSDID_North; break;
        case CSDID_North: return CSDID_South; break;
        case CSDID_SouthEast: return CSDID_NorthWest; break;
        case CSDID_SouthWest: return CSDID_NorthEast; break;
        case CSDID_NorthEast: return CSDID_SouthWest; break;
        case CSDID_NorthWest: return CSDID_SouthEast; break;
        case CSDID_NONE:
        default: return CSDID_NONE; break;
    }
}