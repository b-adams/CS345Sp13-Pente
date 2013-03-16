/**
 @file CSPBoard.m
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
 */


#import "CSPBoard.h"
#import "CSPCoordinateInterface.h"

@implementation CSPBoard
{
    NSArray* _columns;
}
-(NSString*) description
{
    NSMutableString* layout = [NSMutableString stringWithString:@"\n"];
    for(NSMutableArray* row in _columns)
    {
        for(id anObject in row)
        {
            if(anObject != [NSNull null])
                [layout appendFormat:@"[%@]", anObject];
            else
                [layout appendFormat:@"[..]"];
            
        }
        [layout appendFormat:@"\n"];
    }
    [layout appendFormat:@"Count: %ld", [self count]];
    
    return layout;
}
- (id)init
{
    return [self initWithWidth:0];
}
- (id)initWithWidth:(NSUInteger)theWidth
{
    self = [super init];
    if (self) {
        [self setWidth:theWidth];

        NSMutableArray* cols = [NSMutableArray arrayWithCapacity:theWidth];
        NSMutableArray* rowPrototype = [NSMutableArray arrayWithCapacity:theWidth];
        for(int i=0; i<theWidth; i+=1)
        {
            [rowPrototype addObject:[NSNull null]];
        }
        for(int i=0; i<theWidth; i+=1)
        {
            [cols addObject:[NSMutableArray arrayWithArray: rowPrototype]];
        }
        _columns = cols;
        
    }
    return self;
}

+ (id)boardWithWidth:(NSUInteger)theWidth
{
    return [[[self class] alloc] initWithWidth:theWidth];
}

- (void)clearCoordinate:(id <CSPCoordinateInterface>)coord
{
    [self setObjectAtCoordinate:coord
                       toObject:[NSNull null]];
}

- (void)setObjectAtCoordinate:(id <CSPCoordinateInterface>)coord
                     toObject:(id)anObject
{
    NSUInteger xCoord = [coord x];
    NSUInteger yCoord = [coord y];
    NSUInteger myWidth = [self width];
    if(xCoord >= myWidth)
    {
        [NSException raise:NSRangeException
                    format:@"X Index exceeds size"];
    }
    if(yCoord >= myWidth)
    {
        [NSException raise:NSRangeException
                    format:@"Y Index exceeds size"];
    }
    
    NSMutableArray* row = [_columns objectAtIndex:xCoord];
    [row replaceObjectAtIndex:yCoord withObject:anObject];

}

- (id)objectAtCoordinate:(id <CSPCoordinateInterface>)coord
{
    NSMutableArray* theRow = [_columns objectAtIndex:[coord x]];
    id theObject = [theRow objectAtIndex:[coord y]];
    if(theObject == [NSNull null]) theObject=nil;
    return theObject;
}

- (NSUInteger)count
{
    NSUInteger total=0;
    for(NSMutableArray* row in _columns)
    {
        for(id anObject in row)
        {
            if(anObject != [NSNull null])
                total+=1;
        }
    }
    return total;
}


@end
