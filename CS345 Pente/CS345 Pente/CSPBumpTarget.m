//
//  CSPBumpTarget.m
//  CS345 Pente
//
//  Created by Kyle Steere on 4/29/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//  Help received from DragDropDemo

#import "CSPBumpTarget.h"

@implementation CSPBumpTarget
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib
{
    NSArray* acceptedTypes = @[NSPasteboardTypeString];
    [self registerForDraggedTypes:acceptedTypes];
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSDragOperation desiredAction = [sender draggingSourceOperationMask];
    
   
    if((desiredAction & NSDragOperationCopy) != 0)
    {
        [self setImageFrameStyle:NSImageFrameGroove];
        return NSDragOperationCopy;
    }
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
        if([[theColor lowercaseString] isEqualToString:@"black"])
        {
            [self setToBlack];
        }
        else if([[theColor lowercaseString] isEqualToString:@"white"])
        {
            [self setToWhite];
        }
        else if([[theColor lowercaseString] isEqualToString:@"bump"])
        {
            [self setToBump];
        }
            
        {
            NSLog(@"Please type bump, white, or black, no other words available '%@' data", theColor);
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
@end

