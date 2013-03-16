/**
 @file CSPPenteGameModelInterface.h
 @author Bryant Adams
 @date 3/15/13
 @copyright Available under GPLv3 or any later version
 */

#import <Foundation/Foundation.h>
#import "CSPMoveInterface.h"
#import "CSPCoordinateInterface.h"

@protocol CSPPenteGameModelInterface <NSObject>

// Is ___ a legal place to move? / Is ___ a legal move? (yes/no)
-(BOOL) isLegalMove:(id<CSPMoveInterface>) aMove;

// Place ___'s stone at ___ / Make move ____
-(void)makeMove:(id<CSPMoveInterface>) aMove;

// How many stones has player ___ captured? (0 through 10)
-(int) capturesByPlayer:(CSPPlayerID) player;

// Who has won the game? (White/Black/Nobody yet)
-(CSPPlayerID) whoIsWinner;

// Whose turn is it? (White/Black)
-(CSPPlayerID) whoseTurnIsIt;

// What piece is at location _____? (White/Black/Empty)
-(CSPPlayerID) whosePieceIsAt:(id<CSPCoordinateInterface>) aLocation;

// How wide is the board?
-(int) boardWidth;

// Low priority:
// Max adjacent stones of stone ___? (0-4)
// [For user-assistance coloring purposes, still allowing sneaky XX-XX wins.]
-(int)longestChainForStoneAt:(id<CSPCoordinateInterface>) aLocation;

@end
