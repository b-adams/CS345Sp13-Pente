/**
 @file CSPCoordinateInterface.h
 @author Bryant Adams 
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 */

#import <Foundation/Foundation.h>

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

@protocol CSPCoordinateInterface <NSObject>

@property (readonly, assign) int x;
@property (readonly, assign) int y;
-(id)initWithX:(int) initialX andY:(int) initialY;
+(id)coordinateWithX:(int) initialX andY:(int) initialY;

@end
