//
//  CSPBump.h
//  CS345 Pente
//
//  Created by Kyle Steere on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSPBoardView;

@interface CSPBump : NSImageView

-(void) setWhiteStone;
-(void) setBlankBump;
-(void) setBlackStone;
-(void) setColor:(NSString*) newColor;
-(id) initWithBoard:(CSPBoardView*) myBoard
           andFrame:(NSRect)frameRect;

@end
