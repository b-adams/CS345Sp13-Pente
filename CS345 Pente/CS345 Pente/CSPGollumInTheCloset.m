//
//  CSPGollumInTheCloset.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPGollumInTheCloset.h"
#import "CSPCoordinateInterface.h"
#import "CSPBoard.h"
#import "CSPStone.h"

@implementation CSPGollumInTheCloset
{
    CSPBoard* _theBoard;
}
- (id)init
{
    self = [super init];
    if (self) {
        _theBoard = [CSPBoard boardWithWidth:19];
    }
    return self;
}
- (BOOL)isLegalMove:(id<CSPMoveInterface>)aMove
{
    if([self turnNumber]==2 &&
       [self isInCenterRegion:aMove]) return NO;
    
    if(![self isCurrentTurn:[aMove player]]) return NO;
    
    id currentObject = [_theBoard objectAtCoordinate:aMove];
    if(currentObject) return NO;
    
    return YES;
}

- (void)makeMove:(id<CSPMoveInterface>)aMove
{
//check for legality first
    [self setTurnNumber:1+[self turnNumber]];
    CSPStone* theStone = [[CSPStone alloc] initWithPlacement:aMove];
    [_theBoard setObjectAtCoordinate:aMove
                            toObject:theStone];
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
