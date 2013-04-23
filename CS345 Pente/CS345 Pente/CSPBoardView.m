//
//  CSPBoardView.m
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import "CSPBoardView.h"

@implementation CSPBoardView
{
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
    }
    return self;
}

-(void)drawRect:(NSRect)dirtyRect

{
    [super drawRect:dirtyRect];
    
    const int BOARD_SIZE = 500;
    const int GRID_SQUARES = 19;
    const int GRID_SIZE = BOARD_SIZE/(GRID_SQUARES+1);
    
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

@end
