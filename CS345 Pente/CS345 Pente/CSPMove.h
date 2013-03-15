//
//  CSPMove.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPMoveInterface.h"

@interface CSPMove : NSObject <CSPMoveInterface>
@property (assign) int x;
@property (assign) int y;
@property (assign) CSPPlayerID player;
@end
