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
    NSDictionary* _captures;
}

- (id)init
{
    self = [super init];
    if (self) {
        _theBoard = [CSPBoard boardWithWidth:19];
        [self setGameOverState:CSPGO_GameNotOver];
        
        _captures = @{@"White": [NSMutableSet set],
                      @"Black": [NSMutableSet set]};
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
    [self setTurnNumber:1+[self turnNumber]];
    CSPStone* theStone = [[CSPStone alloc] initWithPlacement:aMove];
    [_theBoard setObjectAtCoordinate:aMove
                            toObject:theStone];
    CSPPlayerID thePlayer = [aMove player];
    NSString* playerKey = nil;
    id<CSPCoordinateInterface> tempLocation = nil;
    CSPStone* tempStone = nil;

    for(CSPDirectionID dir=0; dir<=8; dir+=1)
    {
        tempLocation = [aMove coordinateInDirection:dir];
        tempStone = [_theBoard objectAtCoordinate:tempLocation];
        if(tempStone)
        {
            [theStone setNeighborTo:tempStone
                        inDirection:dir];
            [tempStone setNeighborTo:theStone
                         inDirection:oppositeDirectionOf(dir)];

        }
    }
    NSSet* captives = [theStone bookendedStones];
    for(tempStone in captives)
    {
        [tempStone removeSelfFromNeighbors];
        [_theBoard clearCoordinate:[tempStone placement]];
    }
    if([captives count]>0)
    {
        switch(thePlayer)
        {
            case CSPID_PlayerWhite: playerKey=@"White"; break;
            case CSPID_PlayerBlack: playerKey=@"Black"; break;
            case CSPID_NOBODY:
            default: playerKey=@"ERROR";
        }
    }
    NSMutableSet* oldCaptures = [_captures objectForKey:playerKey];
    [oldCaptures unionSet:captives];
    NSUInteger longest = [theStone longestChainLength];
    
    if([theStone longestChainLength]==5)
    {
        switch(thePlayer)
        {
            case CSPID_PlayerBlack: [self setGameOverState:CSPGO_BlackWins]; break;
            case CSPID_PlayerWhite: [self setGameOverState:CSPGO_WhiteWins]; break;
            default: break; //???
        }
    }
}

- (NSUInteger)capturesByPlayer:(CSPPlayerID)player
{
    NSString* playerKey = nil;
    switch(player)
    {
        case CSPID_PlayerWhite: playerKey=@"White"; break;
        case CSPID_PlayerBlack: playerKey=@"Black"; break;
        case CSPID_NOBODY:
        default: playerKey=@"ERROR";
    }
    NSSet* captures = [_captures objectForKey:playerKey];
    return [captures count];
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

- (NSUInteger)boardWidth
{
    return [_theBoard width];
}

- (NSUInteger)longestChainForStoneAt:(id<CSPCoordinateInterface>)aLocation
{
    CSPStone* thePiece = [_theBoard objectAtCoordinate:aLocation];
    return [thePiece longestChainLength];
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
