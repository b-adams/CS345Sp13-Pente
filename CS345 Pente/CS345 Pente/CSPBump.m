//
//  CSPBump.m
//  CS345 Pente
//
//  Created by Kyle Steere on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBump.h"
#import "CSPBoardView.h"

@implementation CSPBump
{
    int ctr;
    CSPBoardView* theBoardUponWhichIReside;
    NSString* currentColor;
}
-(void) setWhiteStone
{
    [self setImage:[NSImage imageNamed:@"Pente_White_Stone.png"]];
}

-(void) setBlankBump
{
    [self setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
}

-(void) setBlackStone
{
    [self setImage:[NSImage imageNamed:@"Pente_Black Stone.png"]];
}

-(void) setColor:(NSString*) newColor
{
    if(currentColor == newColor) return; //no work to do

    currentColor = newColor; //So we can skip work later
    if([newColor isEqualToString:@"black"]) return [self setBlackStone];
    if([newColor isEqualToString:@"white"]) return [self setWhiteStone];
    if([newColor isEqualToString:@"blank"]) return [self setBlankBump];
    NSLog(@"Bump attempting to set unknown color <%@>", newColor);
}


- (id)initWithBoard:(CSPBoardView *)myBoard
           andFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        theBoardUponWhichIReside = myBoard;
        [self setColor:@"blank"];

        //Can't do this in AwakeFromNib because these are not set
        //up in a nib file!
        NSArray* acceptedTypes = @[NSPasteboardTypeString];
        [self registerForDraggedTypes:acceptedTypes];
    }
    return self;
}
- (id)init
{
    NSLog(@"Error: Attempting to initialize a bump without a board");
    return nil;
}

- (id)initWithFrame:(NSRect)frame { return [self init]; }

#pragma mark Drop Target

//This has to be done in init, because these aren't being stored in the NIB
//-(void)awakeFromNib
//{
//    NSArray* acceptedTypes = @[NSPasteboardTypeString];
//    [self registerForDraggedTypes:acceptedTypes];
//}

-(NSString*) extractStringFromDrag:(id<NSDraggingInfo>)sender
{
    NSPasteboard* pboard = [sender draggingPasteboard];
    NSArray* availableTypes = [pboard types];
    
    if([availableTypes containsObject:NSPasteboardTypeString])
    {
        NSString* theColor = [pboard stringForType:NSPasteboardTypeString];
        return [theColor lowercaseString];
    } else {
        return nil;
    }

}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSDragOperation allowedAction = NSDragOperationCopy;
    NSDragOperation desiredAction = [sender draggingSourceOperationMask];
    if((desiredAction & allowedAction) == NSDragOperationNone)
    {
        return NSDragOperationNone;
    }
    
    NSString* theColor = [self extractStringFromDrag:sender];
    if(!theColor)
    {
        return NSDragOperationNone;
    }

    BOOL dragOK;
    dragOK = [theBoardUponWhichIReside allowDragEnteredForBump:self
                                                     withColor:theColor];
    if(!dragOK)
    {
        return NSDragOperationNone;
    }

    //It's a copy action with a color that yields a legal move!
    [self setImageFrameStyle:NSImageFrameGroove];
    return allowedAction;
}

-(void)draggingExited:(id<NSDraggingInfo>)sender
{
    [self setImageFrameStyle:NSImageFrameNone]; //Clear highlight
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{

    NSString* theColor = [self extractStringFromDrag:sender];
    BOOL dropAccepted;
    
    dropAccepted = [theBoardUponWhichIReside allowDragDropForBump:self
                                                        withColor:theColor];

    if(dropAccepted)
    {
        [self setNeedsDisplay];
    }
    
    [self setImageFrameStyle:NSImageFrameNone]; //Clear highlight
    return dropAccepted;
}


@end
