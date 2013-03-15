/**
 @file CSPCoordinateInterface.h
 @author Bryant Adams 
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 */

#import <Foundation/Foundation.h>

@protocol CSPCoordinateInterface <NSObject>

@property (readonly, assign) int x;
@property (readonly, assign) int y;
-(id)initWithX:(int) initialX andY:(int) initialY;
+(id)coordinateWithX:(int) initialX andY:(int) initialY;

@end
