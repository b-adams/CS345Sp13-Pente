//
//  CSPBowlView.h
//  CS345 Pente
//
//  Created by Keegan Evans on 4/24/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CSPBowlView : NSImageView
@property (strong) NSString* bowlColor;
-(void)setToBlack;
-(void)setToWhite;
@end
