//
//  CSPLocation.h
//  CS345 Pente
//
//  Created by Bryant Adams on 3/15/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPCoordinateInterface.h"

@interface CSPLocation : NSObject <CSPCoordinateInterface>
@property (assign) NSUInteger x;
@property (assign) NSUInteger y;


@end

int directionOffsetX(CSPDirectionID dir);
int directionOffsetY(CSPDirectionID dir);