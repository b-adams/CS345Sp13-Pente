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
    int _clickCounter;
}
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setToSomething];
        _clickCounter = 0;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect]; // Drawing code here.
}


-(void)setToWhite{
    
    [self setStoneColor:@"White"];
    [self setImage:[NSImage imageNamed:@"Pente_White_Stone.png"]];
    
}

-(void)setToBump{
    
    [self setStoneColor:@"Bump"];
    [self setImage:[NSImage imageNamed:@"Pente_Blank_Bump.png"]];
}

-(void)setToBlack{
    [self setStoneColor:@"Black"];
    [self setImage:[NSImage imageNamed:@"Pente_Black_Stone.png"]];
    
}

;-(void) setToSomething
{
    
    if(rand()%2)
        [self setToWhite];
    
    else [self setToBlack];
    
}

-(void)mouseDown:(NSEvent *)theEvent
{
    
    _clickCounter+=1;
    
    NSLog(@"Click %d", _clickCounter);
    
    if((_clickCounter/10)%2)
        
    {
        
        [self setToWhite];
        
    }
    else {
        
        [self setToBlack];
        
    }
    
    [self setToBump];
    
}

@end