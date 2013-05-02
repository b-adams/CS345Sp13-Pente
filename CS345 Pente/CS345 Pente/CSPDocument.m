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
#import "CSPMove.h"

@implementation CSPDocument
{
    id<CSPPenteGameModelInterface> _myModel;
}
- (id)init
{
    self = [super init];
    if (self) {
        _myModel = [[CSPGollumInTheCloset alloc] init];
        [(id)_myModel addObserver:self
                       forKeyPath:@"gameOverState"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
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
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    if(object==_myModel && [keyPath isEqualToString:@"gameOverState"])
    {
        switch([_myModel gameOverState])
        {
            case CSPGO_BlackWins: [self popupGameOverAlertWithWinner:@"Black"]; break;
            case CSPGO_WhiteWins: [self popupGameOverAlertWithWinner:@"White"]; break;
            case CSPGO_GameNotOver: break;
        }
    }
}

- (void)popupGameOverAlertWithWinner:(NSString *)winnerName
{
    NSAlert* alert = [[NSAlert alloc]init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:[NSString stringWithFormat:@"Game Over, %@ wins", winnerName]];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
    [self close]
}

- (BOOL)isLegalFor:(NSString *)playerColor
         toMoveAtX:(NSUInteger)x
              andY:(NSUInteger)y
{
    CSPPlayerID thePlayer;
    
    if([playerColor isEqualToString:@"white"])
        thePlayer = CSPID_PlayerWhite;
    else if([playerColor isEqualToString:@"black"])
        thePlayer = CSPID_PlayerBlack;
    else
        thePlayer = CSPID_NOBODY;
    
    return [_myModel isLegalMove:[CSPMove moveWithPlayer:thePlayer
                                                     atX:x andY:y]];
}

- (void)executeMoveBy:(NSString *)playerColor
                  atX:(NSUInteger)x
                 andY:(NSUInteger)y
{
    CSPPlayerID thePlayer;
    
    if([playerColor isEqualToString:@"white"])
        thePlayer = CSPID_PlayerWhite;
    else if([playerColor isEqualToString:@"black"])
        thePlayer = CSPID_PlayerBlack;
    else
        thePlayer = CSPID_NOBODY;
    
    [_myModel makeMove:[CSPMove moveWithPlayer:thePlayer
                                           atX:x andY:y]];
    

    [[self penteBoard] needsDisplay];
    
    NSUInteger captures;
    NSString* capString = nil;
    
    captures = [_myModel capturesByPlayer:CSPID_PlayerWhite];
    capString = [NSString stringWithFormat:@"%ld", captures];
    [[self whiteCounter] setStringValue:capString];

    captures = [_myModel capturesByPlayer:CSPID_PlayerBlack];
    capString = [NSString stringWithFormat:@"%ld", captures];
    [[self blackCounter] setStringValue:capString];
}

- (NSString *)getPlayerColorAtX:(NSUInteger)x
                           andY:(NSUInteger)y
{
    CSPPlayerID pieceCode;
    pieceCode = [_myModel whosePieceIsAt:[[CSPLocation alloc] initWithX:x
                                                                   andY:y]];
    switch(pieceCode)
    {
        case CSPID_PlayerBlack: return @"black";
        case CSPID_PlayerWhite: return @"white";
        case CSPID_NOBODY: return @"empty";
    }
}

@end
