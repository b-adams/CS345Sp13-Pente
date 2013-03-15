//
//  CSPStone.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPMoveInterface.h"

@interface CSPStone : NSObject
@property (strong) id<CSPMoveInterface> placement;
@property (strong) NSMutableArray* neighbors;

-(id) initWithPlacement: (id<CSPMoveInterface>) whoAndWhere;
-(void) setNeighborTo:(CSPStone*) newNeighbor
          inDirection:(CSPDirectionID) whichWay;
-(int) chainLengthIn:(CSPDirectionID) whichDirection;
-(NSSet*) bookendedStonesIn:(CSPDirectionID) whichDirection;
-(NSSet*) bookendedStones;
-(int) neighborCount;
-(CSPStone*) neighborInDirection:(CSPDirectionID) whichDirection;
-(int) longestChainLength;
@end

CSPDirectionID oppositeDirectionOf(CSPDirectionID aDirection);