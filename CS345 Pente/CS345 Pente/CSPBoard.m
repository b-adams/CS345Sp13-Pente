//
//  CSPBoard.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//


//2D array with access by CSPLocation Interfaced indices
//Also should have fast enumeration (?)
#import "CSPBoard.h"

@implementation CSPBoard
- (id)init
{
    return [self initWithWidth:0];
}
- (id)initWithWidth:(NSUInteger)theWidth
{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

+ (id)boardWithWidth:(NSUInteger)theWidth
{
    return [[[self class] alloc] initWithWidth:theWidth];
}

- (void)clearCoordinate:(id <CSPCoordinateInterface>)coord
{

}

- (void)setObjectAtCoordinate:(id <CSPCoordinateInterface>)coord
                     toObject:(id)anObject
{

}

- (id)objectAtCoordinate:(id <CSPCoordinateInterface>)coord
{
    return nil;
}

- (NSUInteger)count
{
    return 0;
}


@end
