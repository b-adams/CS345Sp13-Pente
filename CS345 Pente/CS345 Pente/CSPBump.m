//
//  CSPBump.m
//  CS345 Pente
//
//  Created by Kyle Steere on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBump.h"

@implementation CSPBump


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setToBump];
        NSArray* acceptedTypes = @[NSPasteboardTypeString];
        [self registerForDraggedTypes:acceptedTypes];

    }
    return self;
}

#pragma mark Kyle

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

#pragma mark Keegan


-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSDragOperation desiredAction = [sender draggingSourceOperationMask];
    
    if((desiredAction & NSDragOperationCopy) == NSDragOperationNone)
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
    NSString* theColor = [self draggedColor:sender];
    
    BOOL dropAccepted = NO;
    
    if(theColor)
    {
        dropAccepted = YES;
        if([theColor isEqualToString:@"white"])
        {
            [self setToWhite];
        }
        else if([theColor isEqualToString:@"black"])
        {
            [self setToBlack];
        }
        else
        {
            [self setToBump];
            NSLog(@"Oh noes! I dunno how to handle '%@' data", theColor);
            dropAccepted=NO;
        }
    }
    
    if(dropAccepted)
    {
        [self setNeedsDisplay];
    }
    [self setImageFrameStyle:NSImageFrameNone];
    return dropAccepted;
}

#pragma mark Adams

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