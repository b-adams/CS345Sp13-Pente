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

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Comment the next two lines to disable OCHamcrest (for test assertions)
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

// Comment the next two lines to disable OCMockito (for mock objects)
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

/**
 @brief For testing <#TestStone#>
 */
@interface TestStone : SenTestCase
@end

@implementation TestStone
{
    // test fixture ivars go here
}

- (void)setUp
{
    [super setUp];
    <#set up#>
}

- (void)tearDown
{
    <#tear down#>
    [super tearDown];
}

- (void)test<#FooShouldBar#>
{
    // given
    
    // when
    
    // then
    STFail(@"Unit tests are not implemented yet in TestStone");
}


@end
