//
//  CSPBoard.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol CSPCoordinateInterface;

@interface CSPBoard : NSObject //<NSCopying, NSMutableCopying, NSFastEnumeration>
@property (assign) NSUInteger width;
-initWithWidth:(NSUInteger) theWidth;
+boardWithWidth:(NSUInteger) theWidth;

-(void)clearCoordinate:(id<CSPCoordinateInterface>)coord;
-(void)setObjectAtCoordinate:(id<CSPCoordinateInterface>)coord
                    toObject:(id)anObject;
-(id)objectAtCoordinate:(id<CSPCoordinateInterface>)coord;
-(NSUInteger) count;

@end
