//
//  CSPStone.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPStone.h"

@implementation CSPStone
- (id)init
{
    return [self initWithPlacement:nil];
}
- (id)initWithPlacement:(id <CSPMoveInterface>)whoAndWhere
{
    if(!whoAndWhere) return nil;
    
    self = [super init];
    if (self) {
        [self setPlacement:whoAndWhere];
        [self setNeighbors:[NSMutableArray arrayWithCapacity:8]];
        for(int i=0; i<8; i++)
        {
            [[self neighbors] addObject:[NSNull null]];
        }
    }
    return self;
}

- (void)setNeighborTo:(CSPStone *)newNeighbor
          inDirection:(CSPDirectionID)whichWay
{
    id addition = newNeighbor;
    if(!newNeighbor) addition = [NSNull null];
    [[self neighbors] setObject:addition
             atIndexedSubscript:whichWay];
}
-(CSPStone*) neighborInDirection:(CSPDirectionID) whichDirection
{
    id theNeighbor = [[self neighbors] objectAtIndex:whichDirection];
    if(theNeighbor == [NSNull null]) theNeighbor=nil;
    return theNeighbor;    
}

-(int) neighborCount
{
    int neighbors=0;
    for(id nbr in [self neighbors])
    {
        if(nbr!=[NSNull null]) neighbors+=1;
    }
    return neighbors;
}

- (int)chainLengthIn:(CSPDirectionID)whichDirection
{
    CSPStone* nbr = [self neighborInDirection:whichDirection];
    if(!nbr)
        return 0;
    if([[nbr placement] player] != [[self placement] player])
        return 0;

    return 1 + [nbr chainLengthIn:whichDirection];
}
- (int)totalChainLengthAlong:(CSPDirectionID)dir
{
    int foreLen;
    int backLen;
    int totLen;
    foreLen=[self chainLengthIn:dir];
    backLen=[self chainLengthIn:oppositeDirectionOf(dir)];
    totLen = foreLen + 1 + backLen;
    return totLen;
}

-(int) longestChainLength
{
    int maxLen=0;
    int dirLen;
    
    dirLen = [self totalChainLengthAlong:CSDID_North];
    if(dirLen > maxLen) maxLen = dirLen;

    dirLen = [self totalChainLengthAlong:CSDID_NorthEast];
    if(dirLen > maxLen) maxLen = dirLen;
    
    dirLen = [self totalChainLengthAlong:CSDID_East];
    if(dirLen > maxLen) maxLen = dirLen;
    
    dirLen = [self totalChainLengthAlong:CSDID_SouthEast];
    if(dirLen > maxLen) maxLen = dirLen;
    
    return maxLen;
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