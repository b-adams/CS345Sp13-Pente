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
@end
