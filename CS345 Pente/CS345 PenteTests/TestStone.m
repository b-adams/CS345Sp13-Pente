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
    id<CSPMoveInterface> placement;
    CSPStone * buddy;
}

- (void)setUp
{
    [super setUp];
    placement = [CSPMove moveWithPlayer:CSPID_PlayerBlack
                                    atX:3 andY:4];
    sut = [[CSPStone alloc] initWithPlacement:placement];
    buddy = [[CSPStone alloc] initWithPlacement:placement];
}

- (void)tearDown
{
    placement=nil;
    sut=nil;
    [super tearDown];
}

- (void)testDumbInitYieldsNil
{
    sut = [[CSPStone alloc] init];
    assertThat(sut, is(equalTo(nil)));
}
- (void)testNilInitYieldsNil
{
    sut = [[CSPStone alloc] initWithPlacement:nil];
    assertThat(sut, is(equalTo(nil)));
}
- (void)testStoneInitStoresPlacement
{
    assertThat(sut, isNot(equalTo(nil)));
    assertThat([sut placement], isNot(equalTo(nil)));
}
-(void)testNewStoneHasNoNeighbors
{
    assertThatInt([sut neighborCount], is(@0));
}
-(void)testAddingNeighborToNewStoneMakesNeighborSetNonempty
{

    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];

    assertThatInt([sut neighborCount], is(@1));
}
-(void)testAddingNeighborLeavesAddedNeighborInRightDirection
{
    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];

    assertThat([sut neighborInDirection:CSDID_SouthEast],
               is(buddy));
}
-(void)testRemovingNeighborClearsDirection
{
    [sut setNeighborTo:nil
           inDirection:CSDID_SouthEast];

    assertThat([sut neighborInDirection:CSDID_SouthEast],
               is(equalTo(nil)));
}
-(void)testRemovingNeighborReducesCount
{
    [sut setNeighborTo:nil
           inDirection:CSDID_SouthEast];
    
    assertThatInt([sut neighborCount], is(@0));
}

-(void)testNewStoneHasNoChainToSE
{
    assertThatInt([sut chainLengthIn:CSDID_SouthEast], is(@0));
}
-(void)testAddingSEStoneIncreasesSEChainToOne
{
    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];
    assertThatInt([sut chainLengthIn:CSDID_SouthEast], is(@1));
}

@end
