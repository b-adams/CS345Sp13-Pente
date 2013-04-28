//
//  CSPBoardViewDataSource.h
//  CS345 Pente
//
//  Created by Bryant Adams on 4/28/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPCoordinateInterface.h"
#import "CSPMoveInterface.h"

@protocol CSPBoardViewDataSource <NSObject>
-(NSString*) pieceColorAtLocation:(id<CSPCoordinateInterface>) where;
-(NSUInteger) pieceChainLengthAtLocation:(id<CSPCoordinateInterface>) where;
-(BOOL) isMoveLegal:(id<CSPMoveInterface>) aMove;
-(BOOL) makeMoveHappen:(id<CSPMoveInterface>) aMove;
@end
