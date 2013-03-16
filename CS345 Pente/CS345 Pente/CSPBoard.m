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
#import "CSPCoordinateInterface.h"

@implementation CSPBoard
- (id)init
{
    return [self initWithWidth:0];
}
- (id)initWithWidth:(NSUInteger)theWidth
{
    self = [super init];
    if (self) {
        [self setWidth:theWidth];
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
    NSUInteger cox = [coord x];
    NSUInteger coy = [coord y];
    NSUInteger myw = [self width];
    if(cox >= myw)
    {
        [NSException raise:NSRangeException
                    format:@"X Index exceeds size"];
    }
    if(coy >= myw)
    {
        [NSException raise:NSRangeException
                    format:@"Y Index exceeds size"];
    }
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
