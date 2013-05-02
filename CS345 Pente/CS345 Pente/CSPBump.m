//
//  CSPBump.m
//  CS345 Pente
//
//  Created by Kyle Steere on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBump.h"

@implementation CSPBump
{
    id<CSPBumpHost> _myBoard;
}
- (id)initWithFrame:(NSRect)frame
            andHost:(id<CSPBumpHost>)hostingBoard
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setToBump];
        NSArray* acceptedTypes = @[NSPasteboardTypeString];
        [self registerForDraggedTypes:acceptedTypes];
        _myBoard = hostingBoard;
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    return [self initWithFrame:frame andHost:nil];
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
    if([_myBoard isColor:theColor
             legalAtBump:self])
    {
        [self setImageFrameStyle:NSImageFrameGrayBezel];
        return NSDragOperationCopy;
    } else {
        return NSDragOperationNone;
    }
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

    [_myBoard dropColor:theColor
               ontoBump:self];
    
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

@end