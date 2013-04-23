//
//  CSPStoneBowl.m
//  CS345 Pente
//
//  Created by Bryant Adams on 4/23/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPStoneBowl.h"

@implementation CSPStoneBowl

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)setToBlack
{
    [self setStoneColor:@"black"];
    [self setImage:[NSImage imageNamed:@"Pente_Black Stone.png"]];
}
-(void)setToWhite
{
    [self setStoneColor:@"black"];
    [self setImage:[NSImage imageNamed:@"Pente_White_Stone.png"]];
}
@end
