//
//  CSPBumpHost.h
//  CS345 Pente
//
//  Created by Bryant Adams on 5/1/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSPBump;

@protocol CSPBumpHost <NSObject>
-(BOOL) isColor:(NSString*) whichColor
    legalAtBump:(CSPBump*) whichBump;
-(void)dropColor:(NSString*) whichColor
        ontoBump:(CSPBump*) whichBump;
@end
