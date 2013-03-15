/**
 @file TestModel.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 0.1
*/

    // Class under test
#import "CSPGollumInTheCloset.h"

    // Collaborators
#import "CSPPenteGameModelInterface.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Comment the next two lines to disable OCHamcrest (for test assertions)
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

// Comment the next two lines to disable OCMockito (for mock objects)
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

/**
 @brief For testing Gollum in the Closet model
 */
@interface TestModel : SenTestCase
@end

@implementation TestModel
{
    // test fixture ivars go here
    id<CSPPenteGameModelInterface> sut;
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBoardSizeIsReasonable
{
    // given
    sut = [[CSPGollumInTheCloset alloc] init];
    
    // when
    int boardsize = [sut boardWidth];
    // then
    assertThatInt(boardsize, is(closeTo(19, 5)));
}


@end
