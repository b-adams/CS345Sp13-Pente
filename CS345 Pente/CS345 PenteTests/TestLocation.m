/**
 @file TestLocation.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 0.1
*/

    // Class under test
#import "CSPLocation.h"
#import "CSPCoordinateInterface.h"

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
 @brief For testing CSPLocation
 */
@interface TestLocation : SenTestCase
@end

@implementation TestLocation
{
    id<CSPCoordinateInterface> sut;
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNewLocationHasNegativeCoords
{
    // given
    sut = [[CSPLocation alloc] init];

    // when
    // then
    [self assertThatCoord:sut hasX:-1 andY:-1];
}


- (void)testLocationX3Y2HasCoordinatesX3Y2
{
    // given
    sut = [[CSPLocation alloc] initWithX:3 andY:2];

    // when
    // then
    [self assertThatCoord:sut hasX:3 andY:2];
}

- (void)testCoordNEofZeroZeroIsOneOne
{
    // given
    sut = [[CSPLocation alloc] initWithX:0 andY:0];
    
    // when
    CSPLocation* coord = [sut coordinateInDirection:CSDID_NorthEast];
    
    // then
    [self assertThatCoord:coord hasX:1 andY:1];
}

- (void)assertThatCoord:(id <CSPCoordinateInterface>)coord
                   hasX:(int)targX
                   andY:(int)targY
{
    // when
    int x = [coord x];
    int y = [coord y];

    // then
    assertThatInt(x, equalToInt(targX));
    assertThatInt(y, equalToInt(targY));
}


@end
