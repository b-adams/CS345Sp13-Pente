//
//  CSPGollumInTheCloset.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPGollumInTheCloset.h"

@implementation CSPGollumInTheCloset
- (BOOL)isLegalMove:(id<CSPMoveInterface>)aMove
{
    return NO;
}

- (BOOL)makeMove:(id<CSPMoveInterface>)aMove
{
    return NO;
}

- (int)capturesByPlayer:(CSPPlayerID)player
{
    return 0;
}

- (CSPPlayerID)whoIsWinner
{
    return CSPID_PlayerWhite;
}

- (CSPPlayerID)whoseTurnIsIt
{
    return CSPID_PlayerWhite;
}

- (CSPPlayerID)whosePieceIsAt:(id<CSPCoordinateInterface>)aLocation
{
    return CSPID_PlayerWhite;
}

- (int)boardWidth
{
    return 19;
}

- (int)longestChainForStoneAt:(id<CSPCoordinateInterface>)aLocation
{
    return 0;
}

@end
