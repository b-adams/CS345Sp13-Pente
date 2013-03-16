/**
 @file CSPMoveInterface.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 */

#import <Foundation/Foundation.h>
#import "CSPCoordinateInterface.h"

typedef enum {
    CSPID_NOBODY,
    CSPID_PlayerBlack,
    CSPID_PlayerWhite
} CSPPlayerID;

@protocol CSPMoveInterface <CSPCoordinateInterface>

@property (readonly, assign) CSPPlayerID player;
-(id)initWithPlayer:(CSPPlayerID) who
                atX:(NSUInteger) initialX
               andY:(NSUInteger) initialY;
+(id)moveWithPlayer:(CSPPlayerID) who
                atX:(NSUInteger) initialX
               andY:(NSUInteger) initialY;
+(id)moveWithPlayer:(CSPPlayerID) who
         atLocation:(id<CSPCoordinateInterface>) location;

@end
