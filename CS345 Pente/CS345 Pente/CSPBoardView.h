//
//  CSPBoardView.h
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CSPMoveInterface.h"
#import "CSPBoardViewDataSource.h"

@class CSPBump;

@interface CSPBoardView : NSImageView
@property (readwrite, weak) IBOutlet id<CSPBoardViewDataSource> dataSource;

-(BOOL) allowDragEnteredForBump:(CSPBump*) whichBump
                      withColor:(NSString*) color;
-(BOOL) allowDragDropForBump:(CSPBump*) whichBump
                    withColor:(NSString*) color;
-(void) setBumpToMatch:(id<CSPMoveInterface>) aMove;
-(void) setDangerLevelTo:(NSUInteger) danger
               forBumpAt:(id<CSPCoordinateInterface>) location;
@end
