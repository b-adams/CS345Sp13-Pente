/**
 @file TestMove.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 0.1
*/

    // Class under test
#import "CSPMove.h"
#import "CSPMoveInterface.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Comment the next two lines to disable OCHamcrest (for test assertions)
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

// Comment the next two lines to disable OCMockito (for mock objects)
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

/**
 @brief For testing CSPMove
 */
@interface TestMove : SenTestCase
@end

@implementation TestMove
{
    id<CSPMoveInterface> sut;
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNewMoveHasNoPlayerAndNegativeCoords
{
    // given
    sut = [[CSPMove alloc] init];
    
    // when
    // then
    [self assertThatMove:sut
                hasPlayer:CSPID_NOBODY
                     forX:-1
                     andY:-1];
}


- (void)testMoveWhiteX4Y3HasPlayerWhiteWithCoordinatesX4Y3
{
    // given
    sut = [[CSPMove alloc] initWithPlayer:CSPID_PlayerWhite
                                          atX:4
                                         andY:3];
    
    // when
    // then
    [self assertThatMove:sut
                hasPlayer:CSPID_PlayerWhite
                     forX:4
                    andY:3];
}


- (void)testConvenienceCreationWithPlayerAndLocation
{
    // given
    
    //Mocking Move instead of Location since a move is a location
    id<CSPCoordinateInterface> loc = mock([CSPMove class]);
    
    [given([loc x]) willReturnInt:5];
    [given([loc y]) willReturnInt:9];

    sut = [CSPMove moveWithPlayer:CSPID_PlayerBlack
                       atLocation:loc];
    // when
    // then
    [self assertThatMove:sut
               hasPlayer:CSPID_PlayerBlack
                    forX:5
                    andY:9];
}

- (void)assertThatMove:(id <CSPMoveInterface>)move
              hasPlayer:(CSPPlayerID) plrID
                   forX:(int) targX
                   andY:(int) targY
{
    // when
    int x = [move x];
    int y = [move y];
    CSPPlayerID plr = [move player];
    // then
    assertThatInt(x, equalToInt(targX));
    assertThatInt(y, equalToInt(targY));
    assertThatInt(plr, equalToInt(plrID));
}


@end
