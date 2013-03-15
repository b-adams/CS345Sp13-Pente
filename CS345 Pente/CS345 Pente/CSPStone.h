//
//  CSPStone.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPMoveInterface.h"

typedef enum {
    CSDID_North,
    CSDID_NorthEast,
    CSDID_East,
    CSDID_SouthEast,
    CSDID_South,
    CSDID_SouthWest,
    CSDID_West,
    CSDID_NorthWest,
    CSDID_NONE
} CSPDirectionID;

@interface CSPStone : NSObject
@property (strong) id<CSPMoveInterface> placement;
@property (assign) int longestChainLength;
@property (strong) NSMutableArray* neighbors;

-(id) initWithPlacement: (id<CSPMoveInterface>) whoAndWhere;
-(void) setNeighborTo:(CSPStone*) newNeighbor
          inDirection:(CSPDirectionID) whichWay;
-(int) chainLengthIn:(CSPDirectionID) whichDirection;
-(NSSet*) bookendedStonesIn:(CSPDirectionID) whichDirection;
-(NSSet*) bookendedStones;
-(int) neighborCount;

@end

CSPDirectionID oppositeDirectionOf(CSPDirectionID aDirection);