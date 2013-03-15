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
@property (assign) int x;
@property (assign) int y;


@end
