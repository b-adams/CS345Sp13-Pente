//
//  CSPBoardViewDelegate.h
//  CS345 Pente
//
//  Created by Bryant Adams on 5/1/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSPBoardViewDelegate <NSObject>
-(BOOL) isLegalFor:(NSString*) playerColor
         toMoveAtX:(NSUInteger) x
              andY:(NSUInteger) y;
-(void) executeMoveBy:(NSString*) playerColor
                  atX:(NSUInteger) x
                 andY:(NSUInteger) y;
-(NSString*) getPlayerColorAtX:(NSUInteger) x
                          andY:(NSUInteger) y;
@end
