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
    int ctr;
}
-(void) setWhiteStone{
   
    [self setImage:[NSImage imageNamed:@"Pente_White_Stone.png"]];

}

-(void) setBlankBump{
    
    [self setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
}

-(void) setBlackStone{

    [self setImage:[NSImage imageNamed:@"Pente_Black Stone.png"]];

}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBlankBump];
        //Can't do this in AwakeFromNib because these are not set
        //up in a nib file!
        NSArray* acceptedTypes = @[NSPasteboardTypeString];
        [self registerForDraggedTypes:acceptedTypes];
    }
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent
{
    ctr+=1;
    ctr%=3;
    switch(ctr)
    {
        case 0: [self setWhiteStone]; break;
        case 1: [self setBlackStone]; break;
        case 2:
        default: [self setBlankBump]; break;
    }
    [self setNeedsDisplay];
}

#pragma mark Drop Target

//This has to be done in init, because these aren't being stored in the NIB
//-(void)awakeFromNib
//{
//    NSArray* acceptedTypes = @[NSPasteboardTypeString];
//    [self registerForDraggedTypes:acceptedTypes];
//}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSLog(@"Drag entered: <%@>", sender);
    NSDragOperation desiredAction = [sender draggingSourceOperationMask];
    
    if(desiredAction & NSDragOperationCopy)
    {
        [self setImageFrameStyle:NSImageFrameGroove];
        return NSDragOperationCopy;
    } else {
        return NSDragOperationNone;
    }
}

-(void)draggingExited:(id<NSDraggingInfo>)sender
{
    NSLog(@"Drag exited: <%@>", sender);
    [self setImageFrameStyle:NSImageFrameNone];
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSLog(@"Drag perform: <%@>", sender);

    NSPasteboard* pboard = [sender draggingPasteboard];
    NSArray* availableTypes = [pboard types];
    
    BOOL dropAccepted = NO;
    
    if([availableTypes containsObject:NSPasteboardTypeString])
    {
        NSString* theColor = [pboard stringForType:NSPasteboardTypeString];
        dropAccepted = YES;
        
        NSLog(@"What a [%@] drag!\n", [theColor lowercaseString]);
        
        if([[theColor lowercaseString] isEqualToString:@"black"])
        {
            [self setBlackStone];
        }
        else if([[theColor lowercaseString] isEqualToString:@"white"])
        {
            [self setWhiteStone];
        }
        else
        {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"YES"];
            [alert addButtonWithTitle:@"No"];
            [alert setMessageText:@"Blank the bump?"];
            [alert setInformativeText:[NSString stringWithFormat:@"Unrecognized color \"%@\"", theColor]];
            [alert setAlertStyle:NSWarningAlertStyle];
            
            if ([alert runModal] == NSAlertFirstButtonReturn) {
                // OK clicked
                [self setBlankBump];
            } else {
                dropAccepted=NO;
            }
            alert = nil;
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
