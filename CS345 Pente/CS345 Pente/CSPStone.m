/**
 @file CSPStone.m
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
 */

#import "CSPStone.h"

@implementation CSPStone
-(NSString*) description
{
    char playerLetter;
    switch([[self placement] player])
    {
        case CSPID_PlayerWhite: playerLetter='W'; break;
        case CSPID_PlayerBlack: playerLetter='B'; break;
        default: playerLetter='.'; break;
    }
    return [NSString stringWithFormat:@"%ld%c",
            [self longestChainLength], playerLetter];
}
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

-(NSUInteger) neighborCount
{
    NSUInteger neighbors=0;
    for(id nbr in [self neighbors])
    {
        if(nbr!=[NSNull null]) neighbors+=1;
    }
    return neighbors;
}

- (NSUInteger)chainLengthIn:(CSPDirectionID)whichDirection
{
    CSPStone* nbr = [self neighborInDirection:whichDirection];
    if(!nbr)
        return 0;
    if([self hasSameOwnerAs:nbr])
        return 1 + [nbr chainLengthIn:whichDirection];
    else
        return 0;
}
- (NSUInteger)totalChainLengthAlong:(CSPDirectionID)dir
{
    NSUInteger foreLen=[self chainLengthIn:dir];
    NSUInteger backLen=[self chainLengthIn:oppositeDirectionOf(dir)];
    return foreLen + 1 + backLen;
}

-(NSUInteger) longestChainLength
{
    NSUInteger maxLen=0;
    NSUInteger dirLen;
    
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
- (BOOL)hasSameOwnerAs:(CSPStone *)anotherStone
{
    return [[anotherStone placement] player] == [[self placement] player];
}

- (NSSet *)bookendedStonesIn:(CSPDirectionID)whichDirection
{
    CSPStone* theBookend = nil;
    CSPStone* captiveTwo = nil;
    CSPStone* captiveOne = nil;
    NSSet* captives = [NSSet set];

    captiveOne = [self neighborInDirection:whichDirection];
    if(!captiveOne) return captives;
    if([self hasSameOwnerAs:captiveOne]) return captives;
    
    captiveTwo = [captiveOne neighborInDirection:whichDirection];
    if(!captiveTwo) return captives;
    if([self hasSameOwnerAs:captiveTwo]) return captives;
    
    theBookend = [captiveTwo neighborInDirection:whichDirection];
    if(!theBookend) return captives;
    if(![self hasSameOwnerAs:theBookend]) return captives;
    
    captives = [NSSet setWithObjects:captiveOne, captiveTwo, nil];
    return captives;
}

- (NSSet *)bookendedStones
{

    NSMutableSet* allCaptures = [NSMutableSet set];
    
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_North]];
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_NorthEast]];
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_NorthWest]];
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_South]];
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_SouthEast]];
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_SouthWest]];
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_East]];
    [allCaptures unionSet:[self bookendedStonesIn:CSDID_West]];

    return allCaptures;
}

- (void)removeNeighbor:(CSPStone *)aNeighbor
{
    NSUInteger index = [[self neighbors] indexOfObject:aNeighbor];
    [[self neighbors] replaceObjectAtIndex:index withObject:[NSNull null]];
}

- (void)removeSelfFromNeighbors
{
    for(CSPStone* aNeighbor in [self neighbors])
    {
        if((id)aNeighbor != [NSNull null])
            [aNeighbor removeNeighbor:self];
    }
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