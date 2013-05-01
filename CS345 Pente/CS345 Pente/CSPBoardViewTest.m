//
//  CSPBoardViewTest.m
//  CS345 Pente
//
//  Created by Keegan Evans on 4/29/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBoardViewTest.h"

@implementation CSPBoardViewTest

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
    
    //If the COPY bit is set (recall CS225 masking), we're into that!
    if((desiredAction & NSDragOperationCopy) != 0)
    {
        [self setImageFrameStyle:NSImageFramePhoto];
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
            [self setToWhite];
        }
        else if([[theColor lowercaseString] isEqualToString:@"black"])
        {
            [self setToBlack];
        }
        else
        {
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

@end
