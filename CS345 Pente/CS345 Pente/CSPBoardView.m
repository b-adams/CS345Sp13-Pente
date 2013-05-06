//
//  CSPBoardView.m
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import "CSPBoardView.h"
#import "CSPBump.h"
#import "CSPLocation.h"

const int BOARD_SIZE = 500;
const int GRID_SQUARES = 19;
const int GRID_SIZE = BOARD_SIZE/(GRID_SQUARES+1);

@implementation CSPBoardView
{
    NSMapTable* ourMapTable;
    NSMutableArray* twoDArray;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ourMapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                            valueOptions:NSPointerFunctionsStrongMemory];
        twoDArray = [NSMutableArray array];
        
        [self setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];
        
        NSRect vJPBRect;
        CSPBump* tempBump;
        NSPoint location;
        
        
        CSPLocation* tempLocation;
        
        
        int offset = GRID_SIZE/2;
        int numPlaces = 19;
        
        for (int x=0; x<numPlaces; x+=1)
        {
            NSMutableArray* tempRowArray = nil;
            tempRowArray = [NSMutableArray array];
            for (int y=0; y<numPlaces; y+=1)
            {
                location.x = x*GRID_SIZE+offset;
                location.y = y*GRID_SIZE+offset;
                vJPBRect = NSMakeRect(location.x, location.y, GRID_SIZE, GRID_SIZE);
                tempBump = [[CSPBump alloc] initWithFrame:vJPBRect
                                                  andHost:self];
                [self addSubview:tempBump];
                [tempRowArray addObject: tempBump];
                tempLocation = [[CSPLocation alloc] initWithX:x
                                                         andY:y];
                [ourMapTable setObject: tempLocation forKey:tempBump];
                
            }
            [twoDArray addObject: tempRowArray];
        }
    }
    return self;
}


-(void) drawRect:(NSRect)dirtyRect

{
    
    [super drawRect:dirtyRect];
    [self drawGrid];
    [self refreshBumpColors];
}

- (void)drawGrid
{
    NSPoint startPoint;
    NSPoint endPoint;
    NSBezierPath * path = [NSBezierPath bezierPath];
    //Sketch horizontal lines
    for (int i=0; i<BOARD_SIZE+GRID_SIZE; i+=GRID_SIZE)
    {
        startPoint = NSMakePoint(0, i);
        endPoint   = NSMakePoint(BOARD_SIZE, i);
        [path  moveToPoint:startPoint];
        [path lineToPoint:endPoint];
    }
    
    //Sketch vertical lines
    for (int i=0; i<BOARD_SIZE+GRID_SIZE; i+=GRID_SIZE)
    {
        startPoint = NSMakePoint(i, 0);
        endPoint   = NSMakePoint(i, BOARD_SIZE);
        [path  moveToPoint: startPoint];
        [path lineToPoint:endPoint];
    }
    
    //Ink the sketch
    [[NSColor blackColor] set];
    [path setLineWidth: 2];
    [path stroke];
    
}
- (void)refreshBumpColors
{
    id<CSPCoordinateInterface> where = nil;
    NSString* color;
    for(CSPBump* aBump in [ourMapTable keyEnumerator])
    {
        where = [ourMapTable objectForKey:aBump];
        color = [[self dataSource] getPlayerColorAtX:[where x]
                                                andY:[where y]];
        [self setBump:aBump
              toColor:color];
    }
}

- (CSPBump *)bumpAtLocation:(id <CSPCoordinateInterface>)where
{
    return [[twoDArray objectAtIndex:[where x]] objectAtIndex:[where y]];
}

- (id <CSPCoordinateInterface>)locationOfBump:(CSPBump *)whichBump
{
    return [ourMapTable objectForKey:whichBump];
}

- (void)setBump:(CSPBump *)bumpObject
        toColor:(NSString *)colorString
{
    if([colorString isEqualToString:@"black"])
    {
        [bumpObject setToBlack];
    } else if([colorString isEqualToString:@"white"]) {
        [bumpObject setToWhite];
    } else if([colorString isEqualToString:@"empty"]) {
        [bumpObject setToBump];
    } else {
        NSLog(@"Error, bad color %@ for bump", colorString);
    }
}

- (BOOL)isColor:(NSString *)whichColor
    legalAtBump:(CSPBump *)whichBump
{
    id<CSPCoordinateInterface> where = [self locationOfBump:whichBump];
    return [[self dataSource] isLegalFor:whichColor
                               toMoveAtX:[where x]
                                    andY:[where y]];
}



- (void)dropColor:(NSString *)whichColor
         ontoBump:(CSPBump *)whichBump
{
    id<CSPCoordinateInterface> where = [self locationOfBump:whichBump];
    return [[self dataSource] executeMoveBy:whichColor
                                        atX:[where x]
                                       andY:[where y]];
}

@end
