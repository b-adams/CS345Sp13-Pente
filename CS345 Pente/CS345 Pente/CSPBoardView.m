//
//  CSPBoardView.m
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import "CSPBoardView.h"
#import "CSPBump.h"
@implementation CSPBoardView
{
    
    
}
const int BOARD_SIZE = 500;
const int GRID_SQUARES = 19;
const int GRID_SIZE = BOARD_SIZE/(GRID_SQUARES+1);
NSPoint startPoint;
NSPoint endPoint;
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CSPBump* tempBump;
        
        [self setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];
        tempBump = [[CSPBump alloc] initWithFrame:JPBRect];
        [tempBump setBlankBump];
        [self addSubview:(tempBump)];
        NSLog(@"x %f y %f W %f H %f\n", [tempBump frame].origin.x,
              [tempBump frame].origin.y, [tempBump frame].size.width,
              [tempBump frame].size.height);
              
        
        int offset = GRID_SIZE/2;
        int numPlaces = 19;
        for (int x=0; x<numPlaces; x+=1)
        {
            for (int y=0; y<numPlaces; y+=1){
                               location.x = x*GRID_SIZE+offset;
                location.y = y*GRID_SIZE+offset;
                JPBRect = (NSMakeRect(location.x, location.y, GRID_SIZE, GRID_SIZE));
                tempBump = [[CSPBump alloc] initWithFrame:JPBRect];
                [tempBump setBlankBump];
                [self addSubview:tempBump];
                //NSLog(@"Placing bump %@ at %d, %d", tempBump, i, p);
                
            }
            
        }
        
    }
    return self;
}


-(void) drawRect:(NSRect)dirtyRect

{
    
    [super drawRect:dirtyRect];
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
