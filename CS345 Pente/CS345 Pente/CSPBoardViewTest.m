//
//  CSPBoardViewTest.m
//  CS345 Pente
//
//  Created by Keegan Evans on 4/29/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBoardViewTest.h"
#import "CSPBowlView.h"

@implementation CSPBoardViewTest

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setImage: [NSImage imageNamed:@"Pente_Blank_Bump.png"]];
    }
    
    return self;
}
-(void)drawBumps
{
    const int BOARD_SIZE = 500;
    const int GRID_SQUARES = 19;
    const int GRID_SIZE = BOARD_SIZE/(GRID_SQUARES+1);
    
    NSPoint startPoint;
    NSPoint endPoint;
    
    for (int i=0; i<BOARD_SIZE+GRID_SIZE; i+=GRID_SIZE)
    {
        startPoint = NSMakePoint(0, i);
        [self addSubview:self];
        endPoint   = NSMakePoint(BOARD_SIZE, i);
    }
    
    //Sketch vertical lines
    for (int i=0; i<BOARD_SIZE+GRID_SIZE; i+=GRID_SIZE)
    {
        startPoint = NSMakePoint(i, 0);
        [self addSubview:self];

        endPoint   = NSMakePoint(i, BOARD_SIZE);
    }

}

-(void)awakeFromNib
{
    NSArray* acceptedTypes = @[NSPasteboardTypeString];
    [self registerForDraggedTypes:acceptedTypes];
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSDragOperation desiredAction = [sender draggingSourceOperationMask];
    
    //If the COPY bit is set (recall CS225 masking), we're into that!
    if((desiredAction & NSDragOperationCopy) != 0)
    {
        [self setImageFrameStyle:NSImageFramePhoto];
        [self setImageFrameStyle:NSImageFrameGrayBezel];
        return NSDragOperationCopy;
    }
    //Oh well, not our flavor of drag
    else
    {
        return NSDragOperationNone;
    }
}
-(void)draggingExited:(id<NSDraggingInfo>)sender
{
    [self setImageFrameStyle:NSImageFrameNone];
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSPasteboard* pboard = [sender draggingPasteboard];
    NSArray* availableTypes = [pboard types];
    
    BOOL dropAccepted = NO;
    
    if([availableTypes containsObject:NSPasteboardTypeString])
    {
        NSString* theColor = [pboard stringForType:NSPasteboardTypeString];
        dropAccepted = YES;
        if([[theColor lowercaseString] isEqualToString:@"white"])
        {
            [self setImage: [NSImage imageNamed:@"Pente_White_Stone.png"]];
        }
        else if([[theColor lowercaseString] isEqualToString:@"black"])
        {
            [self setImage: [NSImage imageNamed:@"Pente_Black Stone.png"]];
        }
        else
        {
            NSLog(@"Oh noes! I dunno how to handle '%@' data", theColor);
            dropAccepted=NO;
            [self setImage: [NSImage imageNamed:@"Pente_Blank_Bump.png"]];
        }
    }
    
    if(dropAccepted)
    {
        [self setNeedsDisplay];
    }
    [self setImageFrameStyle:NSImageFrameNone];
    return dropAccepted;
}

@end
