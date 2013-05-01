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
    [self setImage:[NSImage imageNamed:@"Pente_Black_Stone_Bowl.png"]];
    [self setBowlColor:@"black"];
}

-(void) setToWhite
{
    [self setImage:[NSImage imageNamed:@"Pente_White_Stone_Bowl.png"]];
    
    [self setBowlColor:@"white"];
}

-(void)iamgeForCurrentColor
{
    [self setToBlack];
    [self setToWhite];
    [self needsDisplay];
}

@end
