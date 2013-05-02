//
//  CSPBoardView.h
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CSPBumpHost.h"
#import "CSPCoordinateInterface.h"

@interface CSPBoardView : NSImageView <CSPBumpHost>
-(void) drawGrid;
-(void)refreshBumpColors;

-(CSPBump*) bumpAtLocation:(id<CSPCoordinateInterface>) where;
-(id<CSPCoordinateInterface>) locationOfBump:(CSPBump*) whichBump;

-(void)setBump:(CSPBump*) bumpObject
       toColor:(NSString*) colorString;

@end