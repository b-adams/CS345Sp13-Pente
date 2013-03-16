/**
 @file CSPMove.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
 */

#import <Foundation/Foundation.h>
#import "CSPMoveInterface.h"
#import "CSPLocation.h"

@interface CSPMove : CSPLocation <CSPMoveInterface>
@property (assign) NSUInteger x;
@property (assign) NSUInteger y;
@property (assign) CSPPlayerID player;
@end
