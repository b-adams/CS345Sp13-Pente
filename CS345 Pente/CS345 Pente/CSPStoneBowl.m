//
//  CSPStoneBowl.m
//  CS345 Pente
//
//  Created by Bryant Adams on 4/23/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPStoneBowl.h"

@implementation CSPStoneBowl
{
    NSDictionary* stoneImages;
    NSDictionary* bowlImages;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        stoneImages = @{@"black":[NSImage imageNamed:@"Pente_Black Stone.png"],
                        @"white":[NSImage imageNamed:@"Pente_White_Stone.png"]};
        bowlImages = @{@"black":[NSImage imageNamed:@"Pente_Black_Stone_Bowl.png"],
                       @"white":[NSImage imageNamed:@"Pente_White_Stone_Bowl.png"]};
    }
    
    return self;
}

-(void)updateDisplayedColor
{
    NSString* myColor = [self stoneColor];
    NSImage* theImage = nil;
    theImage = [bowlImages objectForKey:myColor];
    [self setImage:theImage];
}
-(void)setToBlack
{
    [self setStoneColor:@"black"];
    [self updateDisplayedColor];
}
-(void)setToWhite
{
    [self setStoneColor:@"white"];
    [self updateDisplayedColor];
}

-(void) mouseDown:(NSEvent *)theEvent
{
    int dragImageSize = 50;
    
    NSString* myColor = [self stoneColor];
    NSImage *imageToAccompanyDrag = [stoneImages objectForKey:myColor];

    NSSize reasonableImageSize = NSMakeSize(dragImageSize, dragImageSize);
    [imageToAccompanyDrag setSize:reasonableImageSize];
    
    NSPoint clickSpot = [self convertPoint:[theEvent locationInWindow]
                                  fromView:nil];
    clickSpot.x -= dragImageSize/2;
    clickSpot.y -= dragImageSize/2;
    
    NSPasteboard *dragData = [NSPasteboard pasteboardWithName:NSDragPboard];
    [dragData declareTypes:@[NSPasteboardTypeString]
                     owner:nil];
    [dragData setString:[self stoneColor]
                forType:NSPasteboardTypeString];

    [self dragImage:imageToAccompanyDrag
                 at:clickSpot
             offset:NSZeroSize
              event:theEvent
         pasteboard:dragData
             source:self
          slideBack:YES];
    
    [super mouseDown:theEvent]; //Still do any inherited click actions
    [self needsDisplay];
}


@end
