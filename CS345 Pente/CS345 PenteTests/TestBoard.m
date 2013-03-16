/**
 @file TestBoard.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 0.1
*/

    // Class under test
#import "CSPBoard.h"

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
 @brief For testing the Board/2d array
 */
@interface TestBoard : SenTestCase
@end

@implementation TestBoard
{
    // test fixture ivars go here
    CSPBoard* sut;
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

@end
