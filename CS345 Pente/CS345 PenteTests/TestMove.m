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
                hasPlayer:CS345NOBODY
                     forX:@-1
                     andY:@-1];
}


- (void)testMoveWhiteX4Y3HasPlayerWhiteWithCoordinatesX4Y3
{
    // given
    sut = [[CSPLocation alloc] initWithPlayer:CS345PlayerWhite
                                          atX:4
                                         andY:3];
    
    // when
    // then
    [self assertThatMove:sut
                hasPlayer:CS345PlayerWhite
                     forX:@4
                     andY:@3]
}

- (void)assertThatMove:(id <CSPMoveInterface>)move
              hasPlayer:(CSPPlayerID) plrID
                   forX:(NSNumber *)targX
                   andY:(NSNumber *)targY
{
    // when
    int x = [move x];
    int y = [move y];
    CSPPlayerID plr = [move player];
    // then
    assertThatInt(x, is(targX));
    assertThatInt(y, is(targY));
    assertThatInt(plr, equalToInt(plrID));
}


@end
