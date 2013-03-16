/**
 @file CSPStone.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
 */

#import <Foundation/Foundation.h>
#import "CSPMoveInterface.h"

@interface CSPStone : NSObject
@property (strong) id<CSPMoveInterface> placement;
@property (strong) NSMutableArray* neighbors;

-(id) initWithPlacement: (id<CSPMoveInterface>) whoAndWhere;
-(void) setNeighborTo:(CSPStone*) newNeighbor
          inDirection:(CSPDirectionID) whichWay;
-(void) removeNeighbor:(CSPStone*) aNeighbor;
-(void) removeSelfFromNeighbors;
-(NSUInteger) chainLengthIn:(CSPDirectionID) whichDirection;
-(NSSet*) bookendedStonesIn:(CSPDirectionID) whichDirection;
-(NSSet*) bookendedStones;
-(NSUInteger) neighborCount;
-(CSPStone*) neighborInDirection:(CSPDirectionID) whichDirection;
-(NSUInteger) longestChainLength;
@end

CSPDirectionID oppositeDirectionOf(CSPDirectionID aDirection);