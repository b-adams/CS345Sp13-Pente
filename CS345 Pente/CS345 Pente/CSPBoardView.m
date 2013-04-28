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
{
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];
        
        CSPBump* aBump = nil;
        NSRect location;
        location.size = NSMakeSize(GRID_SIZE, GRID_SIZE);
        int offset = GRID_SIZE/2;
        for(int x=0; x<GRID_SQUARES; x+=1)
            for(int y=0; y<GRID_SQUARES; y+=1)
            {
                aBump = [[CSPBump alloc] init];
                location.origin = NSMakePoint(x*GRID_SIZE+offset,
                                              y*GRID_SIZE+offset);
                [aBump setFrame:location];
                switch(rand()%3)
                {
                    case 0: [aBump setWhiteStone]; break;
                    case 1: [aBump setBlankBump]; break;
                    case 2: [aBump setBlackStone]; break;
                }
                [self addSubview:aBump];
            }
    }
    return self;
}

-(void)drawRect:(NSRect)dirtyRect

{
    [super drawRect:dirtyRect];
    
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
    [[NSColor colorWithSRGBRed:0 green:0 blue:0 alpha:0.2] set];
    [path setLineWidth: 2];
    [path stroke];
}

@end
