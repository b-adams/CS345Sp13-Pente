//
//  CSPDocument.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CSPDocument : NSDocument

@property (weak) IBOutlet NSTextField *whiteCounter;

@property (weak) IBOutlet NSTextField *blackCounter;

@property (weak) IBOutlet NSView *penteBoard;

@end
