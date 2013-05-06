/**
 @file CSPBoard.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
 */

#import <Foundation/Foundation.h>
@protocol CSPCoordinateInterface;

// TODO: Add fast enumeration and other collection protocols?
@interface CSPBoard : NSObject //<NSCopying, NSMutableCopying, NSFastEnumeration>

//NSImageView *CSPBoard;
@property (assign) NSUInteger width;
-initWithWidth:(NSUInteger) theWidth;
+boardWithWidth:(NSUInteger) theWidth;

-(void)clearCoordinate:(id<CSPCoordinateInterface>)coord;
-(void)setObjectAtCoordinate:(id<CSPCoordinateInterface>)coord
                    toObject:(id)anObject;
-(id)objectAtCoordinate:(id<CSPCoordinateInterface>)coord;
-(NSUInteger) count;

@end
