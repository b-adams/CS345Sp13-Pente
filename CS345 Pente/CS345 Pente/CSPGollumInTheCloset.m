//
//  CSPGollumInTheCloset.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPGollumInTheCloset.h"

@implementation CSPGollumInTheCloset
- (BOOL)isLegalMove:(id)id1
{
    return NO;
}

- (BOOL)makeMove:(id)id1
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

- (CSPPlayerID)whosePieceIsAt:(id)id1
{
    return CSPID_PlayerWhite;
}

- (int)boardWidth
{
    return 19;
}

- (int)longestChainForStoneAt:(id)id1
{
    return 0;
}

@end
