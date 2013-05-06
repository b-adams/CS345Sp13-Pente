//
//  CSPDocument.m
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPDocument.h"
#import "CSPPenteGameModelInterface.h"

@implementation CSPDocument
//TODO: Create an ivar of type id<CSPPenteGameModelInterface> named  _myModel
{
    id<CSPPenteGameModelInterface> _myModel;
}
- (id)init
{
    self = [super init];
    if (self) {
        //TODO: Initialize _myModel with a new GollumInTheCloset instance
        //******************TODO: (KVO) Register to Key-Value-Observe _myModel's gamoeOverState
        _myModel = [[CSPBoardView alloc] init];
        
        [(id)_myModel addObserver: self
                       forKeyPath:@"gameOverState"
                          options:(NSKeyValueObservingOptionNew |
                                   NSKeyValueObservingOptionOld)
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

//TODO: (KVO) When a gameOverState change happens, pop up an alert

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    //1 - figure out winner
    NSString *tempWinner;
    tempWinner = @"%@",[_myModel gameOverState];
    
    //2 -translate that and pop up
    [self popupGameOverAlertWithWinner:tempWinner];
    
    [self close];
}

- (void)popupGameOverAlertWithWinner:(NSString *)winnerName
{
    //TODO: Implement this method. Should close the window after showing the alert.
    NSAlert* alert = [[NSAlert alloc]init];
    [alert addButtonWithTitle:@"End Game"];
    [alert addButtonWithTitle:@"Press 'CMD N' for New Game."];
    [alert setMessageText:@"Game Over. %@ Won!", winnerName];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
    
    //    @throw [NSException exceptionWithName:@"Unimplemented Method"
    //                                   reason:NSStringFromSelector(_cmd)
    //                                 userInfo:nil];
}

- (BOOL)isLegalFor:(NSString *)playerColor
         toMoveAtX:(NSUInteger)x
              andY:(NSUInteger)y
{
    //TODO: Implement this method (it should delegate work to the model)
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
    return NO;
}

- (void)executeMoveBy:(NSString *)playerColor
                  atX:(NSUInteger)x
                 andY:(NSUInteger)y
{
    //TODO: Implement this method (it should delegate work to the model)
    //Also  send the view a -needsDisplay message
    //Also update the whiteCounter and the blackCounter contents
    
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
}

- (NSString *)getPlayerColorAtX:(NSUInteger)x
                           andY:(NSUInteger)y
{
    //TODO: Implement this method (it should delegate work to the model)
    @throw [NSException exceptionWithName:@"Unimplemented Method"
                                   reason:NSStringFromSelector(_cmd)
                                 userInfo:nil];
    return nil;
}

@end
