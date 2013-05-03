//
//  CSPBoardView.m
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import "CSPBoardView.h"
#import "CSPBump.h"

const int BOARD_SIZE = 500;
const int GRID_SQUARES = 19;
const int GRID_SIZE = BOARD_SIZE/(GRID_SQUARES+1);

@implementation CSPBoardView
//TODO: Declare ivars for maptable and 2D array
int xCoordinate;
int yCoordinate;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //TODO: Initialize maptable
        //TODO: Initialize 2D array
        
        NSMapTable *ourMapTable;
        [NSMapTable
         mapTableWithKeyOptions:NSMapTableCopyIn
         valueOptions:NSMapTableStrongMemory];
        
        NSArray *multiArray = [NSArray arrayWithObjects:
                               [NSMutableArray array],
                               [NSMutableArray array],
                               [NSMutableArray array],
                               [NSMutableArray array], nil];
        
        [self setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];

        NSRect vJPBRect;
        CSPBump* tempBump;
        NSPoint location;
        
        
        int offset = GRID_SIZE/2;
        int numPlaces = 19;
        
        for (int x=0; x<numPlaces; x+=1)
        {
            for (int y=0; y<numPlaces; y+=1)
            {
                location.x = x*GRID_SIZE+offset;
                location.y = y*GRID_SIZE+offset;
                vJPBRect = NSMakeRect(location.x, location.y, GRID_SIZE, GRID_SIZE);
                tempBump = [[CSPBump alloc] initWithFrame:vJPBRect];
                //TODO: Initialize bumps with a reference to their host board (this one - self)
                [self addSubview:tempBump];
                [multiArray ;
                
                //TODO: Add bumps to appropriate X,Y coordinate in XY->Bump 2D array
                //TODO: Add key:bump->object:location in Bump->XY maptable
            }
        }
    }
    return self;
}


-(void) drawRect:(NSRect)dirtyRect

{
    
    [super drawRect:dirtyRect];
    
    //TODO: factor grid-drawing code out into -drawGrid method
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

    //TODO: Use refreshBumpColors method (and implement it)
    //Method should loop through all bumps and, for each bump,
    //ask the datasource for the correct color and set the bump to that color
}

- (void)drawGrid
{
    //TODO: Implement this method
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
}

- (void)refreshBumpColors
{
    //TODO: Implement this method
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
}

- (CSPBump *)bumpAtLocation:(id <CSPCoordinateInterface>)where
{
    //TODO: Implement this method
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
    return nil;
}

- (id <CSPCoordinateInterface>)locationOfBump:(CSPBump *)whichBump
{
    //TODO: Implement this method
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
    return nil;
}

- (void)setBump:(CSPBump *)bumpObject
        toColor:(NSString *)colorString
{
    //TODO: Implement this method
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
}

- (BOOL)isColor:(NSString *)whichColor
    legalAtBump:(CSPBump *)whichBump
{
    //TODO: Implement this method
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
    return NO;
}

- (void)dropColor:(NSString *)whichColor
         ontoBump:(CSPBump *)whichBump
{
    //TODO: Implement this method
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
}

@end
