/**
 @file CSPLocation.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
 */

#import <Foundation/Foundation.h>
#import "CSPCoordinateInterface.h"

@interface CSPLocation : NSObject <CSPCoordinateInterface>
@property (assign) NSUInteger x;
@property (assign) NSUInteger y;


@end

int directionOffsetX(CSPDirectionID dir);
int directionOffsetY(CSPDirectionID dir);