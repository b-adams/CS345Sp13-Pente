/**
 @file TestBoard.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 1.0
*/

    // Class under test
#import "CSPBoard.h"

    // Collaborators
#import "CSPLocation.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Comment the next two lines to disable OCHamcrest (for test assertions)
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

// Comment the next two lines to disable OCMockito (for mock objects)
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

/**
 @brief For testing the Board/2d array
 */
@interface TestBoard : SenTestCase
@end

@implementation TestBoard
{
    // test fixture ivars go here
    CSPBoard* sut;
    id<CSPCoordinateInterface> place;
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    place=nil;
    [super tearDown];
}

- (void)testDefaultSizeIsZero
{
    // given
    sut = [[CSPBoard alloc] init];
    // when
    
    // then
    assertThatInteger([sut width], is(equalTo(@0)));
}

- (void)testInitialCountIsZero
{
    // given
    sut = [CSPBoard boardWithWidth:19];
    // when
    
    // then
    assertThatInteger([sut count], is(equalTo(@0)));
}

- (void)testSizeIsTakenFromInit
{
    // given
    sut = [CSPBoard boardWithWidth:19];
    // when
    
    // then
    assertThatInteger([sut width], is(equalTo(@19)));
}

- (void)testAccessOutOfXRangeThrowsException
{
    //given
    sut = [CSPBoard boardWithWidth:5];
    place = [CSPLocation coordinateWithX:10 andY:2];
    id dummy = self;
    //when
    
    //then
    STAssertThrowsSpecificNamed([sut setObjectAtCoordinate:place
                                                  toObject:dummy],
                                NSException,
                                NSRangeException,
                                @"Out of range exception was allowed");
}

- (void)testAccessInsideRangeDoesNotThrowException
{
    //given
    sut = [CSPBoard boardWithWidth:5];
    place = [CSPLocation coordinateWithX:2 andY:2];
    //when
    
    //then
    STAssertNoThrow([sut setObjectAtCoordinate:place
                                      toObject:@"dummy string"],
                    @"Raising exception while still in bounds");
}

- (void)testAccessOutOfYRangeThrowsException
{
    //given
    sut = [CSPBoard boardWithWidth:5];
    place = [CSPLocation coordinateWithX:2 andY:10];
    id dummy = self;
    //when
    
    //then
    STAssertThrowsSpecificNamed([sut setObjectAtCoordinate:place
                                                  toObject:dummy],
                                NSException,
                                NSRangeException,
                                @"Out of range exception was allowed");
}

-(void)testStoredItemIncreasesCount
{
    // given
    sut = [CSPBoard boardWithWidth:5];
    place = [CSPLocation coordinateWithX:3 andY:2];
    // when
    [sut setObjectAtCoordinate:place toObject:@42];
    //then
    assertThatUnsignedInteger([sut count], is(@1));
}

- (void)testStoredItemCanBeRetrieved
{
    // given
    sut = [CSPBoard boardWithWidth:5];
    place = [CSPLocation coordinateWithX:3 andY:2];
    // when
    [sut setObjectAtCoordinate:place toObject:@42];
    
    // then
    assertThat([sut objectAtCoordinate:place], is(@42));
}


- (void)testInitialStoredItemsReadAsNil
{
    //given
    sut = [CSPBoard boardWithWidth:5];
    place = [CSPLocation coordinateWithX:2 andY:3];
    //when
    
    //then
    assertThat([sut objectAtCoordinate:place], is(equalTo(nil)));
}

- (void)testClearingASpotClearsTheSpot
{
    // given
    sut = [CSPBoard boardWithWidth:5];
    place = [CSPLocation coordinateWithX:2 andY:3];
    [sut setObjectAtCoordinate:place toObject:@43];
    
    // when
    [sut clearCoordinate:place];
    
    // then
    assertThat([sut objectAtCoordinate:place], is(equalTo(nil)));
}

@end
