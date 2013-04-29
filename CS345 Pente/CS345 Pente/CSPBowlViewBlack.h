//
//  CSPBowlViewBlack.h
//  CS345 Pente
//
//  Created by Keegan Evans on 4/24/13.
//  Copyright (c) 2013 Wells CS345: GUI programming. All rights reserved.
//

#import "CSPBowlView.h"

@interface CSPBowlViewBlack : CSPBowlView

@property (strong) NSString* bowlColor;
-(void)setToBlack;
//-(void)setToSomething;
- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
@end
