/**
 @file CSPGollumInTheCloset.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 @version 1.0
 */

#import <Foundation/Foundation.h>
#import "CSPPenteGameModelInterface.h"

@interface CSPGollumInTheCloset : NSObject <CSPPenteGameModelInterface>
@property (assign) NSUInteger turnNumber;
@property (assign) CSPGameOverID gameOverState;

@end
