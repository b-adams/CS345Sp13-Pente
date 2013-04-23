//
//  CSPStoneBowl.h
//  CS345 Pente
//
//  Created by Bryant Adams on 4/23/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CSPStoneBowl : NSImageView
@property (strong) NSString* stoneColor;
-(void)setToBlack;
-(void)setToWhite;
@end
