//
//  CSPBump.m
//  CS345 Pente
//
//  Created by Kyle Steere on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBump.h"

@implementation CSPBump

//TODO: Implement initWithFrame:andHost: method to allow bumps to know who their board is
//TODO: Make a _myHost or _myBoard ivar for use by above method

- (id)initWithFrame:(NSRect)frame
{
    //TODO: Make initWithFrame:andBoard: be the designated initializer (initWithFrame: will just pass the buck to it)
    self = [super initWithFrame:frame];
    if (self) {
        [self setToBump];
        NSArray* acceptedTypes = @[NSPasteboardTypeString];
        [self registerForDraggedTypes:acceptedTypes];

    }
    return self;
}

/* Kyle's code */

-(void)setToWhite{
    
    [self setStoneColor:@"White"];
    [self setImage:[NSImage imageNamed:@"Pente_White_Stone.png"]];
    
}

-(void)setToBlack{
    [self setStoneColor:@"Black"];
    [self setImage:[NSImage imageNamed:@"Pente_Black Stone.png"]];
    
}

-(void)setToBump{
    
    [self setStoneColor:@"Bump"];
    [self setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
}

/* Keegan's code */


-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSDragOperation desiredAction = [sender draggingSourceOperationMask];
    NSString* theColor = [self draggedColor:sender];

    if((desiredAction & NSDragOperationCopy) == NSDragOperationNone)
    {
        return NSDragOperationNone;
    }

    NSLog(@"Processing %@ drag into bump %@", theColor, self);
    //TODO: Check legality
    //Ask host board if the the dragged color would be allowed for this bump
    //If not: return NSDragOperationNone
    //If so, do the following code
    
    [self setImageFrameStyle:NSImageFrameGrayBezel];
    return NSDragOperationCopy;
}
-(void)draggingExited:(id<NSDraggingInfo>)sender
{
    [self setImageFrameStyle:NSImageFrameNone];
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSString* theColor = [self draggedColor:sender];
    BOOL dropAccepted = YES;

    NSLog(@"Processing %@ drop into bump %@", theColor, self);
    //TODO: Initiate move
    //Assumption: If you're able to make a drop, it was already cleared as legal
    //Notify host board that dragged color has been dropped on this bump
    //Don't need to update color - board's drawrect will be responsible for that
    
    [self setNeedsDisplay];
    [self setImageFrameStyle:NSImageFrameNone];
    return dropAccepted;
}

-(NSString*) draggedColor:(id<NSDraggingInfo>) sender
{
    NSPasteboard* pboard = [sender draggingPasteboard];
    NSArray* availableTypes = [pboard types];
    
    if([availableTypes containsObject:NSPasteboardTypeString])
    {
        return [[pboard stringForType:NSPasteboardTypeString] lowercaseString];
    } else {
        return nil;
    }
}

- (id)initWithFrame:(NSRect)frameRect
            andHost:(id <CSPBumpHost>)hostingBoard
{
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
    return nil;
}

@end