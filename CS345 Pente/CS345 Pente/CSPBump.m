//
//  CSPBump.m
//  CS345 Pente
//
//  Created by Kyle Steere on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBump.h"

@implementation CSPBump

-(void) setWhiteStone{
   
    [self setImage:[NSImage imageNamed:@"Pente_White_Stone.png"]];

}

-(void) setBlankBump{
    
    [self setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
}

-(void) setBlackStone{

    [self setImage:[NSImage imageNamed:@"Pente_Black_Stone.png"]];

}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBlankBump];
    }
    return self;
}
@end
