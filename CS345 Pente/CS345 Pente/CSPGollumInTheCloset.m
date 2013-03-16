//
//  CSPGollumInTheCloset.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPGollumInTheCloset.h"
#import "CSPCoordinateInterface.h"

@implementation CSPGollumInTheCloset
{
    id<CSPCoordinateInterface> _lastMove;
}
- (BOOL)isLegalMove:(id<CSPMoveInterface>)aMove
{
    if([self turnNumber]==2 &&
       [self isInCenterRegion:aMove]) return NO;
    
    if(![self isCurrentTurn:[aMove player]]) return NO;
    
    int curX = [aMove x];
    int oldX = [_lastMove x];
    int curY = [aMove y];
    int oldY = [_lastMove y];
    if(curX == oldX && curY == oldY)
        return NO;
    
    return YES;
}

- (BOOL)makeMove:(id<CSPMoveInterface>)aMove
{
    [self setTurnNumber:1+[self turnNumber]];
    _lastMove = aMove;
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

#pragma mark Helper Methods
-(BOOL) isInCenterRegion:(id<CSPMoveInterface>)aMove
{
    if([aMove x] <= 5) return NO;
    if([aMove x] >=13) return NO;
    if([aMove y] <= 5) return NO;
    if([aMove y] >=13) return NO;
    return YES;
}

- (BOOL)isCurrentTurn:(CSPPlayerID)turnColor
{
    CSPPlayerID correctTurnColor = [self turnNumber]%2 ? CSPID_PlayerBlack : CSPID_PlayerWhite;
    
    return correctTurnColor==turnColor;
}


@end
