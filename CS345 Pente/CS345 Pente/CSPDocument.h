//
//  CSPDocument.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CSPBoardViewDelegate.h"
#import "CSPBoardView.h"

@interface CSPDocument : NSDocument <CSPBoardViewDelegate>

@property (weak) IBOutlet NSTextField *whiteCounter;
@property (weak) IBOutlet NSTextField *blackCounter;
@property (weak) IBOutlet CSPBoardView *penteBoard;

-(void)popupGameOverAlertWithWinner:(NSString*) winnerName;
@end
