/**
 @file CSPCoordinateInterface.h
 @author Bryant Adams 
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
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

@property (readonly, assign) NSUInteger x;
@property (readonly, assign) NSUInteger y;
-(id)initWithX:(NSUInteger) initialX andY:(NSUInteger) initialY;
+(id)coordinateWithX:(NSUInteger) initialX andY:(NSUInteger) initialY;
-(id<CSPCoordinateInterface>) coordinateInDirection:(CSPDirectionID)whichDirection;
@end
