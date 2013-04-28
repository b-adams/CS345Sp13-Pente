//
//  CSPBoardView.m
//  Pente
//
//  Created by Guest User on 4/21/13.
//  Copyright (c) 2013 Guest User. All rights reserved.
//

#import "CSPBoardView.h"
#import "CSPBump.h"
#import "CSPMove.h"
#import "CSPLocation.h"

NSString * const CSPDatumBump = @"bump";
NSString * const CSPDatumX = @"coordX";
NSString * const CSPDatumY = @"coordY";

const int BOARD_SIZE = 500;
const int GRID_SQUARES = 19;
const int GRID_SIZE = BOARD_SIZE/(GRID_SQUARES+1);

@implementation CSPBoardView
{
    NSMapTable* locationsOfBumps;
    NSArray* bumpsAtLocations;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray* gridData = [NSMutableArray arrayWithCapacity:GRID_SQUARES];
        NSMapTable* reverseGridData = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                                            valueOptions:NSMapTableStrongMemory];
        NSMutableArray* gridRowData = nil;
        NSDictionary* gridDatum = nil;
        
        [self setWantsLayer:YES]; //http://stackoverflow.com/questions/9050703/nsview-drop-shadow-using-setshadow
        [self setImage:[NSImage imageNamed:@"Pente_Board_2.png"]];
        
        CSPBump* aBump = nil;
        NSRect location;
        location.size = NSMakeSize(GRID_SIZE, GRID_SIZE);
        int offset = GRID_SIZE/2;
        for(int x=0; x<GRID_SQUARES; x+=1)
        {
            gridRowData = [NSMutableArray arrayWithCapacity:GRID_SQUARES];
            for(int y=0; y<GRID_SQUARES; y+=1)
            {
                //Update location
                location.origin = NSMakePoint(x*GRID_SIZE+offset,
                                              y*GRID_SIZE+offset);
                //Create bump and add to view
                aBump = [[CSPBump alloc] initWithBoard:self
                                              andFrame:location];
                [self addSubview:aBump];

                //For later lookup
                gridDatum = @{CSPDatumBump: aBump,
                              CSPDatumX: @(x),
                              CSPDatumY: @(y)};
                [gridRowData addObject:gridDatum];
                [reverseGridData setObject:gridDatum
                                    forKey:aBump];
//                [aBump setWantsLayer:YES];
//                [aBump setShadow:[self shadowForDangerLevel:(x+y)%6]];


            }
            [gridData addObject:gridRowData];
        }
        bumpsAtLocations = gridData;
        locationsOfBumps = reverseGridData;
    }
    return self;
}

-(void)drawRect:(NSRect)dirtyRect

{
    [super drawRect:dirtyRect];
    
    NSPoint startPoint;
    NSPoint endPoint;

    NSBezierPath * path = [NSBezierPath bezierPath];
    
    //Sketch horizontal lines
    for (int i=0; i<BOARD_SIZE+GRID_SIZE; i+=GRID_SIZE)
    {
        startPoint = NSMakePoint(0, i);
        endPoint   = NSMakePoint(BOARD_SIZE, i);
        [path  moveToPoint:startPoint];
        [path lineToPoint:endPoint];
    }
    
    //Sketch vertical lines
    for (int i=0; i<BOARD_SIZE+GRID_SIZE; i+=GRID_SIZE)
    {
        startPoint = NSMakePoint(i, 0);
        endPoint   = NSMakePoint(i, BOARD_SIZE);
        [path  moveToPoint: startPoint];
        [path lineToPoint:endPoint];
    }

    //Ink the sketch
    [[NSColor colorWithSRGBRed:0 green:0 blue:0 alpha:0.2] set];
    [path setLineWidth: 2];
    [path stroke];
    
    //Refresh images on dirty bumps
    NSString* newColor=nil;
    NSUInteger newDangerLevel;
    id<CSPCoordinateInterface> bumpLocation = nil;
    NSPoint bumpCenter;
    for(CSPBump* aBump in [locationsOfBumps keyEnumerator])
    {
        bumpLocation = [self makeLocationAtBump:aBump];
        bumpCenter = NSMakePoint([bumpLocation x]*GRID_SIZE + GRID_SIZE/2,
                                 [bumpLocation y]*GRID_SIZE + GRID_SIZE/2);
        newDangerLevel = [[self dataSource] pieceChainLengthAtLocation:bumpLocation];
        if(NSPointInRect(bumpCenter, dirtyRect))
        {
            newColor = [[self dataSource] pieceColorAtLocation:bumpLocation];
            [aBump setColor:newColor];
            [self setDangerLevelTo:newDangerLevel
                         forBumpAt:bumpLocation];
        }
    }
}

#pragma mark Bump Management

