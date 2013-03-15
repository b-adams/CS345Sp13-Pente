/**
 @file TestStone.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 0.1
*/

    // Class under test
#import "CSPStone.h"

    // Collaborators
#import "CSPMove.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Comment the next two lines to disable OCHamcrest (for test assertions)
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

// Comment the next two lines to disable OCMockito (for mock objects)
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

/**
 @brief For testing Stone
 */
@interface TestStone : SenTestCase
@end

@implementation TestStone
{
    // test fixture ivars go here
    CSPStone *sut;
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testDumbInitYieldsNil
{
    //given
    sut = [[CSPStone alloc] init];
    assertThat(sut, is(equalTo(nil)));
}
//- (void)testStoneInitStoresPlacement
//{
//    // given
//    id<CSPMoveInterface> placement = [CSPMove moveWithPlayer:CSPID_PlayerBlack
//                                                         atX:3 andY:4];
//
//    sut = [[CSPStone alloc] initWithPlacement:placement];
//    // when
//
//    // then
//    assertThat(sut, isNot(equalTo(nil)));
//    assertThat([sut placement], isNot(equalTo(nil)));
//}


@end
