//
//  CSPDocument.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPDocument.h"
#import "CSPPenteGameModelInterface.h"
#import "CSPGollumInTheCloset.h"
#import "CSPMoveInterface.h"
#import "CSPMove.h"

@implementation CSPDocument
{
    id<CSPPenteGameModelInterface> theModel;
}
- (id)init
{
    self = [super init];
    if (self) {
        theModel = [[CSPGollumInTheCloset alloc] init];
    }
    return self;
}

- (NSString *)windowNibName
{
    return @"CSPDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

#pragma mark Board View Data Source methods

- (NSString *)pieceColorAtLocation:(id <CSPCoordinateInterface>)where
{
    CSPPlayerID playerAtLocation;
    playerAtLocation = [theModel whosePieceIsAt:where];
    switch(playerAtLocation)
    {
        case CSPID_PlayerBlack: return @"black";
        case CSPID_PlayerWhite: return @"white";
        case CSPID_NOBODY: return @"blank";
        default: return nil;
    }
}

- (BOOL)isMoveLegal:(id <CSPMoveInterface>)aMove
{
    return [theModel isLegalMove:aMove];
}

- (BOOL)makeMoveHappen:(id <CSPMoveInterface>)aMove
{
    //Make the move
    NSSet* changedLocations = nil;
    [theModel makeMove:aMove];
    
    //Update changed pieces
    changedLocations = [theModel locationsChangedInLastMove];
    CSPPlayerID whoIsThere;
    id<CSPMoveInterface> newMove = nil;
    for(id<CSPMoveInterface> changedMove in changedLocations)
    {
        whoIsThere = [theModel whosePieceIsAt:changedMove];
        newMove = [CSPMove moveWithPlayer:whoIsThere
                               atLocation:changedMove];
        [[self theBoardView] setBumpToMatch:newMove];
        
        NSUInteger pieceThreat = [self pieceChainLengthAtLocation:aMove];
        [[self theBoardView] setDangerLevelTo:pieceThreat
                                    forBumpAt:newMove];
    }
    
    //Update capture labels
    NSUInteger captures;
    NSString* captureMessage = nil;
    
    captures = [theModel capturesByPlayer:CSPID_PlayerBlack];
    captureMessage = [NSString stringWithFormat:@"%ld", (unsigned long)captures];
    [[self captureLabelForBlack] setStringValue:captureMessage];
    
    captures = [theModel capturesByPlayer:CSPID_PlayerWhite];
    captureMessage = [NSString stringWithFormat:@"%ld", (unsigned long)captures];
    [[self captureLabelForWhite] setStringValue:captureMessage];
    
    
    if([theModel whoIsWinner]==CSPID_NOBODY)
    {
        [[self theBoardView] setNeedsDisplay];
        return YES; //Move over, allow the drop.
    }
    
    
    NSString* winnersColor = nil;
    switch([theModel whoIsWinner])
    {
        case CSPID_PlayerBlack:
            winnersColor = @"Black";
            break;
        case CSPID_PlayerWhite:
            winnersColor = @"White";
            break;
            
        case CSPID_NOBODY:
        default: NSLog(@"Reached impossible case!");
    }
    
    //Someone must have won to get to this point
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:[NSString stringWithFormat:@"Winner: %@", winnersColor]];
    [alert setInformativeText:@"Command-N to play again."] ;
    [alert setAlertStyle:NSWarningAlertStyle];
    
    if ([alert runModal] == NSAlertFirstButtonReturn)
    {   // user clicked OK
        [self close]; //Close the window.
    }
    alert = nil;
    return NO;  //Don't place the piece! Game was over!
    
}

- (NSUInteger)pieceChainLengthAtLocation:(id <CSPCoordinateInterface>)where
{
    return [theModel longestChainForStoneAt:where];
}

@end
