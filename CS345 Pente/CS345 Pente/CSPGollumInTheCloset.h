//
//  CSPGollumInTheCloset.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPPenteGameModelInterface.h"

@interface CSPGollumInTheCloset : NSObject <CSPPenteGameModelInterface>
@property (assign) int turnNumber;
@property (assign) CSPGameOverID gameOverState;

@end
