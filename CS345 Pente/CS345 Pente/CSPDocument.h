//
//  CSPDocument.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CSPBoardViewDataSource.h"
#import "CSPBoardView.h"

@interface CSPDocument : NSDocument <CSPBoardViewDataSource>
@property (weak) IBOutlet NSTextField *captureLabelForWhite;
@property (weak) IBOutlet NSTextField *captureLabelForBlack;
@property (weak) IBOutlet CSPBoardView *theBoardView;

@end
