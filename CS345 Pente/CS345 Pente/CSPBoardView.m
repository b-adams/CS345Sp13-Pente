//
//  CSPBoardView.m
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import "CSPBoardView.h"

@implementation CSPBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(NSRect)dirtyRect

{
    //const int resY = 1024;
    const int boardSize = 500;
    const int gridSize = 25;
    const int halfGrid = gridSize/2;
    convertStartIntX = ((convertStartIntX+halfGrid)/gridSize)*gridSize;
    convertStartIntY = ((convertStartIntY+halfGrid)/gridSize)*gridSize;
    convertEndIntX = ((convertEndIntX+halfGrid)/gridSize)*gridSize;
    convertEndIntY = ((convertEndIntY+halfGrid)/gridSize)*gridSize;
    
    
    NSBezierPath * path = [NSBezierPath bezierPath];
    [path setLineWidth: 2];
    for (int i=0; i<boardSize+gridSize; i+=gridSize)
    {
        NSPoint startPoint2 = { 0, i };
        NSPoint endPoint2   = {boardSize,i };
        [path  moveToPoint:startPoint2];
        [path lineToPoint:endPoint2];
    }
    [[NSColor blueColor] set];
    [path stroke];
    for (int i=0; i<boardSize+gridSize; i+=gridSize)
    {
        NSPoint startPoint2 = { i, 0};
        NSPoint endPoint2   = {i, boardSize};
        [path  moveToPoint: startPoint2];
        [path lineToPoint:endPoint2];
    }
    [[NSColor blackColor] set];
    [path stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
