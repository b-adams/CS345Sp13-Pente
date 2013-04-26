//
//  CSPGridView.m
//  CS345 Pente
//
//  Created by Josh Brutscher on 4/25/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPGridView.h"

@implementation CSPGridView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    const int BOARD_SIZE = 500;
    const int GRID_SQUARES = 19;
    const int GRID_SIZE = BOARD_SIZE/(GRID_SQUARES+1);
    NSPoint startPoint;
    NSPoint endPoint;
    
    NSBezierPath * path = [NSBezierPath bezierPath];
    
    
    for (int i=GRID_SIZE/2; i<BOARD_SIZE-GRID_SIZE; i+=GRID_SIZE)
    {
        for (int p=GRID_SIZE/2; p<BOARD_SIZE-GRID_SIZE; p+=GRID_SIZE){
            JPBRect = NSMakeRect(i, p, GRID_SIZE, GRID_SIZE);
            CSPBoardViewJPB2 = [[NSImageView alloc] initWithFrame:JPBRect];
            [CSPBoardViewJPB2 setImageScaling:NSScaleToFit];
            [CSPBoardViewJPB2 setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
            [self addSubview:CSPBoardViewJPB2];
        }
        
    }
    
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
     // [self addSubview:CSPBoardViewJPB2];
     

}

@end
