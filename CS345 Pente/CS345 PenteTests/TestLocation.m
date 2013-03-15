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
    int x = [sut x];
    int y = [sut y];
    
    // then
    assertThatInt(x, is(@-1));
    assertThatInt(y, is(@-1));
}

- (void)testLocationX3Y2HasCoordinatesX3Y2
{
    // given
    sut = [[CSPLocation alloc] initWithX:3 andY:2];

    // when
    int x = [sut x];
    int y = [sut y];
    
    // then
    assertThatInt(x, is(@3));
    assertThatInt(y, is(@2));
}

@end