//Delegate-style drag-enter manager
- (BOOL)allowDragEnteredForBump:(CSPBump *)whichBump
                      withColor:(NSString*) color;
{

    CSPMove* attemptedMove = [self makeMoveAtBump:whichBump
                                         forColor:color];

    //Send request via Controller to the Model to determine if the move is legal
    BOOL allowed;
    allowed = [[self dataSource] isMoveLegal:attemptedMove];
    return allowed;
}

//Delegate-style drop manager
- (BOOL)allowDragDropForBump:(CSPBump *)whichBump
                           withColor:(NSString*) color;
{
    CSPMove* attemptedMove = [self makeMoveAtBump:whichBump
                                         forColor:color];

    //Send order via Controller to the Model to make the move
    BOOL allowed;
    allowed = [[self dataSource] isMoveLegal:attemptedMove];
    if(allowed)
    {
        allowed = [[self dataSource] makeMoveHappen:attemptedMove];
    }
    return allowed;
}

-(void) setBumpToMatch:(id<CSPMoveInterface>) aMove
{
    NSDictionary* bumpRecord = [self datumAtX:[aMove x]
                                         andY:[aMove y]];
//    NSLog(@"Lookup up %@\n", bumpRecord);
    CSPBump* theBump = [bumpRecord objectForKey:CSPDatumBump];
    
    if(!theBump) return;
    
    switch([aMove player])
    {
        case CSPID_PlayerBlack:
            [theBump setBlackStone];
            break;
        case CSPID_PlayerWhite:
            [theBump setWhiteStone];
            break;
        case CSPID_NOBODY:
        default:
            [theBump setBlankBump];
            break;
    }
}

-(void) setDangerLevelTo:(NSUInteger) danger
               forBumpAt:(id<CSPCoordinateInterface>) location
{
    NSDictionary* bumpRecord = [self datumAtX:[location x]
                                         andY:[location y]];
    //    NSLog(@"Lookup up %@\n", bumpRecord);
    CSPBump* theBump = [bumpRecord objectForKey:CSPDatumBump];
    
    if(!theBump) return;
    [theBump setShadow:[self shadowForDangerLevel:danger]];
}


#pragma mark helper methods

-(NSShadow*) shadowForDangerLevel:(NSUInteger) level
{
    NSColor* shadowColor = nil;
    
    switch(level)
    {
        case 5: shadowColor = [NSColor whiteColor]; break;
        case 4: shadowColor = [NSColor redColor]; break;
        case 3: shadowColor = [NSColor orangeColor]; break;
        case 2: shadowColor = [NSColor yellowColor]; break;
            
        case 1: shadowColor = [NSColor greenColor]; break;
        default: shadowColor = nil;
    }
    
    NSShadow* shadow = nil;
    shadow = [[NSShadow alloc] init];
    [shadow setShadowBlurRadius:4.0f];
//    [shadow setShadowOffset:NSMakeSize(4.0f, 4.0f)];
    [shadow setShadowColor:shadowColor];
    
    return shadow;
}

-(NSDictionary*) datumAtX:(NSUInteger) x
                     andY: (NSUInteger) y;
{
    NSArray* gridRow = [bumpsAtLocations objectAtIndex:x];
    return [gridRow objectAtIndex:y];
}

-(NSDictionary*) datumWithBump:(CSPBump*) theBump
{
    return [locationsOfBumps objectForKey:theBump];
}

- (id <CSPMoveInterface>)makeMoveAtBump:(CSPBump *)whichBump
                               forColor:(NSString *)color
{
    NSDictionary* bumpRecord = [self datumWithBump:whichBump];
//    NSLog(@"Lookup up %@\n", bumpRecord);
    
    NSNumber* coord = nil;
    
    coord = [bumpRecord objectForKey:CSPDatumX];
    NSUInteger coordX = [coord unsignedIntegerValue];
    
    coord = [bumpRecord objectForKey:CSPDatumY];
    NSUInteger coordY = [coord unsignedIntegerValue];
    
    CSPPlayerID plID = CSPID_NOBODY;
    if(!color)
    {
        //Someone's probably just making a location
    }
    else if([color isEqualToString:@"black"])
    {
        plID = CSPID_PlayerBlack;
    }
    else if([color isEqualToString:@"white"])
    {
        plID = CSPID_PlayerWhite;
    }
    
    CSPMove* associatedMove = nil;
    associatedMove = [[CSPMove alloc] initWithPlayer:plID
                                                 atX:coordX
                                                andY:coordY];
    return associatedMove;
}

- (id <CSPCoordinateInterface>)makeLocationAtBump:(CSPBump *)whichBump
{
    return [self makeMoveAtBump:whichBump forColor:nil];
}


@end
