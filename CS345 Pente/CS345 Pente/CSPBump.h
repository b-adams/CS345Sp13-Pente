//
//  CSPBump.h
//  CS345 Pente
//
//  Created by Kyle Steere on 4/22/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface CSPBump : NSImageView

@property (strong) NSString* StoneColor;
-(void)setToBlack;
-(void)setToWhite;
-(void)setToBump;
-(void)setToSomething;
@end