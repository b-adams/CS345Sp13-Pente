//
//  CSPBoardView.m
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import "CSPBoardView.h"
#import "CSPBump.h"
//#import "CSPBump.m"

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
        /*
         JPBRect = NSMakeRect(0, 0, 500, 500);
         CSPBoardViewJPB = [[NSImageView alloc] initWithFrame:JPBRect];
         [CSPBoardViewJPB setImageScaling:NSScaleToFit];
         [CSPBoardViewJPB setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];
         [self addSubview:CSPBoardViewJPB];
         */
        //[self addSubview:CSPBoardViewJPB positioned:NSWindowBelow relativeTo:CSPBoardViewJPB];
        [self setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];
        JPBRect = NSMakeRect(0, 0, GRID_SIZE, GRID_SIZE);
        tempBump = [[CSPBump alloc] initWithFrame:JPBRect];
        [tempBump setBlackStone];
        [self addSubview:(tempBump)];
        NSLog(@"x %f y %f W %f H %f\n", [tempBump frame].origin.x,
              [tempBump frame].origin.y, [tempBump frame].size.width,
              [tempBump frame].size.height);
              
        
        
        for (int i=GRID_SIZE/2; i<BOARD_SIZE-GRID_SIZE; i+=GRID_SIZE)
        {
            for (int p=GRID_SIZE/2; p<BOARD_SIZE-GRID_SIZE; p+=GRID_SIZE){
                
                /*
                 JPBRect = NSMakeRect(i, p, GRID_SIZE, GRID_SIZE);
                 CSPBoardViewJPB2 = [[NSImageView alloc] initWithFrame:JPBRect];
                 [CSPBoardViewJPB2 setImageScaling:NSScaleToFit];
                 [CSPBoardViewJPB2 setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
                 [self addSubview:CSPBoardViewJPB2];
                 */
                // JPBRect = NSMakeRect(i, p, GRID_SIZE, GRID_SIZE);
                //somehow call dauris's CSPBump instead of the above stuff.
                //NSImageView *anImage;
                JPBRect = NSMakeRect(i, p, GRID_SIZE, GRID_SIZE);
                tempBump = [[CSPBump alloc] initWithFrame:JPBRect];
                [tempBump setBlankBump];
                [self addSubview:tempBump];
                NSLog(@"Placing bump %@ at %d, %d", tempBump, i, p);
                
            }
            
        }
        
    }
    return self;
}


-(void) drawRect:(NSRect)dirtyRect

{
    
    [super drawRect:dirtyRect];
    /*
     JPBRect = NSMakeRect(0, 0, 500, 500);
     CSPBoardViewJPB = [[NSImageView alloc] initWithFrame:JPBRect];
     [CSPBoardViewJPB setImageScaling:NSScaleToFit];
     [CSPBoardViewJPB setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];
     [self addSubview:CSPBoardViewJPB];
     // [self addSubview:CSPBoardViewJPB positioned:NSWindowBelow relativeTo:CSPBoardViewJPB2];
     */
    
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
    //[self addSubview: CSPBoardViewJPB];
    // [self addSubview:CSPBoardViewJPB2];
    
}

@end
