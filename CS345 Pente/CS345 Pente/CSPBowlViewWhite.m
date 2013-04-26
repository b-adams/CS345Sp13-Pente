//
//  CSPBowlStoneColor.m
//  CS345 Pente
//
//  Created by Keegan Evans on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBowlViewWhite.h"

@implementation CSPBowlViewWhite

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setToWhite];
    }
    
    return self;
}

//-(void) setToBlack
//{
//    [self setBowlColor:@"black"];
//    [self setImage:[NSImage imageNamed:@"Pente_Black_Stone_Bowl.png"]];
//}

//******-(void) setToWhite
//{
//    int bowlImageSize =250;
//    NSImage *bowlImage;
//    bowlImage = [NSImage imageNamed:@"Pente_White_Stone.png"];
//    NSSize sizeForBowlImage = NSMakeSize(bowlImageSize, bowlImageSize);
//    [bowlImage setSize:sizeForBowlImage];
//    [self setImage:bowlImage];
//
//    [self setBowlColor:@"white"];
//}
//-(void) setToSomething
//{
//    if(rand()%2) [self setToWhite];
//    else [self setToBlack];
//}

-(void) mouseDown:(NSEvent *)theEvent
{
    [self setToWhite];
    int dragImageSize = 50;
    
    NSImage *associatedImage;
    
    
    //associatedImage = [NSImage imageNamed:@"Pente_Black Stone.png"];
    
    associatedImage = [NSImage imageNamed:@"Pente_White_Stone.png"];
    
    NSImage *imageToAccompanyDrag = associatedImage;
    NSSize reasonableImageSize = NSMakeSize(dragImageSize, dragImageSize);
    [imageToAccompanyDrag setSize:reasonableImageSize];
    
    NSPoint clickSpot = [self convertPoint:[theEvent locationInWindow]
                                  fromView:nil];
    clickSpot.x -= dragImageSize/2;
    clickSpot.y -= dragImageSize/2;
    
    NSPasteboard *dragData = [NSPasteboard pasteboardWithName:NSDragPboard];
    [dragData declareTypes:@[NSPasteboardTypeString] owner:nil];
    [dragData setString:[self bowlColor] forType:NSPasteboardTypeString];
    [self dragImage:imageToAccompanyDrag
                 at:clickSpot
             offset:NSZeroSize
              event:theEvent
         pasteboard:dragData
             source:self
          slideBack:YES];
    
    [super mouseDown:theEvent]; //Make sure basic bird gets its turn
    [self needsDisplay];
}


@end
