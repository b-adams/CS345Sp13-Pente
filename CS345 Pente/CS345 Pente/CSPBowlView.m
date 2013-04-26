//
//  CSPBowlView.m
//  CS345 Pente
//
//  Created by Keegan Evans on 4/21/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBowlView.h"

@implementation CSPBowlView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

- (NSDragOperation) draggingSourceOperationMaskForLocal:(BOOL)flag
{
    return NSDragOperationCopy;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect]; // Drawing code here.
}

-(void) setToBlack
{
    int bowlImageSize =250;
    NSImage *bowlImage;
    bowlImage = [NSImage imageNamed:@"Pente_White_Stone.png"];
    NSSize sizeForBowlImage = NSMakeSize(bowlImageSize, bowlImageSize);
    [bowlImage setSize:sizeForBowlImage];
    [self setImage:bowlImage];
    
    [self setBowlColor:@"black"];
}

-(void) setToWhite
{
    int bowlImageSize =250;
    NSImage *bowlImage;
    bowlImage = [NSImage imageNamed:@"Pente_White_Stone.png"];
    NSSize sizeForBowlImage = NSMakeSize(bowlImageSize, bowlImageSize);
    [bowlImage setSize:sizeForBowlImage];
    [self setImage:bowlImage];
    
    [self setBowlColor:@"white"];
}

-(void)iamgeForCurrentColor
{
    [self setToBlack];
    [self setToWhite];
    [self needsDisplay];
}

@end
