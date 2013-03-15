/**
 @file CSPMoveInterface.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 */

#import <Foundation/Foundation.h>
#import "CSPCoordinateInterface.h"

typedef enum {
    CS345NOBODY,
    CS345PlayerBlack,
    CS345PlayerWhite
} CSPPlayerID;

@protocol CSPMoveInterface <CSPCoordinateInterface>

@property (readonly, assign) CSPPlayerID player;
-(id)initWithPlayer:(CSPPlayerID) who
                atX:(int) initialX
               andY:(int) initialY;
+(id)moveWithPlayer:(CSPPlayerID) who
                atX:(int) initialX
               andY:(int) initialY;
+(id)moveWithPlayer:(CSPPlayerID) who
         atLocation:(id<CSPCoordinateInterface>) location;

@end
